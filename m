Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F91DC433DB
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 21:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5A1822BEF
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 21:36:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726348AbhAWVf7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Jan 2021 16:35:59 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63274 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbhAWVf6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jan 2021 16:35:58 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 18FF39E697;
        Sat, 23 Jan 2021 16:35:15 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=xqnabQusonJ6
        IT+ulH794IF4x30=; b=YoJ4tEXV3M+VtdyqRVKQu/QnB4Fo/ktybdKvpNWd7xqw
        /tWRHwwYuyygxCciUk/89BTPIHQEpROmhSN18akaqbEYYNJQzm8gwFMFj44GiMBC
        hGccZzyP36VkLHExdTMC5l7hiz8ihyThUWvxKg8RznawTZarKSyVTmZQrOYsUxw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=L6ZqtR
        eDJebB/Eh28JFyZJy9A7U4mwuTKZeJsKNieK/47BthMBEHZnCb9fbnEGLwBaZOXt
        F5L3fVceAUKHvT/t0mczXHbthY5Es67RPqVI4vP71fSzpGgm2RSTee4StOgyOASu
        fb4imFUmB+5kRVdkx4jUPw6fWLSpMB4lG6Zpo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 108579E694;
        Sat, 23 Jan 2021 16:35:15 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9090C9E693;
        Sat, 23 Jan 2021 16:35:14 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Denton Liu <liu.denton@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 02/10] cache-tree tests: remove unused $2 parameter
References: <87sg6s6lrs.fsf@evledraar.gmail.com>
        <20210123130046.21975-3-avarab@gmail.com>
Date:   Sat, 23 Jan 2021 13:35:13 -0800
In-Reply-To: <20210123130046.21975-3-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Sat, 23 Jan 2021 14:00:38 +0100")
Message-ID: <xmqqpn1v2v72.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E112DC18-5DC2-11EB-BFB3-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Remove the $2 paramater. This appears to have been some
> work-in-progress code from an earlier version of
> 9c4d6c0297 (cache-tree: Write updated cache-tree after commit,
> 2014-07-13) which was left in the final version.

Good.

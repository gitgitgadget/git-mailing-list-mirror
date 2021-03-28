Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19950C433DB
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 18:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2D4F6157F
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 18:34:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbhC1Sdt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Mar 2021 14:33:49 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61025 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbhC1Sdd (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Mar 2021 14:33:33 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 209B6127982;
        Sun, 28 Mar 2021 14:33:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=YBohpCU8Bfbb
        2LHk19HNQmCquMY=; b=QHiD7lt+UDGJNMzv9yW79eCN4RGJIo8eAmbgwFJ6uf7z
        wt1GQnwOtx2BbtqZQWl+gLzhe3dkf6CN4rfpOg5zUMKPiiLt1AHT7ZDLJFo+2zcP
        G0dZ9aQH7iITbPnLTU3XXfe/F8QDHRDzNLvdrKcynOiFD82XOOprOzUXmVhSRiY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=kkh2Qm
        vFwghw2ZXz6Nx878v+5WlX7T86SC/02zxwlI9ALnlQ6vFvK4mMwpbzbK6VxgSJH8
        /jfkZoItYtXdICdnq6OZzKgYDV5K0tt+UbNVz9xBWwddb8OMSztxwogERQZB6VSI
        ++frBe2omJ0iDB6OboXN/exVNXx1Voun9kQZc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 18F42127981;
        Sun, 28 Mar 2021 14:33:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 53F46127980;
        Sun, 28 Mar 2021 14:33:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Mar 2021, #07; Mon, 22)
References: <xmqq35wm5y6d.fsf@gitster.g> <878s67o09v.fsf@evledraar.gmail.com>
Date:   Sun, 28 Mar 2021 11:33:28 -0700
In-Reply-To: <878s67o09v.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Sun, 28 Mar 2021 15:50:20 +0200")
Message-ID: <xmqqy2e7ku13.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 18126E28-8FF4-11EB-BF1C-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Tue, Mar 23 2021, Junio C Hamano wrote:
>
> Quick notes on my outstanding submissions listed here:

A summary like this is greatly appreciated.

Thanks.

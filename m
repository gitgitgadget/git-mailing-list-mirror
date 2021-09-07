Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A34C433F5
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 20:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75B406115C
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 20:27:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346514AbhIGU2d (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 16:28:33 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51997 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346287AbhIGU2c (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 16:28:32 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BD0E6E6A5D;
        Tue,  7 Sep 2021 16:27:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=dJTP43WTi166
        m3aM5jIYRZmGBUY39zRCCIqvgZQ2IIo=; b=uw2v3RzxlxqotyzkYDIP++8vhtTv
        U6XHzD2gcANFJwuLAWphe1ut4bwP6BSDEPNbpcLOwxVPI0Irmuj2cgGFmhhjpzNt
        iQUOu9tN4LeypnDuUzRytnfQhPCB5QSHlmMcj/Wi7h9l/aRv7O8Ns2tXFIGRsIOn
        +sGxmgafnKbQQBQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AFE59E6A5B;
        Tue,  7 Sep 2021 16:27:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3298AE6A59;
        Tue,  7 Sep 2021 16:27:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Makefile: remove the check_bindir script
References: <patch-1.1-996c05525db-20210906T075527Z-avarab@gmail.com>
Date:   Tue, 07 Sep 2021 13:27:22 -0700
In-Reply-To: <patch-1.1-996c05525db-20210906T075527Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 6 Sep
 2021 09:55:33 +0200")
Message-ID: <xmqqpmtk9ln9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 021BAC3C-101A-11EC-A825-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> This script was added in f28ac70f48 (Move all dashed-form commands to
> libexecdir, 2007-11-28) when commands such as "git-add" lived in the
> bin directory, instead of the git exec directory.

Thanks.  This removal makes sense.

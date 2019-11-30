Return-Path: <SRS0=RoqO=ZW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99CE4C432C0
	for <git@archiver.kernel.org>; Sat, 30 Nov 2019 17:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 553A52075C
	for <git@archiver.kernel.org>; Sat, 30 Nov 2019 17:14:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="aiY3bwWJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbfK3ROi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Nov 2019 12:14:38 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64388 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbfK3ROi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Nov 2019 12:14:38 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D60713C7C2;
        Sat, 30 Nov 2019 12:14:35 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BfDm/M1Q9PQ0o+OodUyQ0T+7RKc=; b=aiY3bw
        WJ+IZBL+SUZdpOvNH2B63aT2SC/RDpaL13uY9r02jcR8jjzfRrZjUJ/PRdFkFdAB
        4gZGpwUj+OMGGGJrqadm53LIS123o1sRbo4W3WcAwz4gcs7kfnxdkR03rrvg/fdh
        Z58FkwzIfhRX5YuzaYODY+jVpbmkDpPOSrt4E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lWjZ+JsaBBdEdoe1eNoTLdhV5bHBLL8T
        tKx0Km0De0VAu1NrfrIlPZke2jTcfQZgZY35+RULdUw636ZYABeqWkvv6z6mJ1yx
        XcrWzOKaJYwetVVJJrztdKyB1xElKxQ/7uJU9Jy8Koy5o6S/aRu2Pm9GXxvemedw
        unWx1eBQaY8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CEBE53C7C1;
        Sat, 30 Nov 2019 12:14:35 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 425403C7C0;
        Sat, 30 Nov 2019 12:14:35 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Eric Wong <e@80x24.org>
Subject: Re: [PATCH 0/2] Hi Peff,
References: <20191127125231.GH22221@sigill.intra.peff.net>
        <cover.1574882812.git.liu.denton@gmail.com>
Date:   Sat, 30 Nov 2019 09:14:34 -0800
In-Reply-To: <cover.1574882812.git.liu.denton@gmail.com> (Denton Liu's message
        of "Wed, 27 Nov 2019 11:28:52 -0800")
Message-ID: <xmqqmucd2sn9.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E1D0CDBE-1394-11EA-85E4-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> Thanks for doing this. Perhaps while we're at it, we want to change all
> of the MARC and Gmane links as well? The series below does this.

I suspect that most of the reference you make to LKML should refer
to lore.kernel.org instead.

Replacing gmane articule number with the message ID is very much
appreciated.


> I've based my series on top of yours so if you need to do a reroll, feel
> free to pick my changes in.
>
> Denton Liu (2):
>   doc: replace MARC links with LKML
>   RelNotes: replace Gmane with real Message-IDs
>
>  Documentation/RelNotes/1.6.2.txt    | 2 +-
>  Documentation/RelNotes/1.6.3.txt    | 2 +-
>  Documentation/RelNotes/1.6.4.txt    | 2 +-
>  Documentation/RelNotes/1.6.5.txt    | 2 +-
>  Documentation/RelNotes/1.6.6.txt    | 2 +-
>  Documentation/RelNotes/1.8.4.txt    | 2 +-
>  Documentation/RelNotes/2.5.0.txt    | 3 ++-
>  Documentation/RelNotes/2.8.3.txt    | 4 ++--
>  Documentation/RelNotes/2.9.0.txt    | 2 +-
>  Documentation/git-bisect-lk2009.txt | 2 +-
>  Documentation/gitcli.txt            | 4 ++--
>  Documentation/user-manual.txt       | 4 ++--
>  t/t6021-merge-criss-cross.sh        | 2 +-
>  13 files changed, 17 insertions(+), 16 deletions(-)

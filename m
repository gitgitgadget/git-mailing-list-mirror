Return-Path: <SRS0=68ZU=2Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86F1DC2D0DA
	for <git@archiver.kernel.org>; Thu, 26 Dec 2019 17:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E63D206CB
	for <git@archiver.kernel.org>; Thu, 26 Dec 2019 17:50:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="J1C4kj1Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbfLZRux (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Dec 2019 12:50:53 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58486 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726475AbfLZRux (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Dec 2019 12:50:53 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A2FD337C3E;
        Thu, 26 Dec 2019 12:50:51 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=KDJAOsVlHxZI
        Liu5wWCnnLt23NY=; b=J1C4kj1Z5t9JKF4368q/sTu/L7LAZvFVeAia+gcyLwIt
        4V1dYIjEthahdUhmaOrkwtXXD4pANA4TV0TQJuOS17MX9FZK3LY+hCyuMaKJZGzN
        VT9hFXlvRxOVdnrvW7qQ1HMOaLd0RXhGLF1b5UlF6/QvqCNUfOjQrIbKv8tgTUU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=dqMw6b
        CaiX7e8RQjBKnP32S4WoHwvT2gi0N3st3IKXHuZ7+2BmEwGliVGgkJWYf3I8+hxH
        mguv/VNPPm8KuUN6FtDet6F01+EsffuQkaRaZiO6PsGKR/uDajhMtTgwMtJuEvRH
        xAbm2n91Gbe7sIr8wr6wANeFP4cD/yExolFUY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9AA4837C3D;
        Thu, 26 Dec 2019 12:50:51 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0637937C3C;
        Thu, 26 Dec 2019 12:50:50 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Danh Doan <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.25.0-rc0
References: <xmqqblrwm65l.fsf@gitster-ct.c.googlers.com>
        <20191226143527.GA24268@danh.dev>
Date:   Thu, 26 Dec 2019 09:50:49 -0800
In-Reply-To: <20191226143527.GA24268@danh.dev> (Danh Doan's message of "Thu,
        26 Dec 2019 21:35:27 +0700")
Message-ID: <xmqq4kxnm0w6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 41686AA2-2808-11EA-8A29-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Danh Doan <congdanhqx@gmail.com> writes:

> My name should be moved down to next paragraph,
> since I was lazy to type my name with all accents.

Your first contribution was back in v2.20 days, and then the recent
ones are all within this cycle for v2.25.

I am a bit curious why you need to avoid being lazy just to give the
correct name to your commits, though.  Isn't=20

	git config [--global] user.name "name with accents"

just fire-once-and-forget solution, or is there anything else
involved?

Thanks.  I do not _mind_ to add a new mailmap entry to correct
mistakes after the fact, but it of course is better to have them
right from the start, and I am wondering if our configuration scheme
needs to do more to help you.

> diff --git a/.mailmap b/.mailmap
> index 14fa041043..b42967e66f 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -60,6 +60,7 @@ David Turner <novalis@novalis.org> <dturner@twopensou=
rce.com>
>  David Turner <novalis@novalis.org> <dturner@twosigma.com>
>  Derrick Stolee <dstolee@microsoft.com> <stolee@gmail.com>
>  Deskin Miller <deskinm@umich.edu>
> +=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh <congdanhqx@gmail.com> Doan=
 Tran Cong Danh
>  Dirk S=C3=BCsserott <newsletter@dirk.my1.cc>
>  Eric Blake <eblake@redhat.com> <ebb9@byu.net>
>  Eric Hanchrow <eric.hanchrow@gmail.com> <offby1@blarg.net>


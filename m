Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA5BC1F97E
	for <e@80x24.org>; Mon, 26 Nov 2018 06:28:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbeKZRVA (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Nov 2018 12:21:00 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58056 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbeKZRVA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Nov 2018 12:21:00 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 14F4E112804;
        Mon, 26 Nov 2018 01:27:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Tb5f+R1WYFb1
        mkO58aL34iajEPs=; b=hIVFVGWbgAevRZREG7woxaozBfMDU/tC6VHJY09JC4+C
        Xay6jKIcsZfjDbUeahFjEmKGIpaKaGCS9Eyp2mRrh1Rh/ifVk72SCknDadAcm7+a
        YFDHlT3KEXcy3sTAO45dusiLsYIHMKpG2LvFVZRifLi7MP5cwCd0BrgAorPr3eQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=p7wKGx
        Ii/YGQEFiIbzYuHnXAQDfkOaBJB+ZevCLhCtw7lXpfoiSHpbQEk4qT3gE0wO6x7l
        zmuhfPCWTJPYhsOyUlug8/ExZdaJn1YGL/8QpHMvm6Mda+QimtNIvBagf+oFpk2S
        H2k2umkKf9zF520aSvxBGBUxIYFGt8xSihciY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0D1E5112802;
        Mon, 26 Nov 2018 01:27:54 -0500 (EST)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7C3D9112801;
        Mon, 26 Nov 2018 01:27:53 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 1/7] Documentation: update INSTALL for NetBSD
References: <cover.1543143503.git.carenas@gmail.com>
        <91d5d8cf6c3013f6c309d3666d8626ef546b18df.1543143503.git.carenas@gmail.com>
Date:   Mon, 26 Nov 2018 15:27:52 +0900
In-Reply-To: <91d5d8cf6c3013f6c309d3666d8626ef546b18df.1543143503.git.carenas@gmail.com>
        ("Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n=22's?= message of "Sun, 25 Nov
 2018 03:06:44
        -0800")
Message-ID: <xmqqy39gxsif.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 67BB6FFC-F144-11E8-A4EC-063AD72159A7-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:

> NetBSD added a BSD licensed reimplementation of GNU libintl to
> its base at least since release 4.0 (mid 2012) and git can be
> configured to build with it.
>
> Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
> ---
>  INSTALL | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Looks good.

> diff --git a/INSTALL b/INSTALL
> index c39006e8e7..100718989f 100644
> --- a/INSTALL
> +++ b/INSTALL
> @@ -154,11 +154,11 @@ Issues of note:
>  	  git-gui, you can use NO_TCLTK.
> =20
>  	- A gettext library is used by default for localizing Git. The
> -	  primary target is GNU libintl, but the Solaris gettext
> -	  implementation also works.
> +	  primary target is GNU libintl, but the Solaris and NetBSD gettext
> +	  implementations also work.
> =20
>  	  We need a gettext.h on the system for C code, gettext.sh (or
> -	  Solaris gettext(1)) for shell scripts, and libintl-perl for Perl
> +	  gettext(1) utility) for shell scripts, and libintl-perl for Perl
>  	  programs.
> =20
>  	  Set NO_GETTEXT to disable localization support and make Git only

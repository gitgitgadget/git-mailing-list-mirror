Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D50C433E0
	for <git@archiver.kernel.org>; Wed, 13 May 2020 16:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42E0720671
	for <git@archiver.kernel.org>; Wed, 13 May 2020 16:43:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="K5Z3d+oy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732552AbgEMQnS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 May 2020 12:43:18 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56408 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728780AbgEMQnR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 May 2020 12:43:17 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B82BAC4953;
        Wed, 13 May 2020 12:43:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=rU/m1zZFtYdT
        H/pvvttXmIe5QXs=; b=K5Z3d+oybZYMR2N2fkPXwk2UTqiOvmwvi9t6mhjB8DYN
        fEC1kAx05ix2SF2AGD9LM1eiTZm2haLfXxS/mR6FDgNQVgruu/2tf8LSGELwA7wC
        SIFI4X2zOZSb14L9W6iDdp7RxWDL2GqXjc2lwBS/M+2wEwKpHWP3PTTMaaq83ek=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=VQCZbb
        44/yA1Hd4AyZH+MsVtBhBOynt0rMkEsFWXg7gTrfox0RlWakWhxBFkm0s2iS0ZQb
        5jN1A+VpDB+MGQW7pZwjbJ6aU+BSnXfdzd5aqF1dGNm+hVfTcmbvRhwTpOKPWS9h
        HW7C2zSYmfnIJztNjFPrDwS06A8Fde24VRZuE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AFFE3C4952;
        Wed, 13 May 2020 12:43:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0165CC4951;
        Wed, 13 May 2020 12:43:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] t1509: correct i18n test
References: <cover.1589375923.git.congdanhqx@gmail.com>
        <6675cb952771a48a50b46bcf577e363fcf5d7b3b.1589375923.git.congdanhqx@gmail.com>
Date:   Wed, 13 May 2020 09:43:11 -0700
In-Reply-To: <6675cb952771a48a50b46bcf577e363fcf5d7b3b.1589375923.git.congdanhqx@gmail.com>
        (=?utf-8?B?IsSQb8OgbiBUcuG6p24gQ8O0bmc=?= Danh"'s message of "Wed, 13 May
 2020 20:23:06 +0700")
Message-ID: <xmqqd077vl9c.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D60EA250-9538-11EA-ABEB-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh  <congdanhqx@gmail.com> writes=
:

> git-init(1)'s messages is subjected to i18n.
> They should be tested by test_i18n* family.
>
> Fix them.
>
> Signed-off-by: =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh <congdanhqx@g=
mail.com>
> ---
>  t/t1509-root-work-tree.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/t/t1509-root-work-tree.sh b/t/t1509-root-work-tree.sh
> index 553a3f601b..fd2f7abf1c 100755
> --- a/t/t1509-root-work-tree.sh
> +++ b/t/t1509-root-work-tree.sh
> @@ -221,7 +221,7 @@ test_expect_success 'setup' '
>  	rm -rf /.git &&
>  	echo "Initialized empty Git repository in /.git/" > expected &&
>  	git init > result &&
> -	test_cmp expected result
> +	test_i18ncmp expected result
>  '
> =20
>  test_vars 'auto gitdir, root' ".git" "/" ""
> @@ -246,7 +246,7 @@ test_expect_success 'setup' '
>  	cd / &&
>  	echo "Initialized empty Git repository in /" > expected &&
>  	git init --bare > result &&
> -	test_cmp expected result
> +	test_i18ncmp expected result
>  '
> =20
>  test_vars 'auto gitdir, root' "." "" ""

OK.  It shows how rarely (if ever) this test script is actually
exercised that we need fixes like these.  Well done.

Thanks.

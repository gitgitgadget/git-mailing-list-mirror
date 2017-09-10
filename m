Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59346202A4
	for <e@80x24.org>; Sun, 10 Sep 2017 12:13:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751474AbdIJMM7 (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Sep 2017 08:12:59 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34614 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751451AbdIJMM6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Sep 2017 08:12:58 -0400
Received: by mail-wm0-f67.google.com with SMTP id l19so4791170wmi.1
        for <git@vger.kernel.org>; Sun, 10 Sep 2017 05:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Uvlf9TIMGlSV3N93Y4aqRA45fAUZkbuHIMycl0RBXCs=;
        b=l6r6SAuiJzTfKyw47MnFipl/4W+HrZ4PMbwCiay93/FImHWyjPFU8J2qU4pE+ck3cn
         lOHDxi3B0QgT1fN0HVbQtRgKviQXA4JakSY+Ro9d4Ep0JIZM2nnZQJRUou1qTwI78Gny
         d1m6aNkoPSwiU2w5jixhe+CcW4tnToOKkvRJHJKkGhxb2eBWp1prFNKxnBxWG4p3Q57X
         FSHKAZaZP33q4S0dYfv4qR55LLYU9BWZyFZl3lYHlgl0TvHGBdHORROYKMcx+zcLe8a6
         XXD8JOn7ihR3e9y8Q2FLX3qDTBEjfL0RgSYa0kZfQMAFurAKvEknjxIGXOVUdSCZBVtN
         xrZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Uvlf9TIMGlSV3N93Y4aqRA45fAUZkbuHIMycl0RBXCs=;
        b=SAOIk/UlpFw0ZkHObGpvMW5DqEXTeZ5XXv5UmkU/3SwA1R3nsnNnRyp4hb4Nj0Tczi
         GXOXHZkciW9sbe3ly19YkzJWU3oTGy4D0N9SeKjBa+Ag278wcAt0epAFxb9XrpG4MAul
         BrdhFMGqHjt/I3PTzpCcz8oN3z0pWtgBfeVzSUJz7J4k3tfkxTh5rWSx2rrMuvCKkqn4
         GXnJqGzeMd+fJnzlcIsnnZxOFLWNpvGa8f35OmbxC68ek0VT1bYCvMNNzOx5ktO7YINp
         2R3i3oEmjXhRwse4CVUu5OaZQsTnZxGcLPcgX5K1dAKjSRx1VrXFDk8aH4LC1nbc5WJn
         K+Dw==
X-Gm-Message-State: AHPjjUgo8D+4UISrEs/kSQpRoRNl+6HZopWOZVTPrqN0+jdjXYENJ9lP
        o23DanUjVT65qZms0/FNwSg=
X-Google-Smtp-Source: AOwi7QAbNjASKS+lIh2ZnLesJsuapfBTh1TIFXbObeTjPNShbr0C6hbWT9ocRIHrEPJyS3Qb93pMxA==
X-Received: by 10.28.27.87 with SMTP id b84mr6206864wmb.71.1505045577152;
        Sun, 10 Sep 2017 05:12:57 -0700 (PDT)
Received: from slxbook4.fritz.box (p5DDB7AFE.dip0.t-ipconnect.de. [93.219.122.254])
        by smtp.gmail.com with ESMTPSA id 193sm11452563wmh.47.2017.09.10.05.12.55
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 10 Sep 2017 05:12:56 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v5 12/40] t0400: add 'put_raw_obj' instruction to odb-helper script
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20170803091926.1755-13-chriscool@tuxfamily.org>
Date:   Sun, 10 Sep 2017 14:12:56 +0200
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>, Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <50C9AF15-26DF-48F5-926E-B5D57F492DD1@gmail.com>
References: <20170803091926.1755-1-chriscool@tuxfamily.org> <20170803091926.1755-13-chriscool@tuxfamily.org>
To:     Christian Couder <christian.couder@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 03 Aug 2017, at 10:18, Christian Couder =
<christian.couder@gmail.com> wrote:
>=20
> To properly test passing objects from Git to an external odb
> we need an odb-helper script that supports a 'put'
> capability/instruction.
>=20
> For now we will support only sending raw blobs, so the
> supported capability/instruction will be 'put_raw_obj'.

What other kind of blobs do you imagine could we send?


> While at it let's add a test to check that our odb-helper
> script works well.
>=20
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
> t/t0400-external-odb.sh | 24 ++++++++++++++++++++++++
> 1 file changed, 24 insertions(+)
>=20
> diff --git a/t/t0400-external-odb.sh b/t/t0400-external-odb.sh
> index ed89f3ab40..3fa0449883 100755
> --- a/t/t0400-external-odb.sh
> +++ b/t/t0400-external-odb.sh
> @@ -7,10 +7,15 @@ test_description=3D'basic tests for external object =
databases'
> ALT_SOURCE=3D"$PWD/alt-repo/.git"
> export ALT_SOURCE
> write_script odb-helper <<\EOF
> +die() {
> +	printf >&2 "%s\n" "$@"
> +	exit 1
> +}
> GIT_DIR=3D$ALT_SOURCE; export GIT_DIR
> case "$1" in
> init)
> 	echo "capability=3Dget_git_obj"
> +	echo "capability=3Dput_raw_obj"
> 	echo "capability=3Dhave"
> 	;;
> have)
> @@ -20,6 +25,16 @@ have)
> get_git_obj)
> 	cat "$GIT_DIR"/objects/$(echo $2 | sed 's#..#&/#')
> 	;;
> +put_raw_obj)
> +	sha1=3D"$2"
> +	size=3D"$3"
> +	kind=3D"$4"
> +	writen=3D$(git hash-object -w -t "$kind" --stdin)
> +	test "$writen" =3D "$sha1" || die "bad sha1 passed '$sha1' vs =
writen '$writen'"

Typo? Should it be "written"?

- Lars=

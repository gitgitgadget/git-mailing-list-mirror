Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F201B2021E
	for <e@80x24.org>; Sun,  6 Nov 2016 14:30:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752005AbcKFOag (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 Nov 2016 09:30:36 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35443 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751830AbcKFO3g (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Nov 2016 09:29:36 -0500
Received: by mail-wm0-f68.google.com with SMTP id a20so1211267wme.2
        for <git@vger.kernel.org>; Sun, 06 Nov 2016 06:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=OpIp7tpWqPcW8DpiROe4Z0W29RUeb+DykCLSkCfR0qQ=;
        b=FGcjWDxgbTGHAjljfczGpsVve7F9ufHwv3Bk1dU8cJdaVYQYaQjzFvVmH+lMcXm+ym
         9HEoSZcVqtdtIeAjCIsSPgVIS/B6XfOEZVLEMaUiuGJlQuF4e0jbaWarLywUXp6dfJdG
         j6Zpk9JuE/l2ruw2I/6SSZQrD9u1hB/bWOwU3IlM3+Kv2XuP5/fweW4rolOVriTj9+Kd
         IrBh0C/vFTLo0bTCUsctDSKRIhnGQnY/cwbJHF3H66m2gTW+D+Ccpocb/kPg4ro5WPBg
         dwYE7lTlI5Ig/1ZsvMedwlmIiLBnlVjCOiU0tjWh7kC9E4vO1NZmhPVbi5MSRRPxZhbV
         VLsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=OpIp7tpWqPcW8DpiROe4Z0W29RUeb+DykCLSkCfR0qQ=;
        b=HK30IwA3YKsxnidmHTCot7pq1gbzn9krWSV6iMx/i2HA8LSRtw5hNTBD7iSh+nPdeR
         p7vF8gtsMHWr87qEyzkTOKvYWO3XuNOcGECwx5BMOiHlnt0Qyu5OSPVNsAR2sSQ9imac
         SHsN3tYyIo6PsQYDJJFKqOPGJavDd0i+/up3v3tDncwb7RFpp4+8cl9adDGAl4Dcwq4K
         VgctDGCCdgvBAxBCd0fEV+CHTv2XrEyU0oCkDR/sqpc8I82bWvsI8kRYHUNucWNv8MAG
         4AAYGeF9JK+thXGeHSHyOhUodJMKo21xb8vOPnU9JtzPX8XDjZWirilhDhN5JyMP2LX9
         ltXg==
X-Gm-Message-State: ABUngve7nkYh2CvIu7IE3z4LSqWQLVtVrNXtnzHN3NXROCbUI74akQH7ABhnYLjMPxnlZw==
X-Received: by 10.28.188.87 with SMTP id m84mr2765927wmf.14.1478442575294;
        Sun, 06 Nov 2016 06:29:35 -0800 (PST)
Received: from slxbook4.fritz.box (p5DDB5D74.dip0.t-ipconnect.de. [93.219.93.116])
        by smtp.gmail.com with ESMTPSA id r72sm7892610wmd.21.2016.11.06.06.29.34
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 06 Nov 2016 06:29:34 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 2/4] t0021: put $TEST_ROOT in $PATH
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20161102181824.mi6lmfnfckvrav7n@sigill.intra.peff.net>
Date:   Sun, 6 Nov 2016 15:29:42 +0100
Cc:     =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <C023A4E4-AA9B-45EF-AA34-C249323F2AE8@gmail.com>
References: <20161102181625.e2uprqdlzl7z2xrz@sigill.intra.peff.net> <20161102181824.mi6lmfnfckvrav7n@sigill.intra.peff.net>
To:     Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 02 Nov 2016, at 19:18, Jeff King <peff@peff.net> wrote:
>=20
> We create a rot13.sh script in the trash directory, but need
> to call it by its full path when we have moved our cwd to
> another directory. Let's just put $TEST_ROOT in our $PATH so
> that the script is always found.
>=20
> This is a minor convenience for rot13.sh, but will be a
> major one when we switch rot13-filter.pl to a script in the
> same directory, as it means we will not have to deal with
> shell quoting inside the filter-process config.
>=20
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> t/t0021-conversion.sh | 7 ++++---
> 1 file changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
> index dfde22549..c1ad20c61 100755
> --- a/t/t0021-conversion.sh
> +++ b/t/t0021-conversion.sh
> @@ -5,6 +5,7 @@ test_description=3D'blob conversion via gitattributes'
> . ./test-lib.sh
>=20
> TEST_ROOT=3D"$(pwd)"
> +PATH=3D$TEST_ROOT:$PATH
>=20
> write_script <<\EOF "$TEST_ROOT/rot13.sh"
> tr \
> @@ -64,7 +65,7 @@ test_cmp_exclude_clean () {
> # is equal to the committed content.
> test_cmp_committed_rot13 () {
> 	test_cmp "$1" "$2" &&
> -	"$TEST_ROOT/rot13.sh" <"$1" >expected &&
> +	rot13.sh <"$1" >expected &&
> 	git cat-file blob :"$2" >actual &&
> 	test_cmp expected actual
> }
> @@ -513,7 +514,7 @@ test_expect_success PERL 'required process filter =
should process multiple packet
> 		for FILE in "$TEST_ROOT"/*.file
> 		do
> 			cp "$FILE" . &&
> -			"$TEST_ROOT/rot13.sh" <"$FILE" >"$FILE.rot13"
> +			rot13.sh <"$FILE" >"$FILE.rot13"
> 		done &&
>=20
> 		echo "*.file filter=3Dprotocol" >.gitattributes &&
> @@ -616,7 +617,7 @@ test_expect_success PERL 'process filter should =
restart after unexpected write f
>=20
> 		# Smudge failed
> 		! test_cmp smudge-write-fail.o smudge-write-fail.r &&
> -		"$TEST_ROOT/rot13.sh" <smudge-write-fail.o >expected &&
> +		rot13.sh <smudge-write-fail.o >expected &&
> 		git cat-file blob :smudge-write-fail.r >actual &&
> 		test_cmp expected actual
> 	)
> --=20
> 2.11.0.rc0.258.gf434c15

Looks good to me and the PWD Windows fix suggested by Hannes [1] works =
great
on macOS.

Thanks,
Lars

[1] =
http://public-inbox.org/git/20161103204438.zfe653c2bsv3zqkx@sigill.intra.p=
eff.net/=

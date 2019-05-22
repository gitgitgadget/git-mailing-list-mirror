Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_WORDY,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38F4F1F462
	for <e@80x24.org>; Wed, 22 May 2019 20:27:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729679AbfEVU1E (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 May 2019 16:27:04 -0400
Received: from mout.gmx.net ([212.227.15.18]:38799 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729528AbfEVU1D (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 May 2019 16:27:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1558556759;
        bh=weWZcPe+AWztmahRiwrOSXEl7yCwbRCNRySrDKrlJBU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Kgvd2tWc6Z8Ug1bMN67OeRUPyyrlDoF9WJ6oxn43eN5m/RH0rUFRhKOPeRUjZRdWC
         2fe7h7aSXwnOJxnS3ceJ6K20mguKxWPOpKGccuxbSPBDg+C0NMUA4LIxS2dP9ASWq4
         HVfs7xcQTgR2DiDc3n1sJB4Ww06f09WOb1myt6zA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LzskF-1gYVRk2qg7-0155tB; Wed, 22
 May 2019 22:25:59 +0200
Date:   Wed, 22 May 2019 22:25:42 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Stephen Boyd <swboyd@chromium.org>,
        jrnieder@gmail.com, sandals@crustytoothpaste.net,
        sunshine@sunshineco.com, xypron.glpk@gmx.de,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 4/5] send-email: fix regression in sendemail.identity
 parsing
In-Reply-To: <20190517195545.29729-5-avarab@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1905222223380.46@tvgsbejvaqbjf.bet>
References: <xmqqsgtd3fw3.fsf@gitster-ct.c.googlers.com> <20190517195545.29729-5-avarab@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2083867656-1558556759=:46"
X-Provags-ID: V03:K1:Qpqc94R4HrfOiH1o1Cye8pq9gPVI9N1ddnpVXnde6tcq5YuMQHa
 qAsIFWILj1qn8tSettiTpSoGpiqjrKExeQl0KztrfV1/t3xctGyRPsw8oxvjHXwehuVkIZT
 cG2pGSYlDw94vQIGFHyAIxBRagSuaFP7eXDniHbBKpUan1BoSv3SwoYln2mlh5YnB1bCcHD
 f0SFJXVJ5wNv5wdTl7nkg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KpoETRRUqPg=:cc0+alxN11q/KbncjIvvOL
 7L9rNiAbznxVCSIYD3bTF4wTHw5FHUYTS8ClHAcNMzFVl4+rGHs9s/M6KZkvCgLrvUKLQVWOA
 LRn7kGBVf5T48TEiv47sLEA3eOhPuproI60Qvz4WJAtQ33lQxsmj1vpzgkuC9D7PxfM3b4u0o
 mJ6jY1P8ZRf4XslwzRWhRq3RBlGvBJum9lopGbd8tdeJEYxHpSkRFTkWVpEqF3nzIT3Hyh3Xa
 SReI5IajlOrTxRMZP92KpiEaSJZzX35cPda6G2xLgaqFyemOKriQjTpZ7wSy6bl2Oy3yhrAHn
 hof6oIdYQB4buG4m/cWqqaut3wsZxfhoHbGJhiQX9/eHIjv7aOYFd5STm0yasfC6GBzoSL/3B
 az/vnLHbLolPD/q25MxipDO+1gTdSv52R9feAT6SLrZ9P3hWmD3YSgJzJi+X7wd7QGFbcjF6v
 mrDYZwMzwvnV0y8n7ckNFnF+RQsiuTBILEoiCrrAerCwQAIlRfdgbGumsszCN49uK3lEEFbeF
 Gt6rxBC8MGNXyQQlj6GwXzvL1+XVbvDeODTUAHBoLjXcDUmTPNvpo0vOHdJx8p7g1xkoA8VLN
 oFJuFZA9zwC8sgWYprU1Un7hZlLK03+HailbgUd64eKzR9mDlszriI7j5bDqIGFh/DxcPsEDe
 v5nXgLd/48pb1CytST2PpxhkC0kYa4zkdRCnyWCnP4Qyq9sJHJDOJvu5IL5pT+YiP399o0bmk
 wceSMrSFajsT1vYh9tRFXQP40eKwjBeVK1wluNjn5QqgbaGLZb0jklrC5R6aSXiPTFMGPVmCs
 Mtlh/tuCZYKyG+8d/n0VGbBZAne9nMjY3m1f1ndsZpnvJOcZQ6zWAnS25If7T3t5VNDsqwg3x
 lemHgK/QALLe4DcB0IWwf+Kl/BYSX1jwN20HhmzTEdlVnDNgiJHqUlgVEkF6HRUl9PWX6F0EW
 z1IvZmvGF/+hqTUpsBbknZHJM50Aj3UJaAI0uWpPFHAWDuBy8zYD2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2083867656-1558556759=:46
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Fri, 17 May 2019, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
> index 61d484d1a6..890e2874c3 100755
> --- a/t/t9001-send-email.sh
> +++ b/t/t9001-send-email.sh
> @@ -1228,6 +1228,61 @@ test_expect_success $PREREQ 'sendemail.to works' =
'
>  	grep "To: Somebody <somebody@ex.com>" stdout
>  '
>
> +test_expect_success $PREREQ 'setup sendemail.identity' '
> +	git config --replace-all sendemail.to "default@example.com" &&
> +	git config --replace-all sendemail.isp.to "isp@example.com" &&
> +	git config --replace-all sendemail.cloud.to "cloud@example.com"
> +'
> +
> +test_expect_success $PREREQ 'sendemail.identity: reads the correct iden=
tity config' '
> +	git -c sendemail.identity=3Dcloud send-email \
> +		--dry-run \
> +		--from=3D"nobody@example.com" \
> +		$patches >stdout &&
> +	grep "To: cloud@example.com" stdout
> +'
> +
> +test_expect_success $PREREQ 'sendemail.identity: identity overrides sen=
demail.identity' '
> +	git -c sendemail.identity=3Dcloud send-email \
> +		--identity=3Disp \
> +		--dry-run \
> +		--from=3D"nobody@example.com" \
> +		$patches >stdout &&
> +	grep "To: isp@example.com" stdout
> +'
> +
> +test_expect_success $PREREQ 'sendemail.identity: --no-identity clears p=
revious identity' '
> +	git -c sendemail.identity=3Dcloud send-email \
> +		--no-identity \
> +		--dry-run \
> +		--from=3D"nobody@example.com" \
> +		$patches >stdout &&
> +	grep "To: default@example.com" stdout
> +'
> +
> +test_expect_success $PREREQ 'sendemail.identity: bool identity variable=
 existance overrides' '
> +	git -c sendemail.identity=3Dcloud \
> +		-c sendemail.xmailer=3Dtrue \
> +		-c sendemail.cloud.xmailer=3Dfalse \
> +		send-email \
> +		--dry-run \
> +		--from=3D"nobody@example.com" \
> +		$patches >stdout &&
> +	grep "To: cloud@example.com" stdout &&
> +	! grep "X-Mailer" stdout
> +'
> +
> +test_expect_success $PREREQ 'sendemail.identity: bool variable fallback=
' '
> +	git -c sendemail.identity=3Dcloud \
> +		-c sendemail.xmailer=3Dfalse \
> +		send-email \
> +		--dry-run \
> +		--from=3D"nobody@example.com" \
> +		$patches >stdout &&
> +	grep "To: cloud@example.com" stdout &&
> +	! grep "X-Mailer" stdout
> +'
> +

These test cases all diligently use the `$PREREQ` prerequisite, but...

>  test_expect_success $PREREQ '--no-to overrides sendemail.to' '
>  	git send-email \
>  		--dry-run \
> @@ -1785,6 +1840,15 @@ test_expect_success '--dump-aliases must be used =
alone' '
>  	test_must_fail git send-email --dump-aliases --to=3Djanice@example.com=
 -1 refs/heads/accounting
>  '
>
> +test_expect_success 'aliases and sendemail.identity' '
> +	test_must_fail git \
> +		-c sendemail.identity=3Dcloud \
> +		-c sendemail.aliasesfile=3Ddefault-aliases \
> +		-c sendemail.cloud.aliasesfile=3Dcloud-aliases \
> +		send-email -1 2>stderr &&
> +	test_i18ngrep "cloud-aliases" stderr
> +'
> +

This one is missing it. That breaks the Windows job in our Azure Pipeline
where we leave out all of the Perl bits (to accelerate the tests somewhat)=
.

Ciao,
Dscho

>  test_sendmail_aliases () {
>  	msg=3D"$1" && shift &&
>  	expect=3D"$@" &&
> --
> 2.21.0.1020.gf2820cf01a
>
>
>

--8323328-2083867656-1558556759=:46--

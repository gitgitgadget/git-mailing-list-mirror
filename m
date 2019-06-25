Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D97D31F461
	for <e@80x24.org>; Tue, 25 Jun 2019 11:30:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729957AbfFYLaz (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jun 2019 07:30:55 -0400
Received: from mout.gmx.net ([212.227.17.20]:37713 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729170AbfFYLaz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jun 2019 07:30:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1561462247;
        bh=58wkaKedlMQ6318y4l631UkmcZuCkyxfoEHpfEs/ZrA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=beoEYFpB2rb90cjKua/4vLfs7H5EyuAFEvYV520mO7fXjYd8v97gFrW9bvwBhSNnc
         bDnkqmjKmcJaBGTCpx+j9Q51tdueztGT4SXbs8ADp+S24IyUbhDUg/n/k7ypG1l3n+
         D6PqYS6AzTITaBjwHSudhNSLa1sDoIol+TrARz3o=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Ll0tl-1iGRJy0eWb-00ai3Q; Tue, 25
 Jun 2019 13:30:47 +0200
Date:   Tue, 25 Jun 2019 13:31:07 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: Re: [PATCH v2 01/10] ls-files: add --json to dump the index
In-Reply-To: <nycvar.QRO.7.76.6.1906251142580.44@tvgsbejvaqbjf.bet>
Message-ID: <nycvar.QRO.7.76.6.1906251328320.44@tvgsbejvaqbjf.bet>
References: <20190624130226.17293-1-pclouds@gmail.com> <20190624130226.17293-2-pclouds@gmail.com> <nycvar.QRO.7.76.6.1906251142580.44@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-837661696-1561462268=:44"
X-Provags-ID: V03:K1:IebrNsvcDCFac5LaNODpNtofHdOzEzYXbKWIM20sLO995WhCo/c
 ZVIgsEGZyXmhTQZDNq22fIKLLtnEQrQDkLRHCFb56osJOKkhPQd5wG3iXiYkwoOZ89oF/o0
 HBmX4LukZuYi8Rb8r5D9g6PH83Ok6VEEogsp9CvXn3RyeTqg5nVHYQJRj9hs8SyampY+/gy
 VWzcYIy1UMdTzDNbpMwWw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ERK6mfFquls=:IyQc4kHQJ0bdrlv99PMCvq
 tpjFZanRvDysmYxjwJ9ODTC7cSk76q1Hwh7H/Mze81lXvd6bAZQ2EIoKln0d0xaaN9HvKJ+Sq
 1BdL2qRe9DN3XZ7D9ufA03zvwxDGfJ3bop0KbhpEffMihCmgGXjp5YfWBd0P2fs7vCIoNbZze
 +1EQ6vTyF5UyY6I4th1kRKGd2k+AJoQLa+OaOgdw/ycc8jTct4DIuPjEvMCIOn0MudFhHkMhs
 dbRxM5be5PFFgrFY5WVCDlrRpLo4PkQ26gtMYIN7Kf2oUo1I/iN9iB3mNHQYhh314XH1XMu8P
 KFksvKx1pKyfuBSp+2mkf14GA6ju3Kzt1u8RCWLDkzmaKV5Gg16llubnwlG792Z5jGdoxvlTS
 j93pJbMY77Vh0XRhTLP/WtkH/tjNAtJ3g6EoVuWUo/4MUlNjlqj2XgmKguL8z6MzEn8H5t2RP
 2jleF1If1I9qtodwOFE5nNUCU3tx0kRoxvm6nqaSrsCpndqoS0loaC7HPr3V60G5s43USJtZz
 UexSzd4svmUoPWV6DjYTPYb2qCs2BMCeZR3wtC6QgLInRmUqXemw86amKrEoNtFHYw+KUdEBo
 ILF1CtdSGtD9/rlN2iKWpF4yeraBHKxQwEPiRQi7XgzsOuS9Fa8Q4ImXulWpoHvCxGPzVoo3b
 mkhOXN8EVwUredK52q/PWod8AClEy9zpxddLsD6BI8CAFfm4V2KYpWxqaYXJMNwa2eQAHfHsR
 9iXWI8y5eMssmQenl1ZtDV7CqAH+Svfxu0SBuKXD4MNAGtTJyQqMmo5ZTL+Bs7XPoaYAloHC3
 Zn0Kju51o5gqjKMHkONd1+LOeiiftwb/kASyrKB0soEruSplhv7rKomInaa+9UKe0fK5mFkK3
 DjgdRgPuhsK45zzVk4kKPPNEeAXQmszZ7ENUUErGTPdrV9Nmi1YXNIj0YhkZ4a8bMbBMDeRAP
 dVTvc9VvLF2Wh8wTUGcXNhbab21dTTc1R6MbxRspDSJhw5Q++dnp7obhz6Wh/sckTzpyviRI+
 /bOz1pyZMgghmL+D5PSh9wyf4xE5pyCna7G93dnZZT4uf7sq0YfTIV1NZh/Mqx9XC4NGbDqfq
 xz/HmgFgk7cQ71ZEm3//YN3jfWcnep38phg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-837661696-1561462268=:44
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Duy,

On Tue, 25 Jun 2019, Johannes Schindelin wrote:

> On Mon, 24 Jun 2019, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>
> > diff --git a/t/t3011-ls-files-json.sh b/t/t3011-ls-files-json.sh
> > new file mode 100755
> > index 0000000000..97bcd814be
> > --- /dev/null
> > +++ b/t/t3011-ls-files-json.sh
> > @@ -0,0 +1,44 @@
> > +#!/bin/sh
> > +
> > +test_description=3D'ls-files dumping json'
> > +
> > +. ./test-lib.sh
> > +
> > +strip_number() {
> > +	for name; do
> > +		echo 's/\("'$name'":\) [0-9]\+/\1 <number>/' >>filter.sed
>
> This does not do what you think it does, in Ubuntu Xenial and on macOS:
>
> https://dev.azure.com/gitgitgadget/git/_build/results?buildId=3D11408&vi=
ew=3Dms.vss-test-web.build-test-results-tab&runId=3D27736&paneView=3Ddebug=
&resultId=3D105613
>
> The `\1` is expanded to the ASCII character 001. Therefore your test cas=
es
> fail on almost all platforms.

The `strip_number()`/`strip_string()` approach might look elegant from a
design perspective, but from a readability perspective (and obviously,
when one wants to make those tests more robust and cross-platform), it
would be a lot better to do it more explicitly.

This patch on top of your patch series makes the test run correctly in my
Linux and Windows setup, and much easier to understand:

=2D- snipsnap --
diff --git a/t/t3011-ls-files-json.sh b/t/t3011-ls-files-json.sh
index 9f4ad4c9cf..8b782c48e0 100755
=2D-- a/t/t3011-ls-files-json.sh
+++ b/t/t3011-ls-files-json.sh
@@ -4,18 +4,6 @@ test_description=3D'ls-files dumping json'

 . ./test-lib.sh

-strip_number() {
-	for name; do
-		echo 's/\("'$name'":\) [0-9]\+/\1 <number>/' >>filter.sed
-	done
-}
-
-strip_string() {
-	for name; do
-		echo 's/\("'$name'":\) ".*"/\1 <string>/' >>filter.sed
-	done
-}
-
 compare_json() {
 	git ls-files --debug-json >json &&
 	sed -f filter.sed json >filtered &&
@@ -35,9 +23,21 @@ test_expect_success 'setup' '
 	echo intent-to-add >ita &&
 	git add -N ita &&

-	strip_number ctime_sec ctime_nsec mtime_sec mtime_nsec &&
-	strip_number device inode uid gid file_offset ext_size last_update &&
-	strip_string oid ident
+	cat >filter.sed <<-\EOF
+	s/\("ctime_sec":\) [0-9]\+/\1 <number>/
+	s/\("ctime_nsec":\) [0-9]\+/\1 <number>/
+	s/\("mtime_sec":\) [0-9]\+/\1 <number>/
+	s/\("mtime_nsec":\) [0-9]\+/\1 <number>/
+	s/\("device":\) [0-9]\+/\1 <number>/
+	s/\("inode":\) [0-9]\+/\1 <number>/
+	s/\("uid":\) [0-9]\+/\1 <number>/
+	s/\("gid":\) [0-9]\+/\1 <number>/
+	s/\("file_offset":\) [0-9]\+/\1 <number>/
+	s/\("ext_size":\) [0-9]\+/\1 <number>/
+	s/\("last_update":\) [0-9]\+/\1 <number>/
+	s/\("oid":\) ".*"/\1 <string>/
+	s/\("ident":\) ".*"/\1 <string>/
+	EOF
 '

 test_expect_success 'ls-files --json, main entries, UNTR and TREE' '
@@ -98,7 +98,9 @@ test_expect_success !SINGLE_CPU 'ls-files --json and mul=
ticore extensions' '
 		touch one two three four &&
 		git add . &&
 		cp ../filter.sed . &&
-		strip_number offset &&
+		cat >>filter.sed <<-\EOF &&
+		s/\("offset":\) [0-9]\+/\1 <number>/
+		EOF
 		compare_json eoie
 	)
 '

--8323328-837661696-1561462268=:44--

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EAA0F1F424
	for <e@80x24.org>; Tue,  8 May 2018 20:53:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932533AbeEHUxV (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 May 2018 16:53:21 -0400
Received: from mout.gmx.net ([212.227.17.20]:58915 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932493AbeEHUxN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 May 2018 16:53:13 -0400
Received: from [10.92.140.20] ([167.220.148.20]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MIPhr-1fJAHV2xoN-004CIW; Tue, 08
 May 2018 22:53:06 +0200
Date:   Tue, 8 May 2018 16:53:04 -0400 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] t6050-replace: don't disable stdin for the whole test
 script
In-Reply-To: <20180507120407.4323-1-szeder.dev@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1805081651150.77@tvgsbejvaqbjf.bet>
References: <20180507120407.4323-1-szeder.dev@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-489636863-1525812779=:77"
Content-ID: <nycvar.QRO.7.76.6.1805081653030.77@tvgsbejvaqbjf.bet>
X-Provags-ID: V03:K1:JHFNKpjQJiGDk+lIsbdWtGW07RG0PNRc9b74U0y0yKTK0g+aPiw
 WARROreEaBBixzhSIGqqOnN60GJ/qwjKUv0SK1ZS4/ShLBFv3YkIMN0CxoM98+Veym2A87V
 gwqMTz8KEWqsucZ26eL+4oDPXLtjgSooGoz3kbByuzd+p4D/Xgu7tjDnj77BloXu7cKAtra
 j8xOis40Zo9EmQNYaswog==
X-UI-Out-Filterresults: notjunk:1;V01:K0:FDq1IBH8cLU=:F5VE4fiEe/Q6KWPnznxbpv
 jlaNqqLqmHUHna8SncT5h7gYpt095oBsl5AecbUqj/iLntl8pDnMdDsEClD49zo9ZSa5iGlSC
 3v8e4TaQRFbG/bUSDchXmgCSGxxRija6BCbkXaHHxm/Pe96aDhCNPoxFhA70UgGvjBksHO1ZE
 Pui8Uc8LjfgIG8jy5ihEMGgzptjZkZvF9LkgXOurLQGxrmQv8l2n7nhIjtbAOh4WRIuESfA2B
 PnpeWTSKxHGOHCPKK+Seza2XhMHzHaG10oxpqHxs8JYL++/aNyfBAAOsSHIHCwUmHQry0KwIP
 3BO7JrK3zRraVY8uu2qn993zCUgA4V4da54cW8GTX/J1aJQMXTSMhe1hMT0wY5skdP3VBQ1xa
 E8whPNzE/xwA7mOyzrdm4J1QZLJndkcSaPIhuBfZumDVMlIk0K16ZTzgVYEvSpOUqAeZ8sszk
 OZo19UJ+rlBlSfmiA3onI2vI2/9AlS7aaM5+jB5XSR5bU1Xd5YhjcX52xfo30hiWKcewIwgqQ
 5nx1BFBuKKM4XwNyodGeTfsHkwyun7ehlhUVFvyK7Zn04wjTraY7xeLn5m71BKpL9TqBQbclS
 jv2LlUoN0xk50rkNYpWA/mtrEed+hyWFgGWav5mnCKmTTEZT9aTKI6RhpOa9/Vk5HOIKeezdG
 YGFVh5kccIPsBQVPpyVRlioqe5+ta0l5IUm0YwtzH8CtwaUq31qZEcXR/L/iNp9zdqNenZDFc
 8edJIR3UPh643LG4c2rB03k2kmp0rTu6y1NXAI8pC/S5wReWDTTUcfGfdiqpze/SynzwiCbBr
 HAygKfZ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-489636863-1525812779=:77
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <nycvar.QRO.7.76.6.1805081653031.77@tvgsbejvaqbjf.bet>

Hi G=C3=A1bor,

On Mon, 7 May 2018, SZEDER G=C3=A1bor wrote:

> The test script 't6050-replace.sh' starts off with redirecting the whole
> test script's stdin from /dev/null.  This redirection has been there
> since the test script was introduced in a3e8267225 (replace_object: add
> a test case, 2009-01-23), but the commit message doesn't explain why it
> was deemed necessary.  AFAICT, it has never been necessary, and t6050
> runs just fine and succeeds even without it, not only the current
> version but past versions as well.
>=20
> Besides being unnecessary, this redirection is also harmful, as it
> prevents the test helper functions 'test_pause' and 'debug' from working
> properly in t6050, because we can't enter any commands to the shell and
> the debugger, respectively.

The redirection might have been necessary before 781f76b1582 (test-lib:
redirect stdin of tests, 2011-12-15), but it definitely is not necessary
now.

Thanks,
Dscho
--8323328-489636863-1525812779=:77--

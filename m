Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 303502055E
	for <e@80x24.org>; Wed, 25 Oct 2017 23:10:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751813AbdJYXKi (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Oct 2017 19:10:38 -0400
Received: from mout.gmx.net ([212.227.15.19]:64406 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751753AbdJYXKh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Oct 2017 19:10:37 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lvkwm-1d71Cl1sbs-017VB6; Thu, 26
 Oct 2017 01:10:07 +0200
Date:   Thu, 26 Oct 2017 01:10:05 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Christian Couder <christian.couder@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 0/6] Create Git/Packet.pm
In-Reply-To: <20171019123030.17338-1-chriscool@tuxfamily.org>
Message-ID: <alpine.DEB.2.21.1.1710260008270.37495@virtualbox>
References: <20171019123030.17338-1-chriscool@tuxfamily.org>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:U41usAnkYMIFQtArdvBplLvP/zFm07J/HTBOQfOIE3ZyIS8AgAn
 gzOrK8FL9LtAlFiIFcitCJ6rLZuNIUoiARIHmW54HOpWWx1pf1/ecyOTUbv7rnacuGpHFR0
 L/S2/pMknkNRrxzISFjTr1qckuXOYMfWm4gKJlHBealggPTB+Z6qhZDGpVJOfUSDd270pjr
 Yk+PjeIQ9YSbZk7QRMkqA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:nrztQ8DQxPw=:gE5vL7qkTjSgs1sxY/CUGX
 0DcvAilQQBiSlaiAQFIPBJoV/MeUa6/5THXPAXirf0Jad02Zy2w2+iUrAiG7Ktnlw/ayrJlUN
 yRluSFk0BVVeXNunDKZD6bqkiMJwCKB9CaPYzvXE1OQxBPBM5TptzNebTMNRGJu0QgtkDMd8J
 q/kXiW0FYDQQhTl8YZzVzGu32LYL0sGw0w1E2Yv0Ko9h98okoUvsaLjysXIbCncAmNmx/nvkM
 5Y5kOSZsXfqSqA8sCvexc/4OUYv86FF/S8SEcvCrT1tV6cdb1a+tfNmnNbb4GGrFFCotvx0ce
 Rqs00yfhEQPI8Apgr0HuzPmSnxyELm4X+Q2E25CLoFWmci+MgoYnrnP2pj5j5+7GRTX9onKF6
 DDnGgYGw8QInJMxfeoIykijvfLkNaLeFOCKVvy6qI3SckvUpydc0O+SrT+UOwtvm/NW9ownCF
 R0FmklYaNzK5FYrLFCLnU0bG1q6BpmURPiA1vo8Ru8UIa6yRN9czrnBndG6QOI9glLaUCIxVM
 uZU1Br/eb6o4cmxYvkBqyqZ54k4YzkRrqIgBidIy7MnNB7gc8y9AV7fSyB3p8KYKaHUHTHmlk
 KSC4lYRAqC/A9kySzBQIdc9MLy1qjn53hN52OsV/PCCo/WC4XJfaE3O79eLtX02M7qpSKu6/3
 UFIbOowyN4zhrjBpD18kTanQYExyrD5v+DQwTJFDk2RIMaRoOT9AlHD//ekGAUeIblpCi2XSS
 WrOjiYyPR3CnyISN6sL4FYylIg+LOsWRav7iUCtm0yg3Y5wMTbDf+ZsZhL3Yd8AKTOwGddplS
 YgSn5pW802Ugqp19HIAdw78yT79YwlyqJqSHbKpwOeWEJm/plWIE5mV5w4bH1K5TULo23+U
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Christian,

On Thu, 19 Oct 2017, Christian Couder wrote:

>   Add Git/Packet.pm from parts of t0021/rot13-filter.pl
> 
>  perl/Git/Packet.pm      | 118 ++++++++++++++++++++++++++++++++++++++++++++++++

This change, together with forcing t0021/rot13-filter.pl to use
Git/Packet.pm, breaks the test suite on Windows:

	https://travis-ci.org/git/git/jobs/292461846

There are actually two problems, one of which is fixed by

-- snip --
diff --git a/perl/Makefile b/perl/Makefile
index 15d96fcc7a5..f657de20e39 100644
--- a/perl/Makefile
+++ b/perl/Makefile
@@ -30,6 +30,7 @@ instdir_SQ = $(subst ','\'',$(prefix)/lib)
 modules += Git
 modules += Git/I18N
 modules += Git/IndexInfo
+modules += Git/Packet
 modules += Git/SVN
 modules += Git/SVN/Memoize/YAML
 modules += Git/SVN/Fetcher
-- snap --

You will want to pick this up in the next iteration. (You simply did not
notice because you did not build with NO_PERL_MAKEMAKER.)

However, that *still* does not fix the test for me: note how in the
verbose output recorded in Travis (see the link above), Perl fails to find
the Perl modules and then says:

Can't locate Git/Packet.pm in @INC (you may need to install the Git::Packet module) (@INC contains: C \BuildAgent\_work\5\s\perl\blib\lib;C \BuildAgent\_work\5\s\perl\blib\arch\auto\Git /usr/lib/perl5/site_perl [..]

Note that the correct blib path starts with `C:\BuildAgent\_work` and
the line

	use lib (split(/:/, $ENV{GITPERLLIB}));

splits off the drive letter from the rest of the path. Obviously, this
fails to Do The Right Thing, and simply points to Yet Another Portability
Problem with Git's reliance on Unix scripting.

But why is it a Windows path in the first place? We take pains at using
only Unix-style paths in Git's test suite after all.

Well, this one is easy. We call git.exe, which is a pure Win32 executable
(i.e. it *wants* Windows paths, even in the environment passed to it) and
git.exe in turn calls Perl to interpret rot13-filter.pl. So on the way to
git.exe, GITPERLLIB is converted by the MSYS2 runtime into a Windows-style
path list. And then it is not converted back when we call Perl.

As a workaround, I used a trick to exclude GITPERLLIB from being converted
by MSYS2: setting the environment variable MSYS2_ENV_CONV_EXCL=GITPERLLIB
"fixed" the test for me (with above patch thrown in). I also set the test
in the Visual Studio Team Services build definition that runs those tests
triggered by Travis.

If your patch makes it into Git's `master`, we may have to hardcode that
MSYS2_ENV_CONV_EXCL=GITPERLLIB (or augment any existing
MSYS2_ENV_CONV_EXCL), so that other Windows developers do not have to
stumble over the same thing and then spend 3 hours to debug it.

Ciao,
Dscho

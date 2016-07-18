Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 070FE2018B
	for <e@80x24.org>; Mon, 18 Jul 2016 13:52:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751396AbcGRNww (ORCPT <rfc822;e@80x24.org>);
	Mon, 18 Jul 2016 09:52:52 -0400
Received: from mout.gmx.net ([212.227.17.20]:61252 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750732AbcGRNwu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2016 09:52:50 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0LtEtL-1bEmok2cl1-012mgL; Mon, 18 Jul 2016 15:52:33
 +0200
Date:	Mon, 18 Jul 2016 15:52:31 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Jeff King <peff@peff.net>
cc:	Eric Wong <e@80x24.org>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, git@vger.kernel.org
Subject: Re: [PATCH] test-lib: stricter unzip(1) check
In-Reply-To: <20160718130405.GA19751@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1607181536540.3472@virtualbox>
References: <20160718064431.GA10819@starla> <20160718130405.GA19751@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; CHARSET=US-ASCII
Content-ID: <alpine.DEB.2.20.1607181546001.3472@virtualbox>
X-Provags-ID: V03:K0:b5BUrHUpvDEMeSO0PUGpqyCmheqoRTSP8s8UXcBQlTSPRkMd5CD
 /mlEMZmCIvocKL2O1XOlCoVNAHZjQEBAudkU8ylyq+uZrGFDEDbA7wqCs+lEnA9GaR+hAK/
 FVXKVZt7YJWQYxnvU5MA/DBKgbEgMQO1n1/XThEVkT3jmF+deqwBKBo5iZAICHDPCGpQvvD
 xWegFHtm2ZhgQu8IBm3XQ==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:eV3MUQU3hzs=:ypuTUd1ZMzXO686cexGuJ0
 KMJOBuE/nrZTqBthqqB7pWTIhhFHqodi/KRjI/mC2Ea13OGk1GSdTtq8KKsdQ6yNrFDCl6qAb
 ojs9V+iYo4FpSW6Lwq7X6y4nlN96gVe8XHvyTVfwF8ZEekASwtd323jAoxhcbiN/KRzT5Kadx
 mm01qw73rjHhRbbODmt7k2hxgq+F5g8+hcO5vB4zrsfhStnRidwaTaGAwtldAfJ2Iwu/8sPBK
 9HaCjqh/feHRY/M9Frd0mJxqVia+U+lHgRSzj88O4FAp579bPVRa9j/8YORGSa8nLhXeV8HuI
 qpDoQ3ss3T1g+0tQ6vDGmd0AFXbMlvzFPIovTv0Fv9YciK/maA20MbBhQs8ANMvyHa5ZGF1ie
 pqTkOX4n+Xd2Lwu4kOVZWt+CWJV3YVIfOcWh6BycIL7yU1kQyfyFmceCvP4ZokdCmEP1OfEAz
 3Ryh/iOd7U3JDbSns1Ine3Sy4lVIwyHlzv3OXwsZLlRYXKzaKTnHuzMMz3cu2lbLi1QSv4xTI
 +vN2lBUOVbnYIA32HhcPEO4vRXjBUgU9aSvUcic9cx37LbVkAlL9pl20R7tkICqMyTZgeU2xC
 7FAXD8kR0BN7OFOYb1vKIq9LlaLaYoBbM3MsSFjCMuO/rZk90MbzbqwbPiIO/XIQckYcrWvLB
 lSGCMocOercwqyAZ3KAYokmocMGU4cZ3RxuxJBAKv8OmkfQmNfe9PMhXovBADzZ7GTDrfZlBt
 EKW868ESAOc0jZH531iqvYn80lPO2HMq/ucffsNYbae1ljOpQnbnUuo/2d7sn52LES57pyy6o
 ia5HcnF
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Peff & Eric,

On Mon, 18 Jul 2016, Jeff King wrote:

> On Mon, Jul 18, 2016 at 06:44:31AM +0000, Eric Wong wrote:
> 
> > On FreeBSD 10.3 (but presumably any FreeBSD 8+), /usr/bin/unzip
> > exists, but is insufficient for t5003 due to its non-standard
> > handling of the -a option[1].  This version of unzip exits
> > with "1" when given the "-v" flag.
> > 
> > However, the common Info-ZIP version may be installed at
> > /usr/local/bin/unzip (via "pkg install unzip") to pass t5003.
> > This Info-ZIP version exits with "0" when given "-v",
> > so limit the prereq to only versions which return 0 on "-v".

Hrm. That sounds a little magical, and fragile, to me. What if the next
person's unzip returns 0 and *still* cannot handle -a?

I'd rather do something like

-- snipsnap --
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 0055ebb..5b9521e 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -929,7 +929,8 @@ yes () {
 }
 
 # Fix some commands on Windows
-case $(uname -s) in
+uname_s=$(uname -s)
+case $uname_s in
 *MINGW*)
 	# Windows has its own (incompatible) sort and find
 	sort () {
@@ -1100,6 +1101,7 @@ test_lazy_prereq SANITY '
 	return $status
 '
 
+test FreeBSD != $uname_s || GIT_UNZIP=${GIT_UNZIP:-/usr/local/bin/unzip}
 GIT_UNZIP=${GIT_UNZIP:-unzip}
 test_lazy_prereq UNZIP '
 	"$GIT_UNZIP" -v

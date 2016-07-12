Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 618CE2018E
	for <e@80x24.org>; Tue, 12 Jul 2016 11:25:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932617AbcGLLZq (ORCPT <rfc822;e@80x24.org>);
	Tue, 12 Jul 2016 07:25:46 -0400
Received: from mout.gmx.net ([212.227.15.15]:50645 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932188AbcGLLZo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2016 07:25:44 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MhAVV-1bj7P13P05-00MLSP; Tue, 12 Jul 2016 13:25:22
 +0200
Date:	Tue, 12 Jul 2016 13:25:20 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Jeff King <peff@peff.net>
cc:	Junio C Hamano <gitster@pobox.com>,
	Andreas Schwab <schwab@linux-m68k.org>, git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.9.1
In-Reply-To: <20160712073912.GA26431@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1607121257450.6426@virtualbox>
References: <xmqqbn247x1f.fsf@gitster.mtv.corp.google.com> <87lh17kgdy.fsf@linux-m68k.org> <20160711235417.GA26163@sigill.intra.peff.net> <xmqqy4577h0o.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1607120927410.6426@virtualbox>
 <20160712073912.GA26431@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:xkWxAseLK0ydZbE8gynyRC7tonPRyxpC6cQt1u00Dr+Ob8ayQMF
 nSvdbMt5XffSHnoRQjjqL2PB1/DFM+D6DqacYD+erdR6LdZSgcOmre43clX4ODcNwETlxD9
 7ikv11zZKm+LKgiGCzzQyu/h+ztpBxHgFiMEWvyd/vOO3b0le89SOosibyj7VuI/WkH61jK
 CoT4H0catD7p9ZqGcr/Ug==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:tVAEMDLjgWA=:Rm6LQ+HbCJZ655ha/zwr4N
 wbQ1v+KMVGncZVFg5VEzKvbw3H6zufB5m2V3jo6SVPYxi+B/sxd4NgpQxCthcgBtfbmDNEDXQ
 lH0W+YwCm1nb2L2TV5PkOUG2dzpJ+945pO+yky8bvEeo53Sy2+VpcAgLt6aQqqCb8Z9fHzKk7
 NVAEJUhlcrGvtOsBQhz18r5bErIdsfSj3eBFhpfp867XgowbKPl3/Yv9HxVOF5QTbOgTkSs5z
 etG2nAEd5TxRVu2HOUKxAscodQbYbkjW8vtrRhBiDgE/Drs8hjUTDOh1icY0w2YrV1bzmOzju
 vZ4JDpX9MoALLfKONtFpVA17OwenKDv1EWPMI91uqxpmUBL6OYQ3TxEhjCaLP2rPxbVJEsWD/
 8exr98iXvM6+RcowRZfWq83bOV7zBH3zhAtJq+r87i4g3yAszynz6/gIHVO83whsW6jUcucr/
 vU+FcgiWE4qXFoXyUIuPYEQT7rolpyJKVrCIJvzV1wUBNPwDUofOazND9rnuZ1Ttn26OG4WZH
 XF3a3J9pwsrzvm0pgobM/YJA84Mi47srWzRXCk5EIRI1uXalsi0aDVQZSz6oOn+45N/zl47of
 sX1re0m7g0NPh9BGkiieSXGbVy06wnk+pc94Bep5yBu9p6kMCB4jVb69cLZ4Bz+0ut0TyNUSu
 TQux5QtL9/1D2Cnp/sQLY+l8q7Xax3uXEcKB5OgR5wRt83kTjLMZsv5GCuu3vFcvMYxOc4t+3
 /HJXhKKLOWQz+MD9sEYJkBNL4Y6nCFM1BSw9ol0Nsy7YrtHDKx6rmGpFBtogin4+nm2jL2ur2
 duQb/kx
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Peff,

On Tue, 12 Jul 2016, Jeff King wrote:

> On Tue, Jul 12, 2016 at 09:30:28AM +0200, Johannes Schindelin wrote:
> 
> > FWIW I have this monster patch as a starting point (I plan to work more on
> > this today):
> 
> Cool! Thanks for working on this.

Well, I had to. Git for Windows v2.9.1 needs to get released, and I won't
do that with a failing test suite.

> I suspect we should still do something about skipping those tests,
> though, if only because the v2.9.x maint track is broken, and switching
> to time_t is a sufficiently large change that we probably don't want it
> for maint (it _seems_ like it shouldn't cause any problems, but I'm
> wondering if we might inadvertently trigger funny issues around
> signedness or something).

I totally agree that this patch is very, very large. And yeah, this change
is intrusive enough that it should not hit maint (but then, IMO neither
should the change that triggered this test failure have hit maint).

So I think I'll go with this for the moment (as we all know, my patch
series often go through a couple of commenting rounds, and are not always
picked up quickly, and I do not wait that long with Git for Windows
v2.9.1):

-- snipsnap --
[PATCH] Work around test failures due to timestamps being unsigned long

Git's source code refers to timestamps as unsigned longs. On 32-bit
platforms, as well as on Windows, unsigned long is not large enough to
capture dates that are "absurdly far in the future".

While we will fix this issue properly by replacing unsigned long ->
time_t, on the maint track we want to be a bit more conservative and
just skip those tests.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t0006-date.sh | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/t/t0006-date.sh b/t/t0006-date.sh
index 04ce535..d185640 100755
--- a/t/t0006-date.sh
+++ b/t/t0006-date.sh
@@ -48,10 +48,17 @@ check_show default "$TIME" 'Wed Jun 15 16:13:20 2016 +0200'
 check_show raw "$TIME" '1466000000 +0200'
 check_show iso-local "$TIME" '2016-06-15 14:13:20 +0000'
 
-# arbitrary time absurdly far in the future
-FUTURE="5758122296 -0400"
-check_show iso       "$FUTURE" "2152-06-19 18:24:56 -0400"
-check_show iso-local "$FUTURE" "2152-06-19 22:24:56 +0000"
+case "$(test-date show:iso 9999999999)" in
+*2038*)
+	# on this platform, unsigned long is 32-bit, i.e. not large enough
+	;;
+*)
+	# arbitrary time absurdly far in the future
+	FUTURE="5758122296 -0400"
+	check_show iso       "$FUTURE" "2152-06-19 18:24:56 -0400"
+	check_show iso-local "$FUTURE" "2152-06-19 22:24:56 +0000"
+	;;
+esac
 
 check_parse() {
 	echo "$1 -> $2" >expect
-- 
2.9.0.278.g1caae67


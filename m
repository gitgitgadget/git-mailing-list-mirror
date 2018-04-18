Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D564D1F404
	for <e@80x24.org>; Wed, 18 Apr 2018 21:49:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752245AbeDRVtR (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Apr 2018 17:49:17 -0400
Received: from mout.gmx.net ([212.227.17.22]:37139 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750981AbeDRVtQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Apr 2018 17:49:16 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Le69A-1ef1Bp2bwi-00pwBM; Wed, 18
 Apr 2018 23:48:53 +0200
Date:   Wed, 18 Apr 2018 23:48:22 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Kim Gybels <kgybels@infogroep.be>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Oleg Gubanov <oleg.gubanov@gmail.com>
Subject: Re: [PATCH 2/2] daemon: graceful shutdown of client connection
In-Reply-To: <20180415202122.GA4657@infogroep.be>
Message-ID: <nycvar.QRO.7.76.6.1804182316420.4241@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <20180412210757.7792-1-kgybels@infogroep.be> <20180412210757.7792-3-kgybels@infogroep.be> <nycvar.QRO.7.76.6.1804131440100.65@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <20180415202122.GA4657@infogroep.be>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:0YmH18hOnoZKJrXzXDNv2liomL3yVR+mzxrx5J+xYqkXoHhZkjN
 hXT1RsBbQC4ji0A7IYYtKIu5eo50SqthDJvMWl0ge6vHSkT+Kms2B6NTRlH/TkNNwMuZI8C
 nfxJstQmv1GyBHZ15i5ZJThWJzm3G70ALx28vRcDlC7oIEtvc0D61PTfiwA2dm1ByU1F5I5
 M+RG3mcyaVKsStBFFtJyA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:IFAf3U54Dj8=:oBE+npA03fm4ITjF0NV0sP
 /ZGIVHxmtMk0eg3jWijpdI6U3yH5Vd0i8yqXgMEgcqy+b5BTUEY9caZr5eNsPRrlMMQjq28ou
 iUNsUzb1laH74yiFZAxAf5beHT8t16BzLCxZR3JWUsxp0tdsYqETSOnyGhBNQuBr8t2DbCZpH
 h5wzYyz8qGIJvXnoS2lUrrFu2TMwtaHEwNAqkrrRXFXInFgALS1tlCGH2hdZPgAuKZmlm3kl8
 ejAPDAQYemGsaAPWsDyznEnK5BxXy5AMCAYQZ9kK0nhlhQOpCLM3CifL+g9Jr13N3n09DyckC
 5Efrlnte0KIj4KnlHsjzXZmlEmut2iwOOCPn+S92dDYSeBD3UqqCad41sy0pw1iB0SoVAfhlA
 UsRY9yXtlWKQPtRrg6cmpozPxrqbKuyZMX52hVU4GvJSWu9784AWoEc0KQeYOg+d4FYyuWc0N
 ljgtW13NKEa5EZDNfQEZwCMziTshmpABgoId/63u1O7dSok1+U1yfTyr1w3BJhI5RR/cdTc+1
 vqEK0dfr12v+FZbZtlnyGP79opOtjBn3szoL63UungxMPxN/c8639WtyQh3dhPVXX+zA7ZP2H
 XZXsKb+YBmp9Go01H2WbrBfW+h/ppQRIkSe5a25v9uZKD/1gGLbhVy6b2XyDYwlN3usbaRYnm
 yahsgta7ByAXWQGBFlfyPQ+vfSdSWjH8rXD7HRqtL8or8iO/LnEVDdOPb29CM5Nt/pzauCP6A
 vgqv5I1pSwb7DsTaWGXLV/PNdrWBrb0t8GxAN5qs270zT8zkMKAPk0gbuQgFnOBuGRZbgVzPq
 x9TtNQ4KakFH6hv47o7kpsykWzBu7FcmPGhdalW2Uutv44O648=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Kim,

On Sun, 15 Apr 2018, Kim Gybels wrote:

> On (13/04/18 15:03), Johannes Schindelin wrote:
> > I wonder whether you found a reliable way to trigger this? It would be
> > nice to have a regression test for this.
> 
> On my system, it reproduced reliably using Oleg's example [1], below is
> my bash version of it.

Okay.

> Script to generate repository with some history:
> 
>   $ cat example.sh
>   #!/bin/bash
>   
>   git init example
>   cd example
>   
>   git --help > foo.txt
>   
>   for i in $(seq 1 12); do
>       cat foo.txt foo.txt > bar.txt
>       mv bar.txt foo.txt
>       git add foo.txt
>       git commit -m v$i
>   done

Okay, so this sets up a minimal repository with a moderate size, inflating
foo.txt from the initial Git help text by factor 2**12 = 4096. The help
text is around 2kB, so we end up with an ~8MB large file in the end that
grew exponentially.

>   $ ./example.sh
>   Initialized empty Git repository in C:/git/bug/example/.git/
>   [master (root-commit) 2e44b4a] v1
>    1 file changed, 84 insertions(+)
>    create mode 100644 foo.txt
>   [master 9791332] v2
>    1 file changed, 84 insertions(+)
>   [master 524e672] v3
>    1 file changed, 168 insertions(+)
>   [master afec6ef] v4
>    1 file changed, 336 insertions(+)
>   [master 1bcd9cc] v5
>    1 file changed, 672 insertions(+)
>   [master 2f38a8e] v6
>    1 file changed, 1344 insertions(+)
>   [master 33382fe] v7
>    1 file changed, 2688 insertions(+)
>   [master 6c2cbd6] v8
>    1 file changed, 5376 insertions(+)
>   [master 8d0770f] v9
>    1 file changed, 10752 insertions(+)
>   [master 517d650] v10
>    1 file changed, 21504 insertions(+)
>   [master 9e12406] v11
>    1 file changed, 43008 insertions(+)
>   [master 4c4f600] v12
>    1 file changed, 86016 insertions(+)
> 
> Server side:
> 
>   $ git daemon --verbose --reuseaddr --base-path=$(pwd) --export-all
>   [4760] Ready to rumble
>   [696] Connection from 127.0.0.1:2054
>   [696] unable to set SO_KEEPALIVE on socket: No such file or directory
>   [696] Extended attribute "host": 127.0.0.1
>   [696] Request upload-pack for '/example'

I guess apart from the generated repo size (which would make this an
expensive test in and of itself), the fact that we have to run the daemon
(and that lib-git-daemon.sh requires the PIPE prerequisite which we
disabled on Windows) makes it hard to turn this into a regular regression
test in t/.

Although we *could* of course introduce a test that does not use
lib-git-daemon.sh and is hidden behind the EXPENSIVE prerequisite or some
such.

BTW I just tested this, and it indeed fixes the problem, so I am eager to
ship it to the Git for Windows users. Let's see whether we can convince
Junio that your quite small and easy-to-review patches are not too much of
a maintenance burden, and the fact that they fix a long-standing bug
should help.

BTW I had to apply this to build with DEVELOPER=1:

diff --git a/daemon.c b/daemon.c
index 97fadd62d10..1cc901e9739 100644
--- a/daemon.c
+++ b/daemon.c
@@ -1162,13 +1162,13 @@ static int service_loop(struct socketlist
*socklist)
 	signal(SIGCHLD, child_handler);
 
 	for (;;) {
-		int i;
+		int i, ret;
 
 		check_dead_children();
 #ifdef NO_POLL
 		poll_timeout = live_children ? 100 : -1;
 #endif
-		int ret = poll(pfd, socklist->nr, poll_timeout);
+		ret = poll(pfd, socklist->nr, poll_timeout);
 		if  (ret == 0) {
 			continue;
 		} else if (ret < 0) {

Would you mind squashing that in?

Thanks,
Dscho

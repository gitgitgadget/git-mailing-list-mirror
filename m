Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62956203C1
	for <e@80x24.org>; Fri, 22 Jul 2016 08:11:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752040AbcGVILU (ORCPT <rfc822;e@80x24.org>);
	Fri, 22 Jul 2016 04:11:20 -0400
Received: from mout.gmx.net ([212.227.15.15]:60385 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751821AbcGVILO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2016 04:11:14 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MKHtm-1bS9hy3TB0-001fO6; Fri, 22 Jul 2016 10:11:08
 +0200
Date:	Fri, 22 Jul 2016 10:11:07 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Brett Cundal <brett.cundal@iugome.com>
cc:	David Aguilar <davvid@gmail.com>, git@vger.kernel.org,
	Roberto Tyley <roberto.tyley@gmail.com>
Subject: Re: [PATCH] git-subtree.sh: Use --allow-unrelated-histories when
 splitting with --rejoin
In-Reply-To: <CAMaPC4JTerX7TSg5_M=DOztyaGUVd5_kK8cmTJuWrCekGgSodw@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1607220954470.14111@virtualbox>
References: <010201560af48050-012ea887-a1e1-4d1b-82d3-4799ac7788bc-000000@eu-west-1.amazonses.com> <20160721052625.GA31423@gmail.com> <alpine.DEB.2.20.1607211724430.14111@virtualbox> <CAMaPC4JTerX7TSg5_M=DOztyaGUVd5_kK8cmTJuWrCekGgSodw@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:1asvNgeP1pqvwfX8C7lu09lPDcRHppk+i/wHdQD7g13zy6PdoOz
 XpIrk0OpolF9xXqJ1vwIqtpnL+aK+xoU51mvzpxq3RHaF4r44YJ2HV6xHyewDpP7EnsY4FA
 dFZuwvDMDHwERF1TqxaUFolit9KV5zcAeJ1bMy/hNRuiNej1qe/KQY9NUVv9OjQBRPjt+vb
 Rd9NElJlEv/KnizezpUWw==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:U4yllLEPbeY=:NLdhTJaS/jsBuhyeByWF1B
 7s6P5f7FFQ81oQQqq8eRbixEHzUhBSa96246JN4jLw676t4HpIQQDeP5ZeuOVJpOB4o/BhOHG
 eMglrGt2k2MNUmLANPFxDNe/+pXfUlASo/o8HZls9PmhmOilkC0u/GYG6EC/g3IdBB+dmT8AL
 5o5nhxp3LuHMXaktuaaketFB403zLKc0xhyOZVxHeAl7T3UX8FGYdUdoaQLqUD7zCIuil/rKI
 Bb2zncUB2ST0SE6t7ScpgCwH6co4VFjmjXSqrBZGfjhGMXOLLXAhYzTVfsdp/H0g/oDCiucbj
 e+CJvqYNVXswPTRBZeKslSRygPD3Zx9Iu+rQ+jlvfLlYqhC8YO8k1fKydvEfSZNwL/dR6m9Zz
 BNYL+rBDiF49X0IdbBAAYFFsvq10kCXc3Nh6f9yXKTfjtlvWmu4E1wYGw44JPPudFeYlyetFc
 XvP4O6wV/Xr8c74FewpECd3saBeL6dL4O+sT9dtvaoec1m+4oG5UA6yL+HVxyTnd/iGiUuyIK
 DU6EPiH2KB7OB/o4B5cf0JXioHbpycqLFkozoiVwxPMc5FS18um3mUowJhDkXF8F9GZbpceps
 nNPTXdseSUTMv4cRNdj731H/q3G3syI68/E83xu4aQgrtntN2USil8eX9SbdGS3/AuWH+Q1CM
 5voVrHHj1ezRtV5DvZEUte/H7g8ZK80AX1u+H73aPOfNKE+ptK+29OxlxtjdKTkGikP4h/FD3
 iiQ/WnQgehUHwZ7uKsymp0h+J3aR3G1T4HjBqeaAm6yA/pApd2vHUi2rNasvMwKcrSDU18vyw
 qiLc9+W
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Brett,

On Thu, 21 Jul 2016, Brett Cundal wrote:

> [re-sending as plain-text so the list software doesn't reject as
> spam... what decade is this?]

I know it feels good to get frustration off of your chest by ranting. I am
very sympathetic to that. Please note, however, that it puts the people
who are ready to help you immediately into a defensive corner. Probably
unintentional?

> Sorry about the empty commit message... there was one originally (albeit
> not as detailed as the pull request), but I guess it got stripped? As
> you have probably guessed, I have no idea how you guys do patch
> submission.

It is okay. For historical reasons, the patch submission is a bit more
involved than simply opening a Pull Request. We also frown upon
top-posting, among other rules of netiquette. You may dislike it, but you
would have to build more of a "street cred" if you truly wanted to try to
convince the Git developers to change it.

Back to the patch you wanted to submit: since this is an important bug
fix, I spent the time to clean it up. The only missing bit that requires
further effort from your side is that we need your Sign-off. See
https://github.com/git/git/blob/v2.9.2/Documentation/SubmittingPatches#L239-L291
for an explanation. Essentially, you are stating explicitly that you are
not legally prohibited from contributing this patch. If you can say that,
simply reply with a

	Signed-off-by: Brett Cundal <brett.cundal@iugome.com>

We can take it from there by inserting it into the following patch:

-- snipsnap --
From: Brett Cundal <brett.cundal@iugome.com>
Subject: [PATCH] subtree: allow unrelated histories when splitting with --rejoin

Git 2.9 added a check against merging unrelated histories, which is
exactly what git subtree with --rejoin does. Adding the
--allow-unrelated-histories flag to merge will override this check.
---
 contrib/subtree/git-subtree.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 7a39b30..556cd92 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -661,7 +661,7 @@ cmd_split()
 	if [ -n "$rejoin" ]; then
 		debug "Merging split branch into HEAD..."
 		latest_old=$(cache_get latest_old)
-		git merge -s ours \
+		git merge -s ours --allow-unrelated-histories \
 			-m "$(rejoin_msg "$dir" $latest_old $latest_new)" \
 			$latest_new >&2 || exit $?
 	fi
-- 
2.9.0.281.g286a8d9



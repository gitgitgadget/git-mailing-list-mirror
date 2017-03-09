Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A46371FBEC
	for <e@80x24.org>; Thu,  9 Mar 2017 11:52:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932195AbdCILwW (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Mar 2017 06:52:22 -0500
Received: from mout.gmx.net ([212.227.15.15]:50412 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754289AbdCILvx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2017 06:51:53 -0500
Received: from virtualbox ([95.208.58.21]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MGSDw-1czC8Z2WmW-00DDUh; Thu, 09
 Mar 2017 12:51:07 +0100
Date:   Thu, 9 Mar 2017 12:51:06 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 0/9] Fix the early config
In-Reply-To: <xmqqinnj1jb6.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1703091243260.3767@virtualbox>
References: <cover.1488506615.git.johannes.schindelin@gmx.de> <cover.1488562287.git.johannes.schindelin@gmx.de> <20170304073952.drfgy7jacnlm6tum@sigill.intra.peff.net> <alpine.DEB.2.20.1703071314180.3767@virtualbox> <20170308073035.pt5ysp6bzpozoqps@sigill.intra.peff.net>
 <xmqqy3wf3dbo.fsf@gitster.mtv.corp.google.com> <20170308174237.cm6e5uvve6hu7lpf@sigill.intra.peff.net> <xmqqinnj1jb6.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:rKHdJU7s+b2JlpJMHsvzbCodDJSqZImyCPBt2sxdun00e5qDwpp
 pIJleDfodl90dgc/O/Cb8aVWPPuVhXNSDfDhZgL7Xkn93Fl7Vo1L+Sr9wIrbpB22r6PoEmU
 XkD+0ekdi8Qy5vHsBx1YVkj/7KUNiNWIFLBqPS23n1yFTykR+1hIXh+X4Qku6SqH3zRGhC7
 0H6KY+7Sjzzbp3UJ0lLRg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7GlOyJjtczQ=:QAvz9MruX1hicy4ajpPt1Z
 tg49qhIraOvMEzTrgdZcLOltKjf/jwVHfjVhU6Xb31jgv8F9L1j0Y+b4N7uGQjyl9bwDJUp/3
 04AgZ102Xzow4UHD7DudlxmsyR/zcmZjcNbKUe4uzRn6D6LKQx24KdU5ZTyOyxTW756qC5d0H
 LZWWZgAJiJPliC6T0LOrY7+VZfMji4lF0Wjiq3iYi3s7iyMrE9kl71m7PoCGhW+0j+ZQiqYk3
 ekrJa46eso+ohpsjIHtKKb59/8lTheYPFGh0bvEQ+3iOSoHmgbT1c2t6UjUSmykgwAixKpBcg
 BZX1uGbIAENJobJ1k55e9qLEO0HefiWYWSiPEzfruKOL04BFq8EQtwP67GbcyCRCRaPE/xfHq
 xVeJGcHRIE9XMwpSa8vgdBzsca86yOHpvIcibhO3i964SuyA9emuhoFWsXUp6LWoJUGEbagtl
 7fbWOdMYG1iBSaw1fWborSBSP7zptqD/4s39UQc8k18N91AUxE/TmTZe0ndkwxNIBcZYsepgP
 gmolXffav2j11MYkc5/Y/B2uUd+l+VZYyN5Xdc98NHeBFKkJILaOnALnWKxORCKaHBITnemTw
 a5PvjjdpHZ0Nv5a3JFBs5OLgcO3M5tf+GOg9JEL2Ga2T6nmz7v/itcoUwjJDjefzA7ts9GREV
 Qo0pY7W4ff+uONMJtFgLGASL7+P52Y8SH4snSblVLJZb7gD25wYja3tCkHUwa1rQM6dC6tDCY
 Rjggg+YfChqGfWkpBAM2G6M+GLYVCkV6Z9ABSK5DEIereBPuS/lcoL1UyNyO6SoKQ4Icvg5/K
 j16OPZ7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, 8 Mar 2017, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >> Or are you discussing a more general issue, iow, anything that can
> >> work without repository (i.e. those who do _gently version of the
> >> setup and act on *nongit_ok) should pretend as if there were no
> >> (broken) repository and take the "no we are not in a repository"
> >> codepath?
> >
> > Yes, exactly.  It would have been less confusing if I picked something
> > that passed nongit_ok. Like hash-object:

... or like testing the early config directly?

> >   $ git init
> >   $ echo content >file
> >   $ git hash-object file
> >   d95f3ad14dee633a758d2e331151e950dd13e4ed
> >
> >   $ echo '[core]repositoryformatversion = 10' >.git/config
> >   $ git hash-object file
> >   warning: Expected git repo version <= 1, found 10
> >   d95f3ad14dee633a758d2e331151e950dd13e4ed
> >
> > The warning is fine and reasonable here. But then:
> >
> >   $ echo '[core]repositoryformatversion = foobar' >.git/config
> >   $ git hash-object file
> >   fatal: bad numeric config value 'foobar' for 'core.repositoryformatversion' in file .git/config: invalid unit
> >
> > That's wrong. We're supposed to be gentle. And ditto:
> >
> >   $ echo '[co' >.git/config
> >   $ git hash-object file
> >   fatal: bad config line 1 in file .git/config
> >
> > Those last two should issue a warning at most, and then let the command
> > continue.
> 
> Yeah, I agree with that as one of the worthy goals.  IIUC, we
> decided to leave that outside of this series and later fix on top,
> which is fine by me, too.

How about this on top, then:

-- snipsnap --
From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH] t1309: document cases where we would want early config not to
 die()

Jeff King came up with a couple examples that demonstrate how the new
read_early_config() that looks harder for the current .git/ directory
could die() in an undesirable way.

Let's add those cases to the test script, to document what we would like
to happen when early config encounters problems.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t1309-early-config.sh | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/t/t1309-early-config.sh b/t/t1309-early-config.sh
index 0c55dee514c..027eca63a3c 100755
--- a/t/t1309-early-config.sh
+++ b/t/t1309-early-config.sh
@@ -47,4 +47,29 @@ test_expect_success 'ceiling #2' '
 	test xdg = "$(cat output)"
 '
 
+test_with_config ()
+{
+	rm -rf throwaway &&
+	git init throwaway &&
+	(
+		cd throwaway &&
+		echo "$*" >.git/config &&
+		test-config read_early_config early.config
+	)
+}
+
+test_expect_success 'ignore .git/ with incompatible repository version' '
+	test_with_config "[core]repositoryformatversion = 999999" 2>err &&
+	grep "warning:.* Expected git repo version <= [1-9]" err
+'
+
+test_expect_failure 'ignore .git/ with invalid repository version' '
+	test_with_config "[core]repositoryformatversion = invalid"
+'
+
+
+test_expect_failure 'ignore .git/ with invalid config' '
+	test_with_config "["
+'
+
 test_done
-- 
2.12.0.windows.1.7.g94dafc3b124


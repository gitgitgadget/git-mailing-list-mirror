Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDCFD209AB
	for <e@80x24.org>; Fri, 14 Oct 2016 13:20:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932742AbcJNNTv (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Oct 2016 09:19:51 -0400
Received: from mout.gmx.net ([212.227.17.21]:49550 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932444AbcJNNTd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2016 09:19:33 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0LwW8p-1d2xhA17GB-018Ius; Fri, 14 Oct 2016 15:19:27
 +0200
Date:   Fri, 14 Oct 2016 15:19:26 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v4 25/25] sequencer: mark all error messages for
 translation
In-Reply-To: <cover.1476450940.git.johannes.schindelin@gmx.de>
Message-ID: <a9e1ee4e2315a106337d598d17089304f4d93643.1476450940.git.johannes.schindelin@gmx.de>
References: <cover.1476120229.git.johannes.schindelin@gmx.de> <cover.1476450940.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:FTb0+Ze76nYfV4SCWvBDTL7mRMml2aDcozg5039h/sXgNAYz3/r
 52wGMRHBbW4ae/gSty0WL+sxWuWZOhj6NiI+UHMa4OiCGMX/CsNthfkqs33wAL3p8wmIDRL
 MCJaFOv9580sXCY3iIhGiS0gDGbaobDGKmqLvFTl3UpL/uuROdzYo/Lb7aK5bsorPrHHTP6
 Hk5jqX4/6eLyM5gFvzqkQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:tY51rLuegWE=:YyrRWxFmuE0xKhd9pCPXoO
 t1Q6ZqPdUrnsS8YGarJG8JLqBr7hHVyEkV1l1glr4Q/qchzNY2fCqlLsaKLuTj5egpMz9fVXV
 qbwqdDRoosjRqxDhJh06KqZDoW6yk0BrHLcNZSA6+Nflx4xOCPkHIjheUMp2Yxva4fVAc8ifx
 51EYyU+Ram26E/339gTB4RbE+xvR5zzptldsXww3aqXCy3p1MITJFtXfzzFSIHTZ3Tjn9+66g
 9fv9Fv8mXNQeiTzHpQ2QpPXZbZvSwtJQHITXmhrMIyHL+LVRAq3XzM/WYXizXV/y1MOSegYO0
 ks2c8A+54G97ZzR9YLIzvJbjWuOgtzXe+kQxRBoHgcK5pn/G57rYOIeFvHfoK39oMEppKVH6b
 VQZhrUr4lGdbVFChHwPzX+jFz6NWyjW93SMnKhn1X73Pols2CQLBzBJt6JVbvXHW+nSmfumqO
 aSwFRwpwRe5YsM0co6ev3Q5WNzzV7d4imEABIeTb/T1ydlTSq5X5n+cQahUmL5oipsFVFUBqJ
 0uN2cvNBwsKWz50KtmRezSzILgFIaNA0b4z+YpKGLnZ3W4M2AjJjcKULD5iKFzc/EDV4gTatm
 5o8jorqehQCc8sS1HGt8r53n4xlSrHi8QbqbP9OANW1jEuGSR1xfYhYBxuoawYfr7DRAKPPwF
 2qrzp8yyLppS0lk2oyrB8bPfmzCv1rEc39cVMt3BwcDnwHfy3vgBPShWaoiwGS1oerTu/wFbJ
 3CUjcFrU8yDm4zCZteeLyvk3+IUmmlPxDMNu70vp63nLo2mLpGtsZapCtVinznnBYAmhJ0aYB
 GVqxqFW
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There was actually only one error message that was not yet marked for
translation.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 57c5c0c..1cf70f7 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -483,6 +483,20 @@ static char **read_author_script(void)
 	return env;
 }
 
+static const char staged_changes_advice[] =
+N_("you have staged changes in your working tree\n"
+"If these changes are meant to be squashed into the previous commit, run:\n"
+"\n"
+"  git commit --amend %s\n"
+"\n"
+"If they are meant to go into a new commit, run:\n"
+"\n"
+"  git commit %s\n"
+"\n"
+"In both cases, once you're done, continue with:\n"
+"\n"
+"  git rebase --continue\n");
+
 /*
  * If we are cherry-pick, and if the merge did not result in
  * hand-editing, we will hit this commit and inherit the original
@@ -509,16 +523,8 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
 		if (!env) {
 			const char *gpg_opt = gpg_sign_opt_quoted(opts);
 
-			return error("you have staged changes in your working "
-				"tree. If these changes are meant to be\n"
-				"squashed into the previous commit, run:\n\n"
-				"  git commit --amend %s\n\n"
-				"If they are meant to go into a new commit, "
-				"run:\n\n"
-				"  git commit %s\n\n"
-				"In both cases, once you're done, continue "
-				"with:\n\n"
-				"  git rebase --continue\n", gpg_opt, gpg_opt);
+			return error(_(staged_changes_advice),
+				     gpg_opt, gpg_opt);
 		}
 	}
 
-- 
2.10.1.513.g00ef6dd

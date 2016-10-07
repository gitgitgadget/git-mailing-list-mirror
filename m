Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B44420986
	for <e@80x24.org>; Fri,  7 Oct 2016 16:09:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938834AbcJGQJP (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Oct 2016 12:09:15 -0400
Received: from mout.gmx.net ([212.227.17.22]:52887 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936461AbcJGQJN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2016 12:09:13 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MWxtA-1bMdFN0P0G-00VyMI; Fri, 07 Oct 2016 18:09:05
 +0200
Date:   Fri, 7 Oct 2016 18:09:04 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 6/6] wt-status: begin error messages with lower-case
In-Reply-To: <cover.1475856491.git.johannes.schindelin@gmx.de>
Message-ID: <0d3413e8bd648444f9c029820469b73acc20aa8e.1475856491.git.johannes.schindelin@gmx.de>
References: <cover.1475586229.git.johannes.schindelin@gmx.de> <cover.1475856491.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:oN21UqfjVCtQadDf+/wPB9IzTiTTKggEj4QK36BPMO6OMBMTcyA
 iqjWhhRZT0rrZzP4GP0xHHu/l6GmpkGo1rOAsl74Cu9y3B6ywareDuIiV8j2QMS+P1FJSJ1
 uUU2CWDIdf7/zTmdLS+dDDjujHB33ZGQcpg97KnHATvrIPdRmMEjBUYtU9+FRGb2iXLWzrW
 6sY/KYOJBTCw7BQwJqjiw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:nLERngsyuKQ=:idrJYXLoJxYt/K328mCEHM
 fwBR7yw/XLj3nP2E+MFfapcPfPYEcCe+3BbiO1gy8JiRnx/bzfegCsgtEHl5tWh9UU2BwP7HL
 tOFXzAWzhrYpg0M2uRcLNcMfmK6IGOgFZae9Stknrrs5uP5fdnUKJ9V6/JtLgVZ650rQviT4K
 8YxgwWyXdiD2jaUDAUt/OcEWF9D3KlXAi7xALA04wk0Wht93aBvD8fmR/F+9wxxq9re/CwUVJ
 uoJQg+Fcu5Ldp7BR+zWFbPiYUMGEXERELuV2LA5hXjJmrKZfqctnpfMK0AnTUoXNurRbn0++l
 Yd5088U86vfGD0lDOX9qLGCa3DQo6XXrQlw2Hxt8/j4Pl5JEt2mySs8juxuSgI6OMbosNdEt4
 wXltmyywHeZPgJ6bQ78bJ62Y1McRCEAovoT9i1axBXebdna67XOHXiZud6XWNhCEtQySekTBJ
 npDJONewrhCepWw3m489XH7B/HFRuFX2IK/fEVLeEOb/x5lnbVFOxsq1DP0kwjzh44QKzeQrt
 j2NjPeR6+33NrW9u/ZFk5X03mCj1Oz5XkgHiNeFI07CL+E19+mXjjr2ihWOqx3edDdRGmMhgf
 SvIL9XG7E00iwiqE4lR8NIXrcMbbjw3rmSpFu1TgdI1i3Ic26Elr4Hes1SLCPuJroXIf2PasY
 96WB3iPfg5Di5fNSDNIBTp5mj+sChpEWu0+pliP1Z1cER8Q5HhzXHCs7oteQmqXBkii8JF27w
 2F8Lm48RGt9E422+wwqD4mdL9+V9koeGeRjEwaVuN4B2fdbuQllMcvWer0SM3Bte495Ibxk+1
 J91jPo7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The previous code still followed the old git-pull.sh code which did not
adhere to our new convention.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 wt-status.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 0020140..e8e5de4 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -2264,15 +2264,15 @@ int require_clean_work_tree(const char *action, const char *hint, int ignore_sub
 
 	if (has_unstaged_changes(ignore_submodules)) {
 		/* TRANSLATORS: the action is e.g. "pull with rebase" */
-		error(_("Cannot %s: You have unstaged changes."), _(action));
+		error(_("cannot %s: You have unstaged changes."), _(action));
 		err = 1;
 	}
 
 	if (has_uncommitted_changes(ignore_submodules)) {
 		if (err)
-			error(_("Additionally, your index contains uncommitted changes."));
+			error(_("additionally, your index contains uncommitted changes."));
 		else
-			error(_("Cannot %s: Your index contains uncommitted changes."),
+			error(_("cannot %s: Your index contains uncommitted changes."),
 			      _(action));
 		err = 1;
 	}
-- 
2.10.0.windows.1.325.ge6089c1

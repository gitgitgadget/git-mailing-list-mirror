Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29DE6200B9
	for <e@80x24.org>; Fri,  4 May 2018 15:35:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751519AbeEDPfd (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 May 2018 11:35:33 -0400
Received: from mout.gmx.net ([212.227.15.15]:48493 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751470AbeEDPfP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 May 2018 11:35:15 -0400
Received: from virtualbox.mshome.net ([37.201.195.116]) by mail.gmx.com
 (mrgmx002 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0M23zf-1eMVsd2Nxr-00u5Dt; Fri, 04 May 2018 17:35:08 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 16/18] branch-diff --dual-color: work around bogus white-space warning
Date:   Fri,  4 May 2018 17:35:07 +0200
Message-Id: <b99ab186c4f11239a10950b9902d9c87d0e60513.1525448066.git.johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.17.0.409.g71698f11835
In-Reply-To: <cover.1525448066.git.johannes.schindelin@gmx.de>
References: <cover.1525361419.git.johannes.schindelin@gmx.de> <cover.1525448066.git.johannes.schindelin@gmx.de>
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Hy3FCqs3egEUml522LBe8tN+x9UUhkSGC6yUa8/GFuNtgb/MsR3
 29/9CEDAIUU75Ix9gR97hK0bBUp0FTmQzLIFFl2o2aHqvUQXKmEHvpU0sUD2TQDt9MEuqE4
 kLyMy45md7cREhs8XayPzZqMmkoCTtiODvByVavzfeoQpdtij3PXPWx37SIRzdNZgD2+qAq
 zemXXmpXnDuzRZpkOE3Rw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Jy15BhmT7Lo=:NHV49n1QHqNqBX/86CbWut
 f/UUP70pT2B6xX2BE2kjkEvTP+9ERjCK8/ALw/rJVEA4Q7gLaZ3dR1JbqoqIC4T9PHPNRXfe1
 OzMEI4/EpQUqE7N0a0QwFUBMx0D/4/Ngtt4LYdvwXxHLgsxZTKtO8uGTgndekjCc+oRpxOx9U
 p/akDS/Tyasxta/ldSqCp8jZygAPVZIxDpgNsUqTFISXCue0W+dXa+UAHt66D5BWjUTyVmgNa
 C8a4e+JzpkNbiCkz14eNetOM7gG3VFlGmtNSWJuwu08lWlMkthNIGn4isaNFDR/3aB4rEICj4
 VeLQ/+3VKAjRWVazt1dXmFRk07eYljAJdYrBLtkoP9fVXvAd0oFex7z8VOlLUAtLdo+b5woNY
 DLximo82aPAGlhEh0WeFu25/I/HY+PuYOH/qUs7qave2fsLd6JdjuLvUG9EE/KUjOkH64Tqo7
 plSAV3HXjRwOgRQ99HryHz4hBdqUCRguAp3uHu9aNFDL5SieggbvqPnOnQ9zOdBg95MSvNhON
 Wq+UzqOkeXyWRRVDV6NkyosM37XiVyvxPMBG4bGcDAyywyNLuXV4+mLZyLvstf6mhY9oGjKul
 LQEk5po4cdTm7cGM0tQju3Fs1aW77KH/ecy0gV+EPLtZEc8iUJ9EvTDdXrk0UMvOp3u8emdwI
 04MpGOJ7rnE+/BMgR/2kdYoDTiWjpLe8g1Xl61Momt+ZUeh19sZOwIHATT3/Ti33BizYyEJTz
 gKk3PIbNbnMAAIq1GwDSPiOv/9GHWqnPHEAay024rWigue4j0liUO9AA9+kKbjW+ckV3KSeuu
 Do6yPTl
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When displaying a diff of diffs, it is possible that there is an outer
`+` before a context line. That happens when the context changed between
old and new commit. When that context line starts with a tab (after the
space that marks it as context line), our diff machinery spits out a
white-space error (space before tab), but in this case, that is
incorrect.

Work around this by detecting that situation and simply *not* printing
the space in that case.

This is slightly improper a fix because it is conceivable that an
output_prefix might be configured with *just* the right length to let
that tab jump to a different tab stop depending whether we emit that
space or not.

However, the proper fix would be relatively ugly and intrusive because
it would have to *weaken* the WS_SPACE_BEFORE_TAB option in ws.c.
Besides, we do not expose the --dual-color option in cases other than
the `branch-diff` command, which only uses a hard-coded output_prefix of
four spaces (which misses the problem by one column ;-)).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 diff.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/diff.c b/diff.c
index 98a41e88620..b98a18fe014 100644
--- a/diff.c
+++ b/diff.c
@@ -1098,6 +1098,12 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
 				set = diff_get_color_opt(o, DIFF_FILE_OLD);
 			else if (c != '+')
 				set = diff_get_color_opt(o, DIFF_CONTEXT);
+			/* Avoid space-before-tab warning */
+			if (c == ' ' && (len < 2 || line[1] == '\t' ||
+					 line[1] == '\r' || line[1] == '\n')) {
+				line++;
+				len--;
+			}
 		}
 		emit_line_ws_markup(o, set, reset, line, len, set_sign, '+',
 				    flags & DIFF_SYMBOL_CONTENT_WS_MASK,
-- 
2.17.0.409.g71698f11835



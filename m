Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D3D6200B9
	for <e@80x24.org>; Thu,  3 May 2018 15:31:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751582AbeECPbZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 11:31:25 -0400
Received: from mout.gmx.net ([212.227.17.21]:35667 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751512AbeECPbL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 May 2018 11:31:11 -0400
Received: from virtualbox.mshome.net ([37.201.195.116]) by mail.gmx.com
 (mrgmx103 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0M1WHV-1eLBbO08uP-00tWS3; Thu, 03 May 2018 17:31:07 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 16/18] branch-diff --dual-color: work around bogus white-space warning
Date:   Thu,  3 May 2018 17:31:02 +0200
Message-Id: <62f0e2cf73fb392114e0ded73af79b7dfa9ab66f.1525361419.git.johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.17.0.409.g0f525fc0ba7
In-Reply-To: <cover.1525361419.git.johannes.schindelin@gmx.de>
References: <cover.1525361419.git.johannes.schindelin@gmx.de>
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:HRBP3HO9w62d57Um3fy8hEEGP/XwXwv0LYLa9iaGFOBH+K6Q/2c
 G4+B+oJC/41q7BPkOP6mRhXyIXeWuawBPpDd0jC0cZDKwF0igjwuuVeSvD6H/hBIcHICu3r
 akWSOh+6G02iSbYTai8/GkJEqtLLI7cQvEMM9DdkeyHyeEAI3vlYG5P8R2ZoeblEa75HjMS
 BF9jdCohrZcGXwOHQBv2g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Kagj+rTAl/4=:GDSqXg+3lU5gBVaGfmUb32
 VF1CnZbq3L0dgtj+VNIQKQrgFqJW+21Rpv1ucbuLiiEjpWYZN+aAQcOHH8iZpr8tBLT8ETVoF
 /n+xxiLKbnpNy5EcZAJn1QIH+t/pZmlpbdIhu7Lv9cOlj5zkdZBiVrOXZ60f6WxQeyf7sTqOq
 CLYCLtXik7JpFVUYIp6DypRZW4rykiaT6xDNK94ddZ/Txkn0Tek328/K7Q/mwK6J6HNQoZhr/
 CYdZWWLEzabNRvgKH4n8NTCm/8/DyBq5ej+ZAVRMRN484zn3cRHCHdOeHtEafUixAHnvlbOv/
 p+7hrohDCKbBkO6caHo+g8RfQlelJXUDmJelCBn9zGyEWhAdwP1OvWm4P9muazS+tadYW1i9Y
 dnRIzdmrK+nndMa5S4mccxRmCpUMFZD/SJr6AaR9+LS3ObFg6XXRsJOu4gMus0J8ToskEopSL
 y4ntxs6HHfp6Q5TxgGjTO12H4y9i0ANxoZd+F/FK++fFYivhiCV8N8WxEYFVr9WXPxGgMtutl
 EAtMMsGG3MGS8nGM5+yXrIcjqqaQBq+Sel8gPiOdcN4/Hp8Mv338qaWw1qGvlsNIZQwcKd3Vr
 RQEZ240sEtsT1OB+IlSbjIlRuY3Y0VtsbZ1Yx9IEKVXe2Y/LJ0cfqN3YF3LqVPOONXby0ubuc
 NFTWch/GAThh30kGPTxg1hFQd/ATN19AUZrpfcPQiJDjqU/OklGYI+hWa/KHaK1wN5l/9kmGv
 WrgVACuPAMd68jDJ5nG3GhbKoKejuZiDB36CAdkqohGLUhRsdG1Eh1408RHKtzBL7Cy/alWQQ
 eX4T8pP
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
2.17.0.395.g6a618d6010f.dirty



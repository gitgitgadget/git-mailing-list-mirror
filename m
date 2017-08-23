Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5436020899
	for <e@80x24.org>; Wed, 23 Aug 2017 12:10:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753981AbdHWMKz (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Aug 2017 08:10:55 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:63712 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753919AbdHWMKy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2017 08:10:54 -0400
Received: from localhost ([130.75.46.4]) by mrelayeu.kundenserver.de (mreue102
 [212.227.15.183]) with ESMTPSA (Nemesis) id 0M3Sim-1dSxZr1kfY-00qwot; Wed, 23
 Aug 2017 14:10:51 +0200
From:   Michael J Gruber <git@grubix.eu>
To:     git@vger.kernel.org
Cc:     hIpPy <hippy2981@gmail.com>
Subject: [PATCH v3 1/4] Documentation/git-merge: explain --continue
Date:   Wed, 23 Aug 2017 14:10:42 +0200
Message-Id: <ddd9c06813f8e2e9d8160f2ed965e728190bc573.1503489842.git.git@grubix.eu>
X-Mailer: git-send-email 2.14.1.426.g4352aa77a5
In-Reply-To: <xmqq1so34m6d.fsf@gitster.mtv.corp.google.com>
References: <xmqq1so34m6d.fsf@gitster.mtv.corp.google.com>
In-Reply-To: <cover.1503489842.git.git@grubix.eu>
References: <cover.1503489842.git.git@grubix.eu>
X-Provags-ID: V03:K0:mkr4Yhx6ACRtZUISm2Ca8koBikhpgWKjZhA0jUn/D4nLlg+KXuh
 50MoVM1mKPLPxHtXhCeRqHEI585mNwY8/zdeBKiEwibbileXc7a7ILr0iuemTynSMJPxlwJ
 o4BiARGxa8oqw9Qa7vWIQikFu9yl7KwW6RASAlz9SNTUevUMzMjTqGeCvmdXjyaJyK0Pc1D
 Fai2kZl/sjGs5vukU54Iw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ZTpfM6LgOXE=:Trr0LcOMoDcPs7qu75488s
 G0npDZKB/w3ywuIvVCkjSaFzQoMi16seROgx6q0pDpiNrEY3GxiL52toMBk4JcjCfjHikdQjR
 Uwlsbfke1LYTqruZSe7AlvPTtiOxV+mP1Nc9BbOLZJAPJhCCaR9FlgFSc/x/Kam1GJCuRxHsB
 KvshDDr9DmOjdzakfWfrZuKaW8h+V05OGyyNkqUpHe8EBc+NY4qnJMB3wEDXP/YeNQ5N0c9hN
 XFpCL+iJcNVoTqw8+yNEY0MSdcKzY/ngHvQp3HuAC1muoiq7cNw1iknwCDcsOsHx3ImWzyCQj
 CDEZzBH+vEFWUqrk+/4zF1/KuE5vQpRvtHE00uTlPbkOqldgGa73AoadbAHQOI2tmWtYOoPOC
 VoDimjJ0fq93eiVtWNm1X8t/ILj5GReWhOfJxKEF4k6spsMBYU2yGdlkSd21JhN13PQtri+lQ
 Ka+hLl6C/Gm/l8f7eMOFEaJN6Pzf8k+4LsHvOdTn0XhnBmUeYMA7MBwlrjNdFmMR77uzCVUNb
 L6AY5rq/ugHWf2P4AoqO0j+1LgC8QObWXkCGsoFLltjMJLgCd4BCMc1fyCUQPFysvG4RuWYRO
 JI2aB7hGU2lZ3ONmgqK8NFe9a61/AVS3K+TcOYqrXV5CUuvIC1VE7pu+Nv2jLIk23HOCCB1AW
 /RGizPOw9n9C6XrV+9oVbwT/MB+aIji8Pn4CthHeOFMlqFM6l4eLyEVP16U/72NYRkR5iGy7N
 /pWmgCZMvKT2Wphbcv1uFPoFzx5lLZgQAYSiMg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, 'git merge --continue' is mentioned but not explained.

Explain it.

Signed-off-by: Michael J Gruber <git@grubix.eu>
---
 Documentation/git-merge.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index 6b308ab6d0..615e6bacde 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -288,7 +288,10 @@ After seeing a conflict, you can do two things:
 
  * Resolve the conflicts.  Git will mark the conflicts in
    the working tree.  Edit the files into shape and
-   'git add' them to the index.  Use 'git commit' to seal the deal.
+   'git add' them to the index.  Use 'git commit' or
+   'git merge --continue' to seal the deal. The latter command
+   checks whether there is a (interrupted) merge in progress
+   before calling 'git commit'.
 
 You can work through the conflict with a number of tools:
 
-- 
2.14.1.426.g4352aa77a5


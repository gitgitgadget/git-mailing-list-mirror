Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45DA220357
	for <e@80x24.org>; Fri, 14 Jul 2017 14:45:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754513AbdGNOpM (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jul 2017 10:45:12 -0400
Received: from mout.gmx.net ([212.227.17.20]:58881 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754471AbdGNOpL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jul 2017 10:45:11 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0La3c1-1dvUkU3hPB-00lngS; Fri, 14
 Jul 2017 16:45:04 +0200
Date:   Fri, 14 Jul 2017 16:45:03 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Liam Beguin <liambeguin@gmail.com>
Subject: [PATCH v6 03/10] rebase -i: remove useless indentation
In-Reply-To: <cover.1500043436.git.johannes.schindelin@gmx.de>
Message-ID: <b3c71a9d577956dc0aae0763d4a5683bc1eb6304.1500043437.git.johannes.schindelin@gmx.de>
References: <cover.1500043436.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:vJAB5AFkWN6anB+Qg7ETt2nqU1xqRh2ouM9euSK70230tPOhck5
 AOzriiRSsjtuQCko96T7GcuKErvilWW7TuYyT3z6CLXZZptiqRtaupCMJLDW8b6hD+9krgo
 GRF+NY/1WtM45ja5G8ilkNR9aO2WSCjxuvjD6c7omKi18DLO5XHoxHDjMZtDI1tbO5X+hio
 7vowrbzSFA4UHI3D7uq2w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:5czRi7MjZLU=:Yy8wjqPArOcFQ0dcI6mfqJ
 I7ya6NHj2ZqN0JgFm/cEVv7P+Sr6CXNfoZQqidqdmFtJ+lL2HcXrLohSc8HFhvNlnKKmc7WHd
 GwEYIxvsNLUCBl1QnUvS7xD8PTNWQHcjo2lvnh44EoAxoVwPY1khRRMpDLzKZJcfK+la/lcQg
 qZIUYf76ivBr7jKaX7VlohQLECLdj0mgvA6J3tOJdc9wwW2RYsE37kVYPs6Kp+AOB1vUxrr0c
 nluOv8ObVLpi8IvYNssltqZlwBksKBvRO1xgQC7pY0153+HhAKlPVx8BnI/hUAm+VMZ6zpLmj
 dFLAJFbYT05tRPdKtHQNsKX8RMGABYezgWN/qjBYIP8OgstT5xwii+05drU6PXEER1K5VjgXn
 5oFyKHQPsBFmG+5sExkdOuCvQQk+WMyjKv03+QCt4chxcX7XY1BWE9nnd909cFJbRafbtbGyc
 zQIcraTuVbFNT0hrLwqzYJWpVg2YtUzW6Jpq7qiIDHoBaz1UFb/ACtBGlril/lPxbe0ViA4sI
 kBc0WA24aV1TujBqmEJKgstPunkIaaerHYQrxJzkuyeSoIR44RAVbH/fk3atY5VfhurpFmaTz
 5cZHTmoEYSuVSIuTv71Kz89E/JG06Gpcq3pah33IEwE4+WvJshkQfeFjDmhkGCBdO5/WhqAHW
 0JdWd7uPSFkBrS/UV03boY5LimvtjEOCa/fys+2UNenksWPQ8Qti/aaWufRQmHN08RUBZJlNm
 vepxavQXbxCjl4XHEB52gyoolmDTiZsShgBugJcFYnd8Y+bv7KhEoqVRq0DtWYZ0ntPxzh0d9
 n1jVNINf0+8A8Hu+W7uyQ9fiEMMwX2VSgjGmkDG5bPSX9iI0UU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The commands used to be indented, and it is nice to look at, but when we
transform the SHA-1s, the indentation is removed. So let's do away with it.

For the moment, at least: when we will use the upcoming rebase--helper
to transform the SHA-1s, we *will* keep the indentation and can
reintroduce it. Yet, to be able to validate the rebase--helper against
the output of the current shell script version, we need to remove the
extra indentation.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-rebase--interactive.sh | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 05766835de1..93372c62b2e 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -155,13 +155,13 @@ reschedule_last_action () {
 append_todo_help () {
 	gettext "
 Commands:
- p, pick = use commit
- r, reword = use commit, but edit the commit message
- e, edit = use commit, but stop for amending
- s, squash = use commit, but meld into previous commit
- f, fixup = like \"squash\", but discard this commit's log message
- x, exec = run command (the rest of the line) using shell
- d, drop = remove commit
+p, pick = use commit
+r, reword = use commit, but edit the commit message
+e, edit = use commit, but stop for amending
+s, squash = use commit, but meld into previous commit
+f, fixup = like \"squash\", but discard this commit's log message
+x, exec = run command (the rest of the line) using shell
+d, drop = remove commit
 
 These lines can be re-ordered; they are executed from top to bottom.
 " | git stripspace --comment-lines >>"$todo"
-- 
2.13.3.windows.1.13.gaf0c2223da0



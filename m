Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3DA620A2C
	for <e@80x24.org>; Sat, 30 Sep 2017 21:41:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751320AbdI3ViK (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Sep 2017 17:38:10 -0400
Received: from mout.gmx.net ([212.227.15.15]:63391 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751178AbdI3ViJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Sep 2017 17:38:09 -0400
Received: from fermat.fritz.box ([92.76.241.171]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MIu7d-1e0sQk1rkP-002Yqv; Sat, 30
 Sep 2017 23:38:03 +0200
From:   Stephan Beyer <s-beyer@gmx.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Stephan Beyer <s-beyer@gmx.net>, git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Add a comment to .clang-format about the meaning of the file
Date:   Sat, 30 Sep 2017 23:37:31 +0200
Message-Id: <20170930213731.27133-1-s-beyer@gmx.net>
X-Mailer: git-send-email 2.14.2.677.g5a59ab275
In-Reply-To: <20170929224505.GN19555@aiede.mtv.corp.google.com>
References: <20170929224505.GN19555@aiede.mtv.corp.google.com>
X-Provags-ID: V03:K0:WQXymJKTggWCpBpAiwY7W2g8FjfpBTSoFUOlCnsY1G34MN4Gsvx
 5goN/DfbfgQP5z5D0VTsA/TvQjVfc0IUmuojsSToW2cdtvJyXkZN3zf9fyZuJ0QlcZrBmyM
 jb74QM5sung0m9ZZv8itV+tWgqI2goX1/nVQUeS13KnN+7SrrVzloIT0XAA2O+010/9XuzG
 p6J0Tqd+IxVodOST/rMew==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7XPQroq2MjU=:ePnb5Y2s7y+vpsBbqs32Bw
 z3cJFQJYvrdPHSJEtM6ObAJEWm4XVYj84SskueEZGg5yLLQGASOY3MtnaroAy413bIW6k6rXE
 PZAcIJ9Gd+FrZaD5Gzi6KqxuEf6HaKTamk+3datktxHN1FuZg0uxIMKbGuN985MFz+F5tHQfO
 trLRmB7eyp4HUOJFq6Y51a4dsRrY+lKtqFw2M0jEjELwzIzONiEHa2A7KdTIfn3jQFTa7KRbI
 7D/Su5itLHDjHs9YJeVZJrMZbRCl1HFrl1BRn5R82LIhabN0jQ5ldgQRpG/mFDIvLwmuSMYzT
 cw4dYOxmfTSU1Xa7uOiG83j3sH3WwpzFJYgJdeoScIME9gWb6N36qH2JEFoyyeJblHC0dAC3A
 GJBwwKylo9ofTd5QvHqQb9lKdf9IH8MM6++4ig+4Urudp13k90Al1rvZAmJ+kbbxtuGNn2kUM
 RDv3ICL5iapaUOJri19lnlr2WSGCWr+/t1HOh4t+Rfe19odTqgR9YK5OaWziESLo678QBquoi
 U7hQN4HrxvnRQfYkxbhQq36c+dvg80zyX+ekaSf0ewrGMySmqEy6OJ42JhAqMlpKmEE1rEQEg
 G7Ycx9InGQNzqDd2BzEHphW0Sd7f9sfGvr/yovYhTGR6jmpUQEA0ORnNOfgUCT1xILMKFGWQg
 bVpJh4XMhoIFwqTLfCP49KGFm7Q3C5KzkeyxEDQvMilz+/MTGvKJKo7+fhWPn4oRhmqkQ3AkJ
 f0wIBh026i62FPwKLria9lDjTJRydAU378rc0g38D1p//EhE1HY8I2abPc62JS37Plw2VLprB
 ceSuH7X5uO9jbzZ5DYzoJB5i4g/qg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Having a .clang-format file in a project can be understood in a way that code
has to be in the style defined by the .clang-format file, i.e., you just have
to run clang-format over all code and you are set. This is not the case in the
Git project, which is now reflected by an comment in the beginning of the file.

Additionally, the working clang-format version is mentioned because the config
directives change from time to time (in a compatibility-breaking way).

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---

Notes:
    On 09/30/2017 12:45 AM, Jonathan Nieder wrote:
    > Sounds good to me.  Care to send it as a patch? :)
    
    Like this? :)

 .clang-format | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/.clang-format b/.clang-format
index 3ede2628d..558fc7fd8 100644
--- a/.clang-format
+++ b/.clang-format
@@ -1,4 +1,8 @@
-# Defaults
+# This file is an example configuration for clang-format 5.0.
+#
+# Note that this style definition should only be understood as a hint
+# for writing new code. Most of Git's codebase does not conform to
+# this definition.
 
 # Use tabs whenever we need to fill whitespace that spans at least from one tab
 # stop to the next one.
-- 
2.14.2.677.g5a59ab275


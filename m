Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBEFC1F404
	for <e@80x24.org>; Fri, 20 Apr 2018 22:26:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752679AbeDTW0Z (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Apr 2018 18:26:25 -0400
Received: from mout.gmx.net ([212.227.17.20]:42771 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752514AbeDTW0X (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Apr 2018 18:26:23 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MUHbK-1f0CaH3BYI-00R0tV; Sat, 21
 Apr 2018 00:26:19 +0200
Date:   Sat, 21 Apr 2018 00:26:03 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 09/11] technical/shallow: describe the relationship with
 replace refs
In-Reply-To: <cover.1524262793.git.johannes.schindelin@gmx.de>
Message-ID: <853b0a445ab1d78e8cbe19dacd09e70892b34b03.1524262793.git.johannes.schindelin@gmx.de>
References: <cover.1524125760.git.johannes.schindelin@gmx.de> <cover.1524262793.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:YdvZuQomZTZaUQz5FAiwTuBTvF4b1ThdyT+IQFlkmK6bVHe4ltz
 Uo/E65+NbyAlfw97q7JC85R99d43EDqIEG/W+2/grhyANU6RQ57xhU/gdWWlPVLRxRmtKA0
 oR1HIoOw0BAguYhNA3+S/baOLw6Ap8JG6YLg3QnT9id8PeIK73J222sY9lYP+uAKZrRxQxp
 OlPMjqbBUCOfdDGq+nfMA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:rsvDv//dxHY=:d0qRNzg4xSyEN0IJXP1ViZ
 IGm2SLKbMxhvFK4yHKahjBSvxlwMQgox5QJNucjw8cde5J4qgKwprO6QSqtda4/E5al9H9Vic
 8p/sAf5MNKcHKjRqxOBigZZM8CzrvO8jnlUu0YB4EWsWJhEHsiKvK1IJuWBsN9dIHDEB1rNHk
 LSAzH3oTHT4nwpCa7RYYfD1vXW1ZUtrn/IXAsrUTeH+unM5pu4HOKrGpn6s+cUJKM7J3MafcQ
 Yykkklq1HZzDssj/YGNLZXODJzwXFA9RovMk+9/tnuNE4ln3uMz0UuWYqka4DG7BpgYqFDeS0
 HZtJL3pYW+0VA5Ees76im1wVOynupJj1WkfkdEJDZhj/lZ/ycrDM+NeLOaMyLnkLXrmgolMxr
 O1c2sLu5xHwvbSg5yR+jQK58BWjCUnGVzX0CWD64GejQd5ap/YwHNLMu4/ngHU9tYAUEkUVMT
 ENwbRUfZ/0kexdaokUPxRb7RZyncOeVEoFE0KrOgrwtyYpc9foLJHqEVsU4Qk8lR+vRe7aGpL
 aAGYR2znYhLUIBBz2MyFZPmvg80HSpCOMHg4cxvtStgCwaZspKzheHLaERxJvEZKRcp2KTcgm
 POv4Gfkv3QkMo6/c5+HvJP37t3fzpiGWkclVITwNsfDB9KPxuLsfiSGad53Wcz8K48hpbpm+v
 0JOo8kSglAGF7vhOGCVJvYNH+wxt9pjLXDd7XYSjgB2l5xdAJbKVNxc4FDxtlVIPV9Af+bYGl
 Eougqmowif6tlaC+wLw6MpDyZmsfZWzZ1z7HnAw4oUgI1dlOPi0fP7NCIQ97rgydc6jXJMUq0
 CG2a1+qupcBDukxIbF8AyFaLjDxDF3PLx9HUn/gZFW7bv+8DFI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that grafts are deprecated, we should start to assume that readers
have no idea what grafts are. So it makes more sense to describe the
"shallow" feature in terms of replace refs.

Suggested-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/technical/shallow.txt | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/Documentation/technical/shallow.txt b/Documentation/technical/shallow.txt
index 5183b154229..b3ff23c25f6 100644
--- a/Documentation/technical/shallow.txt
+++ b/Documentation/technical/shallow.txt
@@ -9,14 +9,17 @@ these commits have no parents.
 *********************************************************
 
 The basic idea is to write the SHA-1s of shallow commits into
-$GIT_DIR/shallow, and handle its contents like the contents
-of $GIT_DIR/info/grafts (with the difference that shallow
-cannot contain parent information).
-
-This information is stored in a new file instead of grafts, or
-even the config, since the user should not touch that file
-at all (even throughout development of the shallow clone, it
-was never manually edited!).
+$GIT_DIR/shallow, and handle its contents similar to replace
+refs (with the difference that shallow does not actually
+create those replace refs) and very much like the deprecated
+graft file (with the difference that shallow commits will
+always have their parents grafted away, not replaced by
+different parents).
+
+This information is stored in a special-purpose file because the
+user should not touch that file at all (even throughout
+development of the shallow clone, it was never manually
+edited!).
 
 Each line contains exactly one SHA-1. When read, a commit_graft
 will be constructed, which has nr_parent < 0 to make it easier
-- 
2.17.0.windows.1.15.gaa56ade3205



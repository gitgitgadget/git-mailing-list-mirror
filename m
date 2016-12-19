Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7EF71FF40
	for <e@80x24.org>; Mon, 19 Dec 2016 16:52:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933504AbcLSQqT (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Dec 2016 11:46:19 -0500
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:64934 "EHLO
        alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933451AbcLSQpg (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 19 Dec 2016 11:45:36 -0500
X-AuditID: 12074414-773ff70000004a85-2b-58580eafb075
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 0A.85.19077.FAE08585; Mon, 19 Dec 2016 11:45:35 -0500 (EST)
Received: from bagpipes.fritz.box (p57906BA3.dip0.t-ipconnect.de [87.144.107.163])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id uBJGjKR6011292
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Mon, 19 Dec 2016 11:45:35 -0500
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Paul Mackerras <paulus@samba.org>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 13/13] gitk: change the default colors for remote-tracking references
Date:   Mon, 19 Dec 2016 17:45:12 +0100
Message-Id: <1d704ec5620f97bc6129d738666e7acabff4e97a.1482164633.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1482164633.git.mhagger@alum.mit.edu>
References: <cover.1482164633.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDIsWRmVeSWpSXmKPExsUixO6iqLueLyLC4Nk2M4uuK91MFrdXzGe2
        WHNkMbsDs8ff9x+YPObu6mP0+LxJLoA5issmJTUnsyy1SN8ugSujZU0PU8Eh9oozBx6xNTD2
        sHUxcnJICJhIPHz2m7GLkYtDSOAyo0TvwnYmCOcUk8TlVStZQarYBHQlFvU0AyU4OEQEVCXW
        XxACCTMLOEhs/tzICGILC4RKTDrVxAxSwgJUcvidMUiYVyBK4k3jbRaIXXISl7Z9YQaxOQUs
        JG7Ov8IOYgsJmEtsePabZQIjzwJGhlWMcok5pbm6uYmZOcWpybrFyYl5ealFuhZ6uZkleqkp
        pZsYIQEhsoPxyEm5Q4wCHIxKPLwF78MihFgTy4orcw8xSnIwKYny7ueJiBDiS8pPqcxILM6I
        LyrNSS0+xCjBwawkwruXFyjHm5JYWZValA+TkuZgURLn/bZY3U9IID2xJDU7NbUgtQgmK8PB
        oSTBex+kUbAoNT21Ii0zpwQhzcTBCTKcB2h4Otjw4oLE3OLMdIj8KUZdjgPvVzxlEmLJy89L
        lRLndQQpEgApyijNg5sDi+RXjOJAbwnzcgLjWogHmATgJr0CWsIEtGRhdzjIkpJEhJRUA6Ob
        2OaV92eHdDrvmLaWIe9NYIsD677weU8cyl0WG5pMyLxWvMjjUU105ZF/vxJm6/gX6mmsPPH5
        Q/WcExtibz3fc3HxwitP0wJ5ppYbv+aWO+hXcNJTeLHF1YrVKn2OEmLHjH+t3VthmX1Ac36D
        8g95Paf1Sb4J+YYbbX3/fhCV+X444SVr9AolluKMREMt5qLiRACWYsLTvwIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of coloring the reference name part of remote-tracking
references the same bright green as used for local branches, change it
to a subtler brown. Change the remote name color to go better with the
brown.

I chose these colors because

* Remote-tracking references are less important than local branches, so
  it is appropriate that their coloring be subtler.

* Brown isn't used elsewhere.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 gitk | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/gitk b/gitk
index cb5c715..be97640 100755
--- a/gitk
+++ b/gitk
@@ -12363,8 +12363,8 @@ set markbgcolor "#e0e0ff"
 set headbgcolor "#00ff00"
 set headfgcolor black
 set headoutlinecolor black
-set remotebgcolor #ffddaa
-set remoterefbgcolor #00ff00
+set remotebgcolor #d9d4b2
+set remoterefbgcolor #c1a677
 set otherrefbgcolor #ddddff
 set tagbgcolor yellow
 set tagfgcolor black
-- 
2.9.3


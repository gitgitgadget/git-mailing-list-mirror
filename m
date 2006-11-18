X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 0/5] gitweb: New patchset view corrections and improvements, and few other things
Date: Sat, 18 Nov 2006 23:35:37 +0100
Message-ID: <1163889342877-git-send-email-jnareb@gmail.com>
NNTP-Posting-Date: Sat, 18 Nov 2006 22:34:51 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:x-mailer;
        b=XUFACw/GStAruUY8RCWGab5OLXe9KYWtHSLJFomY7rFrGkigb6hwl8hzlF2RhuvRkRVZeUXAwcGhOyVeNvoLRFSqsTfK+Ksx+y6w3ekX/LiLbv5BC1JPCCyohHs97i1L1pZozweQtYtue5fNbCJyJ6tTGpcVFo5D33/e3t4lJ2I=
X-Mailer: git-send-email 1.4.3.4
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31808>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GlYlc-0001jk-Mr for gcvg-git@gmane.org; Sat, 18 Nov
 2006 23:34:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755264AbWKRWeU (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 18 Nov 2006
 17:34:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755274AbWKRWeU
 (ORCPT <rfc822;git-outgoing>); Sat, 18 Nov 2006 17:34:20 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:5395 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1755264AbWKRWeT
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 18 Nov 2006 17:34:19 -0500
Received: by ug-out-1314.google.com with SMTP id m3so953026ugc for
 <git@vger.kernel.org>; Sat, 18 Nov 2006 14:34:17 -0800 (PST)
Received: by 10.67.91.6 with SMTP id t6mr5192706ugl.1163889257585; Sat, 18
 Nov 2006 14:34:17 -0800 (PST)
Received: from roke.D-201 ( [81.190.24.209]) by mx.google.com with ESMTP id
 b35sm2288856ugd.2006.11.18.14.34.17; Sat, 18 Nov 2006 14:34:17 -0800 (PST)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1]) by roke.D-201
 (8.13.4/8.13.4) with ESMTP id kAIMZgY2015343 for <git@vger.kernel.org>; Sat,
 18 Nov 2006 23:35:43 +0100
Received: (from jnareb@localhost) by roke.D-201 (8.13.4/8.13.4/Submit) id
 kAIMZgeF015342 for git@vger.kernel.org; Sat, 18 Nov 2006 23:35:42 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Table of contents:
 [PATCH 1/5] gitweb: Protect against possible warning in git_commitdiff
 [PATCH 2/5] gitweb: Buffer diff header to deal with split patches 
                     + git_patchset_body refactoring
 [PATCH 3/5] gitweb: New improved formatting of chunk header in diff
 [PATCH 4/5] gitweb: Default to $hash_base or HEAD for $hash
                     in "commit" and "commitdiff"
 [PATCH 5/5] gitweb: Add an option to href() to return full URL

Diffstat:
 gitweb/gitweb.css  |   13 +++
 gitweb/gitweb.perl |  264 ++++++++++++++++++++++++++++++++--------------------
 2 files changed, 176 insertions(+), 101 deletions(-)

-- 
Jakub Narebski

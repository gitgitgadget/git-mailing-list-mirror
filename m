X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>
Subject: [PATCH] Add config example with respect to branch
Date: Thu, 07 Dec 2006 12:06:55 +0530
Message-ID: <4577B687.5080907@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010006030902030700040300"
NNTP-Posting-Date: Thu, 7 Dec 2006 06:37:23 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type;
        b=lELoZBn+3JwsYj8zw/QIl1YgTcltiv974gLO1gpsBZz4ffCr55FxnwP49suO2O43/hq7NNf8yc1ReZ/qw1n+7ebYMqull5TWtulE/EsA7Q7mquPVN+XP+fM7S1Q9/K86Yo9Swkm5SpFWJrE0zgahPAMC+IXrIjKAEHWDH1gXbnc=
User-Agent: Thunderbird 1.5.0.8 (X11/20061115)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33553>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsCsi-0000Qq-ES for gcvg-git@gmane.org; Thu, 07 Dec
 2006 07:37:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031717AbWLGGhJ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 7 Dec 2006
 01:37:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031716AbWLGGhJ
 (ORCPT <rfc822;git-outgoing>); Thu, 7 Dec 2006 01:37:09 -0500
Received: from nz-out-0506.google.com ([64.233.162.231]:39460 "EHLO
 nz-out-0102.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with
 ESMTP id S1031717AbWLGGhF (ORCPT <rfc822;git@vger.kernel.org>); Thu, 7 Dec
 2006 01:37:05 -0500
Received: by nz-out-0102.google.com with SMTP id s1so283856nze for
 <git@vger.kernel.org>; Wed, 06 Dec 2006 22:37:05 -0800 (PST)
Received: by 10.65.180.7 with SMTP id h7mr2876360qbp.1165473425114; Wed, 06
 Dec 2006 22:37:05 -0800 (PST)
Received: from ?217.236.224.183? ( [156.153.255.234]) by mx.google.com with
 ESMTP id e14sm309674qbe.2006.12.06.22.37.02; Wed, 06 Dec 2006 22:37:04 -0800
 (PST)
To: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

This is a multi-part message in MIME format.
--------------010006030902030700040300
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


--------------010006030902030700040300
Content-Type: text/plain;
 name="0001-Add-config-example-with-respect-to-branch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="0001-Add-config-example-with-respect-to-branch.txt"

From: Aneesh Kumar K.V <aneesh.kumar@gmail.com>

Update config.txt with example with respect to branch
config variable. This give a better idea regarding
how branch names are expected.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@gmail.com>
---
 Documentation/config.txt |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 9090762..d3518d1 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -31,6 +31,11 @@ Example
 		external = "/usr/local/bin/gnu-diff -u"
 		renames = true
 
+	[branch "devel"]
+		remote = origin
+		merge = refs/heads/devel
+
+
 Variables
 ~~~~~~~~~
 
-- 
1.4.4.1.g278f-dirty



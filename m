From: Vitor Antunes <vitor.hda@gmail.com>
Subject: [PATCH V2 0/2] git-p4: Small updates to test cases
Date: Sat, 28 Mar 2015 00:03:01 +0000
Message-ID: <1427500983-8802-1-git-send-email-vitor.hda@gmail.com>
Cc: Vitor Antunes <vitor.hda@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 28 01:04:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YbeDr-0002bE-Q1
	for gcvg-git-2@plane.gmane.org; Sat, 28 Mar 2015 01:03:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752576AbbC1AD1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Mar 2015 20:03:27 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:33774 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752239AbbC1AD0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Mar 2015 20:03:26 -0400
Received: by wixm2 with SMTP id m2so44998475wix.0
        for <git@vger.kernel.org>; Fri, 27 Mar 2015 17:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=4Qy80gPVHtvA1+MLXzngp6IXaksgX2f8hZL+UVXcLLk=;
        b=iwflwxpu3DgiMxb8gucGiC2t6UNYPjaEPbzrBvsOrU44aw2e7fxh5SxaGOoQ5raSUF
         aPMDg19GI5gd2iUKLNz5ESlI1lUMX1ccqRpcKByh7W1F04nglB9lhJHMW8OLgi1poAzH
         t/fbsBGKKFu+4oWjf9EGMvY3rI9nVuFIVHESJvTJfHG0kkP2jFyM2unn96GbDJn9OwWv
         L+OS5XGdfhXpko43s4CNf3dYSn/YrsHepz6K5F8wp98mLtTdbTOm53JeZvs+7sYxdUpN
         v6PSIgUs0uD8z4j5TJMq3xoA1ohhm27zLhxKZwPk1pFLAgo7/gYg/RDhjO5SWURoAZ4L
         D/7w==
X-Received: by 10.194.223.5 with SMTP id qq5mr43089425wjc.152.1427501005287;
        Fri, 27 Mar 2015 17:03:25 -0700 (PDT)
Received: from localhost.localdomain (88.41.108.93.rev.vodafone.pt. [93.108.41.88])
        by mx.google.com with ESMTPSA id hn8sm4879409wib.18.2015.03.27.17.03.23
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Mar 2015 17:03:24 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266407>

Updated both fixes:

1. Remove "true" from case statements and replaced it with ":".
2. Also use a case statement in the copy detection test to allow
   diff-tree to detect two different files as the origin of the
   copy. I've also reverted a change I introduced in the V1 patch
   that no longer makes much sense to me.

Vitor Antunes (2):
  git-p4: Make rename test case runnable under dash
  git-p4: Fix copy detection test

 t/t9814-git-p4-rename.sh |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

-- 
1.7.10.4

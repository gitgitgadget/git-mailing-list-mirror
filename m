From: Vitor Antunes <vitor.hda@gmail.com>
Subject: [PATCH 0/2] git-p4: Small updates to test cases
Date: Fri, 27 Mar 2015 01:04:27 +0000
Message-ID: <1427418269-3263-1-git-send-email-vitor.hda@gmail.com>
Cc: Vitor Antunes <vitor.hda@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 27 02:05:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YbIi4-0007Uh-H8
	for gcvg-git-2@plane.gmane.org; Fri, 27 Mar 2015 02:05:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752906AbbC0BFE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2015 21:05:04 -0400
Received: from mail-wg0-f46.google.com ([74.125.82.46]:36311 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752513AbbC0BFD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2015 21:05:03 -0400
Received: by wgra20 with SMTP id a20so82941900wgr.3
        for <git@vger.kernel.org>; Thu, 26 Mar 2015 18:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=v9extZ4MomYg4VuDbp0dCg/qezqjIwTlC/8eLE4Zwbs=;
        b=pcP9GnsY1kPkTWUQS4iW7RuJs1Rpec8pgwaZbMzw/cTgrd+F/chMsX5GmJJTsgnE0h
         q+JhQXpeanzbW9JPtMaJ1Hd9MsmcVJz0DmyCqW1N+Sn+MuNCxQbSx4DUIZ9bXHnRnSAg
         DzsIItCJysvQiy1M9mZLbdjWuD/fsDn9ZWJ/GLdC+8DvFkAHFPAsfSfh6nAeeXlXM4r8
         MYUBFuiakkFDibsWyZC9HHqmQK4vVj+fUHRAW9vd0RanLBYSUXiSh1G7ht+TMVamRfBF
         C6WFsGuUrhFlZlPg8bhKmRSNshH769YEHUjioRL/SDXjLoG5DY5i7jPp8jXfEt7eEXdK
         HUFA==
X-Received: by 10.180.187.19 with SMTP id fo19mr51880825wic.2.1427418301532;
        Thu, 26 Mar 2015 18:05:01 -0700 (PDT)
Received: from localhost.localdomain (88.41.108.93.rev.vodafone.pt. [93.108.41.88])
        by mx.google.com with ESMTPSA id u10sm1231219wib.1.2015.03.26.18.05.00
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Mar 2015 18:05:00 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266359>

This patch set includes two small fixes to the rename test case. The fix to
support dash should be trivial, but in the fix to the copy detection test case
it isn't obvious to me what changed in diff-tree to result in a different file
being detected as the origin of a copy.

Vitor Antunes (2):
  git-p4: Make rename test case runnable under dash
  git-p4: Fix copy detection test

 t/t9814-git-p4-rename.sh |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

-- 
1.7.10.4

From: Yuxuan Shui <yshuiv7@gmail.com>
Subject: [PATCH v2 0/2] GSoC micro project, use skip_prefix() in fsck_commit()
Date: Thu, 13 Mar 2014 02:51:28 +0800
Message-ID: <1394650290-3750-1-git-send-email-yshuiv7@gmail.com>
Cc: Yuxuan Shui <yshuiv7@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 12 19:51:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNoFo-0007DY-5O
	for gcvg-git-2@plane.gmane.org; Wed, 12 Mar 2014 19:51:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751162AbaCLSvn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2014 14:51:43 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:62725 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751011AbaCLSvm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2014 14:51:42 -0400
Received: by mail-pd0-f171.google.com with SMTP id r10so1448607pdi.2
        for <git@vger.kernel.org>; Wed, 12 Mar 2014 11:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=wbsPycPjMHxOBLrNnZgf7TEWoA7CEYSawwEw4f33qzA=;
        b=bi2m+kXnggCNa75jY3tNcZ7qkPlnBzMMSrop6Jt68NpDXjZFF0mhUuD+4WuDmTH6uw
         fZ8usaTRDEm6H+d9bc9EuSpvn5V2OHFGw0Gx9dm11VDpZZ14MtkdPnmcPWFDZelAR2Gy
         vLt/Xb1RVwfw45dgP/A+1POPNY3J5lTQ6viNKjBtcQMKs4qAbGHOBPltBuUFDYBYoMkG
         cjGVcuHWNoRgrcsEDHfvE/Q6TppCbovSMlqCwc7Qi8+j0CrdsVroYQ+nT/PX5N2YBT9O
         W0YfdcHndKZdaSG+IsZkw8s8gGjkIpjm6bam3Ri+rE24YZbAlM4IAEusAoHCW+MDHRrL
         HQFg==
X-Received: by 10.68.110.165 with SMTP id ib5mr6966604pbb.61.1394650301924;
        Wed, 12 Mar 2014 11:51:41 -0700 (PDT)
Received: from localhost.localdomain ([123.151.32.162])
        by mx.google.com with ESMTPSA id tu3sm25142283pab.1.2014.03.12.11.51.39
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 12 Mar 2014 11:51:41 -0700 (PDT)
X-Mailer: git-send-email 1.9.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243960>

I'm sorry for resending these patches, but the previous ones miss the sign-offs.

Yuxuan Shui (2):
  fsck.c: Change the type of fsck_ident()'s first argument
  fsck.c: Rewrite fsck_commit() to use skip_prefix()

 fsck.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

-- 
1.9.0

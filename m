From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: [PATCH v3 0/2] submodule update continue
Date: Thu,  9 Jun 2011 09:47:01 +0200
Message-ID: <1307605623-2831-1-git-send-email-iveqy@iveqy.com>
Cc: hvoigt@hvoigt.net, jens.lehmann@web.de, git@vger.kernel.org
To: iveqy@iveqy.com
X-From: git-owner@vger.kernel.org Thu Jun 09 09:47:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUZxa-0003Oi-0R
	for gcvg-git-2@lo.gmane.org; Thu, 09 Jun 2011 09:47:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754844Ab1FIHrL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2011 03:47:11 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:54621 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753802Ab1FIHrH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2011 03:47:07 -0400
Received: by eyx24 with SMTP id 24so444493eyx.19
        for <git@vger.kernel.org>; Thu, 09 Jun 2011 00:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:sender:from:to:cc:subject:date:message-id
         :x-mailer;
        bh=GJZJk4QjDDt4M39MnfX9Tra7vgfDf31jRlhC8J5PQe0=;
        b=NTL/D6SU+DJr1FgHQGThypwSrP3t5/6Y0SfmgGehjeF3T6S6nZ5+pjl9R5Tmf9jfsB
         H3vsL1lqHCz9TOe1rI4oUV9mCo56CA0f9P43Ed4V0rkq4lFuCBw1aSTX08I7kZb7csUY
         GaALm7q9leXwY2+oi/1zsjg5g7f/agxt8AEnE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        b=PxIugyG48um++lKRq0pqgkQMUYHd0Zu5r5DTTmLDyeV9M+YXvsHCxtc1CTu2kVMQS6
         Xe8sX5DabXfC1f1e5KurM9rtJTlYCutyqiKBgtAmmuugAj5i7TN+gR1JzuMRcdWd+rYN
         XljJsRQp89VnnbHH4rxiPk1HV88s+zxFj1WEI=
Received: by 10.213.26.136 with SMTP id e8mr697794ebc.9.1307605624301;
        Thu, 09 Jun 2011 00:47:04 -0700 (PDT)
Received: from kolya (1-1-3-35a.mfb.mlm.bostream.se [82.182.194.253])
        by mx.google.com with ESMTPS id a45sm1198678eec.23.2011.06.09.00.47.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 09 Jun 2011 00:47:03 -0700 (PDT)
Received: from iveqy by kolya with local (Exim 4.72)
	(envelope-from <iveqy@kolya>)
	id 1QUZxZ-0000lk-C0; Thu, 09 Jun 2011 09:47:21 +0200
X-Mailer: git-send-email 1.7.6.rc0.14.g4fc55
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175500>

This series adds support to submodule update to continue if some
submodules fail to do so.

This is the third iteration of this patch series. 
The first can be found on:
http://thread.gmane.org/gmane.comp.version-control.git/171895
The second can be found on:
http://thread.gmane.org/gmane.comp.version-control.git/173629
Fredrik Gustafsson (2):
  Add new function die_with_status
  submodule update: continue when a checkout fails

 git-sh-setup.sh             |   12 +++-
 git-submodule.sh            |   48 +++++++++++++--
 t/t7406-submodule-update.sh |  144 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 196 insertions(+), 8 deletions(-)

-- 
1.7.6.rc0.14.g4fc55

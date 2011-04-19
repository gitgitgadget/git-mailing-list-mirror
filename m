From: Luke Diamand <luke@diamand.org>
Subject: [PATCH] git-p4: add option to preserve user names
Date: Tue, 19 Apr 2011 19:01:17 +0100
Message-ID: <1303236078-14011-1-git-send-email-luke@diamand.org>
Cc: Luke Diamand <luke@diamand.org>, Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Tue Apr 19 20:02:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QCFFS-00009U-Hn
	for gcvg-git-2@lo.gmane.org; Tue, 19 Apr 2011 20:02:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754043Ab1DSSBy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2011 14:01:54 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:40828 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753445Ab1DSSBx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2011 14:01:53 -0400
Received: by wwa36 with SMTP id 36so7262680wwa.1
        for <git@vger.kernel.org>; Tue, 19 Apr 2011 11:01:52 -0700 (PDT)
Received: by 10.227.172.7 with SMTP id j7mr1916250wbz.60.1303236112148;
        Tue, 19 Apr 2011 11:01:52 -0700 (PDT)
Received: from localhost.localdomain ([212.183.128.32])
        by mx.google.com with ESMTPS id x1sm89143wbh.19.2011.04.19.11.01.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 19 Apr 2011 11:01:51 -0700 (PDT)
To: git@vger.kernel.org
X-Mailer: git-send-email 1.7.1
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171804>

Patches from git passed into p4 end up with the committer
being identified as the person who ran git-p4.

With "submit --preserve-user", git-p4 sets P4USER. If the
submitter has sufficient p4 permissions, the p4 equivalent
of the git email committer will be passed into perforce.

Luke Diamand (1):
  git-p4: add option to preserve user names

 contrib/fast-import/git-p4     |   33 +++++++++++++++++++++++++++++++++
 contrib/fast-import/git-p4.txt |    6 ++++++
 2 files changed, 39 insertions(+), 0 deletions(-)

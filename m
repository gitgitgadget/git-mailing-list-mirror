From: Luke Diamand <luke@diamand.org>
Subject: [PATCHv4 0/5] git p4: label import/export: documentation fix
Date: Tue, 24 Apr 2012 09:33:18 +0100
Message-ID: <1335256403-22162-1-git-send-email-luke@diamand.org>
Cc: Pete Wyckoff <pw@padd.com>, Junio C Hamano <gitster@pobox.com>,
	Vitor Antunes <vitor.hda@gmail.com>,
	Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 24 10:33:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMbBr-00083G-Vc
	for gcvg-git-2@plane.gmane.org; Tue, 24 Apr 2012 10:33:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756240Ab2DXIdd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Apr 2012 04:33:33 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:53086 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755810Ab2DXIdb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2012 04:33:31 -0400
Received: by wejx9 with SMTP id x9so243064wej.19
        for <git@vger.kernel.org>; Tue, 24 Apr 2012 01:33:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:x-gm-message-state;
        bh=A3Zx+21UUv3cB8zUVLchYrmd0paHD4+4Qp2JeDQiFI8=;
        b=Bgqibol190PoQR84m3O/5/PezqyNTf3vtBB9Hmo3kgqPdSnpCj4PhVcbbmIWIwDWGb
         J6+IeRKc5gCtKyUqbUC43NelXte5TTF2zCgfjFEcMdwk4lHa+bLTEUUrUyx7ljctQUwW
         9/lGCvjS2LTc1CQ9uhBTpnzNcsktyT5jDan+HitOqRcyGxESjgEfI3qAlf4sBDX/mlqB
         8wgzGtmbebWF6wtfq7ANjMt4+qDfPNfgmWy+aMjxkR/npzKoWGgRnBDuxeyOkCu2+9wC
         AFmQHEhWQomFiCn6+VEQT/CAIZe2aDkVp+XuHny7n4aF2hl/YeoNXfOpE/aol+YFAcdl
         +/0g==
Received: by 10.216.131.206 with SMTP id m56mr11290658wei.92.1335256410674;
        Tue, 24 Apr 2012 01:33:30 -0700 (PDT)
Received: from ethel.diamand (cpc19-cmbg14-2-0-cust6.5-4.cable.virginmedia.com. [86.6.30.7])
        by mx.google.com with ESMTPS id fz9sm28534467wib.3.2012.04.24.01.33.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 24 Apr 2012 01:33:30 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.8.g12781
X-Gm-Message-State: ALoCoQmPphO7Nvu5yDxoE/6JYyIT1tnQomjcv56XDzJAbYv7fwrEKENHrrRzD5Gkk6iv8UN49skO
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196210>

Sorry, the previous patch series contained an error in the "git p4"
documentation. Everything else is as before.

Luke Diamand (5):
  git p4: Fixing script editor checks
  git p4: Squash P4EDITOR in test harness
  git p4: Ignore P4EDITOR if it is empty
  git p4: import/export of labels to/from p4
  git p4: move verbose to base class

 Documentation/git-p4.txt       |   54 ++++++--
 git-p4.py                      |  289 ++++++++++++++++++++++++++++++++--------
 t/lib-git-p4.sh                |    1 +
 t/t9800-git-p4-basic.sh        |    4 +-
 t/t9811-git-p4-label-import.sh |  202 ++++++++++++++++++++++++++++
 5 files changed, 482 insertions(+), 68 deletions(-)
 create mode 100755 t/t9811-git-p4-label-import.sh

-- 
1.7.10.8.g12781

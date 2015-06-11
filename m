From: Michael Rappazzo <rappazzo@gmail.com>
Subject: [PATCH v3] git-rebase--interactive.sh: add config option for custom instruction format
Date: Wed, 10 Jun 2015 21:30:43 -0400
Message-ID: <1433986244-76038-1-git-send-email-rappazzo@gmail.com>
Cc: git@vger.kernel.org, Michael Rappazzo <rappazzo@gmail.com>
To: gitset@pobox.com, johannes.schindelin@gmx.de
X-From: git-owner@vger.kernel.org Thu Jun 11 03:47:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2raF-0004a4-TX
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jun 2015 03:47:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752479AbbFKBrC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2015 21:47:02 -0400
Received: from mail-vn0-f65.google.com ([209.85.216.65]:35070 "EHLO
	mail-vn0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751850AbbFKBrB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2015 21:47:01 -0400
X-Greylist: delayed 942 seconds by postgrey-1.27 at vger.kernel.org; Wed, 10 Jun 2015 21:47:01 EDT
Received: by vnbf190 with SMTP id f190so7087033vnb.2
        for <git@vger.kernel.org>; Wed, 10 Jun 2015 18:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=4ABBZR7fq2WyGIjnSM329QG+Zc+A8bV8OawlZRMlxdw=;
        b=1KDxdm1gFEGvgkJXCkz7kzj5Izmi1HIna8FvRpi5QKERjC2DnJN3x26Pm2xWxcQ/ff
         rqvcaICAltVsUUk5HTD0ebalf7EkgIW/SNG5f9Ug9SFyVPfMlENJde58/LKEot+9y4YV
         6TIbMw9FxBDF9OyCkbZ2lTtjWbKYY+66s0w1G17iTbbrcR80na1pvmaJ+fUTMbp9EIqD
         KJc1WS1HX4dMVCir7qTdPBuOCeBvwsIKTw8kUIb+zrprdoCpb+3BbWlh3qOyWMw1QUZm
         ztjvywUVJvQay39ZnakIfwsX78xZPC5vsGuMMMCXN52PdkA/sO89N/GKbFA+awHl2inx
         Zuog==
X-Received: by 10.52.114.42 with SMTP id jd10mr11607602vdb.90.1433986279210;
        Wed, 10 Jun 2015 18:31:19 -0700 (PDT)
Received: from MRappazzo-2.local.info (ool-18e49664.dyn.optonline.net. [24.228.150.100])
        by mx.google.com with ESMTPSA id jk10sm12888072vdb.13.2015.06.10.18.31.18
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 10 Jun 2015 18:31:18 -0700 (PDT)
X-Mailer: git-send-email 2.4.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271371>

Difference between v2 and v3 of this patch:

    - Fixed autosquash
    - Added documentation on the config options
    - Added two tests to t3414 (rebase-autosquash)

Michael Rappazzo (1):
  git-rebase--interactive.sh: add config option for custom instruction
    format

 Documentation/git-rebase.txt |  7 +++++++
 git-rebase--interactive.sh   | 34 ++++++++++++++++++++++++++++------
 t/t3415-rebase-autosquash.sh | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 68 insertions(+), 6 deletions(-)

-- 
2.4.2

From: Andrew Garber <andrew@andrewgarber.com>
Subject: [PATCH] git-p4: replace each tab with 8 spaces for consistency
Date: Thu,  7 Apr 2011 02:01:20 -0400
Message-ID: <1302156081-3286-1-git-send-email-andrew@andrewgarber.com>
References: <y>
Cc: Andrew Garber <andrew@andrewgarber.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Apr 07 08:03:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7iJi-00073S-M2
	for gcvg-git-2@lo.gmane.org; Thu, 07 Apr 2011 08:03:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751657Ab1DGGDY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2011 02:03:24 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:53126 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751069Ab1DGGDX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Apr 2011 02:03:23 -0400
Received: by iwn34 with SMTP id 34so2138060iwn.19
        for <git@vger.kernel.org>; Wed, 06 Apr 2011 23:03:22 -0700 (PDT)
Received: by 10.43.57.200 with SMTP id wh8mr897401icb.29.1302156202864;
        Wed, 06 Apr 2011 23:03:22 -0700 (PDT)
Received: from localhost.localdomain (75-119-246-204.dsl.teksavvy.com [75.119.246.204])
        by mx.google.com with ESMTPS id gy41sm915291ibb.22.2011.04.06.23.03.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 06 Apr 2011 23:03:22 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
In-Reply-To: <y>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171043>

Note that the majority of git-p4 uses spaces, not tabs, for indentation.
Consistent indentation is critical to the functionality of Python
scripts: mixing tabs and spaces in Python can lead to hard-to-find bugs.

Andrew Garber (1):
  git-p4: replace each tab with 8 spaces for consistency

 contrib/fast-import/git-p4 |   64 ++++++++++++++++++++++----------------------
 1 files changed, 32 insertions(+), 32 deletions(-)

-- 
1.7.3.4

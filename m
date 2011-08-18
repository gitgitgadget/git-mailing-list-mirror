From: Vitor Antunes <vitor.hda@gmail.com>
Subject: [PATCH v2 0/4] Support threshold in copy/rename detection
Date: Thu, 18 Aug 2011 23:20:50 +0100
Message-ID: <1313706054-11740-1-git-send-email-vitor.hda@gmail.com>
Cc: Pete Wyckoff <pw@padd.com>, Tor Arvid Lund <torarvid@gmail.com>,
	Vitor Antunes <vitor.hda@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 19 00:21:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuAxp-0002Id-U1
	for gcvg-git-2@lo.gmane.org; Fri, 19 Aug 2011 00:21:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754710Ab1HRWVV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Aug 2011 18:21:21 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:65087 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754587Ab1HRWVU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2011 18:21:20 -0400
Received: by wwf5 with SMTP id 5so2541792wwf.1
        for <git@vger.kernel.org>; Thu, 18 Aug 2011 15:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=05qBnsVKTfmh3pWlv5B4L4hOnMOckkPaqgglK7kfCn0=;
        b=kTBS15y+DRJwdXg/f18Tnl43q5aTkE9Yw9EXpyTKh7IVq9SalTHbtImLnlbtoumn/8
         dj6ivpb6z96Cn/YNfU0TqB7Iv1uYIx20EFkbEp+KJ4vI2u0N15FpiouW0q73iO6N+SYS
         mgscZgFWfIxTZrL7EYuiyMG8mdx1bfuGkd1f4=
Received: by 10.227.182.138 with SMTP id cc10mr1057698wbb.98.1313706079086;
        Thu, 18 Aug 2011 15:21:19 -0700 (PDT)
Received: from localhost.localdomain (111.216.54.77.rev.vodafone.pt [77.54.216.111])
        by mx.google.com with ESMTPS id fy12sm2103590wbb.32.2011.08.18.15.21.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 18 Aug 2011 15:21:17 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179636>

Second version that includes updates recommended by Pete Wyckoff.
Now only "true" and "false" arguments are processed, any other argument
that is no "" is passed directly.

Vitor Antunes (4):
  git-p4: Allow setting rename/copy detection threshold.
  git-p4: Add description of rename/copy detection options.
  git-p4: Add test case for rename detection.
  git-p4: Add test case for copy detection.

 contrib/fast-import/git-p4     |   18 ++++--
 contrib/fast-import/git-p4.txt |   25 ++++++++
 t/t9800-git-p4.sh              |  121 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 159 insertions(+), 5 deletions(-)

-- 
1.7.5.4

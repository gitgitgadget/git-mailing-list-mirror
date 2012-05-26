From: Vitor Antunes <vitor.hda@gmail.com>
Subject: [PATCHv2 0/3] New test cases for branch detection
Date: Sat, 26 May 2012 10:56:03 +0100
Message-ID: <1338026166-5462-1-git-send-email-vitor.hda@gmail.com>
Cc: Pete Wyckoff <pw@padd.com>, Luke Diamand <luke@diamand.org>,
	Vitor Antunes <vitor.hda@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 26 11:56:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYDjq-00018H-Ur
	for gcvg-git-2@plane.gmane.org; Sat, 26 May 2012 11:56:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752160Ab2EZJ4U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 May 2012 05:56:20 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:63256 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751887Ab2EZJ4T (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 May 2012 05:56:19 -0400
Received: by weyu7 with SMTP id u7so1036185wey.19
        for <git@vger.kernel.org>; Sat, 26 May 2012 02:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=8mJI/Iksjk7pQbm/Nga1X6ItGKA4VhivWY/2cZB0C6Q=;
        b=G0RXMge7ejxJ/uID4XmrXGDKRrcPRliTUjdEN2oi9RK/I84fgzn3Z79g1EJrHyFO6U
         34hZi/LadLjRsVHxWstLjODJdL605JufN9FCpUMGJWbmGNlcib6jAkte7rK0q1XwiN24
         7iREIoUlf7gJaZDUlGvWeG5yGTG5gXl4N2NyfeaVr94ujJzWKi8X5MGTsRevxNopTem7
         kccUyZshCX7cuPVvC3TA7/f2V3zFmfavsmGVSwrVIXwrQ+9erI4lwUkXoKgKu+8DxsBe
         imp36O991TlpE8EG641JxbSfAeR43lFjuKGhy26XEu5l0mYtqknrmt/Z+gWlQS71oDVr
         5VtQ==
Received: by 10.216.70.10 with SMTP id o10mr1099667wed.51.1338026177938;
        Sat, 26 May 2012 02:56:17 -0700 (PDT)
Received: from localhost.localdomain (111.216.54.77.rev.vodafone.pt. [77.54.216.111])
        by mx.google.com with ESMTPS id gv4sm5763390wib.8.2012.05.26.02.56.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 26 May 2012 02:56:17 -0700 (PDT)
X-Mailer: git-send-email 1.7.7.rc2.14.g5e044.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198545>

Updates for previous patch according to feedback from Pete Wyckoff (and
some help from Junio). I also tried to find more improvement
opportunities and included an extra small patch with two small fixes.

Please review and provide feedback.

Kind regards.

Vitor Antunes (3):
  git-p4: Test changelists touching two branches
  git-p4: Verify detection of "empty" branch creation
  git-p4: Clean up branch test cases

 t/t9801-git-p4-branch.sh |  110 ++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 107 insertions(+), 3 deletions(-)

-- 
1.7.7.rc2.14.g5e044.dirty

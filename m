From: Vitor Antunes <vitor.hda@gmail.com>
Subject: [PATCH v3 0/5] Support threshold in copy/rename detection
Date: Mon, 22 Aug 2011 09:33:04 +0100
Message-ID: <1314001989-29017-1-git-send-email-vitor.hda@gmail.com>
Cc: Pete Wyckoff <pw@padd.com>, Tor Arvid Lund <torarvid@gmail.com>,
	Vitor Antunes <vitor.hda@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 22 10:34:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QvPxY-0001JE-Ku
	for gcvg-git-2@lo.gmane.org; Mon, 22 Aug 2011 10:34:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754230Ab1HVIeM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Aug 2011 04:34:12 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:35956 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752339Ab1HVIeL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Aug 2011 04:34:11 -0400
Received: by wyg24 with SMTP id 24so3312299wyg.19
        for <git@vger.kernel.org>; Mon, 22 Aug 2011 01:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=erdZjLPMPYO3P0xj1KbHvHBdpok91AF2Rn0TnNpfWzE=;
        b=hug7/+CYFcKDHiOf0JOvq/qUiXWRKph+tqElk10SWOxMc/mYyawe5suDOCbqQgnVkg
         kkHkhV81wZspbkMH3KSHTeA60NS/+jvf48z978AElIfJ3GLLUZrGN1mjGR0o5tKS6WQd
         rziy/Hx3iA/9gco/y+i7T5uob2KBv5mCeFGz4=
Received: by 10.216.13.193 with SMTP id b43mr1728948web.1.1314002049747;
        Mon, 22 Aug 2011 01:34:09 -0700 (PDT)
Received: from localhost.localdomain (111.216.54.77.rev.vodafone.pt [77.54.216.111])
        by mx.google.com with ESMTPS id e44sm3284981wed.41.2011.08.22.01.33.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 22 Aug 2011 01:34:08 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179844>

Make detectCopiesHarder use "git config --bool".
Include Pete Wyckoff's patches to test cases.

Vitor Antunes (5):
  git-p4: Allow setting rename/copy detection threshold
  git-p4: Add description of rename/copy detection options
  git-p4: Add test case for rename detection
  git-p4: Add test case for copy detection
  git-p4: Process detectCopiesHarder with --bool

 contrib/fast-import/git-p4     |   15 +++--
 contrib/fast-import/git-p4.txt |   25 +++++++
 t/t9800-git-p4.sh              |  136 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 171 insertions(+), 5 deletions(-)

-- 
1.7.5.4

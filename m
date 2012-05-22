From: Vitor Antunes <vitor.hda@gmail.com>
Subject: [PATCH 0/2] git-p4: New test cases for branch detection
Date: Wed, 23 May 2012 00:38:09 +0100
Message-ID: <1337729891-27648-1-git-send-email-vitor.hda@gmail.com>
Cc: Pete Wyckoff <pw@padd.com>, Luke Diamand <luke@diamand.org>,
	Vitor Antunes <vitor.hda@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 23 01:38:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWyev-0005jd-5h
	for gcvg-git-2@plane.gmane.org; Wed, 23 May 2012 01:38:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932074Ab2EVXi2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 May 2012 19:38:28 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:41070 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753944Ab2EVXi2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2012 19:38:28 -0400
Received: by wibhn6 with SMTP id hn6so4034207wib.1
        for <git@vger.kernel.org>; Tue, 22 May 2012 16:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=s6dZFMVp92pc7dZMOsYsVcASzneqYF8GUji5+ohp2b0=;
        b=lynFfAMOCO1tTs5CcmyUYhmWerHfpJfOrI1pWdU86OXuLfsWKqiJxSKZeFo4UN5H/K
         I8PBAk9jAqKI8933Zr5vmWYl+4cOosOjFZQGiPXR5sDMzv0h9DN3/CaGyXeFMTlTs/W9
         JTpEZ9mnG2Hm1iLyUG7ePr5IrFvvdUr2D9QrUUubMJsdHQQXT/MvhaEWa08nKRHgjY7x
         BN8AGwCqC4g7ip9/ydoIbgHgFBdYnCwHq2+JIPGIDgSIll2B+Axg92kx3akw3u+BX9BR
         bj7vG4oFd2P3IZfU7+68js4jpx1x5rrnoRbZaeml8TRWuqsSQsiVPm+/s+HlE2VuezH5
         tjRA==
Received: by 10.180.102.36 with SMTP id fl4mr32209677wib.2.1337729905485;
        Tue, 22 May 2012 16:38:25 -0700 (PDT)
Received: from localhost.localdomain (111.216.54.77.rev.vodafone.pt. [77.54.216.111])
        by mx.google.com with ESMTPS id r2sm56922565wif.7.2012.05.22.16.38.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 22 May 2012 16:38:24 -0700 (PDT)
X-Mailer: git-send-email 1.7.7.rc2.14.g5e044.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198265>

Two new test cases to verify branch detection functionality. The first
is working properly and I think it is a good idea to make sure this is
not broken in the future. The second test case shows a limitation in the
current algorithm for new branch detection.

Vitor Antunes (2):
  git-p4: Test changelists touching two branches
  git-p4: Verify detection of "empty" branch creation

 t/t9801-git-p4-branch.sh |  110 ++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 110 insertions(+), 0 deletions(-)

-- 
1.7.7.rc2.14.g5e044.dirty

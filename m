From: Yuxuan Shui <yshuiv7@gmail.com>
Subject: [PATCH v3 0/2] GSoC micro project, rewrite fsck_commit() to use skip_prefix()
Date: Thu, 13 Mar 2014 12:45:49 +0800
Message-ID: <1394685951-9726-1-git-send-email-yshuiv7@gmail.com>
Cc: Yuxuan Shui <yshuiv7@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 13 05:46:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNxX6-0006z5-UX
	for gcvg-git-2@plane.gmane.org; Thu, 13 Mar 2014 05:46:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751042AbaCMEqH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2014 00:46:07 -0400
Received: from mail-pb0-f52.google.com ([209.85.160.52]:43707 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750946AbaCMEqF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2014 00:46:05 -0400
Received: by mail-pb0-f52.google.com with SMTP id rr13so542157pbb.25
        for <git@vger.kernel.org>; Wed, 12 Mar 2014 21:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=dPf7TAufqxKNEg7P0sWXiueymajUG2TLRnGLc9iFiy0=;
        b=qyF1qAI8QhrOdXxM524sdl3LaxC1rEnbK409ZgwEz52jfLxNM86lsT8IKqy4i5XFi5
         DO30zcmK1MzBhclSk5KohXePPs8cod3JV8azlraQo9klHFxUR1Q83VIMeSW1EAQNSd6W
         mWUeGGmWaD4BcT/+20uVwOgVZQagcHhxMDu2CyglSiNmIyP+hFMvsuZgkOXvXVlOivFP
         ooIWTk46/jcIYoOM6RlqODkOkZVvnGSW8g7GmmQqEfznVe5mEcHpDxDQk/8RORpN08QP
         7M1efa6yY0X4p0GZAzo60kn+RExFZ+P5mHCRq+clvBTqV3Kmfd42IlUeOvyboaiU5qjX
         J8vw==
X-Received: by 10.66.150.69 with SMTP id ug5mr1677221pab.55.1394685965123;
        Wed, 12 Mar 2014 21:46:05 -0700 (PDT)
Received: from localhost.localdomain ([123.151.32.162])
        by mx.google.com with ESMTPSA id zb2sm2528040pbc.30.2014.03.12.21.46.02
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 12 Mar 2014 21:46:04 -0700 (PDT)
X-Mailer: git-send-email 1.9.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244019>

Improved commit message, and added a missing hunk to the second commit.

Yuxuan Shui (2):
  fsck.c: Change the type of fsck_ident()'s first argument
  fsck.c: Rewrite fsck_commit() to use skip_prefix()

 fsck.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

-- 
1.9.0

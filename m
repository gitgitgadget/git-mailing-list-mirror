From: Boris Faure <billiob@gmail.com>
Subject: [PATCH/RFC] branch: add optional parameter to -r to specify remote
Date: Sun, 19 Jun 2011 21:19:08 +0200
Message-ID: <1308511149-10933-1-git-send-email-billiob@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 19 21:09:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYNMm-0001xR-3o
	for gcvg-git-2@lo.gmane.org; Sun, 19 Jun 2011 21:09:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754677Ab1FSTI6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jun 2011 15:08:58 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:43308 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754651Ab1FSTI5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jun 2011 15:08:57 -0400
Received: by wyb38 with SMTP id 38so1241443wyb.19
        for <git@vger.kernel.org>; Sun, 19 Jun 2011 12:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:message-id:x-mailer;
        bh=iHZpC0d/WgT+oLYUjjmtKEB97ZU6hehTA+5gYP1yJTI=;
        b=ZbwThEYGRRRP9qJgco9ewJVHkO+SNWiNRe6XUZanH+hqIFSDzJ69yi2pmlayFI56vA
         +i/5OdNIIJqZ3b2wisgOB2l7T9L9Q1A2nbdg9mlnWDw6XhEC+TdQWqiTAUF0gPEb97d4
         Zjf9evRGjl7yhsGIZ4r/z3S9dFCfX1TjWI1pI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer;
        b=VphymGBYYJO4eKIHAsAzeyGJHgToFan5Kq50Ry39Ueu7P8Y3wFE4k1DucQYcH3X7WZ
         QROJ1gbbVGg8BRV2tlUvDG/zrFiOJvg4R82nqSmbr5MTouuQ4LXCLSqTCA3rDdlKM5fq
         5JDENWMpYjQ8tByijkOnD8Yhm9bJiPjOjl8+I=
Received: by 10.216.254.82 with SMTP id g60mr3907242wes.90.1308510536504;
        Sun, 19 Jun 2011 12:08:56 -0700 (PDT)
Received: from localhost.localdomain (ADijon-259-1-31-165.w90-33.abo.wanadoo.fr [90.33.98.165])
        by mx.google.com with ESMTPS id g2sm2508004weg.38.2011.06.19.12.08.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 19 Jun 2011 12:08:55 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.rc2.4.g36bfb.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176026>

The following patch adds an optional parameter to branch -r to use as
-r=<remote> in order to list branches on a particular remote.

'git branch -d -r one/another' can also be done with
'git branch -d -r=one another'.

I haven't found tests specially crafted for 'git branch -r -d <branch>'. I
hope the tests I have added are in the correct places.

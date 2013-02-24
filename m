From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v2 00/16] use a lowercase "usage:" string
Date: Sat, 23 Feb 2013 16:50:08 -0800
Message-ID: <1361667024-49776-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 24 01:51:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9Pnu-0005kg-C7
	for gcvg-git-2@plane.gmane.org; Sun, 24 Feb 2013 01:50:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759429Ab3BXAud (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2013 19:50:33 -0500
Received: from mail-pa0-f49.google.com ([209.85.220.49]:49073 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759390Ab3BXAud (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2013 19:50:33 -0500
Received: by mail-pa0-f49.google.com with SMTP id kp6so1116518pab.8
        for <git@vger.kernel.org>; Sat, 23 Feb 2013 16:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=/gOdXnZNONFdWCTe10jElnAQLMKSy9MtanUX55i333w=;
        b=iO6z1aQ6cT660Ksbvt6smvKzY4TkYBOqsmpHEGuxlFuxvKTOZwfUcNMqWS0KdO2jno
         j3tKu5pF+GRQGdKORFufjRaj6hwwcB7k7N4Ux3v3Kz5kWF9cId2BW096tZAO91g7538w
         XxxqC33Z5Qt/QHGvJxws/BtWUi1PvsC4wakcXLxLwGP6KS0YMUceiw9xX9RNslIlVKsx
         T1eiuQ9OtI/T7DxannDAAGkOYuQFN835N+kgW6kdmMPeN1wZH7DlVV3SLJihXnlY2ffU
         kMuPL3jFe7xcAqc+wmcogqIVsvZ7c37ggxC1el7+1jNehoIbmPDD9iOOsibnt6yVzOPZ
         RfFA==
X-Received: by 10.68.216.7 with SMTP id om7mr10696260pbc.149.1361667032581;
        Sat, 23 Feb 2013 16:50:32 -0800 (PST)
Received: from lustrous.fas.fa.disney.com (remote-11.disneyanimation.com. [198.187.190.11])
        by mx.google.com with ESMTPS id a4sm8190345paw.21.2013.02.23.16.50.30
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 23 Feb 2013 16:50:31 -0800 (PST)
X-Mailer: git-send-email 1.8.2.rc0.263.g20d9441
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216961>

The code content is unchanged from v1.

v2 adjusts the commit messages per Jonathan's review
and adds a Reviewed-by: to the commit message except for
patches 11 and 12, which are unchanged since v1.

David Aguilar (16):
  git-sh-setup: use a lowercase "usage:" string
  git-svn: use a lowercase "usage:" string
  git-relink: use a lowercase "usage:" string
  git-merge-one-file: use a lowercase "usage:" string
  git-archimport: use a lowercase "usage:" string
  git-cvsexportcommit: use a lowercase "usage:" string
  git-cvsimport: use a lowercase "usage:" string
  git-cvsimport: use a lowercase "usage:" string
  contrib/credential: use a lowercase "usage:" string
  contrib/fast-import: use a lowercase "usage:" string
  contrib/fast-import/import-zips.py: fix broken error message
  contrib/fast-import/import-zips.py: use spaces instead of tabs
  contrib/examples: use a lowercase "usage:" string
  contrib/hooks/setgitperms.perl: use a lowercase "usage:" string
  templates/hooks--update.sample: use a lowercase "usage:" string
  Documentation/user-manual.txt: use a lowercase "usage:" string

 Documentation/user-manual.txt                      |  4 +-
 .../gnome-keyring/git-credential-gnome-keyring.c   |  2 +-
 .../osxkeychain/git-credential-osxkeychain.c       |  2 +-
 .../credential/wincred/git-credential-wincred.c    |  2 +-
 contrib/examples/git-remote.perl                   |  2 +-
 contrib/examples/git-svnimport.perl                |  2 +-
 contrib/fast-import/git-import.perl                |  2 +-
 contrib/fast-import/git-import.sh                  |  2 +-
 contrib/fast-import/import-zips.py                 | 98 +++++++++++-----------
 contrib/hooks/setgitperms.perl                     |  2 +-
 git-archimport.perl                                |  2 +-
 git-cvsexportcommit.perl                           |  2 +-
 git-cvsimport.perl                                 |  2 +-
 git-cvsserver.perl                                 |  2 +-
 git-merge-one-file.sh                              |  2 +-
 git-relink.perl                                    |  2 +-
 git-sh-setup.sh                                    |  6 +-
 git-svn.perl                                       |  2 +-
 templates/hooks--update.sample                     |  2 +-
 19 files changed, 70 insertions(+), 70 deletions(-)

-- 
1.8.2.rc0.263.g20d9441

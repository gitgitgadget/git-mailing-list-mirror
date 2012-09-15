From: Andrew Wong <andrew.kw.w@gmail.com>
Subject: [PATCH 0/3] rebase -i: Teach "--edit-todo"
Date: Sat, 15 Sep 2012 16:08:26 -0400
Message-ID: <1347739709-15289-1-git-send-email-andrew.kw.w@gmail.com>
References: <CADgNjambUXj+WEFg=OWvtDQ1EKFhavwbjMbTVaP69rhh5DrphA@mail.gmail.com>
Cc: Andrew Wong <andrew.kw.w@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 15 23:10:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCzdd-0004gH-VM
	for gcvg-git-2@plane.gmane.org; Sat, 15 Sep 2012 23:10:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751482Ab2IOVJp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Sep 2012 17:09:45 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:40721 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750960Ab2IOVJo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Sep 2012 17:09:44 -0400
Received: by ieje11 with SMTP id e11so7950937iej.19
        for <git@vger.kernel.org>; Sat, 15 Sep 2012 14:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=z317JQfScGTbfH/GZPuQs3vpYVddN2QV2F5milqtPFE=;
        b=XVh+ct/D0GbFopK/UuD+Di+SEUu9B1yFjuirW+x6iE+oeDVnD3fi0mJaoEMWkeW+le
         AYAeta/MXaz8eDjZXOe18On466618M4BWB1A1+WChj1rXdjL9gM7/vQsfTjb3Nh/gcky
         aiy/RA/sH/m091KbbRqx7pgMZugdlCv4O6SnMS+qOLVkYMe7uszUYels8ORe5Y+C+EIr
         KW7ptbTjgLES9aOS/Si0qvIfMaZzCUMSKjBDr0Q5ahQj9pRPgHPkRCR3mHrFiHoUuWED
         pkLtUS9/M4V3yQlSlN7qy1L4aaIAaKxkMhDtr/LQaORf1y7T1dHOvuDoZhT/hWQGK79e
         A4/w==
Received: by 10.50.7.177 with SMTP id k17mr2967006iga.27.1347743383641;
        Sat, 15 Sep 2012 14:09:43 -0700 (PDT)
Received: from localhost.localdomain ([69.165.255.59])
        by mx.google.com with ESMTPS id d19sm2172495igp.6.2012.09.15.14.09.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 15 Sep 2012 14:09:42 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.318.g08bf5ad.dirty
In-Reply-To: <CADgNjambUXj+WEFg=OWvtDQ1EKFhavwbjMbTVaP69rhh5DrphA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205571>

The flag will allow the user to edit the todo file while they're in the middle
of an interactive rebase. It simply invoke the editor and do nothing else.

More discussions here:
    http://thread.gmane.org/gmane.comp.version-control.git/205133/focus=205182

Andrew Wong (3):
  rebase -i: Refactor help messages for todo file
  rebase -i: Teach "--edit-todo" action
  rebase -i: Add tests for "--edit-todo"

 Documentation/git-rebase.txt  |  5 ++++-
 git-rebase--interactive.sh    | 47 +++++++++++++++++++++++++++++++++----------
 git-rebase.sh                 | 14 +++++++++++++
 t/t3404-rebase-interactive.sh | 16 +++++++++++++++
 4 files changed, 70 insertions(+), 12 deletions(-)

-- 
1.7.12.318.g08bf5ad.dirty

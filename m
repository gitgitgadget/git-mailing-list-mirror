From: Peter Lauri <peterlauri@gmail.com>
Subject: .gitignore behavior on Mac
Date: Sat, 18 May 2013 20:36:42 +0200
Message-ID: <CAEe6bfD_1GjMBByaEFQ4RMTMaz8XZvd00mxyfaAHtXVpbUjj6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 18 20:36:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Udlzs-0001ym-Qj
	for gcvg-git-2@plane.gmane.org; Sat, 18 May 2013 20:36:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752710Ab3ERSgo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 May 2013 14:36:44 -0400
Received: from mail-lb0-f172.google.com ([209.85.217.172]:60984 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752503Ab3ERSgo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 May 2013 14:36:44 -0400
Received: by mail-lb0-f172.google.com with SMTP id p10so607960lbi.31
        for <git@vger.kernel.org>; Sat, 18 May 2013 11:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:date:message-id:subject:from:to
         :content-type;
        bh=xkakJnEQEzEbvSELv7smiytQ1pMfC/fdWjWMqLVqiMc=;
        b=At9tSLi+ba4Ys0JKTSdoO5KcPZ/bRlXFeu+VDa5jtdwXDL9JBokm/k8L80GDyucN46
         ZmB7wTF5H3l8e8QoTpvnUMoljFhSHg1ieRAHhTotJvGGE5wzq1RKkqlnTVua9/W4u70v
         unsEmIUs2wABnzn1aW3Rw3WmdIjt/D2VNnagVDxXs92Mkc7SMsQidTbvTapk9VUsAyPo
         uCxOZ+v986y0X8Jh37ISKuoOVWFs97yTO/eQnqtH69RmAlDRWxW4ePxIcjJy9Wt9y6kp
         q+Vqr2XY/H66esiqwtcgKEJweYfv4oEm97G4mji12VJGuqJ2OnmelEt/ihJuH18/wwwn
         7ONg==
X-Received: by 10.112.2.166 with SMTP id 6mr24955241lbv.35.1368902202891; Sat,
 18 May 2013 11:36:42 -0700 (PDT)
Received: by 10.112.20.197 with HTTP; Sat, 18 May 2013 11:36:42 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224801>

Shouldn't this be valid? I would expect to NOT see the
core/inc/config.inc.php in the "git status" output...

Peters-MacBook-Air:dt-git plauri$ cat .gitignore
.buildpath
.project
.settings/
web/pjotr.php
core/inc/config.inc.php
dt_error.log
process_wrapper.sh

Peters-MacBook-Air:dt-git plauri$ git status
# On branch local/DT-7_gantt
# Changes not staged for commit:
#   (use "git add <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working directory)
#
# modified:   .gitignore
# modified:   core/inc/config.inc.php
#
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
# out.ionel
# tree.py
no changes added to commit (use "git add" and/or "git commit -a")
Peters-MacBook-Air:dt-git plauri$

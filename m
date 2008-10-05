From: bain <bain@devslashzero.com>
Subject: [Announce] teamGit v0.0.3
Date: Sun, 5 Oct 2008 02:39:53 -0700 (PDT)
Message-ID: <8ce0dfd6-2bd7-4e94-901f-b7c9bbd114aa@w39g2000prb.googlegroups.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: bain@devslashzero.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 05 11:50:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KmQFs-0000g9-76
	for gcvg-git-2@gmane.org; Sun, 05 Oct 2008 11:50:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753328AbYJEJtO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Oct 2008 05:49:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753289AbYJEJtO
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Oct 2008 05:49:14 -0400
Received: from mail-gx0-f62.google.com ([209.85.217.62]:60564 "EHLO
	mail-gx0-f62.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753253AbYJEJtN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Oct 2008 05:49:13 -0400
X-Greylist: delayed 558 seconds by postgrey-1.27 at vger.kernel.org; Sun, 05 Oct 2008 05:49:12 EDT
Received: by gxk22 with SMTP id 22so8109572gxk.21
        for <git@vger.kernel.org>; Sun, 05 Oct 2008 02:49:12 -0700 (PDT)
Received: by 10.150.49.2 with SMTP id w2mr107022ybw.17.1223199593856; Sun, 05 
	Oct 2008 02:39:53 -0700 (PDT)
X-IP: 59.95.16.13
User-Agent: G2/1.0
X-HTTP-UserAgent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.0.1) 
	Gecko/2008072820 Firefox/3.0.1,gzip(gfe),gzip(gfe)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97506>

Hi all,

This is an announcement for a small project to create a functional git
gui.
This project was born as kgit a couple of years back when i needed a
ui commit tool and none other were mature.
My ambitions have grown since then and I recoded it in pure QT4.

The short description of the application :-

Currently it is of course in very early alpha stage.
It works stable to do following things,

1. Its a pretty good commit tool. Just double click on unstaged files
to stage them. It supports staging hunks (just double click on the
hunk you want to stage in diff pane)  and the related stuff.  You can
optionally view untracked files and stage them for inclusion as well.
2. Its a preliminary repository viewer, it does not support graphical
representation for want of performance.
3. It has few other git command implemented, a quick issue of pull/
push, a reset command, cherry pick command and some branch management
implemented.

Known problems,
1. Icons make no sense i just dumped kde icons dir to the project
resources and picked the ones i could match or just at random (e.g.
checkout is a smilie)
2. No documentation, will be addressed soon.
3. All git commands can not be canceled in between. But with git thats
not usually a big issue.

Long description:

You can find the info on
http://www.devslashzero.com/teamgit

Download
http://www.devslashzero.com/teamgit/download (you will need qt-dev >
4.4)

This is so far tested only on ubuntu 8.04 with backports repo enabled
and qt update installed.

Ultimate goal of the project is to add much more than just version
control on top of git. But giving git a ui will always remain an
important goal.
You can view continually evolving roadmap at
http://www.devslashzero.com/teamgit/roadmap

With this announcement i am looking for feedback on the overall
interface design (commit procedure dialogs etc.) and feature requests.

WARNING: never been used out side controlled environment. Use at your
own risk.


Abhijit Bhopatkar - BAIN

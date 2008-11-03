From: Abhijit Bhopatkar <bain@devslashzero.com>
Subject: [Announce] teamGit v0.0.4
Date: Sun, 2 Nov 2008 19:22:07 -0800 (PST)
Message-ID: <d62af2d5-4ba4-4fe6-9ecb-6df007f87245@s9g2000prm.googlegroups.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: bain@devslashzero.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 03 04:23:32 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kwq2N-0007ia-9q
	for gcvg-git-2@gmane.org; Mon, 03 Nov 2008 04:23:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754397AbYKCDWM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Nov 2008 22:22:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754381AbYKCDWK
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Nov 2008 22:22:10 -0500
Received: from yw-out-2122.google.com ([74.125.46.27]:28414 "EHLO
	yw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754397AbYKCDWJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Nov 2008 22:22:09 -0500
Received: by yw-out-2122.google.com with SMTP id 4so216005ywd.1
        for <git@vger.kernel.org>; Sun, 02 Nov 2008 19:22:07 -0800 (PST)
Received: by 10.100.9.6 with SMTP id 6mr955995ani.2.1225682527626; Sun, 02 Nov 
	2008 19:22:07 -0800 (PST)
X-IP: 59.95.20.44
User-Agent: G2/1.0
X-HTTP-UserAgent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.0.3) 
	Gecko/2008101315 Ubuntu/8.10 (intrepid) Firefox/3.0.3,gzip(gfe),gzip(gfe)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99897>

Hi people,

I have just tagged the teamgit repo as v0.0.4

The improvements over v0.0.3 include
rudimentary blame support, sign-off support, apply-mailbox support,
send patch using desktop email client service support (makes mailto:
request to desktop service).

One minor but "i find it really usefull" features is that if you
select a commit in log and quit, it will print the commit hash to
stdout.
So now you can embed it in git commands or scirpts to fire up a visual
commit selection,
like
git-show `teamigt ./` will show the selected commit etc.
This is really helpful and (correct me if i am wrong) i couldn't find
other gui that does this, may be will be a good addition to gitk?

Links:
http://www.devslashzero.com/teamgit
http://www.devslashzero.com/teamgit/download


Abhijit,

Short log follows
---
Abhijit Bhopatkar (36):
      Added .desktop file and icons to install target
      Added support files for running checkinstall
      Don't depend on qt 4.4.1 we can do with just 4.4
      Changed the signoff check box label
      Added auto "add sign off line" to commit
      Added auto sign off option to general settings
      Added auto sign off option in settings
      Change libqt-core to libqtcore4 for intrepid in checkinstall
script
      Make default new project directory ~/linux-2.6
      Add base dir selection for new project dialog
      Current project is no longer used
      Add base dir selection to the new projects dialog
      Fix new project stuff to open up correct repo after clone
      Cleaned up icons directory
      Removed unneeded icon pngs
      Qdevelop cleaned up the project fine
      Added git blam support to backend gitprocess
      Added file annotation support with commit search
      Make sure first column is visible when searching
      Scrool annotation text box to top after receiving annotaion
      Cleanup: we no longer use mutex
      Bring annotated file to front when received
      FIX: Open dialog failed to refresh the UI
      Added apply mailbox function to git process backend
      Added support to push to a selected remote
      Removed an uneeded debug output message
      Added apply mail action in tools
      Added apply mail functionality
      Fix: apply mail didn't use the file provided in path and did
nothing
      Fix: Make apply mail  actully store the last path for it to
remember later
      Fix: apply mail did not refresh after operation completed
      Added send patch by email functionality
      Added send patch by mail in toolbar menu
      Activated send patch by mail menu action
      Added quit action to file menu and activated it
      teamGit will now print sha id of the selected commit while
exiting to stdout

Horst H. von Brand (1):
      Fix typo in src/mainwindowimpl.cpp

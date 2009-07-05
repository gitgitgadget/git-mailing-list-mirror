From: Daniel Trstenjak <Daniel.Trstenjak@online.de>
Subject: Verbose output of git commands
Date: Sun, 5 Jul 2009 12:58:56 +0200
Message-ID: <20090705105856.GC5689@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 05 12:59:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MNPRD-0008ST-7D
	for gcvg-git-2@gmane.org; Sun, 05 Jul 2009 12:59:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752518AbZGEK6z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Jul 2009 06:58:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751641AbZGEK6y
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Jul 2009 06:58:54 -0400
Received: from moutng.kundenserver.de ([212.227.126.177]:59996 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751487AbZGEK6x (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Jul 2009 06:58:53 -0400
Received: from localhost (p54A084B5.dip0.t-ipconnect.de [84.160.132.181])
	by mrelayeu.kundenserver.de (node=mreu1) with ESMTP (Nemesis)
	id 0MKv1o-1MNPQu2PwX-000cP6; Sun, 05 Jul 2009 12:58:56 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Provags-ID: V01U2FsdGVkX18Fsw4Eu9QBx8zLLGEo+PdXxq6/+acRnu83frt
 Lq5dyVtygNDmo3cXBdM35D64udgeYl/58Pdih60VgV21CXHE7R
 tZuaL3s3hPMnxQJqt+a3A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122738>


Hi all,

when starting with git it's very nice to have all this helpful hints in
the output of the git commands. But know, after I can handle git quite well,
all this helpful hints hinder me to get the core information of the
commands. 

E.g:
git status

file: needs merge
# Not currently on any branch.
# Changed but not updated:
#   (use "git add <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working directory)
#
#       unmerged:   file
#
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#       init


The core information is just:

unmerged : file
untracked: init



It would be nice to be able to configure an expert mode, in which only
the core information of the git commands is printed out.

Just some thoughts.



Greetings,
Daniel

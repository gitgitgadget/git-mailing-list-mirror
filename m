From: Graeme Geldenhuys <graemeg@gmail.com>
Subject: Rewrite history then pull repository?
Date: Mon, 13 Jul 2009 10:42:42 +0200
Message-ID: <h3es3p$ie6$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 13 10:44:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQH8h-0005Eb-5g
	for gcvg-git-2@gmane.org; Mon, 13 Jul 2009 10:43:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754725AbZGMInw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jul 2009 04:43:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754340AbZGMInv
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Jul 2009 04:43:51 -0400
Received: from main.gmane.org ([80.91.229.2]:45009 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754725AbZGMInv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jul 2009 04:43:51 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1MQH8X-0008PK-Md
	for git@vger.kernel.org; Mon, 13 Jul 2009 08:43:49 +0000
Received: from 41.177.20.228 ([41.177.20.228])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 13 Jul 2009 08:43:49 +0000
Received: from graemeg by 41.177.20.228 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 13 Jul 2009 08:43:49 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 41.177.20.228
User-Agent: Thunderbird 2.0.0.22 (X11/20090608)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123177>


Hi,

I pushed a repository to Github (a mirror of SubVersion repository). I 
then had some screwup with 'git svn rebase' when I should have used 'git 
svn fetch'.  Anyway I managed to fix the issue locally and then forced 
the push to GitHub. This rewrote the history for the HEAD commit and 
gave it a different date and SHA1.

What will now happen to developers that cloned the repository before the 
  history rewrite and then do a 'git pull' after the history rewrite? 
Will git automatically sort out the mess, or is it going to post some 
warning? The content of that screwed up commit stayed exactly the same, 
only the date of the commit changed which then generated a different SHA1.

If a warning, what must they do to resolve the issue on there PC's?

Regards,
   - Graeme -

-- 
fpGUI Toolkit - a cross-platform GUI toolkit using Free Pascal
http://opensoft.homeip.net/fpgui/

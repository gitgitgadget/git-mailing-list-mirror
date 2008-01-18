From: Benoit Sigoure <tsuna@lrde.epita.fr>
Subject: gitk geometry bug on OSX
Date: Fri, 18 Jan 2008 17:33:02 +0100
Message-ID: <58195B8E-BBFF-4B4D-9986-2D46E5C5BB27@lrde.epita.fr>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 18 17:33:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFuA6-0006td-5u
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 17:33:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760978AbYARQdP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2008 11:33:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761367AbYARQdO
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jan 2008 11:33:14 -0500
Received: from 2.139.39-62.rev.gaoland.net ([62.39.139.2]:56357 "EHLO
	kualalumpur.lrde.epita.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759854AbYARQdO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2008 11:33:14 -0500
Received: from tsunaxbook.lrde.epita.fr ([192.168.101.162])
	by kualalumpur.lrde.epita.fr with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <tsuna@lrde.epita.fr>)
	id 1JFu9Y-00006r-5P
	for git@vger.kernel.org; Fri, 18 Jan 2008 17:33:12 +0100
X-Mailer: Apple Mail (2.753)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71035>

Hi list,
there is another nit which annoys me in gitk.  Besides the fact that  
the maximize button (the green `+' button that is part of Apple-style  
windows) does not do anything, I can't maximize the window on a 2nd  
screen even if I try manually.  Wild guess: I can't make the window  
bigger than the maximum area usable on the main screen of my MacBook  
(max area = screen resolution - area used by the Apple menu - (dock  
hides automatically ? 0 : min size of dock)).

Whether this is a bug in gitk or in Apple's port of Tcl/Tk (I'm still  
under Tiger btw), this is another story.  But if there's a known  
workaround for this issue, I'd be great if gitk could include it :-)

So I thought I'd let you know.  Just in case.

Cheers,

PS: I've just checked and, yes, I have the same issue with git-gui.

-- 
Benoit Sigoure aka Tsuna
EPITA Research and Development Laboratory

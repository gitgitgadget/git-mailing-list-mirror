From: Guido Governatori <guido@itee.uq.edu.au>
Subject: git-svn fails
Date: Sat, 14 Jun 2008 15:50:07 +1000
Message-ID: <A869B7C3-4AC3-4592-A0F1-0349B64E07ED@itee.uq.edu.au>
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 14 09:09:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7Psj-0002pi-Nm
	for gcvg-git-2@gmane.org; Sat, 14 Jun 2008 09:09:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752187AbYFNHIF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jun 2008 03:08:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752155AbYFNHIF
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jun 2008 03:08:05 -0400
Received: from gum.itee.uq.edu.au ([130.102.66.1]:53245 "EHLO
	gum.itee.uq.edu.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752131AbYFNHIE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jun 2008 03:08:04 -0400
X-Greylist: delayed 4666 seconds by postgrey-1.27 at vger.kernel.org; Sat, 14 Jun 2008 03:08:03 EDT
Received: from filter2.itee.uq.edu.au (filter2.itee.uq.edu.au [130.102.79.22])
	by gum.itee.uq.edu.au (8.13.1/8.13.1) with ESMTP id m5E5oEYG013302
	for <git@vger.kernel.org>; Sat, 14 Jun 2008 15:50:14 +1000
Received: from [192.168.0.101] (ss0-79.itee.uq.edu.au [130.102.79.250])
	by filter2.itee.uq.edu.au (8.13.1/8.13.1) with ESMTP id m5E5o87h013450
	for <git@vger.kernel.org>; Sat, 14 Jun 2008 15:50:09 +1000
X-Mailer: Apple Mail (2.924)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84972>

I'm trying to convert an svn repository. But when I run

git svn clone --prefix=file://PATH --sdtlayout URL

the program exist with an error message like

r341 = eaa122678de1d79883f578f3f57b73e31f5d7a6d (file%3A//PATH/tags/ 
NAME)
fatal: refs/remotes/file%3A//PATH/tags/NAME: not a valid SHA1
update-ref refs/heads/master refs/remotes/file%3A//PATH/tags/NAME:  
command returned error: 128

What am I doing wrong?

The revision is the most recent revision on the svn repository.

I use Mac OS X10.5.3, git 1.5.5.4 (from the installer).

Thanks in advance for the helps

Guido

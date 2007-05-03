From: marc.zonzon@gmail.com
Subject: how to filter a pull
Date: Thu, 3 May 2007 15:17:05 +0200
Message-ID: <20070503131704.GA7036@kernoel.kernoel.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 03 15:17:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjbB4-000650-QL
	for gcvg-git@gmane.org; Thu, 03 May 2007 15:16:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161880AbXECNQp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 May 2007 09:16:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161922AbXECNQp
	(ORCPT <rfc822;git-outgoing>); Thu, 3 May 2007 09:16:45 -0400
Received: from postfix2-g20.free.fr ([212.27.60.43]:35784 "EHLO
	postfix2-g20.free.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161880AbXECNQo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 May 2007 09:16:44 -0400
Received: from smtp3-g19.free.fr (smtp3-g19.free.fr [212.27.42.29])
	by postfix2-g20.free.fr (Postfix) with ESMTP id 54EEFF9EAB6
	for <git@vger.kernel.org>; Thu,  3 May 2007 14:17:06 +0200 (CEST)
Received: from kernoel.kernoel.fr (unknown [81.56.187.30])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 007B65F856
	for <git@vger.kernel.org>; Thu,  3 May 2007 15:15:42 +0200 (CEST)
Received: by kernoel.kernoel.fr (Postfix, from userid 206)
	id 37AC818163; Thu,  3 May 2007 15:17:05 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46085>

I'm a git beginner (and an old user of cvs, and more recently of
subversion, and occasionally of arch)

I'm very pleased with the decentralized character of git and the ease
to manage branches. But I have a usual problem that I don't know how
to solve properly in git.

I have projects that draw some parts from two or three other
projects. But it is usually some small part, that are included, and
patched in my project. I want to follow the development of these fellow
projects.

My problem is that I can of course get a branch to host a copy of the
project (if the are under git I can clone and pull, if not I use the
native scm to import and commit in the branch). But now I cannot merge
in my development branch as I include only a small part. 

I found no way to register that I copy these part. The only one I can think of,
is to have a script to extract a sub branch  with only the appropriate
part and then pull from it (or push to my project). 
i.e. I pull from the project (if git) or update in cvs, or ..., then I
filter to extract the appropiate part, then push to my development branch.

But I suppose there are a lot of cleaner way to do it. And moreover
I'm quite sure that developers have met the same problem, and have solved it.

Sorry to ask such  a stupid question but 
(1) git naming itself stupid content tracker encourage dumb people
like me to ask stupid questions .
(2) I tried to RTFM, but could not find the appropriate page.

Thank you for any hint.

From: <4jxDQ6FQee2H@dyweni.com>
Subject: Git - Pushing to a production website
Date: Fri, 9 Jan 2009 22:23:44 -0600
Message-ID: <20090109222344.3539138a@family.dyweni.com>
Reply-To: 4jxDQ6FQee2H@dyweni.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 10 05:25:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLVPL-0003LU-P3
	for gcvg-git-2@gmane.org; Sat, 10 Jan 2009 05:25:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751796AbZAJEXt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jan 2009 23:23:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751770AbZAJEXs
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jan 2009 23:23:48 -0500
Received: from pl1.haspere.com ([208.111.35.220]:45053 "EHLO pl1.haspere.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751664AbZAJEXr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jan 2009 23:23:47 -0500
Received: from family.dyweni.com (173-23-155-27.client.mchsi.com [173.23.155.27])
	by pl1.haspere.com (Postfix) with ESMTPSA id CB0AAC800E;
	Fri,  9 Jan 2009 22:23:46 -0600 (CST)
X-Mailer: Claws Mail 3.4.0 (GTK+ 2.12.11; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105072>

Hi,

Our company's website is stored in a GIT Repository.

The repository is coded for our test server.  When we push updates to
the production server, have manually run a script to patch several
files to make the code work on the production server (i.e. port
numbers, etc).

I'd like to write a script to email me whenever someone changes files
on the production server without checking those changes back into git
(i.e. running 'git status | grep "nothing to commit" ...').

However, this approach get confused by the files patched to work
correctly.

Is there any way to 'save' those patched files so they don't get
reported by 'git status', yet not mung up the git history every time
we push out an update?

Thanks!

From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Beginner problem with .gitignore
Date: Tue, 21 Apr 2009 10:51:32 +0200
Message-ID: <49ED8914.9090808@drmicha.warpmail.net>
References: <gsid27$p1$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Kai Schlamp <schlamp@gmx.de>
X-From: git-owner@vger.kernel.org Tue Apr 21 10:53:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwBjJ-00028g-9o
	for gcvg-git-2@gmane.org; Tue, 21 Apr 2009 10:53:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755017AbZDUIvm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Apr 2009 04:51:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752266AbZDUIvm
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Apr 2009 04:51:42 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:40804 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751397AbZDUIvl (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Apr 2009 04:51:41 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 4932131DC0F;
	Tue, 21 Apr 2009 04:51:40 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Tue, 21 Apr 2009 04:51:40 -0400
X-Sasl-enc: nsmn6UeZFuqa4b9AVokIvYEqg1qxSF8rTsWqjUVrzZRL 1240303899
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id A885148D6C;
	Tue, 21 Apr 2009 04:51:39 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b4pre) Gecko/20090420 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <gsid27$p1$1@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117106>

Kai Schlamp venit, vidit, dixit 20.04.2009 19:57:
> Hello.
> 
> I have a file called TitleAreaDialog.java in the folder
> my_path\org.eclipse.jface\src\org\eclipse\jface\dialogs
> 
> .git and .gitignore is in the my_path\ folder (using Git Cygwin on Windows).
> 
> Now I everything is ignored from org.eclipse.jface, but not that 
> TitleAreaDialog.java
> 
> So I specified the following in .gitignore:
> /org.eclipse.*
> !TitleAreaDialog.java
> 
> I also tried it with:
> !Title*, 
> !/org.eclipse.jface/src/org/eclipse/jface/dialogs/TitleAreaDialog.java
> 
> but the TitleAreaDialog is always ignored as well.

By "is ignored", do you mean that git status doesn't show it? git status
does not recurse into subdirectories by default unless there is at least
one tracked file inside.

> 
> What do I have to do to not ignore this file specifically?

Have you ever added that file?

If you only want to track a few files it's easiest to ignore everything
and git add those files. Once added they will be tracked no matter what
the ignore patterns say.

Michael

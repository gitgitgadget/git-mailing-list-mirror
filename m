From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Fixing author/email fields in commit messages
Date: Sun, 19 Feb 2006 20:27:15 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0602192025170.11855@wbgn013.biozentrum.uni-wuerzburg.de>
References: <43F8BCB1.2010701@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 19 20:27:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FAuDH-00047M-Fg
	for gcvg-git@gmane.org; Sun, 19 Feb 2006 20:27:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932237AbWBST1Q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Feb 2006 14:27:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932239AbWBST1Q
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Feb 2006 14:27:16 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:61841 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932237AbWBST1Q (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Feb 2006 14:27:16 -0500
Received: from virusscan.mail (amavis2.rz.uni-wuerzburg.de [132.187.3.47])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 579591468BF; Sun, 19 Feb 2006 20:27:15 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 498912262;
	Sun, 19 Feb 2006 20:27:15 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 1DB6C1468BF; Sun, 19 Feb 2006 20:27:15 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Jacob Kroon <jacob.kroon@gmail.com>
In-Reply-To: <43F8BCB1.2010701@gmail.com>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16445>

Hi,

On Sun, 19 Feb 2006, Jacob Kroon wrote:

> When I started my git repository for my project, I never setup 
> GIT_AUTHOR_NAME etc. correctly, so my commit messages used the default 
> information, "<jacob@skeletor.(none)>", "skeletor" being the hostname of 
> the computer I'm working on. I'd like to change it so that the messages 
> will contain correct information about my e-mail and username. I noticed 
> that this question has been brought up here before and that the solution 
> might be to use git-convert-objects, but that it might need some 
> modifications.
> 
> Has anyone come up with a working tool for this task ?

Unfortunately not.

However, I'd rather start by enhancing git-rebase. You do not really need 
to rewrite *all* objects, but only the *commit objects*. Two things seem 
to be lacking for what you want:

	- an option to rebase "onto an empty commit", and
	- an optional filter command to run on the commit messages.

Hth,
Dscho

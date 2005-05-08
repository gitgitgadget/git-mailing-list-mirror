From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Commit template
Date: Sun, 08 May 2005 21:30:30 +0200
Message-ID: <1115580630.8949.27.camel@pegasus>
References: <1965.10.10.10.24.1115579256.squirrel@linux1>
	 <1115579764.8949.15.camel@pegasus>
	 <2003.10.10.10.24.1115580031.squirrel@linux1>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@ucw.cz>, GIT Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 08 21:28:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUrRT-0002bB-Qf
	for gcvg-git@gmane.org; Sun, 08 May 2005 21:27:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262883AbVEHTdj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 May 2005 15:33:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262971AbVEHTcV
	(ORCPT <rfc822;git-outgoing>); Sun, 8 May 2005 15:32:21 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:64941 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S262967AbVEHTaI
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 8 May 2005 15:30:08 -0400
Received: from pegasus (p5487D02F.dip.t-dialin.net [84.135.208.47])
	by mail.holtmann.net (8.12.3/8.12.3/Debian-7.1) with ESMTP id j48JVOWX004995
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO);
	Sun, 8 May 2005 21:31:25 +0200
To: Sean <seanlkml@sympatico.ca>
In-Reply-To: <2003.10.10.10.24.1115580031.squirrel@linux1>
X-Mailer: Evolution 2.2.2 
X-Virus-Scanned: ClamAV version 0.83, clamav-milter version 0.83 on coyote.holtmann.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi Sean,

> >> This adds the ability to have a per repository commit template.  Create
> >> a
> >> .git/commit.form file containg  "CG: " and other lines and it will be
> >> used
> >> in place of the regular top 3 lines.  This is kind of handy so that you
> >> can include your signed-off-by: with your email etc.
> >
> > I think it is a bad idea to take the CG: into it. Let them be created by
> > the cg-commit script, because it knows what to do.
> >
> > The question now is when we should provide that form. For me it only
> > makes sense if it is not a merge and if no commit message is provided
> > via command line.
>
> Yeah, it was just a quick hack.  You're not forced to put any CG: lines in
> the commit template of course, but it will handle it if you do.   Even
> with the patch, cg-commit will add addtional CG: lines containing a list
> of modified files etc..

if you don't put any CG: lines in the commit template you screw up the
look of the modified files list. So I propose to leave all the CG: lines
additions as they are in cg-commit and only add the template in front of
it.

Regards

Marcel



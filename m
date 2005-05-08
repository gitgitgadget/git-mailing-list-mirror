From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Commit template
Date: Sun, 08 May 2005 22:03:21 +0200
Message-ID: <1115582601.8949.31.camel@pegasus>
References: <1965.10.10.10.24.1115579256.squirrel@linux1>
	 <1115579764.8949.15.camel@pegasus>
	 <2003.10.10.10.24.1115580031.squirrel@linux1>
	 <1115580630.8949.27.camel@pegasus>
	 <2095.10.10.10.24.1115582244.squirrel@linux1>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@ucw.cz>, GIT Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 08 22:00:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUrvn-0007IM-B6
	for gcvg-git@gmane.org; Sun, 08 May 2005 21:59:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262761AbVEHUFY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 May 2005 16:05:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262779AbVEHUFO
	(ORCPT <rfc822;git-outgoing>); Sun, 8 May 2005 16:05:14 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:174 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S262761AbVEHUDA
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 8 May 2005 16:03:00 -0400
Received: from pegasus (p5487D02F.dip.t-dialin.net [84.135.208.47])
	by mail.holtmann.net (8.12.3/8.12.3/Debian-7.1) with ESMTP id j48K4GWX005225
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO);
	Sun, 8 May 2005 22:04:17 +0200
To: Sean <seanlkml@sympatico.ca>
In-Reply-To: <2095.10.10.10.24.1115582244.squirrel@linux1>
X-Mailer: Evolution 2.2.2 
X-Virus-Scanned: ClamAV version 0.83, clamav-milter version 0.83 on coyote.holtmann.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi Sean,

> > if you don't put any CG: lines in the commit template you screw up the
> > look of the modified files list. So I propose to leave all the CG: lines
> > additions as they are in cg-commit and only add the template in front of
> > it.
> 
> Yes, but you're free to make it look however you like.  Here's a sample:
> 
> CG: -[DO NOT COMMIT!]-------------------------------------------
> CG:
> CG: Hey! You don't want to commit here, use a cloned repository!
> CG:
> 
> 
> and another:
> 
> CG: -[USB CHANGES REPO!]----------------------------------------
> CG:
> CG: Commit only USB changes here!
> CG:
> 
> Signed-off-by: Sean Estabrooks <seanlkml@sympatico.ca>
> CG:
> CG:
> 
> The trailing CG: lines ensure that those added by cg-commit look okay.
> It's not perfect, but it's a nice feature.

my argument is; not to mess up with the CG: lines created by cg-commit.
If you wanna insert a warning then you can of course add additional CG:
lines to the commit template.

Regards

Marcel



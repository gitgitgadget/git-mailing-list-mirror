From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-commit: allow From: line to be entered in commit message
Date: Fri, 13 Jan 2006 22:47:44 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0601132247080.32562@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060112093700.1d3d25db.seanlkml@sympatico.ca>
 <20060112190031.GH14196@ca-server1.us.oracle.com> <7vhd89mc0y.fsf@assigned-by-dhcp.cox.net>
 <20060113065855.GJ14196@ca-server1.us.oracle.com> <7vpsmwbo9s.fsf@assigned-by-dhcp.cox.net>
 <20060113191231.GM14196@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 13 22:47:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ExWlz-0003ob-Vy
	for gcvg-git@gmane.org; Fri, 13 Jan 2006 22:47:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161568AbWAMVrs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Jan 2006 16:47:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161572AbWAMVrs
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jan 2006 16:47:48 -0500
Received: from wrzx35.rz.uni-wuerzburg.de ([132.187.3.35]:40869 "EHLO
	wrzx35.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1161568AbWAMVrr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jan 2006 16:47:47 -0500
Received: from amavis.mail (amavis1.rz.uni-wuerzburg.de [132.187.3.46])
	by wrzx35.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id CAFE5E57E0; Fri, 13 Jan 2006 22:47:44 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by amavis.mail (Postfix) with ESMTP id BC1449AB;
	Fri, 13 Jan 2006 22:47:44 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by amavis.mail (Postfix) with ESMTP id 9F9F39C;
	Fri, 13 Jan 2006 22:47:44 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 7722814620F; Fri, 13 Jan 2006 22:47:44 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Joel Becker <Joel.Becker@oracle.com>
In-Reply-To: <20060113191231.GM14196@ca-server1.us.oracle.com>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
X-Spam-Status: No, hits=0.0 tagged_above=0.0 required=8.0 tests=
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14649>

Hi,

On Fri, 13 Jan 2006, Joel Becker wrote:

> On Thu, Jan 12, 2006 at 11:06:07PM -0800, Junio C Hamano wrote:
> > Joel Becker <Joel.Becker@oracle.com> writes:
> > 
> > > Well, I'm wary of putting
> > > GIT_AUTHOR_EMAIL=joel.becker@oracle.com as a permanent part of my
> > > environment, for fear of overriding some other authors at some point.
> > 
> > The weakest default comes from .git/config so you could have
> > this in your .git/config:
> > 
> > 	[user]
> >         	name = Joel Becker 
> >                 email = Joel.Becker@oracle.com
> 
> 	This configuration is something I have the opportunity to forget
> every time I call git-clone.  So I still need to leave it in the
> environment permanently.

Of course, you could put it in your templates and never forget.

Ciao,
Dscho

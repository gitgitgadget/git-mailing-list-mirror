From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: attempting to clone the git repo
Date: Fri, 9 Mar 2007 11:08:23 +0100
Message-ID: <20070309100823.GB28406@xp.machine.xx>
References: <2fb03ecb0703080849m41ac8158y4895f2bc811934f5@mail.gmail.com> <Pine.LNX.4.63.0703081828500.22628@wbgn013.biozentrum.uni-wuerzburg.de> <7v649ba89l.fsf@assigned-by-dhcp.cox.net> <2fb03ecb0703090151j10842263off743be1f86bf9c3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andrew Kilroy <lemonkandy@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 09 11:04:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPbxZ-0004d4-Mz
	for gcvg-git@gmane.org; Fri, 09 Mar 2007 11:04:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993095AbXCIKEV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Mar 2007 05:04:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767142AbXCIKEV
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Mar 2007 05:04:21 -0500
Received: from magnum.hofmann.stw.uni-erlangen.de ([131.188.23.34]:51302 "HELO
	mail.hofmann.stw.uni-erlangen.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with SMTP id S2993095AbXCIKEU (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Mar 2007 05:04:20 -0500
Received: (qmail 4686 invoked by uid 0); 9 Mar 2007 10:04:17 -0000
Received: from ho135.hofmann.stw.uni-erlangen.de (HELO localhost) (p.b@hofmann.stw.uni-erlangen.de@172.17.27.135)
  by mail.hofmann.stw.uni-erlangen.de with SMTP; 9 Mar 2007 10:04:17 -0000
Mail-Followup-To: Andrew Kilroy <lemonkandy@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <2fb03ecb0703090151j10842263off743be1f86bf9c3@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41792>

On Fri, Mar 09, 2007 at 09:51:14AM +0000, Andrew Kilroy wrote:
> On 08/03/07, Junio C Hamano <junkio@cox.net> wrote:
> >I've always thought that for http transfer the hostname was not
> >git.kernel.org but www.kernel.org, as in:
> >
> >        git clone http://www.kernel.org/pub/scm/git/git.git/
> >
> 
> That worked, thanks.
> 
> I thought there were more branches though (pu, todo...).  I can only
> see master via 'git branch'.  I'm not that familiar with git yet, so I
> might be missing something obvious here.
> 
> Andy

Use
	git branch -r   # shows the remote branches
or
	gitk --all 	# --all = show every branch

to see all the branches.

-Peter

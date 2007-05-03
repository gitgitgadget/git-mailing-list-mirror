From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: how to filter a pull
Date: Thu, 3 May 2007 17:07:52 +0200
Message-ID: <20070503150752.GB6500@xp.machine.xx>
References: <20070503131704.GA7036@kernoel.kernoel.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: marc.zonzon@gmail.com
X-From: git-owner@vger.kernel.org Thu May 03 17:08:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjcuX-0000xs-QU
	for gcvg-git@gmane.org; Thu, 03 May 2007 17:08:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946170AbXECPH6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 May 2007 11:07:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946178AbXECPH6
	(ORCPT <rfc822;git-outgoing>); Thu, 3 May 2007 11:07:58 -0400
Received: from magnum.hofmann.stw.uni-erlangen.de ([131.188.23.34]:55708 "HELO
	mail.hofmann.stw.uni-erlangen.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with SMTP id S1946170AbXECPH5 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 May 2007 11:07:57 -0400
Received: (qmail 23949 invoked by uid 0); 3 May 2007 15:07:54 -0000
Received: from p54aaa661.dip0.t-ipconnect.de (HELO localhost) (p.b@hofmann.stw.uni-erlangen.de@84.170.166.97)
  by mail.hofmann.stw.uni-erlangen.de with SMTP; 3 May 2007 15:07:54 -0000
Mail-Followup-To: marc.zonzon@gmail.com, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070503131704.GA7036@kernoel.kernoel.fr>
User-Agent: Mutt/1.5.14+cvs20070403 (2007-04-02)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46088>

On Thu, May 03, 2007 at 03:17:05PM +0200, marc.zonzon@gmail.com wrote:
> I'm a git beginner (and an old user of cvs, and more recently of
> subversion, and occasionally of arch)
> 
> I'm very pleased with the decentralized character of git and the ease
> to manage branches. But I have a usual problem that I don't know how
> to solve properly in git.
> 
> I have projects that draw some parts from two or three other
> projects. But it is usually some small part, that are included, and
> patched in my project. I want to follow the development of these fellow
> projects.
> 
> My problem is that I can of course get a branch to host a copy of the
> project (if the are under git I can clone and pull, if not I use the
> native scm to import and commit in the branch). But now I cannot merge
> in my development branch as I include only a small part. 
> 
> I found no way to register that I copy these part. The only one I can think of,
> is to have a script to extract a sub branch  with only the appropriate
> part and then pull from it (or push to my project). 
> i.e. I pull from the project (if git) or update in cvs, or ..., then I
> filter to extract the appropiate part, then push to my development branch.
> 
> But I suppose there are a lot of cleaner way to do it. And moreover
> I'm quite sure that developers have met the same problem, and have solved it.
> 
> Sorry to ask such  a stupid question but 
> (1) git naming itself stupid content tracker encourage dumb people
> like me to ask stupid questions .
> (2) I tried to RTFM, but could not find the appropriate page.
> 
> Thank you for any hint.

Perhaps the newly added merge strategy subtree [1] could work. Or the
just added subproject support, but this is very new and only the lowlevel machinery
is implemented right now.

-Peter

[1]: http://git.kernel.org/?p=git/git.git;a=commit;h=68faf68938ee943fc251c702f2027e4dfda354db

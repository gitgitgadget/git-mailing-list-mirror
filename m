From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: [RFH] how to know if a cherry-picked patch has been applied
	already?
Date: Fri, 11 Jan 2008 13:14:00 +0100
Message-ID: <20080111121400.GD21695@xp.machine.xx>
References: <20080111104737.GA7332@mageo.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Michal Vitecek <fuf@mageo.cz>
X-From: git-owner@vger.kernel.org Fri Jan 11 13:14:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDIlx-0005t4-I3
	for gcvg-git-2@gmane.org; Fri, 11 Jan 2008 13:14:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759459AbYAKMNe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 07:13:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759150AbYAKMNd
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 07:13:33 -0500
Received: from matlock.hofmann.stw.uni-erlangen.de ([131.188.24.35]:48942 "HELO
	mail.hofmann.stw.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1757195AbYAKMNd (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Jan 2008 07:13:33 -0500
Received: (qmail 3150 invoked by uid 0); 11 Jan 2008 12:13:30 -0000
Received: from ho135.hofmann.stw.uni-erlangen.de (HELO localhost) (p.b@hofmann.stw.uni-erlangen.de@172.17.27.135)
  by mail.hofmann.stw.uni-erlangen.de with SMTP; 11 Jan 2008 12:13:30 -0000
Content-Disposition: inline
In-Reply-To: <20080111104737.GA7332@mageo.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70152>

On Fri, Jan 11, 2008 at 11:47:37AM +0100, Michal Vitecek wrote:
>  Hello everyone,
> 
>  I'm managing a git repository where I include my and my co-workers'
>  work. With some co-workers I can use 'git merge' but with some I use
>  'git cherry-pick'. However, cherry-picking leads to problems because a
>  new commit ID is generated and I must remember which patches I have
>  cherry-picked to my tree. Is there any easy way to tell which patches
>  have and have not been applied?
> 
>     Thanks,
>             Michal

Have a look at the manpage of git-cherry, which will tell you if you
already applied a commit/patch.

-Peter

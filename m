From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: [StGit] How do I get colored diff output?
Date: Thu, 30 Aug 2007 15:59:09 +0200
Message-ID: <20070830135909.GH5050@xp.machine.xx>
References: <20070830123222.GG5050@xp.machine.xx> <tnx3ay1w40p.fsf@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 30 15:59:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQkYl-0001h1-SV
	for gcvg-git@gmane.org; Thu, 30 Aug 2007 15:59:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759467AbXH3N7o (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Aug 2007 09:59:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759085AbXH3N7o
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Aug 2007 09:59:44 -0400
Received: from matlock.hofmann.stw.uni-erlangen.de ([131.188.24.35]:36121 "HELO
	mail.hofmann.stw.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1757810AbXH3N7n (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Aug 2007 09:59:43 -0400
Received: (qmail 660 invoked by uid 0); 30 Aug 2007 13:59:41 -0000
Received: from ho135.hofmann.stw.uni-erlangen.de (HELO localhost) (p.b@hofmann.stw.uni-erlangen.de@172.17.27.135)
  by mail.hofmann.stw.uni-erlangen.de with SMTP; 30 Aug 2007 13:59:41 -0000
Mail-Followup-To: Catalin Marinas <catalin.marinas@gmail.com>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <tnx3ay1w40p.fsf@arm.com>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57043>

On Thu, Aug 30, 2007 at 02:22:46PM +0100, Catalin Marinas wrote:
> Peter Baumann <waste.manager@gmx.de> wrote:
> > Is there a way to get colored diff output, preferable from the native
> > git diff without having to specify stg diff -O --color everytime?
> > It seems that stg doesn't honor color.diff config entry, so I am a
> > little lost.
> >
> > (And yes I now that I could use the pager setting given in examples/gitconfig,
> >
> > 	stgit.pager = filterdiff --annotate | colordiff | less -FRX
> >
> >  but I really prefere the native git coloring, which looks a loot nicer
> >  and does also highlight traling whitespace)
> 
> There isn't any other way at the moment. There were ideas of adding
> support for default command line options for various commands but I
> haven't looked at this.
> 
> I now tried the example stgit.pager option and it looks bad indeed. In
> the meantime, there is a diffcol.sh script in the contrib directory, I
> use this instead and it looks much nicer.
> 

Ah. I didn't find that while searching for the color ouput.

Thx for your help,
Peter

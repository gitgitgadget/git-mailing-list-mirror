From: Johan Herland <johan@herland.net>
Subject: Re: way to automatically add untracked files?
Date: Mon, 06 Aug 2007 09:46:12 +0200
Message-ID: <200708060946.12793.johan@herland.net>
References: <873ayymzc1.fsf@catnip.gol.com>
 <buo1wehxssa.fsf@dhapc248.dev.necel.com>
 <Pine.LNX.4.64.0708060419230.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Miles Bader <miles.bader@necel.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 06 09:46:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHxIG-0000YK-8h
	for gcvg-git@gmane.org; Mon, 06 Aug 2007 09:46:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756817AbXHFHqW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Aug 2007 03:46:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753825AbXHFHqW
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Aug 2007 03:46:22 -0400
Received: from smtp.getmail.no ([84.208.20.33]:57312 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754387AbXHFHqU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2007 03:46:20 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JMC00M03DL7AJ00@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 06 Aug 2007 09:46:19 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JMC0042TDL5R180@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 06 Aug 2007 09:46:17 +0200 (CEST)
Received: from alpha.herland ([84.215.102.95])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JMC005GWDL4XHE0@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Mon, 06 Aug 2007 09:46:17 +0200 (CEST)
In-reply-to: <Pine.LNX.4.64.0708060419230.14781@racer.site>
Content-disposition: inline
User-Agent: KMail/1.9.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55120>

On Monday 06 August 2007, Johannes Schindelin wrote:
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > >> But I'm wondering whether we'd want to include it in git by default 
> > >> (instead of having to tell confused users to add the alias).
> > >
> > > I recommend against that, too.  All too often, I have some temporary files 
> > > in the working tree, and I'll be dimmed if I'm the only one.  So 
> > > "addremove" adds too much possibility for pilot errors.
> > 
> > "Recommend against it"?  Why?
> 
> Didn't I say that? It just _asks_ for pilot errors.

Ok, in that spirit I also suggest removing _all_ git plumbing-level commands
from the default installation. I also suggest adding confirmation dialog to
any command that alters the repo, since we have to protect the user against
"pilot errors".

Get real. Adding a separate command (provided it's well implemented and
documented) does not push the user off a cliff. Just because the command
doesn't fit your workflow doesn't mean it's dangerous and should never be
included. Just don't use it.

If git were only to support the (probably non-existing) intersection of its
user's workflows, we would probably have to pull e.g. git-rebase out of the
tree, because (according to some) rewriting history is evil, and extremely
prone to "pilot errors".

> > It's a separate command, so if it doesn't fit your working style, don't
> > use it.
> 
> Hah!  If that were true, we'd have a lot less mails like "I tried this and 
> it did not work", only to find out that the person assumed that 
> documentation is for wimps, and tried a command that "sounded" like it 
> would do the right thing.

Having commands that "sound" like they do the right thing is not a bad idea
at all. We should have more of those.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net

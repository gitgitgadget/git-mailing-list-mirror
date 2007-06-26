From: Steven Grimm <koreth@midwinter.com>
Subject: Re: git for subversion users
Date: Mon, 25 Jun 2007 22:25:21 -0700
Message-ID: <4680A341.5000208@midwinter.com>
References: <e2a1d0aa0706251248j1b8da150xbe19826bec15eed6@mail.gmail.com> <46809733.2060200@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Sam Vilain <sam@vilain.net>, git@vger.kernel.org
To: Patrick Doyle <wpdster@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 26 07:25:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I33YF-0008HB-5G
	for gcvg-git@gmane.org; Tue, 26 Jun 2007 07:25:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753978AbXFZFZF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Jun 2007 01:25:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752863AbXFZFZF
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jun 2007 01:25:05 -0400
Received: from 91.86.32.216.static.reverse.layeredtech.com ([216.32.86.91]:43763
	"HELO midwinter.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with SMTP id S1753962AbXFZFZD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jun 2007 01:25:03 -0400
Received: (qmail 15637 invoked from network); 26 Jun 2007 05:25:01 -0000
Received: from c-76-21-17-123.hsd1.ca.comcast.net (HELO pinklady.local) (koreth@76.21.17.123)
  by tater.midwinter.com with SMTP; 26 Jun 2007 05:25:01 -0000
User-Agent: Thunderbird 2.0.0.4 (Macintosh/20070604)
In-Reply-To: <46809733.2060200@vilain.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50948>

Sam Vilain wrote:
> If svn is still the master there should be no difference to the way you
> normally collaborate development using Subversion.  The central server
> is still the publishing point for trunk, however many release
> engineering branches you use, and feature branches.  It's only if you
> want to start mixing groups of people, some working with subversion, and
> other people using git-svn and merging between each other at the git
> level, that you can start getting confused.  They can safely operate at
> the patch trading level though.
>   

I can vouch for all of that as well. On some of my repositories I use 
git solely as a fancy Subversion client, no interaction with any other 
git repositories. And hardly anyone at my company even knows about it; 
as far as they are concerned I just check stuff into the svn repository 
like any other engineer.

But on a few of my repositories I do things like use git to keep a copy 
of my work in progress synced up between my laptop and my development 
server, or (rarely) share my work with another git-aware developer. In 
those cases I do have to be kind of careful what I do, mostly around 
making sure all the repositories are in agreement about which branches 
come from where and about when I use rebase vs. merge vs. squash merge.

I will say, though, that the upcoming addition to git-svn to allow 
merges to be directly committed to the svn repository will make some of 
those kinds of scenarios a lot less brittle than they are now. It's 
still a work in progress but it looks very promising so far. (Search the 
list for "[PATCH] git-svn: allow dcommit to retain local merge 
information" if you want to see what I'm talking about.)

-Steve

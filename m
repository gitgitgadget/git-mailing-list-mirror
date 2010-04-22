From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: Please default to 'commit -a' when no changes were added
Date: Thu, 22 Apr 2010 15:03:07 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1004221445310.7232@xanadu.home>
References: <20100422151037.2310.2429.reportbug@frosties.localdomain>
 <20100422155806.GC4801@progeny.tock> <87wrvzs590.fsf@frosties.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jonathan Nieder <jrnieder@gmail.com>, 578764@bugs.debian.org,
	git@vger.kernel.org
To: Goswin von Brederlow <goswin-v-b@web.de>
X-From: git-owner@vger.kernel.org Thu Apr 22 21:03:18 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O51gC-0007oS-RY
	for gcvg-git-2@lo.gmane.org; Thu, 22 Apr 2010 21:03:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755272Ab0DVTDJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Apr 2010 15:03:09 -0400
Received: from relais.videotron.ca ([24.201.245.36]:22747 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753585Ab0DVTDI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Apr 2010 15:03:08 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0L1A0071XKX7JH21@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 22 Apr 2010 15:03:07 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <87wrvzs590.fsf@frosties.localdomain>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145548>

On Thu, 22 Apr 2010, Goswin von Brederlow wrote:

> I have never ever needed anything but
> 
> git commit -a
> git commit <file> <file> ...

When I was using CVS/SVN that's what I thought too.

> I do commit often and commit early and I start and finish one thing
> before I start another. Also I keep my files small so they do one thing
> and do it well. Overall that means I don't end up with multiple changes
> in a single file so I never need to cherry pick changes for a commit.

Good for you.  I'm not that disciplined. Hence I often end up working on 
more than one thing in parallel.  The index is just so incredibly useful 
in that case.  I'm also a big fan of 'git add -e'.

> So I don't think people should be forced to utilize the index. Imho that
> is a matter of the workflow people use. Some people work better with the
> index and some people (or projects) don't need it.

Exact.  It is therefore not progress to impose some inconvenience to one 
work flow in order to make another one easier.  And in this case we're 
talking about the difference between having to type an additional -a vs 
the risk of creating a commit with unexpected content.

> Alternatively an option to take all changes but only if the index is
> empty would be helpfull. Then people could define an alias for that or
> set the option in the config. Other than setting -a that would allow
> using an index when needed and commit everything in the normal case
> without having to change the command used to commit.

But you're proposing to change the semantics for that command.  And I 
also suspect that you're trying to make the index more hidden while what 
we're actually trying to do is to promote it.

What _you_ can do though, is this:

	git config --global alias.ci "commit -a"


Nicolas

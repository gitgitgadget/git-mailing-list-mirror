From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [PATCH 2/3] rebase-i: slight internal improvements
Date: Fri, 20 Jun 2008 20:45:03 +0200
Message-ID: <20080620184503.GD7369@leksak.fem-net>
References: <1213929935-15093-1-git-send-email-s-beyer@gmx.net> <1213929935-15093-2-git-send-email-s-beyer@gmx.net> <1213929935-15093-3-git-send-email-s-beyer@gmx.net> <485B595B.80608@viscovery.net> <20080620080153.GC7369@leksak.fem-net> <alpine.DEB.1.00.0806201344180.6439@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jun 20 20:46:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9lcf-0000xp-IA
	for gcvg-git-2@gmane.org; Fri, 20 Jun 2008 20:46:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751386AbYFTSpN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2008 14:45:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751341AbYFTSpN
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jun 2008 14:45:13 -0400
Received: from mail.gmx.net ([213.165.64.20]:48973 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751145AbYFTSpL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2008 14:45:11 -0400
Received: (qmail invoked by alias); 20 Jun 2008 18:45:10 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp059) with SMTP; 20 Jun 2008 20:45:10 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX18ITxZFjRIIx3G0rsHAjQDTuWEHx9w3eKqqA9okhq
	5cnkX7NdXOHDgz
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1K9lbb-0005C9-4c; Fri, 20 Jun 2008 20:45:03 +0200
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0806201344180.6439@racer>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85671>

On Fri, Jun 20, 2008 at 01:46:29PM +0100, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote to Cc git@vger.kernel.org:
> Hi,
> 
> On Fri, 20 Jun 2008, Stephan Beyer wrote:
> 
> > Looks like *portable* shell programming is no fun :\
> 
> That is right.  That's one of the reasons why I prefer moving scripts to 
> builtins: prototyping is good and well, but when you need to put it into 
> production, where people have all kinds of weird setups 

Right.

> (just think of dash in Ubuntu!)

Well, I'm using dash as /bin/sh in Debian.
What's so weird about it?  IIRC it allows POSIX + some Berkeley extensions
and so it is far less weird as the least common demoninator of shell
portability ;-)

Hmm,
For shell portability it'd be cool to have something like a "badsh" (bad
shell) with the whole XCU Utilities as builtins without features and
warnings if features want to be used that are not supported by at least
95% of the systems.  So that scripts could be checked using badsh and
then you know, that it is portable.
I guess nobody ever wrote something like that. ;-)

> Better to use something portable, such as C.

Right.

> So would you not agree that PATCH 2/3 is rather unnecessary?

We wanted to make some upfront patches to am/rebase-i, so that, when the
git-sequencer prototype swoops in, it's easier to see, what is
taken from am and what is taken from rebase-i.
But this seems to be not so easy, so I'm currently thinking that I skip
that and concentrate on the builtin.

Regards,
  Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F

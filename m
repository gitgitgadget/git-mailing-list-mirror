From: Theodore Tso <tytso@mit.edu>
Subject: Re: best git practices, was Re: Git User's Survey 2007 unfinished
	summary continued
Date: Thu, 25 Oct 2007 11:21:59 -0400
Message-ID: <20071025152159.GB22103@thunk.org>
References: <20071024212854.GB6069@xp.machine.xx> <05B279A2-98A3-45F1-9661-AB361F7CAA37@zib.de> <Pine.LNX.4.64.0710242258201.25221@racer.site> <008A7EF9-6F58-47AE-9AA0-B466797F6B1D@zib.de> <Pine.LNX.4.64.0710250021430.25221@racer.site> <47204297.5050109@op5.se> <Pine.LNX.4.64.0710251112390.25221@racer.site> <472070E5.4090303@op5.se> <20071025132401.GA22103@thunk.org> <4720AF05.3050308@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Steffen Prohaska <prohaska@zib.de>,
	Peter Baumann <waste.manager@gmx.de>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Federico Mena Quintero <federico@novell.com>,
	git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Thu Oct 25 17:23:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Il4YA-0004eu-Gk
	for gcvg-git-2@gmane.org; Thu, 25 Oct 2007 17:23:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761497AbXJYPW3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2007 11:22:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762177AbXJYPW3
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Oct 2007 11:22:29 -0400
Received: from thunk.org ([69.25.196.29]:54793 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754712AbXJYPW2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2007 11:22:28 -0400
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1Il4hJ-0005dS-Tc; Thu, 25 Oct 2007 11:32:38 -0400
Received: from tytso by closure.thunk.org with local (Exim 4.67)
	(envelope-from <tytso@thunk.org>)
	id 1Il4X2-0007cu-5J; Thu, 25 Oct 2007 11:22:00 -0400
Content-Disposition: inline
In-Reply-To: <4720AF05.3050308@op5.se>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62325>

On Thu, Oct 25, 2007 at 04:58:13PM +0200, Andreas Ericsson wrote:
>
> Correct. I'm working on optimizing it right now though :)

We await your patches.  :-)

>> Another would be to set up a wrapper script for "git-clone" that
>> creates a separate local working directory for each branch.  So for
>> example, it might do something like this:
>>
>> #!/bin/sh
>> # Usage: get-repo <URL> [dir]
>> ...

> Not really, I'm afraid. Apart from missing out on the auto-download of
> new repos you get with "fetch = refs/heads/*:refs/remotes/origin/*",
> it seems inelegant.

You mean new branches, right?

And of course it's inelegant.  You just told us we were dealing with
CVS-brain-damaged corporate developers who can't be bothered to learn
about the fine points of using things the git way.  And I thought you
said there were only a few branches, "master", maint", etc. and all
the developers worked on were the tips of the branches of the
corporate mothership repository.  

It's like complaining that a car with manual transmission is too hard
to drive, and then when someone points out how this could be done with
an automatic transmission, and then complaining that that you don't
have the fine control of a manual transmission.  Well, of course you
don't!  Having that fine control requires that you *learn* how to use
that fine control correctly.

The solution I presented is more elegant than what hg does with
separate repositories, but sure, it does require disk space.  But this
disk space is cheap, even when compared with the salary costs of
CVS-damanged developers.  :-)

						- Ted

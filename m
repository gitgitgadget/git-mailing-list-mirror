From: Martin Pool <mbp@sourcefrog.net>
Subject: Re: VCS comparison table
Date: Thu, 19 Oct 2006 15:56:35 +1000
Message-ID: <20061019055626.GK18052@sourcefrog.net>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <Pine.LNX.4.64.0610171605440.3962@g5.osdl.org> <45357411.20500@utoronto.ca> <200610180246.18758.jnareb@gmail.com> <45357CC3.4040507@utoronto.ca> <Pine.LNX.4.64.0610172014250.3962@g5.osdl.org> <4536EC93.9050305@utoronto.ca> <87lkncev90.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Aaron Bentley <aaron.bentley@utoronto.ca>,
	Linus Torvalds <torvalds@osdl.org>,
	Andreas Ericsson <ae@op5.se>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 19 07:56:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaQtd-00021H-Jj
	for gcvg-git@gmane.org; Thu, 19 Oct 2006 07:56:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161115AbWJSF4q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Oct 2006 01:56:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161175AbWJSF4q
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Oct 2006 01:56:46 -0400
Received: from ozlabs.org ([203.10.76.45]:10120 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1161115AbWJSF4p (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Oct 2006 01:56:45 -0400
Received: from hope.sourcefrog.net (ppp112-44.static.internode.on.net [150.101.112.44])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7821867B99;
	Thu, 19 Oct 2006 15:56:41 +1000 (EST)
Received: by hope.sourcefrog.net (Postfix, from userid 1000)
	id 7A4225C6B6; Thu, 19 Oct 2006 15:56:35 +1000 (EST)
To: Carl Worth <cworth@cworth.org>
Mail-Followup-To: Carl Worth <cworth@cworth.org>,
	Aaron Bentley <aaron.bentley@utoronto.ca>,
	Linus Torvalds <torvalds@osdl.org>, Andreas Ericsson <ae@op5.se>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <87lkncev90.wl%cworth@cworth.org>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29325>

On 18 Oct 2006, Carl Worth <cworth@cworth.org> wrote:

> I understand that bzr also has unique identifiers, but it sounds like
> the tools try to hide them, and people aren't in the habit of using
> them for things like this. Do bzr developers put revision numbers in
> their bug trackers? Is there a guarantee they will always be valid?

There is a mix of 

 - Just giving the overall tarball version number, which is most 
   meaningful to users (and not related to bzr versions)

 - Giving a mainline revision number, which will never revert because we
   never pull (fast-forward) that branch.  That has the substantial
   (imo) benefit that you can immediately compare these numbers by eye,
   and they are easy to quote.

 - Giving a unique id, which is obviously most definitive and
   appropriate if you're talking about something which is not 
   on the mainline or a well known branch.  The launchpad.net 
   bug tracker links branches to bugs and does this through 
   revision ids.

-- 
Martin

From: Edgar Toernig <froese@gmx.de>
Subject: Re: git and time
Date: Wed, 27 Sep 2006 20:00:54 +0200
Message-ID: <20060927200054.7a49b619.froese@gmx.de>
References: <20060927140918.65775.qmail@web51004.mail.yahoo.com>
	<Pine.LNX.4.64.0609270919220.3952@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 27 20:01:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSdit-0007nJ-NU
	for gcvg-git@gmane.org; Wed, 27 Sep 2006 20:01:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030515AbWI0SBF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Sep 2006 14:01:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030514AbWI0SBE
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Sep 2006 14:01:04 -0400
Received: from mail.gmx.net ([213.165.64.20]:17894 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030515AbWI0SBB (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Sep 2006 14:01:01 -0400
Received: (qmail invoked by alias); 27 Sep 2006 18:00:59 -0000
Received: from p50904393.dip0.t-ipconnect.de (EHLO dialup) [80.144.67.147]
  by mail.gmx.net (mp003) with SMTP; 27 Sep 2006 20:00:59 +0200
X-Authenticated: #271361
To: Matthew L Foster <mfoster167@yahoo.com>
In-Reply-To: <Pine.LNX.4.64.0609270919220.3952@g5.osdl.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27916>

Linus Torvalds wrote:
>
> On Wed, 27 Sep 2006, Matthew L Foster wrote:
> > 
> > Perhaps git should record three(+) timestamps, adding when the change was committed into this
> > repository?
> 
> What you CAN do is to connect (in any particular private repository) a 
> _branch_update_ with the time it was done. That is Shawn Pierces "reflog" 
> work - you can track a particular branch _locally_. It's purely local to 
> that _one_ repository, though. It by definition makes no sense anywhere 
> else, and it's not tracking commits, it's literally tracking how branches 
> changed in a local copy.

Well, I would simply look at the filesystem's mtime of the commit object
resp. the pack containing the commit.  IMHO good enough most of the time.

Ciao, ET.

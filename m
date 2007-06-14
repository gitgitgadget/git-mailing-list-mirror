From: Raimund Bauer <ray007@gmx.net>
Subject: Re: pull into dirty working tree
Date: Thu, 14 Jun 2007 10:01:54 +0200
Message-ID: <1181808114.6118.7.camel@localhost>
References: <18031.64456.948230.375333@lisa.zopyra.com>
	 <alpine.LFD.0.98.0706132216300.14121@woody.linux-foundation.org>
	 <7vps3zascu.fsf@assigned-by-dhcp.pobox.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Bill Lear <rael@zopyra.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 14 10:02:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HykHJ-0005wn-Tp
	for gcvg-git@gmane.org; Thu, 14 Jun 2007 10:02:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751028AbXFNICA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jun 2007 04:02:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751618AbXFNIB7
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jun 2007 04:01:59 -0400
Received: from mail.gmx.net ([213.165.64.20]:51795 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751018AbXFNIB7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jun 2007 04:01:59 -0400
Received: (qmail invoked by alias); 14 Jun 2007 08:01:55 -0000
Received: from p5498A0D5.dip0.t-ipconnect.de (EHLO [192.168.178.21]) [84.152.160.213]
  by mail.gmx.net (mp020) with SMTP; 14 Jun 2007 10:01:55 +0200
X-Authenticated: #20693823
X-Provags-ID: V01U2FsdGVkX18nradfroAnAapQNBuDXPwP484R4GWid+NDn3fGN2
	FAnxUyremlmnCo
In-Reply-To: <7vps3zascu.fsf@assigned-by-dhcp.pobox.com>
X-Mailer: Evolution 2.10.1 
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50177>

On Thu, 2007-06-14 at 00:49 -0700, Junio C Hamano wrote:
> Linus Torvalds <torvalds@linux-foundation.org> writes:
> 
> > It might make it a bit easier for CVS people to get used to the git model: 
> > keep your dirty working tree, and do "git pull" to update it, and fix up 
> > any conflicts in the working tree. That's how CVS works - it's a bad 
> > model, but it's a model that may be worth supporting just to get people 
> > more easily into the _good_ model.
> 
> If a bad model _is_ supported, what incentive is there for these
> people to move into the good model, I honestly wonder...

Is it a bad model for the normal development process? Probably.

Would it solve the problem of "I want to keep my debug-statements that I
won't ever commit in the merged result"? ... yes

I think that's at least one valid usecase we should probably support.
One I'd also like to use ;-)

-- 
best regards

  Ray

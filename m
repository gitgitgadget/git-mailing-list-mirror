From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Re: Teach mailinfo to ignore everything before -- >8 --
 mark
Date: Thu, 27 Aug 2009 12:49:44 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908271249220.7562@intel-tinevez-2-302>
References: <7v3a7g501e.fsf@alter.siamese.dyndns.org> <fc2ecb5cf28cabb7d183e2835ce46aa9afb2a322.1251215299.git.nicolas.s.dev@gmx.fr> <7vvdkbl4ul.fsf@alter.siamese.dyndns.org> <7veiqzjmy7.fsf@alter.siamese.dyndns.org> <20090826050224.GK3526@vidovic>
 <h72td7$cu6$1@ger.gmane.org> <alpine.DEB.1.00.0908261059530.4713@intel-tinevez-2-302> <7vprahyfk4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 27 12:49:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgcYE-0007Ad-J6
	for gcvg-git-2@lo.gmane.org; Thu, 27 Aug 2009 12:49:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751046AbZH0Ktp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2009 06:49:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751026AbZH0Ktp
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Aug 2009 06:49:45 -0400
Received: from mail.gmx.net ([213.165.64.20]:35737 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750994AbZH0Ktp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Aug 2009 06:49:45 -0400
Received: (qmail invoked by alias); 27 Aug 2009 10:49:45 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp037) with SMTP; 27 Aug 2009 12:49:45 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+Ce0UT/AWCiyapc+A88cs2dm3Hndq2ldR+T2I1wZ
	bDKOHsXUWuAwLb
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <7vprahyfk4.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127155>

Hi,

On Wed, 26 Aug 2009, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> mailsplit.scissors
> >
> > Sorry, did not have time to read this thread properly, but has anybody put 
> > thought into the interaction between this patch and "git rebase" (which 
> > uses "git am", and therefore mailsplit, internally)?
> 
> I was looking around this area tonight (I promised I won't touch the
> definition of scissors, but I never said I won't work on making it
> usable), as I originally shared the same worry with you.
> 
> It turns out that "rebase" invokes "am" with the "--rebasing" option.
> Under this option, "am" uses an equivalent of "commit -C $commit"
> internally to port the message forward.  So our worries are unfounded.

Thank you very much!  This relieves me, indeed.

Ciao,
Dscho

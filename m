From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-filter-branch could be confused by similar names
Date: Sat, 5 Jan 2008 16:03:55 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801051601490.10101@racer.site>
References: <Pine.LNX.4.64.0712301700580.14355@wbgn129.biozentrum.uni-wuerzburg.de> <1199040667-31850-1-git-send-email-dpotapov@gmail.com> <7v7iiqppkw.fsf@gitster.siamese.dyndns.org> <20080104155114.GS3373@dpotapov.dyndns.org>
 <7vr6gxjpyn.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Dmitry Potapov <dpotapov@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 05 17:04:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBBVf-00073P-7L
	for gcvg-git-2@gmane.org; Sat, 05 Jan 2008 17:04:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755369AbYAEQEA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2008 11:04:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755356AbYAEQEA
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jan 2008 11:04:00 -0500
Received: from mail.gmx.net ([213.165.64.20]:51275 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755324AbYAEQD7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2008 11:03:59 -0500
Received: (qmail invoked by alias); 05 Jan 2008 16:03:57 -0000
Received: from dslb-088-067-194-153.pools.arcor-ip.net (EHLO dslb-088-067-194-153.pools.arcor-ip.net) [88.67.194.153]
  by mail.gmx.net (mp030) with SMTP; 05 Jan 2008 17:03:57 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+o4GpJ8LKorBZQNIDEazuCeDAgHijOaI4vdTofi2
	+BoOvAqD9CxISd
X-X-Sender: gene099@racer.site
In-Reply-To: <7vr6gxjpyn.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69675>

Hi,

On Fri, 4 Jan 2008, Junio C Hamano wrote:

> Dmitry Potapov <dpotapov@gmail.com> writes:
> 
> > It works only if the name "unambiguous" for git show-ref, which 
> > interprets refname differently than rev-list as I wrote above. 
> > Nevertheless, I believe we can use 'git show-ref' if we try something 
> > like this:
> 
> Ahh.
> 
> But at that point I would say that exposing the refname dwimming
> logic to the scripts could be a much cleaner solution.

I considered that when ripping the script from cogito, but it seemed to me 
at that time that not requiring an up-to-date git for testing the script 
would be better.

Now is a different situation, however, so I agree.

Ciao,
Dscho

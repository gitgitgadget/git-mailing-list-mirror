From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: email address handling
Date: Sat, 2 Aug 2008 13:03:22 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0808021300420.9611@pacific.mpi-cbg.de.mpi-cbg.de>
References: <20080731194042.a1534b4d.akpm@linux-foundation.org> <alpine.LFD.1.10.0808011229400.3277@nehalem.linux-foundation.org> <20080801124550.26b9efc0.akpm@linux-foundation.org> <alpine.LFD.1.10.0808011253580.3277@nehalem.linux-foundation.org>
 <20080801131127.20b3acfd.akpm@linux-foundation.org> <alpine.LFD.1.10.0808011316050.3277@nehalem.linux-foundation.org> <20080801132415.0b0314e4.akpm@linux-foundation.org> <alpine.LFD.1.10.0808011335230.3277@nehalem.linux-foundation.org>
 <20080801135421.5ca0f6af.akpm@linux-foundation.org> <alpine.DEB.1.00.0808012314580.9611@pacific.mpi-cbg.de.mpi-cbg.de> <7v4p64sa07.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 02 13:01:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPEr6-00041M-UP
	for gcvg-git-2@gmane.org; Sat, 02 Aug 2008 13:01:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752410AbYHBK7E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Aug 2008 06:59:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752362AbYHBK7D
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Aug 2008 06:59:03 -0400
Received: from mail.gmx.net ([213.165.64.20]:37672 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751973AbYHBK7B (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Aug 2008 06:59:01 -0400
Received: (qmail invoked by alias); 02 Aug 2008 10:58:59 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp038) with SMTP; 02 Aug 2008 12:58:59 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/5zA5vrmj5lOtMSjl1VkzIZm9IIX6tvc8nAHw2Yl
	D5xXAl3evXihwS
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <7v4p64sa07.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91139>

Hi,

On Fri, 1 Aug 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Fri, 1 Aug 2008, Andrew Morton wrote:
> >
> >> I very very frequently copy and paste name+email address out of git 
> >> output and into an MUA.  Have done it thousands and thousands of times, 
> >> and it has always worked.  I'm sure that many others do the same thing.
> 
> >
> > $ git log --pretty=email
> >
> > after this patch:
> 
> You are quoting only Author: and not Signed-off-by: and Cc: that are used
> for e-mail purposes.

You might have realized that this was not a proper patch with a commit 
message and a SOB?

As for Cc: I agree.  But not for S-O-B: this is not an email header.  And 
I was very specific in only changing the behavior for "pretty=email".

At least _I_ was surprised that pretty=email did not behave as if it was 
outputting email headers.

I agree with Linus for pretty=non-email, but not at all for pretty=email.

> I already said send-email is the right place to do this kind of thing, 
> didn't I?

For the given scenario send-email is completely irrelevant.

Ciao,
Dscho

From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Replace instances of export VAR=VAL with VAR=VAL; export
 VAR
Date: Wed, 28 Nov 2007 19:03:52 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711281903330.27959@racer.site>
References: <109026BC-408F-451A-8F7C-A4012DD8DBDF@wincent.com>
 <C3971B37-F75A-40EE-B30A-E88E5DAFAD55@lrde.epita.fr>
 <D21294CA-6FD0-40F5-B0D6-5155865DA69A@wincent.com>
 <CDF48716-F198-4B33-A5F5-8A2DE1F177EB@wincent.com> <474AC136.8060906@viscovery.net>
 <451492C9-F3EA-4C37-A1AD-59FC72E0A0A2@wincent.com> <Pine.LNX.4.64.0711261340470.27959@racer.site>
 <97F6E8DE-4022-4458-B6A9-C644A6EDC1E3@wincent.com> <7vir3m94ku.fsf@gitster.siamese.dyndns.org>
 <50645A3B-C5F0-4A99-A2B8-AD9251024244@wincent.com> <7v1waa7lcv.fsf@gitster.siamese.dyndns.org>
 <1570EAD5-9F47-4105-B3DA-49CA6FA57369@wincent.com> <Pine.LNX.4.64.0711281355460.27959@racer.site>
 <474D7956.8050401@viscovery.net> <Pine.LNX.4.64.0711281428180.27959@racer.site>
 <474D7D92.2000106@viscovery.net> <7vr6ia5hoi.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Wincent Colaiuta <win@wincent.com>,
	Benoit Sigoure <tsuna@lrde.epita.fr>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 20:04:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxSD9-0000YA-BL
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 20:04:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757212AbXK1TEF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 14:04:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757668AbXK1TEE
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 14:04:04 -0500
Received: from mail.gmx.net ([213.165.64.20]:38213 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757212AbXK1TEB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 14:04:01 -0500
Received: (qmail invoked by alias); 28 Nov 2007 19:04:00 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp024) with SMTP; 28 Nov 2007 20:04:00 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/jczMQ/0/jw/J3Je2wWTOCwHs4ctUByxKXU9sL77
	ur32sWio06Cx2N
X-X-Sender: gene099@racer.site
In-Reply-To: <7vr6ia5hoi.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66411>

Hi,

On Wed, 28 Nov 2007, Junio C Hamano wrote:

> Johannes Sixt <j.sixt@viscovery.net> writes:
> 
> > Johannes Schindelin schrieb:
> > ...
> >>> Recently there was a report that \n in the substitution side of s/// is not
> >>> supported by all seds :-(
> >>
> >> Okay, how about replacing the line with
> >>
> >> +			s/.*/GIT_'$uid'_NAME='\''&'\''\
> >> +export GIT_'$uid'_NAME/p
> >>
> >> Hmm?  (It works here.)
> >
> > This looks good. The other case I'm refering to was also solved in this way.
> 
> That looks ugly to me.
> 
> Is there a particular reason to force linebreak when a semicolon would
> do?

D'oh.  Of course.  You want me to resend?

Ciao,
Dscho

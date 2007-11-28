From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Replace instances of export VAR=VAL with VAR=VAL; export
 VAR
Date: Wed, 28 Nov 2007 14:29:11 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711281428180.27959@racer.site>
References: <109026BC-408F-451A-8F7C-A4012DD8DBDF@wincent.com>
 <C3971B37-F75A-40EE-B30A-E88E5DAFAD55@lrde.epita.fr>
 <D21294CA-6FD0-40F5-B0D6-5155865DA69A@wincent.com>
 <CDF48716-F198-4B33-A5F5-8A2DE1F177EB@wincent.com> <474AC136.8060906@viscovery.net>
 <451492C9-F3EA-4C37-A1AD-59FC72E0A0A2@wincent.com> <Pine.LNX.4.64.0711261340470.27959@racer.site>
 <97F6E8DE-4022-4458-B6A9-C644A6EDC1E3@wincent.com> <7vir3m94ku.fsf@gitster.siamese.dyndns.org>
 <50645A3B-C5F0-4A99-A2B8-AD9251024244@wincent.com> <7v1waa7lcv.fsf@gitster.siamese.dyndns.org>
 <1570EAD5-9F47-4105-B3DA-49CA6FA57369@wincent.com> <Pine.LNX.4.64.0711281355460.27959@racer.site>
 <474D7956.8050401@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Wincent Colaiuta <win@wincent.com>,
	Junio C Hamano <gitster@pobox.com>,
	Benoit Sigoure <tsuna@lrde.epita.fr>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Nov 28 15:29:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxNv2-0007Ph-0f
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 15:29:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755614AbXK1O3U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 09:29:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754897AbXK1O3U
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 09:29:20 -0500
Received: from mail.gmx.net ([213.165.64.20]:52764 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754685AbXK1O3U (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 09:29:20 -0500
Received: (qmail invoked by alias); 28 Nov 2007 14:29:18 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp021) with SMTP; 28 Nov 2007 15:29:18 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+TCOB3tdKTJEcxTMWKzcta2TWVaVy3B8onDUupq/
	tKGn0Qtt4oo2tG
X-X-Sender: gene099@racer.site
In-Reply-To: <474D7956.8050401@viscovery.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66345>

Hi,

On Wed, 28 Nov 2007, Johannes Sixt wrote:

> Johannes Schindelin schrieb:
> > -			s/.*/export GIT_'$uid'_NAME='\''&'\''/p
> > +			s/.*/GIT_'$uid'_NAME='\''&'\''\nexport
> > GIT_'$uid'_NAME/p
> 
> Recently there was a report that \n in the substitution side of s/// is not
> supported by all seds :-(

Okay, how about replacing the line with

+			s/.*/GIT_'$uid'_NAME='\''&'\''\
+export GIT_'$uid'_NAME/p

Hmm?  (It works here.)

Ciao,
Dscho

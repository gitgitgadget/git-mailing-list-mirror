From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCHv2 1/2] Support multiple virtual repositories with a single
 object store and refs
Date: Thu, 26 May 2011 01:53:42 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1105260152430.2701@bonsai2>
References: <1306274066-4092-1-git-send-email-jamey@minilop.net> <7v7h9f7kzx.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.1105250847380.2701@bonsai2> <20110525154405.GA4839@oh.minilop.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Josh Triplett <josh@joshtriplett.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Sixt <johannes.sixt@telecom.at>
To: Jamey Sharp <jamey@minilop.net>
X-From: git-owner@vger.kernel.org Thu May 26 01:53:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPNti-00087l-5w
	for gcvg-git-2@lo.gmane.org; Thu, 26 May 2011 01:53:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756771Ab1EYXxr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2011 19:53:47 -0400
Received: from mailout-de.gmx.net ([213.165.64.22]:37901 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756089Ab1EYXxq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2011 19:53:46 -0400
Received: (qmail invoked by alias); 25 May 2011 23:53:44 -0000
Received: from pD9EB28BC.dip0.t-ipconnect.de (EHLO noname) [217.235.40.188]
  by mail.gmx.net (mp018) with SMTP; 26 May 2011 01:53:44 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+jc2kGB3aj70IDktUbdKq4SEWrR5j0IX1TMA7uG8
	Q55oeWUOhcdhGB
X-X-Sender: gene099@bonsai2
In-Reply-To: <20110525154405.GA4839@oh.minilop.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174482>

Hi,

On Wed, 25 May 2011, Jamey Sharp wrote:

> On Wed, May 25, 2011 at 08:51:07AM +0200, Johannes Schindelin wrote:
>
> > 2) You're extending the protocol by appending the prefix after the 
> >    SHA-1, and I stopped halfway through the patch trying to find 
> >    information which I now think should be in the commit message: a)  
> >    why? b) why does it not break when one of the two sides is a 
> >    previous version?
> 
> I don't think we're changing the protocol in any way...?

Did your patch series not contain a change that sends a capability with 
the prefix appended?

Ciao,
Johannes

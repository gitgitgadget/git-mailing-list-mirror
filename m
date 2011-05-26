From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCHv2 1/2] Support multiple virtual repositories with a
 single object store and refs
Date: Wed, 25 May 2011 17:01:04 -0700
Message-ID: <20110526000104.GA3439@leaf>
References: <1306274066-4092-1-git-send-email-jamey@minilop.net>
 <7v7h9f7kzx.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.1.00.1105250847380.2701@bonsai2>
 <20110525154405.GA4839@oh.minilop.net>
 <alpine.DEB.1.00.1105260152430.2701@bonsai2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jamey Sharp <jamey@minilop.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Sixt <johannes.sixt@telecom.at>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu May 26 02:01:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPO0u-0003mJ-N1
	for gcvg-git-2@lo.gmane.org; Thu, 26 May 2011 02:01:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754504Ab1EZABO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2011 20:01:14 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:51171 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753741Ab1EZABO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2011 20:01:14 -0400
X-Originating-IP: 217.70.178.137
Received: from mfilter8-d.gandi.net (mfilter8-d.gandi.net [217.70.178.137])
	by relay3-d.mail.gandi.net (Postfix) with ESMTP id 8007EA8079;
	Thu, 26 May 2011 02:01:12 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at #File managed by puppet, do not edit
	locally
Received: from relay3-d.mail.gandi.net ([217.70.183.195])
	by mfilter8-d.gandi.net (mfilter8-d.gandi.net [10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id GWO9NgEmF94s; Thu, 26 May 2011 02:01:11 +0200 (CEST)
X-Originating-IP: 50.43.15.19
Received: from leaf (static-50-43-15-19.bvtn.or.frontiernet.net [50.43.15.19])
	(Authenticated sender: josh@joshtriplett.org)
	by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 2C336A805E;
	Thu, 26 May 2011 02:01:07 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.1105260152430.2701@bonsai2>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174484>

On Thu, May 26, 2011 at 01:53:42AM +0200, Johannes Schindelin wrote:
> On Wed, 25 May 2011, Jamey Sharp wrote:
> > On Wed, May 25, 2011 at 08:51:07AM +0200, Johannes Schindelin wrote:
> > > 2) You're extending the protocol by appending the prefix after the 
> > >    SHA-1, and I stopped halfway through the patch trying to find 
> > >    information which I now think should be in the commit message: a)  
> > >    why? b) why does it not break when one of the two sides is a 
> > >    previous version?
> > 
> > I don't think we're changing the protocol in any way...?
> 
> Did your patch series not contain a change that sends a capability with 
> the prefix appended?

Not that we know of.  Are we missing something?

- Josh Triplett

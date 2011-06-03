From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCHv4 2/4] Add infrastructure for ref namespaces
Date: Fri, 3 Jun 2011 14:01:56 -0700
Message-ID: <20110603210156.GA1806@leaf>
References: <1306887870-3875-1-git-send-email-jamey@minilop.net>
 <1306887870-3875-2-git-send-email-jamey@minilop.net>
 <m3sjrrwbyp.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jamey Sharp <jamey@minilop.net>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 03 23:02:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QSbVY-00039R-7R
	for gcvg-git-2@lo.gmane.org; Fri, 03 Jun 2011 23:02:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756228Ab1FCVCJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2011 17:02:09 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:34345 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755161Ab1FCVCI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2011 17:02:08 -0400
X-Originating-IP: 217.70.178.137
Received: from mfilter8-d.gandi.net (mfilter8-d.gandi.net [217.70.178.137])
	by relay4-d.mail.gandi.net (Postfix) with ESMTP id E60F5172083;
	Fri,  3 Jun 2011 23:02:05 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at #File managed by puppet, do not edit
	locally
Received: from relay4-d.mail.gandi.net ([217.70.183.196])
	by mfilter8-d.gandi.net (mfilter8-d.gandi.net [10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id amnEAgQvO3TX; Fri,  3 Jun 2011 23:02:04 +0200 (CEST)
X-Originating-IP: 131.252.246.22
Received: from leaf (host-246-22.pubnet.pdx.edu [131.252.246.22])
	(Authenticated sender: josh@joshtriplett.org)
	by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 662E8172076;
	Fri,  3 Jun 2011 23:01:58 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <m3sjrrwbyp.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175024>

On Fri, Jun 03, 2011 at 01:35:34AM -0700, Jakub Narebski wrote:
> Jamey Sharp <jamey@minilop.net> writes:
> 
> > From: Josh Triplett <josh@joshtriplett.org>
> > 
> > Add support for dividing the refs of a single repository into multiple
> > namespaces, each of which can have its own branches, tags, and HEAD.
> > Git can expose each namespace as an independent repository to pull from
> > and push to, while sharing the object store, and exposing all the refs
> > to operations such as git-gc.
> [...]
> 
> By the way, after this feature is merged in, would you like for gitweb
> to understand ref namespaces and offer browsing of separate namespaces
> (sub-repositories)?

Yes, definitely!  We'd love to see gitweb handling namespaces
transparently, and presenting them identically to top-level
repositories.  (Also, gitweb would need to present the appropriate
repository URIs for cloning.)

Thanks,
Josh Triplett and Jamey Sharp

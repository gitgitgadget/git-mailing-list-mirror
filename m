From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCHv8 1/4] Fix prefix handling in ref iteration functions
Date: Tue, 7 Jun 2011 18:40:01 -0700
Message-ID: <20110608014001.GA1800@leaf>
References: <1307487890-3915-1-git-send-email-jamey@minilop.net>
 <1307487890-3915-2-git-send-email-jamey@minilop.net>
 <7v4o4141mz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jamey Sharp <jamey@minilop.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>,
	Bert Wesarg <bert.wesarg@googlemail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 03:40:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QU7kv-0000Ot-O1
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 03:40:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753449Ab1FHBkT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2011 21:40:19 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:56759 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751898Ab1FHBkS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2011 21:40:18 -0400
X-Originating-IP: 217.70.178.134
Received: from mfilter4-d.gandi.net (mfilter4-d.gandi.net [217.70.178.134])
	by relay3-d.mail.gandi.net (Postfix) with ESMTP id 19162A806E;
	Wed,  8 Jun 2011 03:40:17 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at #File managed by puppet, do not edit
	locally
Received: from relay3-d.mail.gandi.net ([217.70.183.195])
	by mfilter4-d.gandi.net (mfilter4-d.gandi.net [10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id dUuuVDffOC0Q; Wed,  8 Jun 2011 03:40:15 +0200 (CEST)
X-Originating-IP: 131.252.247.106
Received: from leaf (host-247-106.pubnet.pdx.edu [131.252.247.106])
	(Authenticated sender: josh@joshtriplett.org)
	by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id DE25CA8072;
	Wed,  8 Jun 2011 03:40:03 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7v4o4141mz.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175291>

On Tue, Jun 07, 2011 at 05:17:56PM -0700, Junio C Hamano wrote:
> This round does fix the ".have" issues, but with the --namespace patch
> later in the series, it seems to break the same test, by filtering .have
> entries with "refs/" prefix.

Ouch, missed that; good catch.  We'll fix that in the next round of the
patch series.

> > Commit by Josh Triplett and Jamey Sharp.
> 
> Didn't I ask you to remove this?

You did ask, we responded (with a citation to a specific recommendation
from the Git list saying to include such a note), and you hadn't said
anything further about it until now.  If you insist that we remove it,
fine, we'll remove it.

> It is somewhat irritating having to re-edit the log message (not just this
> part, but what have been queued were retitled, reflowed and reworded to
> match the style of other commits in the project better) over and over
> again.

We attempted to follow the usual commit message conventions, and none of
the feedback we received mentioned anything about any other desired
changes.  What changes would you like us to make?

- Josh Triplett

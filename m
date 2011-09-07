From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4] gitk: Allow commit editing
Date: Wed, 7 Sep 2011 16:10:11 -0400
Message-ID: <20110907201011.GF13364@sigill.intra.peff.net>
References: <87obzlwpx0.fsf@steelpick.2x.cz>
 <1313756753-26498-1-git-send-email-sojka@os.inf.tu-dresden.de>
 <20110825031420.GB3465@sigill.intra.peff.net>
 <87bovdvdhd.fsf@steelpick.2x.cz>
 <20110825173018.GA519@sigill.intra.peff.net>
 <87fwknaveh.fsf@steelpick.2x.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, paulus@samba.org
To: Michal Sojka <sojka@os.inf.tu-dresden.de>
X-From: git-owner@vger.kernel.org Wed Sep 07 22:10:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1OS7-0004dC-CA
	for gcvg-git-2@lo.gmane.org; Wed, 07 Sep 2011 22:10:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754273Ab1IGUKS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Sep 2011 16:10:18 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:47929
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751419Ab1IGUKQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Sep 2011 16:10:16 -0400
Received: (qmail 5345 invoked by uid 107); 7 Sep 2011 20:11:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 07 Sep 2011 16:11:03 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 07 Sep 2011 16:10:11 -0400
Content-Disposition: inline
In-Reply-To: <87fwknaveh.fsf@steelpick.2x.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180902>

On Sat, Aug 27, 2011 at 02:31:02PM +0200, Michal Sojka wrote:

> Here is a new version with the micro-optimization.
> 
> Another minor change is that this patch now applies to gitk repo
> (http://git.kernel.org/pub/scm/gitk/gitk.git) instead of the main git
> repo.

Thanks. This version fixes most of my complaints and looks reasonable
sane, as long as you accept the idea that starting an interactive rebase
behind the scenes is sane.  I'm still not 100% convinced. But then, I am
not a big gitk user, either (I like visualizing with it, but I rarely
want to do anything interactive). So I'll leave Paul and anyone else to
argue or make a decision on that count.

-Peff

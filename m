From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Switch receive.denyCurrentBranch to "refuse"
Date: Fri, 30 Jan 2009 02:34:15 -0500
Message-ID: <20090130073415.GA27224@coredump.intra.peff.net>
References: <cover.1233275583u.git.johannes.schindelin@gmx.de> <alpine.DEB.1.00.0901300133070.3586@pacific.mpi-cbg.de> <4982A99C.6070301@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org, gitster@pobox.com
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Jan 30 08:35:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSnui-0006PB-RM
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 08:35:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751998AbZA3HeT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2009 02:34:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751905AbZA3HeT
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 02:34:19 -0500
Received: from peff.net ([208.65.91.99]:60320 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751729AbZA3HeT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jan 2009 02:34:19 -0500
Received: (qmail 27980 invoked by uid 107); 30 Jan 2009 07:34:27 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 30 Jan 2009 02:34:27 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Jan 2009 02:34:15 -0500
Content-Disposition: inline
In-Reply-To: <4982A99C.6070301@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107776>

On Fri, Jan 30, 2009 at 08:17:48AM +0100, Johannes Sixt wrote:

> Johannes Schindelin schrieb:
> > +		error("refusing to update checked out branch: %s\n"
> > +			"if you know what you are doing, you can allow it by "
> > +			"setting\n\n"
> > +			"\tgit config receive.denyCurrentBranch true\n", name);
> 
> Oh, fscking hell, I should have screamed out loudly when Jeff named this
> option "denyCurrentBranch" instead of "allowCurrentBranch". It's all too
> easy to fall into the trap, like you here.

Sorry. ;P

On the other hand, you also missed the boat on receive.denyDeletes and
receive.denyNonFastForwards.

-Peff

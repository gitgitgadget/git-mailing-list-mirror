From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] expand --pretty=format color options
Date: Tue, 20 Jan 2009 14:21:52 -0500
Message-ID: <20090120192152.GA8635@coredump.intra.peff.net>
References: <49736331.8010003@lsrfire.ath.cx> <20090118173753.GB17434@coredump.intra.peff.net> <20090118194328.GA31180@coredump.intra.peff.net> <20090118195342.GA612@coredump.intra.peff.net> <7vljt6q4cf.fsf@gitster.siamese.dyndns.org> <20090120040617.GB30714@sigill.intra.peff.net> <alpine.DEB.1.00.0901201126500.3586@pacific.mpi-cbg.de> <alpine.DEB.1.00.0901201133280.3586@pacific.mpi-cbg.de> <20090120142301.GC10688@sigill.intra.peff.net> <alpine.DEB.1.00.0901201553200.5159@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Markus Heidelberg <markus.heidelberg@web.de>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jan 20 20:23:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPMBz-0008ES-UT
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 20:23:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754587AbZATTVz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jan 2009 14:21:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754393AbZATTVz
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jan 2009 14:21:55 -0500
Received: from peff.net ([208.65.91.99]:59582 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754134AbZATTVz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2009 14:21:55 -0500
Received: (qmail 3763 invoked by uid 107); 20 Jan 2009 19:21:59 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 20 Jan 2009 14:21:59 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 20 Jan 2009 14:21:52 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0901201553200.5159@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106510>

On Tue, Jan 20, 2009 at 03:58:29PM +0100, Johannes Schindelin wrote:

> > The behavior I would propose it along the lines of:
> > 
> >  - plumbing _always_ has color off
> > 
> >  - porcelain respects color.* config, --color, etc
> 
> Right, that'd be the sane behavior, even for %Cred.

OK, good. I think our disagreement was just confused wording on both
sides, then.

-Peff

From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Fixed crash in fetching remote tags when there is not
	tags.
Date: Wed, 10 Oct 2007 17:33:06 -0400
Message-ID: <20071010213305.GB8518@sigill.intra.peff.net>
References: <1191919868-4963-1-git-send-email-v@pp.inet.fi> <1191919868-4963-2-git-send-email-v@pp.inet.fi> <81553116-3A4F-4526-A772-9A43C53D3E22@pp.inet.fi> <20071009182043.GA2997@steel.home> <20071010051034.GA30834@coredump.intra.peff.net> <20071010212735.GB16635@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?iso-8859-1?B?VuRpbvYgSuRydmVs5A==?= <v@pp.inet.fi>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 10 23:33:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfjBB-00015b-12
	for gcvg-git-2@gmane.org; Wed, 10 Oct 2007 23:33:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756762AbXJJVdK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2007 17:33:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756748AbXJJVdJ
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Oct 2007 17:33:09 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1819 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756354AbXJJVdI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2007 17:33:08 -0400
Received: (qmail 15084 invoked by uid 111); 10 Oct 2007 21:33:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 10 Oct 2007 17:33:05 -0400
Received: (qmail 8542 invoked by uid 1000); 10 Oct 2007 21:33:06 -0000
Content-Disposition: inline
In-Reply-To: <20071010212735.GB16635@steel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60549>

On Wed, Oct 10, 2007 at 11:27:35PM +0200, Alex Riesen wrote:

> Still, I'd suggest move the test into the caller, firstly because it
> is the only place that special. Also, I can't think of a proper reason

Yes, I agree with that. I came very close to suggesting it in my other
mail, but then realized I had never even looked at the surrounding code,
and I ought not to be making assessments of how that data structure
should be used.  But now there are two of us. :)

-Peff

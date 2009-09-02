From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2] status: list unmerged files last
Date: Wed, 2 Sep 2009 19:39:23 +0100
Message-ID: <20090902183923.GA10581@rakim.wolfsonmicro.main>
References: <20090901145213.GB4194@debian.b2j>
 <200909012213.54611.j6t@kdbg.org>
 <7vy6oy9z9r.fsf@alter.siamese.dyndns.org>
 <200909012325.45739.j6t@kdbg.org>
 <7vtyzmxkpr.fsf@alter.siamese.dyndns.org>
 <20090902011513.GA3874@coredump.intra.peff.net>
 <7vmy5egefh.fsf@alter.siamese.dyndns.org>
 <20090902051248.GB12046@coredump.intra.peff.net>
 <20090902124832.GC4012@sirena.org.uk>
 <20090902180050.GB5998@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	bill lam <cbill.lam@gmail.com>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 02 20:39:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Miuk1-00044K-9W
	for gcvg-git-2@lo.gmane.org; Wed, 02 Sep 2009 20:39:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753204AbZIBSjX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2009 14:39:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753211AbZIBSjX
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Sep 2009 14:39:23 -0400
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:42199 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753189AbZIBSjW (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Sep 2009 14:39:22 -0400
Received: from rakim.wolfsonmicro.main (lumison.wolfsonmicro.com [87.246.78.27])
	by opensource2.wolfsonmicro.com (Postfix) with ESMTPSA id 707851100C4;
	Wed,  2 Sep 2009 19:39:24 +0100 (BST)
Received: from broonie by rakim.wolfsonmicro.main with local (Exim 4.69)
	(envelope-from <broonie@rakim.wolfsonmicro.main>)
	id 1Miujr-0002qM-St; Wed, 02 Sep 2009 19:39:23 +0100
Content-Disposition: inline
In-Reply-To: <20090902180050.GB5998@coredump.intra.peff.net>
X-Cookie: When in doubt, lead trump.
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127626>

On Wed, Sep 02, 2009 at 02:00:50PM -0400, Jeff King wrote:

> Yeah, we already have --untracked-files=<no|normal|all> and a matching
> config variable. If there are cases people find useful, I don't see a
> reason why we can't make other sections configurable, too. I think it
> just somebody to write a patch for the behavior they think makes sense
> (or at the very least a concrete proposal).

My main wishlist would be to have the same control for the changes to be
committed for the big merge case, the use case being while resolving
merges where those changes are those that have been dealt with and the
remaining (hopefully much fewer) changes are those that still need
attention.

From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 17/17] fetch_refs(): simplify logic
Date: Thu, 23 Aug 2012 05:07:40 -0400
Message-ID: <20120823090740.GF6963@sigill.intra.peff.net>
References: <1345709442-16046-1-git-send-email-mhagger@alum.mit.edu>
 <1345709442-16046-18-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Aug 23 11:07:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4TOJ-00087y-49
	for gcvg-git-2@plane.gmane.org; Thu, 23 Aug 2012 11:07:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752845Ab2HWJHq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Aug 2012 05:07:46 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:45997 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751282Ab2HWJHm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Aug 2012 05:07:42 -0400
Received: (qmail 19472 invoked by uid 107); 23 Aug 2012 09:07:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 23 Aug 2012 05:07:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Aug 2012 05:07:40 -0400
Content-Disposition: inline
In-Reply-To: <1345709442-16046-18-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204140>

On Thu, Aug 23, 2012 at 10:10:42AM +0200, mhagger@alum.mit.edu wrote:

> Subject: Re: [PATCH 17/17] fetch_refs(): simplify logic
> [...]
>  static void filter_refs(struct ref **refs, int *nr_heads, char **heads)

The subject should be "filter_refs", no?

-Peff

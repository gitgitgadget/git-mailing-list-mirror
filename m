From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 16/17] fetch_pack(): free matching heads
Date: Thu, 23 Aug 2012 05:04:39 -0400
Message-ID: <20120823090439.GE6963@sigill.intra.peff.net>
References: <1345709442-16046-1-git-send-email-mhagger@alum.mit.edu>
 <1345709442-16046-17-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Aug 23 11:04:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4TLP-0003wL-7K
	for gcvg-git-2@plane.gmane.org; Thu, 23 Aug 2012 11:04:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757744Ab2HWJEo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Aug 2012 05:04:44 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:45989 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752203Ab2HWJEm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Aug 2012 05:04:42 -0400
Received: (qmail 19428 invoked by uid 107); 23 Aug 2012 09:04:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 23 Aug 2012 05:04:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Aug 2012 05:04:39 -0400
Content-Disposition: inline
In-Reply-To: <1345709442-16046-17-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204139>

On Thu, Aug 23, 2012 at 10:10:41AM +0200, mhagger@alum.mit.edu wrote:

> From: Michael Haggerty <mhagger@alum.mit.edu>
> 
> fetch_pack() used to delete entries from the input list (*nr_heads,
> heads) and drop them on the floor.  (Even earlier versions dropped
> some names on the floor and modified others.)  This forced
> fetch_refs_via_pack() to create a separate copy of the original list
> so that it could free the all of the names.

Minor typo: s/the all/all/.

-Peff

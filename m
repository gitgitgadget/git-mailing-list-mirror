From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 00/11] writing out a huge blob to working tree
Date: Thu, 19 May 2011 18:21:28 -0400
Message-ID: <20110519222127.GA30963@sigill.intra.peff.net>
References: <1305505831-31587-1-git-send-email-gitster@pobox.com>
 <1305840826-7783-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 20 00:21:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNBb6-0007mp-0M
	for gcvg-git-2@lo.gmane.org; Fri, 20 May 2011 00:21:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754061Ab1ESWVb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2011 18:21:31 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:50522
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752863Ab1ESWVa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2011 18:21:30 -0400
Received: (qmail 21818 invoked by uid 107); 19 May 2011 22:23:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 19 May 2011 18:23:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 May 2011 18:21:28 -0400
Content-Disposition: inline
In-Reply-To: <1305840826-7783-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174027>

On Thu, May 19, 2011 at 02:33:35PM -0700, Junio C Hamano wrote:

> Also sha1_object_info_extended() lost the call to the expensive function
> packed_object_info_detail(), as the only thing we are interested in is to
> see if the first-level object is a non-delta.  As the result, 02/11 would
> now be much easier to follow.

Thanks, I can confirm that this clears up the performance issue in my
test. I have no idea why it wasn't totally fixed with the patch I posted
earlier. I must have botched something.

-Peff

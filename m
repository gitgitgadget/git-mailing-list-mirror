From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] prune_object_dir(): verify that path fits in the
 temporary buffer
Date: Wed, 18 Dec 2013 15:27:22 -0500
Message-ID: <20131218202722.GA10774@sigill.intra.peff.net>
References: <1387287838-25779-1-git-send-email-mhagger@alum.mit.edu>
 <1387287838-25779-3-git-send-email-mhagger@alum.mit.edu>
 <xmqq8uvjmhu5.fsf@gitster.dls.corp.google.com>
 <20131217232231.GA14807@sigill.intra.peff.net>
 <xmqqa9fyhrzt.fsf@gitster.dls.corp.google.com>
 <20131218200043.GA10244@sigill.intra.peff.net>
 <xmqqwqj1hqjd.fsf@gitster.dls.corp.google.com>
 <20131218201101.GA10507@sigill.intra.peff.net>
 <xmqqppothq5k.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 18 21:27:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VtNiK-0003Xo-E2
	for gcvg-git-2@plane.gmane.org; Wed, 18 Dec 2013 21:27:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751062Ab3LRU1Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Dec 2013 15:27:24 -0500
Received: from cloud.peff.net ([50.56.180.127]:46887 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750915Ab3LRU1Y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Dec 2013 15:27:24 -0500
Received: (qmail 5073 invoked by uid 102); 18 Dec 2013 20:27:24 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 18 Dec 2013 14:27:24 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Dec 2013 15:27:22 -0500
Content-Disposition: inline
In-Reply-To: <xmqqppothq5k.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239483>

On Wed, Dec 18, 2013 at 12:15:19PM -0800, Junio C Hamano wrote:

> > Thanks. Are you picking this up with a commit message, or did you want
> > me to re-send with the usual message/signoff?
> 
> I think this should be sufficient ;-)
> 
> -- >8 --
> From: Jeff King <peff@peff.net>
> Date: Tue, 17 Dec 2013 18:22:31 -0500
> Subject: [PATCH] builtin/prune.c: use strbuf to avoid having to worry about PATH_MAX
> 
> While at it, rename prune_tmp_object(), which used to be a helper to
> remove temporary files that were created to become loose object
> files, to prune_tmp_file(), as the function is also used to remove
> any random cruft whose name begins with tmp_ directly in .git/object
> or .git/object/pack directories these days.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

Great, thanks. You might also want to stick a:

 Noticed-by: Michael Haggerty <mhagger@alum.mit.edu>

in there.

-Peff

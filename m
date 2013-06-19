From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/3] Fix a race condition when reading loose refs
Date: Wed, 19 Jun 2013 12:01:51 -0400
Message-ID: <20130619160150.GA19139@sigill.intra.peff.net>
References: <1371623788-7227-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>,
	Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Jun 19 18:02:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpKpe-0003dE-IY
	for gcvg-git-2@plane.gmane.org; Wed, 19 Jun 2013 18:02:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757124Ab3FSQB6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jun 2013 12:01:58 -0400
Received: from cloud.peff.net ([50.56.180.127]:48012 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757031Ab3FSQB5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jun 2013 12:01:57 -0400
Received: (qmail 21437 invoked by uid 102); 19 Jun 2013 16:02:55 -0000
Received: from mobile-032-132-054-112.mycingular.net (HELO sigill.intra.peff.net) (32.132.54.112)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 19 Jun 2013 11:02:55 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 19 Jun 2013 12:01:51 -0400
Content-Disposition: inline
In-Reply-To: <1371623788-7227-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228396>

On Wed, Jun 19, 2013 at 08:36:25AM +0200, Michael Haggerty wrote:

> I took Peff's suggestion to use gotos rather than an infinite loop in
> the last patch, which means that there is no need for the old patch
> 03/04.

Thanks, this version looks good to me.

I'm sure the Pascal programmers of the world collectively sighed in
disgust at a code review requesting a for loop turn into a goto, but I
think it is more readable than the first version. :)

-Peff

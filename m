From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 10/19] pack-bitmap: add support for bitmap indexes
Date: Wed, 30 Oct 2013 03:00:55 -0400
Message-ID: <20131030070055.GE11317@sigill.intra.peff.net>
References: <20131025055521.GD11810@sigill.intra.peff.net>
 <20131025060345.GH23098@sigill.intra.peff.net>
 <xmqqk3h1hrx0.fsf@gitster.dls.corp.google.com>
 <20131026002629.GA18324@sigill.intra.peff.net>
 <20131026062507.GA23963@sigill.intra.peff.net>
 <xmqqiowhh140.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Vicent Marti <vicent@github.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 30 08:01:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbPm4-0007Wr-3I
	for gcvg-git-2@plane.gmane.org; Wed, 30 Oct 2013 08:01:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753402Ab3J3HA7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Oct 2013 03:00:59 -0400
Received: from cloud.peff.net ([50.56.180.127]:58239 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753103Ab3J3HA6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Oct 2013 03:00:58 -0400
Received: (qmail 14497 invoked by uid 102); 30 Oct 2013 07:00:58 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 30 Oct 2013 02:00:58 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 Oct 2013 03:00:55 -0400
Content-Disposition: inline
In-Reply-To: <xmqqiowhh140.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236991>

On Mon, Oct 28, 2013 at 08:22:07AM -0700, Junio C Hamano wrote:

> >     However, the code in the ewah/ directory has been hacked up a bit
> >     from its original, and ewah_io.c _does_ include "git-compat-util.h".
> >     So it may make sense to consider our copy a fork and git-ify it
> >     more.
> 
> Yeah, sounds very sensible.

I'll make them more git-ish for the next re-roll, then.

-Peff

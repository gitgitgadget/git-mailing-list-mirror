From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Bump core.deltaBaseCacheLimit to 96m
Date: Mon, 5 May 2014 16:19:28 -0400
Message-ID: <20140505201928.GA24266@sigill.intra.peff.net>
References: <1399223637-29964-1-git-send-email-dak@gnu.org>
 <CACsJy8BG8fRPk74R_-YABCGMn-YwbDcLHtjUNX7KE66jX1mR4A@mail.gmail.com>
 <874n14tqty.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Tue May 06 19:31:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Whi8i-0006KZ-Fl
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 18:22:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752446AbaEEUTc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2014 16:19:32 -0400
Received: from cloud.peff.net ([50.56.180.127]:45500 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752161AbaEEUTb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2014 16:19:31 -0400
Received: (qmail 2387 invoked by uid 102); 5 May 2014 20:19:30 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 05 May 2014 15:19:30 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 05 May 2014 16:19:28 -0400
Content-Disposition: inline
In-Reply-To: <874n14tqty.fsf@fencepost.gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248187>

On Mon, May 05, 2014 at 01:20:09PM +0200, David Kastrup wrote:

> > Would it make more sense to advise git devs to set this per repo
> > instead? The majority of (open source) repositories out there are
> > small if I'm not mistaken. Of those few big repos, we could have a
> > section listing all the tips and tricks to tune git. This is one of
> > them. Index v4 and sparse checkout are some other. In future, maybe
> > watchman support, split index and untracked cache as well.
> 
> Shrug.  The last version of the patch was refused because of wanting
> more evidence.  I added the evidence.

FWIW, I was the one who asked for the evidence, and this patch looks
pretty straightforward and good. We may also want to revisit the data
structure for the delta cache, but that can come separately. My earlier
tests had not shown improvement with just bumping the cache size, but
these ones obviously do. So I think it's worth bumping the default.

-Peff

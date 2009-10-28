From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/4] Add I18N-wrappers for low-level IO-routines
Date: Wed, 28 Oct 2009 14:10:34 -0400
Message-ID: <20091028181033.GA17225@sigill.intra.peff.net>
References: <1256651643-18382-1-git-send-email-timur@iris-comp.ru>
 <1256651643-18382-2-git-send-email-timur@iris-comp.ru>
 <20091027210817.GA1577@sigill.intra.peff.net>
 <4ae886f4.0b38560a.6cfb.5ac4@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Timur Sufiev <tsufiev@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 28 19:10:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3Cyp-0001cN-IW
	for gcvg-git-2@lo.gmane.org; Wed, 28 Oct 2009 19:10:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752423AbZJ1SKc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2009 14:10:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752243AbZJ1SKc
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 14:10:32 -0400
Received: from peff.net ([208.65.91.99]:58041 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752189AbZJ1SKb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2009 14:10:31 -0400
Received: (qmail 11576 invoked by uid 107); 28 Oct 2009 18:14:15 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (216.239.45.19)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 28 Oct 2009 14:14:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Oct 2009 14:10:34 -0400
Content-Disposition: inline
In-Reply-To: <4ae886f4.0b38560a.6cfb.5ac4@mx.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131490>

On Wed, Oct 28, 2009 at 09:01:21PM +0300, Timur Sufiev wrote:

> Yes, it actually haven't made it to the list. Perhaps this was due to
> patch size: it was approx. 3300 lines long (BTW, what's the message size
> limit?) So I've rewritten the patch to make it more compact, using mingw
> approach with macros. Subj prefix for a patch series is 'PATCH I18N
> filenames v2'. 

Thanks. The rules for vger are here:

  http://vger.kernel.org/majordomo-info.html

The max size is 100K, but you may also be triggering something from the
taboo list accidentally.

> >   2. I seem to recall that Linus added a filename translation layer for
> >      doing much more, like handling unicode normalizations (but I
> >      confess I haven't looked closely at that code). Should this be part
> >      of that system?
> 
> I've heard nothing about that :(. Could you point me directly at Linus'
> changes?

Try looking at this series:

  http://thread.gmane.org/gmane.comp.version-control.git/119222

-Peff

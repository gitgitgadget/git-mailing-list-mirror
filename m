From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] upload-pack: add a trigger for post-upload-pack hook
Date: Wed, 26 Aug 2009 10:19:08 -0400
Message-ID: <20090826141907.GA3485@sigill.intra.peff.net>
References: <1250579093-40706-1-git-send-email-tom@mojombo.com>
 <12c267e40908251043g4f3e36aya05d9c705f5afee2@mail.gmail.com>
 <20090825184525.GC23731@coredump.intra.peff.net>
 <7vprajmp16.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.1.00.0908261043140.4713@intel-tinevez-2-302>
 <7vr5uzeyl7.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.1.00.0908261200160.4713@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Tom Werner <mojombo@gmail.com>,
	Tom Preston-Werner <tom@mojombo.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Aug 26 16:19:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgJLL-00066s-OS
	for gcvg-git-2@lo.gmane.org; Wed, 26 Aug 2009 16:19:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933005AbZHZOTJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Aug 2009 10:19:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757389AbZHZOTJ
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Aug 2009 10:19:09 -0400
Received: from peff.net ([208.65.91.99]:51437 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757411AbZHZOTI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Aug 2009 10:19:08 -0400
Received: (qmail 23006 invoked by uid 107); 26 Aug 2009 14:19:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 26 Aug 2009 10:19:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 26 Aug 2009 10:19:08 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0908261200160.4713@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127098>

On Wed, Aug 26, 2009 at 12:06:59PM +0200, Johannes Schindelin wrote:

> > Did you get an impression that I was saying "you must add these 
> > otherwise I'll reject the patch"?
> 
> Well, I got the impression that you'd not accept the patch without 
> additional information given by the hook, and I got the impression that 
> Tom would decide as a consequence to rather live with his eternal fork 
> instead of working on getting this patch included.

I don't think any of us wants that. My point in bringing it up at all
was just "is there anything obvious that we should be adding before this
makes it into master, because after that we will have to deal with an
interface change". I certainly don't want to delay a useful patch too
much while we wait for the moon.

-Peff

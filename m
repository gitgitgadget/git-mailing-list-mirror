From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv4 08/12] Teach the notes lookup code to parse notes
 trees with various fanout schemes
Date: Thu, 27 Aug 2009 19:39:00 -0400
Message-ID: <20090827233900.GA7347@coredump.intra.peff.net>
References: <1251337437-16947-1-git-send-email-johan@herland.net>
 <20090827212710.GV1033@spearce.org>
 <7vy6p5ncz0.fsf@alter.siamese.dyndns.org>
 <200908280103.06015.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes.Schindelin@gmx.de, trast@student.ethz.ch,
	tavestbo@trolltech.com, git@drmicha.warpmail.net,
	chriscool@tuxfamily.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Fri Aug 28 01:39:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgoYh-0000S7-4r
	for gcvg-git-2@lo.gmane.org; Fri, 28 Aug 2009 01:39:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752432AbZH0XjD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2009 19:39:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752196AbZH0XjB
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Aug 2009 19:39:01 -0400
Received: from peff.net ([208.65.91.99]:55636 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752146AbZH0XjB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Aug 2009 19:39:01 -0400
Received: (qmail 1606 invoked by uid 107); 27 Aug 2009 23:39:11 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 27 Aug 2009 19:39:11 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 27 Aug 2009 19:39:00 -0400
Content-Disposition: inline
In-Reply-To: <200908280103.06015.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127235>

On Fri, Aug 28, 2009 at 01:03:05AM +0200, Johan Herland wrote:

> Agreed. I'm starting to come around to the idea of storing them in subtrees 
> based on commit dates. For one, you don't have multiple notes for one commit 
> in the same notes tree. Also, the common-case access pattern seems tempting.
> 
> Dscho: Were there other problems with the date-based approach other than not 
> supporting notes on trees and blobs?
> 
> If not, I'll start preparing another series with the date-based approach.

Would you ever want to load a note for a commit when you did not have
that commit present (in which case you would not know its date)?

-Peff

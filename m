From: Jeff King <peff@peff.net>
Subject: Re: git rebase --skip
Date: Wed, 7 Nov 2007 22:23:10 -0500
Message-ID: <20071108032308.GA5638@sigill.intra.peff.net>
References: <20071107222105.GA31666@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Thu Nov 08 04:23:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ipxze-0003SI-KK
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 04:23:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757347AbXKHDXZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 22:23:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754096AbXKHDXY
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 22:23:24 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3584 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757347AbXKHDXX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 22:23:23 -0500
Received: (qmail 11014 invoked by uid 111); 8 Nov 2007 03:23:17 -0000
Received: from c-24-125-35-113.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (24.125.35.113)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 07 Nov 2007 22:23:17 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 07 Nov 2007 22:23:10 -0500
Content-Disposition: inline
In-Reply-To: <20071107222105.GA31666@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63928>

On Wed, Nov 07, 2007 at 11:21:05PM +0100, Mike Hommey wrote:

> I use git-rebase quite regularly, and I haven't used git-rebase --skip
> after a failed merge without first resetting the working tree. I was
> wondering if it wouldn't make sense to automatically do the reset when
> running git-rebase --skip.

I have often been annoyed by this behavior, too, and I can't think of
any situation where you _wouldn't_ want the reset to happen.  But I
would be more comfortable hearing confirmation from others that they
can't think of such a situation.

-Peff

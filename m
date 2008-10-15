From: Jeff King <peff@peff.net>
Subject: Re: [BUG] git status doesn't handle submodules properly on OSX
Date: Wed, 15 Oct 2008 08:49:43 -0400
Message-ID: <20081015124943.GA10816@sigill.intra.peff.net>
References: <c60a85c1297be6446ad92a3e7723ddc8.squirrel@webmail.highteq.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Lars Hoss <lars@woeye.net>
X-From: git-owner@vger.kernel.org Wed Oct 15 14:51:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kq5qV-0007Tt-CS
	for gcvg-git-2@gmane.org; Wed, 15 Oct 2008 14:51:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753638AbYJOMuD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2008 08:50:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753421AbYJOMuC
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Oct 2008 08:50:02 -0400
Received: from peff.net ([208.65.91.99]:3254 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752818AbYJOMuA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2008 08:50:00 -0400
Received: (qmail 24919 invoked by uid 111); 15 Oct 2008 12:49:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 15 Oct 2008 08:49:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 15 Oct 2008 08:49:43 -0400
Content-Disposition: inline
In-Reply-To: <c60a85c1297be6446ad92a3e7723ddc8.squirrel@webmail.highteq.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98270>

On Wed, Oct 15, 2008 at 02:07:17PM +0200, Lars Hoss wrote:

> two days ago I posted about an issue:
> http://thread.gmane.org/gmane.comp.version-control.git/98171
> 
> After more testing I can confirm it is indeed a bug.
> 
> 1.6.0.2 on OSX Leopard doesn't work. After adding a submodule
> the folder of the submodule will always get listed under
> "Untracked files" when calling git status.
> 
> 1.5.6, however, works fine. I have not tested trunk yet.

I wasn't able to reproduce your bug on my Linux box. Can you bisect to
find the faulty commit?

-Peff

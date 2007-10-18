From: Jeff King <peff@peff.net>
Subject: Re: bug: origin refs updated too soon locally
Date: Thu, 18 Oct 2007 01:28:09 -0400
Message-ID: <20071018052809.GA11938@coredump.intra.peff.net>
References: <8CEF6150-4BE7-4B4D-B58C-12CE4671007E@cs.indiana.edu> <20071018045358.GB14735@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Perry Wagle <wagle@cs.indiana.edu>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Oct 18 07:28:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiNvj-0004UY-Mm
	for gcvg-git-2@gmane.org; Thu, 18 Oct 2007 07:28:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753117AbXJRF2N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 01:28:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751902AbXJRF2N
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 01:28:13 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4183 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751171AbXJRF2M (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 01:28:12 -0400
Received: (qmail 32725 invoked by uid 111); 18 Oct 2007 05:28:10 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 18 Oct 2007 01:28:10 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 18 Oct 2007 01:28:09 -0400
Content-Disposition: inline
In-Reply-To: <20071018045358.GB14735@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61479>

On Thu, Oct 18, 2007 at 12:53:58AM -0400, Shawn O. Pearce wrote:

> This is probably easier to do after the db/fetch-pack topic is
> merged as the improvements there might make this easier.  But I
> could be wrong.  Be nice if someone proved me wrong by writing up
> a patch for git-send-pack.

It doesn't look too bad...patch series in a few minutes.

-Peff

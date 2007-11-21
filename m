From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Highlight keyboard shortcuts in git-add--interactive
Date: Wed, 21 Nov 2007 10:28:17 -0500
Message-ID: <20071121152817.GA27144@sigill.intra.peff.net>
References: <1195655278-19535-1-git-send-email-win@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dan Zwell <dzwell@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Wed Nov 21 16:29:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IurVG-0005WI-GI
	for gcvg-git-2@gmane.org; Wed, 21 Nov 2007 16:28:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755766AbXKUP2U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2007 10:28:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755584AbXKUP2U
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 10:28:20 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4883 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755497AbXKUP2U (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2007 10:28:20 -0500
Received: (qmail 8436 invoked by uid 111); 21 Nov 2007 15:28:19 -0000
Received: from c-24-125-35-113.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (24.125.35.113)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 21 Nov 2007 10:28:19 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 21 Nov 2007 10:28:17 -0500
Content-Disposition: inline
In-Reply-To: <1195655278-19535-1-git-send-email-win@wincent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65665>

On Wed, Nov 21, 2007 at 03:27:58PM +0100, Wincent Colaiuta wrote:

> The user interface provided by the command loop in git-add--interactive
> gives the impression that subcommands can only be launched by entering
> an integer identifier from 1 through 8.
> 
> A "hidden" feature is that any string can be entered, and an anchored
> regex search is used to find the first matching option.
> 
> This patch makes this feature a little more obvious by highlighting the
> first character of each subcommand (for example "patch" is displayed as
> "[p]atch"). The mechanism for doing this is to add an optional third

I think this is reasonable. It is also a candidate for colorization in
Dan Zwell's patches. Dan, any progress on the next revision of the patch
series?

-Peff

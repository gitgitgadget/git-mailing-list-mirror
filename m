From: Jeff King <peff@peff.net>
Subject: Re: On Tabs and Spaces
Date: Wed, 17 Oct 2007 23:00:55 -0400
Message-ID: <20071018030055.GA7218@coredump.intra.peff.net>
References: <1192565900.6430.16.camel@athena> <alpine.LFD.0.999.0710161559150.6887@woody.linux-foundation.org> <20071017015109.303760cc@localhost.localdomain> <alpine.LFD.0.999.0710161722320.26902@woody.linux-foundation.org> <3A9408D5-2667-43A6-A0CE-C0720B3A3987@vicaya.com> <alpine.LFD.0.999.0710170849590.26902@woody.linux-foundation.org> <20071018003256.GA5062@coredump.intra.peff.net> <alpine.LFD.0.999.0710171753020.26902@woody.linux-foundation.org> <20071018024553.GA5186@coredump.intra.peff.net> <Pine.LNX.4.64.0710172002020.10276@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Luke Lu <git@vicaya.com>,
	Christer Weinigel <christer@weinigel.se>,
	Tom Tobin <korpios@korpios.com>, git@vger.kernel.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Thu Oct 18 05:01:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiLdI-0002eo-8Y
	for gcvg-git-2@gmane.org; Thu, 18 Oct 2007 05:01:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762680AbXJRDA7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2007 23:00:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762434AbXJRDA7
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Oct 2007 23:00:59 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4821 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761576AbXJRDA6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2007 23:00:58 -0400
Received: (qmail 31840 invoked by uid 111); 18 Oct 2007 03:00:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 17 Oct 2007 23:00:56 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 17 Oct 2007 23:00:55 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0710172002020.10276@asgard.lang.hm>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61454>

On Wed, Oct 17, 2007 at 08:03:51PM -0700, david@lang.hm wrote:

>> This might matter if I'm comparing non-diff code to diff code. But in a
>> diff, _everything_ is indented by exactly one space, so it all lines up.
>> Is there something I'm missing?
>
> if the code uses a tab and the patch uses 8 spaces the two will not line up 
> in the diff becouse in the diff output the tab is 'only 7 spaces;
>
> useing one or the other isn't the problem, it's the mixing of the two.

Yes, obviously. The people who advocate mixing really _are_ objectively
wrong. But I was talking about all-spaces versus all-tabs.

-Peff

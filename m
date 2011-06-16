From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [RFC/PATCH] config.c: Make git_config() work correctly when called
 recursively
Date: Thu, 16 Jun 2011 20:55:57 +0100
Message-ID: <4DFA5FCD.6080902@ramsay1.demon.co.uk>
References: <4DF106B8.2080902@ramsay1.demon.co.uk> <20110609203958.GA4671@sigill.intra.peff.net> <4DF7A627.2080600@ramsay1.demon.co.uk> <20110614182726.GA451@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, johan@herland.net
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 16 22:28:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QXJAi-0001Zc-NJ
	for gcvg-git-2@lo.gmane.org; Thu, 16 Jun 2011 22:28:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932979Ab1FPU17 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jun 2011 16:27:59 -0400
Received: from anchor-post-1.mail.demon.net ([195.173.77.132]:33096 "EHLO
	anchor-post-1.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932360Ab1FPU16 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Jun 2011 16:27:58 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-1.mail.demon.net with esmtp (Exim 4.69)
	id 1QXJAS-0003CH-hw; Thu, 16 Jun 2011 20:27:57 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <20110614182726.GA451@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175926>

Jeff King wrote:
> On Tue, Jun 14, 2011 at 07:19:19PM +0100, Ramsay Jones wrote:
[...]
>> I could, of course, have simply changed the expect file so that it would pass
>> the test, but I wanted the change to be self-contained and to pass all existing
>> tests (ie. the external interface/behaviour should *not* change).
> 
> No, you did the right thing here. The information on which config file
> we're in is valuable, and taking away the globals is not worth the pain
> of making all of the callers and callbacks of git_config have to deal
> with passing around a context struct.
> 
> So the patch you posted looks good to me.

Thanks! (I will abandon the search for an alternate solution! ;-)

I think the commit message needs to be re-worded before actually submitting
the patch (it's fine for an RFC, but the call-chain info has a limited shelf
life and should go).

Also, I wanted to re-submit two additional patches in that branch; last time
they didn't even make it to pu!  Hopefully they will take at least one step
further this time.

ATB,
Ramsay Jones

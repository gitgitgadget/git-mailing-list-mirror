From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: git gc & deleted branches
Date: Fri, 09 May 2008 10:56:14 -0500
Message-ID: <4824741E.4080807@nrlssc.navy.mil>
References: <48236F69.2060900@nrlssc.navy.mil> <20080508213107.GA1016@sigill.intra.peff.net> <48237344.6070405@nrlssc.navy.mil> <20080508214454.GA1939@sigill.intra.peff.net> <48237650.5060008@nrlssc.navy.mil> <20080508224827.GA2938@sigill.intra.peff.net> <loom.20080509T011318-478@post.gmane.org> <20080509041921.GA14773@sigill.intra.peff.net> <E1B43061-69C7-43D7-9A57-34B7C55DF345@adacore.com> <48246A44.7020303@nrlssc.navy.mil> <20080509155323.GA28966@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Geert Bosch <bosch@adacore.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 09 17:57:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JuUyS-0002pn-Vl
	for gcvg-git-2@gmane.org; Fri, 09 May 2008 17:57:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754855AbYEIP4o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2008 11:56:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754805AbYEIP4o
	(ORCPT <rfc822;git-outgoing>); Fri, 9 May 2008 11:56:44 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:37661 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754762AbYEIP4o (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2008 11:56:44 -0400
Received: from starfish.gems.nrlssc.navy.mil (starfish.nrlssc.navy.mil [128.160.50.76])
	by mail.nrlssc.navy.mil (8.13.8/8.13.8) with ESMTP id m49FuEsi004146;
	Fri, 9 May 2008 10:56:14 -0500
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 9 May 2008 10:56:14 -0500
User-Agent: Thunderbird 2.0.0.12 (X11/20080213)
In-Reply-To: <20080509155323.GA28966@sigill.intra.peff.net>
X-OriginalArrivalTime: 09 May 2008 15:56:14.0926 (UTC) FILETIME=[35DF6EE0:01C8B1ED]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81617>

Jeff King wrote:
> On Fri, May 09, 2008 at 10:14:12AM -0500, Brandon Casey wrote:
> 
>>>   -  Objects will not be accessible by ordinary git commands for a while,
>>>      before they are really removed, avoiding surprises
>> Unreferenced objects are sometimes used by other repositories which have
>> this repository listed as an alternate. So it may not be a good idea to
>> make the unreferenced objects inaccessible.
> 
> But that is precisely what we're going to do, but in two weeks. Isn't it
> better to have the dependent repo fail while the change is recoverable?

good point.

-b

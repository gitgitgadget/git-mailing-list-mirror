From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: rebase -p confusion in 1.6.1
Date: Thu, 15 Jan 2009 15:14:04 +0100
Message-ID: <496F44AC.2060607@drmicha.warpmail.net>
References: <slrngmu4j5.e1u.sitaramc@sitaramc.homelinux.net> <496F3C99.1040800@drmicha.warpmail.net> <20090115135518.GB10045@leksak.fem-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Sitaram Chamarty <sitaramc@gmail.com>, git@vger.kernel.org,
	Stephen Haberman <stephen@exigencecorp.com>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Thu Jan 15 15:15:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNT0R-0007yC-9t
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 15:15:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759197AbZAOOOK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2009 09:14:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758883AbZAOOOH
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 09:14:07 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:46346 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756337AbZAOOOG (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Jan 2009 09:14:06 -0500
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id D1A84212D5B;
	Thu, 15 Jan 2009 09:14:05 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Thu, 15 Jan 2009 09:14:05 -0500
X-Sasl-enc: dsjZmnxzzOnm2aoFrteJmt17dHNp8Ga60Ca9ywBEVnFZ 1232028845
Received: from [139.174.44.34] (pascal.math.tu-clausthal.de [139.174.44.34])
	by mail.messagingengine.com (Postfix) with ESMTPSA id DD68A3195D;
	Thu, 15 Jan 2009 09:14:04 -0500 (EST)
User-Agent: Thunderbird 2.0.0.19 (X11/20081209)
In-Reply-To: <20090115135518.GB10045@leksak.fem-net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105817>

Stephan Beyer venit, vidit, dixit 15.01.2009 14:55:
> Hi,
> 
>> First of all: git 1.6.0.6 gives you the unchanged graph after using
>> rebase -i -p.
> 
> This is true and it is a far better behavior than now, but I think it's
> not the expected behavior. (I have written about the behavior I'd expect
> in another reply to the original mail.)

Yep, I think -p should preserve only merges in side branches (and
therefore produce what you suggest, and what you get without -p). If it
preserves all merges then there is nothing to rewrite here.

BTW: How does the sequencer based rebase do in this case, and what's the
general status? If it's about to be integrated we can do without the
present script...

Michael

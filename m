From: Guido Ostkamp <git@ostkamp.fastmail.fm>
Subject: Re: git gc & deleted branches
Date: Thu, 8 May 2008 23:33:39 +0200 (CEST)
Message-ID: <alpine.LSU.1.10.0805082330520.4850@bianca.dialin.t-online.de>
References: <alpine.LSU.1.10.0805081920160.8678@bianca.dialin.t-online.de> <20080508183926.GA30613@sigill.intra.peff.net> <alpine.LSU.1.10.0805082051210.10981@bianca.dialin.t-online.de> <48235D99.2040407@nrlssc.navy.mil> <alpine.LSU.1.10.0805082232070.4260@bianca.dialin.t-online.de>
 <20080508210125.GC32762@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Brandon Casey <casey@nrlssc.navy.mil>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 08 23:37:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JuDlM-0000dJ-Sh
	for gcvg-git-2@gmane.org; Thu, 08 May 2008 23:34:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933347AbYEHVdr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2008 17:33:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933351AbYEHVdq
	(ORCPT <rfc822;git-outgoing>); Thu, 8 May 2008 17:33:46 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:49043 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752726AbYEHVdp (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 May 2008 17:33:45 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 55E88106D36;
	Thu,  8 May 2008 17:33:44 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Thu, 08 May 2008 17:33:44 -0400
X-Sasl-enc: rv2ZO1TgLR5TfmY850+eDLRh9lxtKvWZHvOzpMS33cvA 1210282423
Received: from [192.168.2.100] (p549A4064.dip.t-dialin.net [84.154.64.100])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 55FD91FD2D;
	Thu,  8 May 2008 17:33:43 -0400 (EDT)
In-Reply-To: <20080508210125.GC32762@sigill.intra.peff.net>
User-Agent: Alpine 1.10 (LSU 1032 2008-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81571>

On Thu, 8 May 2008, Jeff King wrote:
> According to that commit message, prune is now a no-op. However, it 
> looks like it is still used for trigger a "repack -a" rather than 
> "repack -A".

I tried to look at this but found this option '-A' to be undocumented in 
the manpage (git/Documentation/git-repack.txt and what is generated from 
it).

Regards

Guido

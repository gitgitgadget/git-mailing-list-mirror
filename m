From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: git gc & deleted branches
Date: Thu, 08 May 2008 16:53:20 -0500
Message-ID: <48237650.5060008@nrlssc.navy.mil>
References: <20080508183926.GA30613@sigill.intra.peff.net> <alpine.LSU.1.10.0805082051210.10981@bianca.dialin.t-online.de> <48235D99.2040407@nrlssc.navy.mil> <alpine.LSU.1.10.0805082232070.4260@bianca.dialin.t-online.de> <20080508210125.GC32762@sigill.intra.peff.net> <alpine.LFD.1.10.0805081712270.23581@xanadu.home> <20080508211734.GA819@sigill.intra.peff.net> <48236F69.2060900@nrlssc.navy.mil> <20080508213107.GA1016@sigill.intra.peff.net> <48237344.6070405@nrlssc.navy.mil> <20080508214454.GA1939@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@cam.org>,
	Guido Ostkamp <git@ostkamp.fastmail.fm>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 08 23:54:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JuE4G-0000Nj-Kh
	for gcvg-git-2@gmane.org; Thu, 08 May 2008 23:54:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757805AbYEHVxf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2008 17:53:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761454AbYEHVxf
	(ORCPT <rfc822;git-outgoing>); Thu, 8 May 2008 17:53:35 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:48449 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757805AbYEHVxe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2008 17:53:34 -0400
Received: from starfish.gems.nrlssc.navy.mil (starfish.nrlssc.navy.mil [128.160.50.76])
	by mail.nrlssc.navy.mil (8.13.8/8.13.8) with ESMTP id m48LrKXJ030668;
	Thu, 8 May 2008 16:53:20 -0500
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 8 May 2008 16:53:20 -0500
User-Agent: Thunderbird 2.0.0.12 (X11/20080213)
In-Reply-To: <20080508214454.GA1939@sigill.intra.peff.net>
X-OriginalArrivalTime: 08 May 2008 21:53:20.0935 (UTC) FILETIME=[EE5B3370:01C8B155]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81574>

Jeff King wrote:
> On Thu, May 08, 2008 at 04:40:20PM -0500, Brandon Casey wrote:
> 
>> The 'prune --expire' behavior is based on object mtime (i.e. file
>> modification time).  That is lost once something is packed right?
> 
> Yes. You would have to use the pack mtime. But of course you would have
> to actually _leave_ them in a pack, or they would just keep getting
> added to the new pack.

I had the impression that unreachable objects would not be packed. Maybe it
was more of an assumption.

-brandon

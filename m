From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Feature request - Subtree checkouts
Date: Tue, 10 Apr 2007 19:41:07 -0400
Message-ID: <20070410234107.GI5436@spearce.org>
References: <20070410074444.GA18541@curie-int.orbis-terrarum.net> <20070410132011.GH5436@spearce.org> <7vslb8ug7y.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Robin H. Johnson" <robbat2@gentoo.org>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Apr 11 08:44:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbPxe-0004oW-Vz
	for gcvg-git@gmane.org; Wed, 11 Apr 2007 01:41:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161108AbXDJXlO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Apr 2007 19:41:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161110AbXDJXlO
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Apr 2007 19:41:14 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:33817 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161108AbXDJXlN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2007 19:41:13 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HbPxL-00075i-QJ; Tue, 10 Apr 2007 19:40:59 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 0F69420FBAE; Tue, 10 Apr 2007 19:41:08 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7vslb8ug7y.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44200>

Junio C Hamano <junkio@cox.net> wrote:
> One thing that people need to be careful about is which SMTP
> server they use.  I had an impression (I do not use send-email
> myself) that it defaulted to local MTA, so the mail trail would
> look like your local MTA receives from the MUA (which is
> send-email), which forwards it to whereever destination (or
> intermediaries).  On the other hand, I suspect many people use
> their ISP's SMTP server when using their usual MUA, so the mail
> trail would look different.  I do not know what filtering vger
> does, but if it is filtering based on the MTA address
> (dul.dnsbl.sorbs filtering comes to mind), that would make a
> difference.

I'm pretty sure the last time I tried git-send-email I had the
MTA path exactly the same.  My mutt sends to `localhost`, which
forwards over an SSL channel to my colo'd spearce.org mail server,
and that relays to the final destination.  Hence spearce.org mail
always originates from spearce.org.

Now I ran git-send-email on a different system, but had it connect
over SMTP to port 25 of the same system mutt runs on, so the
initial Received line was different, but othewrise the mail path
was the same.

I also have a few other addresses that I can send to that will go
out the spearce.org colo'd box to another SMTP system, then bounce
back, and the round-trip was the same for anything from mutt and
from git-send-email.

I marked the whole mess up to some mail header difference that
git-send-email wasn't sending the same way mutt was, and that vger
cared about. I didn't see the difference easily.  I just gave up.
;-)

-- 
Shawn.

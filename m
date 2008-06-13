From: Miles Bader <miles.bader@necel.com>
Subject: Re: [PATCH 2/2] git-gc: skip stashes when expiring reflogs
Date: Fri, 13 Jun 2008 20:14:37 +0900
Message-ID: <buoabhptwma.fsf@dhapc248.dev.necel.com>
References: <alpine.DEB.1.00.0806112242370.1783@racer>
	<20080611230344.GD19474@sigill.intra.peff.net>
	<alpine.LFD.1.10.0806111918300.23110@xanadu.home>
	<loom.20080612T042942-698@post.gmane.org>
	<6413041E-A64A-4BF4-9ECF-F7BFA5C1EAEF@wincent.com>
	<4851F6F4.8000503@op5.se>
	<20080613055800.GA26768@sigill.intra.peff.net>
	<48521EDA.5040802@op5.se> <20080613074257.GA513@sigill.intra.peff.net>
	<bd6139dc0806130156o747fc128hbe28440ed4d228d4@mail.gmail.com>
	<20080613091040.GB4474@sigill.intra.peff.net>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: sverre@rabbelier.nl, Andreas Ericsson <ae@op5.se>,
	Wincent Colaiuta <win@wincent.com>,
	Eric Raible <raible@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Nicolas Pitre <nico@cam.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 13 13:16:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K77GG-0004kD-Lb
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 13:16:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754278AbYFMLPI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2008 07:15:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753914AbYFMLPH
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 07:15:07 -0400
Received: from TYO202.gate.nec.co.jp ([202.32.8.206]:36531 "EHLO
	tyo202.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754134AbYFMLPG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2008 07:15:06 -0400
Received: from relay11.aps.necel.com ([10.29.19.46])
	by tyo202.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id m5DBEcsW009428;
	Fri, 13 Jun 2008 20:14:38 +0900 (JST)
Received: from relay11.aps.necel.com ([10.29.19.20] [10.29.19.20]) by relay11.aps.necel.com with ESMTP; Fri, 13 Jun 2008 20:14:38 +0900
Received: from dhapc248.dev.necel.com ([10.114.112.215] [10.114.112.215]) by relay11.aps.necel.com with ESMTP; Fri, 13 Jun 2008 20:14:38 +0900
Received: by dhapc248.dev.necel.com (Postfix, from userid 31295)
	id DC6024E7; Fri, 13 Jun 2008 20:14:37 +0900 (JST)
System-Type: i686-pc-linux-gnu
Blat: Foop
In-Reply-To: <20080613091040.GB4474@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 13 Jun 2008 05:10:40 -0400")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84865>

Jeff King <peff@peff.net> writes:
>   2. You don't need perfect foresight. Sometime in the thirty days (but
>      probably about 5 minutes later) you realize "oh, this is some
>      stashed work that I'm not going to deal with for a while" and you
>      promote it to a topic branch.

That's exactly the sort of thing that people end up forgetting to do,
even if they know they know about and understand the issue -- and of
course many (most?) people will be using stashes _without_ knowing about
this issue.  I suspect both types will be pretty annoyed when they
realize their work disappeared...

-Miles

-- 
`To alcohol!  The cause of, and solution to,
 all of life's problems' --Homer J. Simpson

From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: What's cooking in git.git (topics)
Date: Sat, 2 Jun 2007 21:10:26 -0400
Message-ID: <20070603011026.GB4507@spearce.org>
References: <7v646wqrvm.fsf@assigned-by-dhcp.cox.net> <7vfy5wcnbg.fsf@assigned-by-dhcp.cox.net> <7vd50xz7lq.fsf@assigned-by-dhcp.cox.net> <7vodkb1adr.fsf@assigned-by-dhcp.cox.net> <7virac547s.fsf@assigned-by-dhcp.cox.net> <7v6466oygl.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Jun 03 03:10:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Huec9-0006E6-FH
	for gcvg-git@gmane.org; Sun, 03 Jun 2007 03:10:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755281AbXFCBKa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Jun 2007 21:10:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758519AbXFCBKa
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jun 2007 21:10:30 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:59346 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755281AbXFCBK3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jun 2007 21:10:29 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1Huebp-0005Ou-B6; Sat, 02 Jun 2007 21:10:17 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id A440B20FBAE; Sat,  2 Jun 2007 21:10:26 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7v6466oygl.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48969>

Junio C Hamano <junkio@cox.net> wrote:
> 'pu' has Shawn's 'pu' from git-gui, to help people experiment
> with the proposed blame viewer improvements more easily.  I
> personally like it quite a bit.

For what its worth, my 'pu' has the same policy as Junio's; it
rebases freely and topics can come and go from it at any time.
But that said, it is certainly suitable for Junio's 'pu'.  :-)

I just pushed an even newer version out a couple of minutes ago.
Now I'm running two passes of git-blame:

	*) Pass 1:  git-blame --incremental
	*) Pass 2:  git-blame -M -C -C --incremental

and the viewer shows them in two columns.  This gives you pretty
quick information about why a change exists, as you get both who
moved the block to where it is, and who originally wrote it.  ;-)

Lots of things still to be worked on in blame, like having it
keep track of what line(s) you are at or are trying to jump to.
I'll try to get to that stuff tonight or tomorrow.

-- 
Shawn.

From: Shawn Pearce <spearce@spearce.org>
Subject: Re: git and time
Date: Wed, 27 Sep 2006 19:02:56 -0400
Message-ID: <20060927230256.GD21839@spearce.org>
References: <20060927222854.82278.qmail@web51014.mail.yahoo.com> <Pine.LNX.4.64.0609271545140.3952@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthew L Foster <mfoster167@yahoo.com>,
	Andreas Ericsson <ae@op5.se>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 28 01:03:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSiQp-0007Z4-P4
	for gcvg-git@gmane.org; Thu, 28 Sep 2006 01:03:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031204AbWI0XDI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Sep 2006 19:03:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031205AbWI0XDI
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Sep 2006 19:03:08 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:52674 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1031204AbWI0XDG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Sep 2006 19:03:06 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GSiQT-0006m6-Co; Wed, 27 Sep 2006 19:02:49 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 7C47520FB28; Wed, 27 Sep 2006 19:02:56 -0400 (EDT)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0609271545140.3952@g5.osdl.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27944>

Linus Torvalds <torvalds@osdl.org> wrote:
> 
> 
> On Wed, 27 Sep 2006, Matthew L Foster wrote:
> >
> > So the separate action of replication is not tracked?
> 
> Correct. Replication without changes is a no-op.

I think it could be reasonably argued that knowing when the head(s)
of your public repository on a mirror of kernel.org changed to a
given value is useful.  Especially when there is a mirroring lag.

-- 
Shawn.

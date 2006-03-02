From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] fmt-merge-msg: avoid open "-|" list form for Perl 5.6
Date: Thu, 2 Mar 2006 11:55:10 -0500
Message-ID: <20060302165510.GB18929@spearce.org>
References: <20060302164405.GB7292@trixie.casa.cgf.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Mar 02 17:55:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEr5D-0007Fx-TL
	for gcvg-git@gmane.org; Thu, 02 Mar 2006 17:55:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751433AbWCBQzP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Mar 2006 11:55:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751610AbWCBQzP
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Mar 2006 11:55:15 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:56269 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751433AbWCBQzN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Mar 2006 11:55:13 -0500
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1FEr50-0001bb-HB
	for git@vger.kernel.org; Thu, 02 Mar 2006 11:55:06 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 1FAD120FBBF; Thu,  2 Mar 2006 11:55:10 -0500 (EST)
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060302164405.GB7292@trixie.casa.cgf.cx>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17094>

Maybe I missed this but why are people using the native Windows
ActiveState Perl with GIT+Cygwin when Cygwin has a Cygwin-ized Perl
installation available?

I've been using the Cygwin Perl with GIT without any problems
whatsoever.  Including the open(I, "-|")... exec(@argv) code that
doesn't work correctly in ActiveState and started this whole thread.

-- 
Shawn.

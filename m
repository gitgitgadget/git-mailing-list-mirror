From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] git-tag: support -F <file> option
Date: Fri, 22 Dec 2006 01:53:14 -0500
Message-ID: <20061222065314.GB15548@spearce.org>
References: <emdsi9$ecm$1@sea.gmane.org> <Pine.LNX.4.63.0612211512160.19693@wbgn013.biozentrum.uni-wuerzburg.de> <7vvek45svl.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Han-Wen Nienhuys <hanwen@xs4all.nl>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 22 07:53:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxeHr-0003Vl-6h
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 07:53:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423182AbWLVGxV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Dec 2006 01:53:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423183AbWLVGxV
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Dec 2006 01:53:21 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:41148 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423182AbWLVGxU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Dec 2006 01:53:20 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GxeHM-0003sa-DC; Fri, 22 Dec 2006 01:53:16 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id E530420FB65; Fri, 22 Dec 2006 01:53:14 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vvek45svl.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35135>

Junio C Hamano <junkio@cox.net> wrote:
> > +	if test "$#" = "0"; then
> > +	    die "error: option -F needs an argument"
> > +	    exit 2
> > +	;;
> 
> I know it was copied from Han-Wen's aabd7693, but was this
> somehow to catch the case where die can fail???

What, you haven't heard of the /bin/resurrection shell?

Apparently one of its features is it can sometimes make die return
successfully, even days after the initial call.  :-)

-- 
Shawn.

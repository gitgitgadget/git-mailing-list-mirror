From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: GIT v1.5.1-rc1
Date: Tue, 20 Mar 2007 10:42:06 -0400
Message-ID: <20070320144206.GB1750@spearce.org>
References: <20070306063501.GA24355@spearce.org> <7v7itcd8mk.fsf@assigned-by-dhcp.cox.net> <20070320025539.GA28922@spearce.org> <200703200937.39440.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>,
	Bill Lear <rael@zopyra.com>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 20 15:42:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTfXT-0004jE-2M
	for gcvg-git@gmane.org; Tue, 20 Mar 2007 15:42:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752264AbXCTOmM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Mar 2007 10:42:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933537AbXCTOmM
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Mar 2007 10:42:12 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:53883 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752264AbXCTOmK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Mar 2007 10:42:10 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HTfXG-0005IN-IP; Tue, 20 Mar 2007 10:42:02 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 4EA6A20FBAE; Tue, 20 Mar 2007 10:42:06 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <200703200937.39440.andyparkins@gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42742>

Andy Parkins <andyparkins@gmail.com> wrote:
> On Tuesday 2007 March 20 02:55, Shawn O. Pearce wrote:
> > think they are stuck on the fact that you cannot use:
> >
> > 	git log $new --not --all
> 
> > That almost needs a --all-except="refs/heads/a refs/heads/b" option
> > to rev-list.  Grrrr.
> 
> I'm afraid so.  Would a --ignore list be more appropriate?  That way you could 
> list any refs you wanted (i.e. not just --all) and then have that list 
> finally filtered by --ignore.

Last night on #git Dscho suggested something like:

  git log $new --not '!a' '!b' --all

as a way to say ignore ref a and ref b when otherwise parsing the
command line arguments.  Ugly, very ugly.  But is more or less the
same idea you are talking about with the --ignore flag.

-- 
Shawn.

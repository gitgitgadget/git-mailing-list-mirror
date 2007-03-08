From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Split sample update hook into post-receive hook
Date: Thu, 8 Mar 2007 05:02:37 -0500
Message-ID: <20070308100237.GF30289@spearce.org>
References: <20070308041618.GA29744@spearce.org> <81b0412b0703080026v6f3990c3x2cefca661b64e00d@mail.gmail.com> <20070308083317.GB30289@spearce.org> <7vy7m8aytt.fsf@assigned-by-dhcp.cox.net> <81b0412b0703080157n413de6f6q35ae24e2620df91d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Andy Parkins <andyparkins@gmail.com>,
	Bill Lear <rael@zopyra.com>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 08 11:02:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPFSU-0007IS-Pt
	for gcvg-git@gmane.org; Thu, 08 Mar 2007 11:02:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030616AbXCHKCn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Mar 2007 05:02:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030626AbXCHKCn
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Mar 2007 05:02:43 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:41950 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030616AbXCHKCm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2007 05:02:42 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HPFSH-0006uj-3M; Thu, 08 Mar 2007 05:02:37 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id E09E520FBAE; Thu,  8 Mar 2007 05:02:37 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <81b0412b0703080157n413de6f6q35ae24e2620df91d@mail.gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41730>

Alex Riesen <raa.lkml@gmail.com> wrote:
> The proprietary OS' will have the problem, though. And far sooner
> than 1300 refs (w2k has only 32767 bytes for command line).
> Besides, don't overestimate peoples readiness to be careful
> about reference names. I would expect reference names over
> 100 bytes in length to happen regularly (generated from file names
> appended with a timestamp, for example).

Cygwin's lifted that argument handling to be unlimited.  But yes,
the point holds, not all OSen will do well with long ref names
and a lot of refs (such as in an initial push of a very verbosely
named project).
 
> Maybe provide this hooks with simply formatted list on stdin? I.e.
> 
> <old-ref> <new-ref> <ref-name> LF

Yea, exactly what I was thinking.  Easily read on stdin using 'read'
in shell, or in Perl, or, in C, or in ...  ;-)

-- 
Shawn.

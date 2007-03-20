From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 2/4] update-hook: show the contents of the tag message for annotated tags
Date: Tue, 20 Mar 2007 11:36:48 -0400
Message-ID: <20070320153648.GC1750@spearce.org>
References: <200703201058.38519.andyparkins@gmail.com> <20070320124154.GB22773@admingilde.org> <200703201527.15476.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Martin Waitz <tali@admingilde.org>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 20 16:36:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTgOO-0005Bq-EG
	for gcvg-git@gmane.org; Tue, 20 Mar 2007 16:36:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933638AbXCTPgx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Mar 2007 11:36:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933909AbXCTPgx
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Mar 2007 11:36:53 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:56098 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933638AbXCTPgw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Mar 2007 11:36:52 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HTgOB-00022J-TI; Tue, 20 Mar 2007 11:36:43 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 314AD20FBAE; Tue, 20 Mar 2007 11:36:48 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <200703201527.15476.andyparkins@gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42747>

Andy Parkins <andyparkins@gmail.com> wrote:
> On Tuesday 2007 March 20 12:41, Martin Waitz wrote:
> 
> > > Which is dangerously reliant on the format of the tag object being four
> > > header lines then the message.
> >
> > I think you can split at the blank line after the header.
> 
> That's a good idea; I can't think of an efficient way of doing that in shell 
> script though.  What I need is a 
> 
>  grep --everything-after "^$"

	sed -e '1,/^$/d'

Portable too.  ;-)

-- 
Shawn.

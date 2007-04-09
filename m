From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: incorporating the past
Date: Mon, 9 Apr 2007 14:32:10 -0400
Message-ID: <20070409183210.GX5436@spearce.org>
References: <87d52d1kli.fsf@mid.thomas-huehn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thomas =?iso-8859-1?Q?H=FChn?= <newsgroups@thomas-huehn.de>
X-From: git-owner@vger.kernel.org Mon Apr 09 22:19:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hayf3-0005Ka-Nc
	for gcvg-git@gmane.org; Mon, 09 Apr 2007 20:32:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753314AbXDIScO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Apr 2007 14:32:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753356AbXDIScO
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Apr 2007 14:32:14 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:40726 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753314AbXDIScN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Apr 2007 14:32:13 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1Hayeq-0002ZX-OX; Mon, 09 Apr 2007 14:32:04 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 7F99A20FBAE; Mon,  9 Apr 2007 14:32:10 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <87d52d1kli.fsf@mid.thomas-huehn.de>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44065>

Thomas H??hn <newsgroups@thomas-huehn.de> wrote:
> I have a file under version control, that I got at the point of file
> version 1.0. I start committing changes:
> 
> o--o--o--o--o--o--o
> ^                 ^
> git init,         current,
> version 1.0       version 1.6
> 
> Then I get the history up to my version 1.0 from somewhere else (former
> maintainer, whatever). In the form of plain text files, one for each
> version; say, versions 0.1 thru 0.9. I want to incorporate this past
> into my tree.
>
> Or can I do the same, only up to 0.9 instead of 1.0, and then "sew
> together" those histories?

Yes.  Look at the `grafts' file.  You can create a new repository
of the 0.9..1.0 history, then graft that repository as a new parent
of the 1.0 commit.  This lets you join in the old history behind
the existing history.  The Linux kernel folks have done this for
the kernel repository.

-- 
Shawn.

From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 0/3] the return of the strbuf
Date: Thu, 20 Sep 2007 10:19:06 -0400
Message-ID: <20070920141906.GR3099@spearce.org>
References: <20070917125211.GA18176@artemis.corp> <20070917133522.GD18176@artemis.corp> <20070918035721.GL3099@spearce.org> <Pine.LNX.4.64.0709201248400.28395@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Sep 20 16:19:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYMsC-0004RH-Iu
	for gcvg-git-2@gmane.org; Thu, 20 Sep 2007 16:19:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756065AbXITOTO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2007 10:19:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755873AbXITOTN
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Sep 2007 10:19:13 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:42869 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755803AbXITOTL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2007 10:19:11 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IYMru-0006wx-Jz; Thu, 20 Sep 2007 10:19:02 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 8253B20FBAE; Thu, 20 Sep 2007 10:19:06 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0709201248400.28395@racer.site>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58782>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Mon, 17 Sep 2007, Shawn O. Pearce wrote:
> 
> >  $ git log --pretty=format:%an --since=6.months.ago -- fast-import.c \
> >       | sort | uniq -c | sort -nr
...
> FWIW I'd do
> 
> git shortlog -n --since=6.months.ago HEAD -- fast-import.c|grep "^[A-Z]"
> 
> instead...

Yea, Junio pointed out how stupid I was being on #git.  I don't
know why I didn't think of using shortlog here as this is one
of the things it was built for.  Whatever.  I forgot my git-fu
on Monday.  :)

-- 
Shawn.

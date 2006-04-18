From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Clone with local alternates?
Date: Tue, 18 Apr 2006 19:56:58 -0400
Message-ID: <20060418235658.GB8915@spearce.org>
References: <1145404132.16166.97.camel@shinybook.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 19 01:57:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FW04C-0007Iu-V6
	for gcvg-git@gmane.org; Wed, 19 Apr 2006 01:57:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750855AbWDRX5F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 18 Apr 2006 19:57:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750860AbWDRX5F
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Apr 2006 19:57:05 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:37058 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1750855AbWDRX5E (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Apr 2006 19:57:04 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1FW03u-0005mY-KB; Tue, 18 Apr 2006 19:56:50 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 962C520FBB4; Tue, 18 Apr 2006 19:56:58 -0400 (EDT)
To: David Woodhouse <dwmw2@infradead.org>
Content-Disposition: inline
In-Reply-To: <1145404132.16166.97.camel@shinybook.infradead.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18886>

David Woodhouse <dwmw2@infradead.org> wrote:
> Often I want to clone a remote repository but would like to use an
> existing local source tree as 'alternates'. 
> 
> One way of doing this is to clone the local tree with 'git-clone -l -s',
> find the latest common commit shared with the remote tree to be fetched,
> revert to that with 'git-reset --head $last' and then pulling from the
> remote. 
> 
> Is that _really_ the best way of doing it though? It would be better if
> we just had a '--local-alternates=/foo' option to git-clone when cloning
> a remote repository.

  git clone --reference=/foo git://remote/foo

would do the trick.  This is new in 1.3.0.  I just noticed its also
not documented in 1.3.0.  :-)

-- 
Shawn.

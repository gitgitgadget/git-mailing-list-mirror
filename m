From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [RFD] Git glossary: 'branch' and 'head' description
Date: Fri, 19 May 2006 05:21:36 -0400
Message-ID: <20060519092136.GN22257@spearce.org>
References: <e4f1ta$e07$1@sea.gmane.org> <87y7wyv72m.fsf@morpheus.hq.vtech>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 19 11:22:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fh1B0-0000nA-VN
	for gcvg-git@gmane.org; Fri, 19 May 2006 11:21:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751180AbWESJVk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 May 2006 05:21:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751300AbWESJVk
	(ORCPT <rfc822;git-outgoing>); Fri, 19 May 2006 05:21:40 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:46795 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751180AbWESJVj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 May 2006 05:21:39 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1Fh1At-0005pF-7l; Fri, 19 May 2006 05:21:35 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 85C16212691; Fri, 19 May 2006 05:21:36 -0400 (EDT)
To: David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>
Content-Disposition: inline
In-Reply-To: <87y7wyv72m.fsf@morpheus.hq.vtech>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20343>

David K?gedal <davidk@lysator.liu.se> wrote:
> I noticed that some of this seems to be changing slightly with the
> introduction of branch logs, but I don't know how those are supposed
> to be used yet.

	$ git commit -a
	$ git pull . some/other-tag
	# go to lunch
	$ git pull . some/bad-stuff
	$ git commit -a
	# go home
	$ test...
	# realize this is all bad
	$ git reset --hard "master@{yesterday}"

:-)

Its really only useful for recording the history of your ref's state,
so you can 'undo' a bad merge that you might have done a few days
ago but not realized was bad until now.

-- 
Shawn.

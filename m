From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Cherry-pick particular object
Date: Tue, 28 Mar 2006 16:37:44 -0500
Message-ID: <20060328213744.GD14457@spearce.org>
References: <20060328113107.20ab4c21.sebastien@xprima.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 28 23:38:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FOLsy-0004IZ-6C
	for gcvg-git@gmane.org; Tue, 28 Mar 2006 23:37:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932221AbWC1Vhx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Mar 2006 16:37:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932227AbWC1Vhx
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Mar 2006 16:37:53 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:6035 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S932221AbWC1Vhw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Mar 2006 16:37:52 -0500
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1FOLsg-0001aJ-OC; Tue, 28 Mar 2006 16:37:38 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id E56F720FBB4; Tue, 28 Mar 2006 16:37:44 -0500 (EST)
To: =?iso-8859-1?Q?S=E9bastien?= Pierre <sebastien@xprima.com>
Content-Disposition: inline
In-Reply-To: <20060328113107.20ab4c21.sebastien@xprima.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18130>

S?bastien Pierre <sebastien@xprima.com> wrote:
> Hi all,
> 
> This is a newbie question.
> 
> I recently wanted to "cherry" pick a particular file from my
> git-managed project history. Using gitk, I identified which was
> the revision I wanted (95ba0c74e03874e8c1721b91f92f161e9061621f),
> and then using git ls-tree, I managed to get the id of the file I
> wanted (78132af26431e649a0f85f22dc27e5787d80700f).
> 
> Now, what I simply wanted was to do something like:
> 
> "get the file corresponding to
> 78132af26431e649a0f85f22dc27e5787d80700f and save it as myfile.txt"
> 
> How would one properly do that with core git ?

git cat-file blob 78132af26431e649a0f85f22dc27e5787d80700f >myfile.txt

-- 
Shawn.

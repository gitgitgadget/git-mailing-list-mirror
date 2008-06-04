From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: move git repository out of a folder?
Date: Wed, 4 Jun 2008 16:07:24 -0400
Message-ID: <20080604200724.GV12896@spearce.org>
References: <1086fb5f0806041303v7856404dxb95b5a450ac30ae1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Sean Brown <seanmichaelbrown@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 04 22:08:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3zHQ-00047j-I4
	for gcvg-git-2@gmane.org; Wed, 04 Jun 2008 22:08:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752983AbYFDUH2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2008 16:07:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753095AbYFDUH2
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jun 2008 16:07:28 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:59475 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752225AbYFDUH1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2008 16:07:27 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.69)
	(envelope-from <spearce@spearce.org>)
	id 1K3zGP-0001tB-Gr; Wed, 04 Jun 2008 16:07:17 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 96A2820FBAE; Wed,  4 Jun 2008 16:07:24 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1086fb5f0806041303v7856404dxb95b5a450ac30ae1@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83820>

Sean Brown <seanmichaelbrown@gmail.com> wrote:
> Let's say I've got this directory structure of source files:
> 
> /folderA
> /folderA/sourcecode/
> /folderA/sourcecode/file1.txt
> /folderA/sourcecode/file2.txt
> etc...
> 
> When putting the project under git source control, I did this:
> 
> cd /folderA
> git init
> 
> So now when colleagues clone my repository, they get the source code
> in the "sourcecode" folder.  I'd like to just make the repository
> simply give them the source files, not in a directory.  In other
> words, as if I had originally been smart and done this:
> 
> cd /folderA/sourcecode
> git init
> 
> Can I make that happen without losing all of the history?

git mv sourcecode/* .
rmdir sourcecode
git commit

-- 
Shawn.

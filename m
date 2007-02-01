From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: newbie questions about git design and features (some wrt hg)
Date: Thu, 1 Feb 2007 13:13:55 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702011313150.5982@woody.linux-foundation.org>
References: <3c6c07c20701300820l42cfc8dbsb80393fc1469f667@mail.gmail.com>
 <200702010058.43431.jnareb@gmail.com> <20070201003429.GQ10108@waste.org>
 <200702010157.51452.jnareb@gmail.com> <45C19DD0.20504@fs.ei.tum.de>
 <Pine.LNX.4.63.0702011108430.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45C1BDD3.8050103@fs.ei.tum.de> <Pine.LNX.4.64.0702010814470.3632@woody.linux-foundation.org>
 <20070201193647.GA18234@soma>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Simon 'corecode' Schubert" <corecode@fs.ei.tum.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Feb 01 22:17:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCjJ0-0003hR-Jo
	for gcvg-git@gmane.org; Thu, 01 Feb 2007 22:17:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423017AbXBAVRP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Feb 2007 16:17:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423020AbXBAVRP
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Feb 2007 16:17:15 -0500
Received: from smtp.osdl.org ([65.172.181.24]:37819 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423017AbXBAVRP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Feb 2007 16:17:15 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l11LDu9V005517
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 1 Feb 2007 13:13:56 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l11LDtWS022672;
	Thu, 1 Feb 2007 13:13:55 -0800
In-Reply-To: <20070201193647.GA18234@soma>
X-Spam-Status: No, hits=-0.443 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.111__
X-MIMEDefang-Filter: osdl$Revision: 1.172 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38406>



On Thu, 1 Feb 2007, Eric Wong wrote:
> > SVN uses "inode numbers" (I think they are just UUID's generated at "svn 
> > add" time, but I'm not sure) to track file ID's across renames. Some other 
> > SCM's do the same.
> 
> I think you got this part confused with GNU Arch (and possibly
> Bzr).  SVN tracks renames in the changeset, it records (in the log)
> a copy and delete.  pathname@revision is the only "file ID" I know
> about in SVN.

Ahh, I was sure the revision files in FSFS were per-file, but coor me 
corrected - they seem to be per-revision.

My bad.

		Linus

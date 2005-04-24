From: James Bottomley <James.Bottomley@SteelEye.com>
Subject: Re: git-changes-script to show inter tree changes
Date: Sat, 23 Apr 2005 21:39:22 -0400
Message-ID: <1114306762.4805.3.camel@mulgrave>
References: <1114281792.5068.10.camel@mulgrave>
	 <20050423230937.GF13222@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 24 06:19:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPYaG-0005f7-Ty
	for gcvg-git@gmane.org; Sun, 24 Apr 2005 06:19:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262155AbVDXEXv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Apr 2005 00:23:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262158AbVDXEXv
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Apr 2005 00:23:51 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:34527 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262155AbVDXEXt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2005 00:23:49 -0400
Received: from midgard.sc.steeleye.com (midgard.sc.steeleye.com [172.17.6.40])
	by hancock.sc.steeleye.com (8.11.6/8.11.6) with ESMTP id j3O4NbA30296;
	Sun, 24 Apr 2005 00:23:38 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050423230937.GF13222@pasky.ji.cz>
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, 2005-04-24 at 01:09 +0200, Petr Baudis wrote:
> Linus isn't probably the right person to Cc on this, since this is
> git-pasky thing.  Can you please post it as a signed-off patch?

I'm just offering it as one of the scripts I need to operate a git tree
as a maintainer.  I don't have git-pasky installed, so I can't patch it
against anything.  However, feel free to incorporate any pieces you
need.

> I don't get what are you doing anyway. I don't know the "bk changes"
> tool. Can't you just do
> 
> 	git log theothertree yourtree

No idea .. not used it.  However, how does this show the -L and -R diffs
since there are two possible views of changes between trees?  It's
primarily -L (changes in local) I need to keep the changes in my local
tree.  -R (changes in remote) is just useful to show what changes I'm
missing and might need to merge.

James



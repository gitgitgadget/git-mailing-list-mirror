From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] Documentation/git-svn: Instructions for cloning a git-svn-created repository
Date: Thu, 9 Aug 2007 18:43:12 -0700
Message-ID: <20070810014312.GE9764@hand.yhbt.net>
References: <1186388203181-git-send-email-aroben@apple.com> <20070809193759.GA4545@untitled> <46BBADBB.6070502@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Adam Roben <aroben@apple.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Fri Aug 10 03:43:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJJX5-00007B-EK
	for gcvg-git@gmane.org; Fri, 10 Aug 2007 03:43:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756088AbXHJBnQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Aug 2007 21:43:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755865AbXHJBnP
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Aug 2007 21:43:15 -0400
Received: from hand.yhbt.net ([66.150.188.102]:34280 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755783AbXHJBnN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Aug 2007 21:43:13 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id E02082DC08D;
	Thu,  9 Aug 2007 18:43:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <46BBADBB.6070502@midwinter.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55498>

Steven Grimm <koreth@midwinter.com> wrote:
> Eric Wong wrote:
> >I personally believe using rsync to clone repositories created with
> >git-svn is the simplest and best method for now.
> 
> But then you don't get to use alternates -- one of the things I like 
> about the idea of doing a "git clone" of a git-svn repository is that 
> you could do "git clone -s" and get the full svn history with a tiny 
> .git directory.

If I'm working on multiple directories  on the same machine, I have
libflcow in my LD_PRELOAD and use cp -al (GNU-specific) to make hardlink
images of my working directory.  I've been using fl-cow with cp -al
since long before I used git.

The new-ish git-new-workdir command could probably be a replacement
for git-clone / flcow + cp -al / rsync in these situations as well.

-- 
Eric Wong

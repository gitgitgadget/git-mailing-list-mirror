From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: renaming question
Date: Sun, 19 Aug 2007 21:56:21 -0400
Message-ID: <20070820015621.GX27913@spearce.org>
References: <03a701c7e28a$87914fc0$0600a8c0@ze4427wm> <87vebbo0f1.fsf@mid.deneb.enyo.de> <03b401c7e28f$3c7304c0$0600a8c0@ze4427wm> <85sl6fqr9n.fsf@lola.goethe.zz> <03bd01c7e295$976a2970$0600a8c0@ze4427wm> <85odh3qp8j.fsf@lola.goethe.zz> <87mywn8dm0.fsf@mid.deneb.enyo.de> <46C8E421.8000408@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Florian Weimer <fw@deneb.enyo.de>, git@vger.kernel.org,
	angray@beeb.net
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Mon Aug 20 03:56:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IMwVi-00038a-Ot
	for gcvg-git@gmane.org; Mon, 20 Aug 2007 03:56:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754294AbXHTB4d (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Aug 2007 21:56:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754199AbXHTB4d
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Aug 2007 21:56:33 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:33775 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752600AbXHTB4c (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Aug 2007 21:56:32 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IMwV2-0007ME-0a; Sun, 19 Aug 2007 21:56:12 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id AA3D520FBAE; Sun, 19 Aug 2007 21:56:21 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <46C8E421.8000408@midwinter.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56164>

Steven Grimm <koreth@midwinter.com> wrote:
> Not only that, git can detect movement of content *within* files. Try 
> moving some code from one file to another and running "git blame -M -C 
> -C" on the target file; you will see git tell you that the content 
> originally came from the first file. Pretty sweet. (It's not the default 
> since it makes "git blame" slower.)

And if you have a GUI available, try `git gui blame $file`.  It runs
git-blame twice to show you not only where the content originally
came from, but also who put it where it is now.  Still needs more
polish, but its quite useful as it is.

-- 
Shawn.

From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: MinGW port usable
Date: Mon, 29 Jan 2007 18:24:25 -0500
Message-ID: <20070129232425.GB31372@spearce.org>
References: <200701292320.43888.johannes.sixt@telecom.at> <20070129223513.GA31372@spearce.org> <46d6db660701291511v700bfcf7l4851dd6be4fc6e03@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org
To: Christian MICHON <christian.michon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 30 00:24:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBfrX-0006we-Nh
	for gcvg-git@gmane.org; Tue, 30 Jan 2007 00:24:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964925AbXA2XYb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 Jan 2007 18:24:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964919AbXA2XYb
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Jan 2007 18:24:31 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:59405 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964925AbXA2XYa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jan 2007 18:24:30 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HBfqb-0001rH-7s; Mon, 29 Jan 2007 18:23:37 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 147F520FBAE; Mon, 29 Jan 2007 18:24:25 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <46d6db660701291511v700bfcf7l4851dd6be4fc6e03@mail.gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38112>

Christian MICHON <christian.michon@gmail.com> wrote:
> my last compilation is less than 8 hours old, and I do not have cygwin
> installed. What is it you want to test actually ?

Try creating a desktop icon (Repository->Create Desktop Icon) and
start git-gui from the resulting .bat file.  It *should* come up
right on MinGW, but I'm only guessing here.

The other one that I'm curious about is if fetch/push/merge work.
merge requires git-merge right now, which is a shell script.
fetch is the same, but push is pure C so it should work.  But I
don't think the Tcl environment will make it into the child, which
means things like SSH_AUTH_SOCK don't get used.

But I really should just install the git-mingw port on one of
my windows systems and play with it.  If its faster than Cygwin
then it's worthwhile.
 
> git-gui and gitk have been working for a bit more than a week, if I
> recall well. I'd like to see git-blame latest patch work with git-gui.

The blame feature is in git-gui (went in last night).  It requires
the --incremental patches from Linus&Junio, which are now in git.git
master.  It also needs a big display, as the interface is horrid.  :)

-- 
Shawn.

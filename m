From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git gui: Possible to see which commands are executed?
Date: Tue, 20 May 2008 15:44:03 -0400
Message-ID: <20080520194403.GC29038@spearce.org>
References: <48301B17.30309@dirk.my1.cc> <20080519022125.GV29038@spearce.org> <4833206E.1080300@dirk.my1.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Dirk =?utf-8?Q?S=C3=BCsserott?= <newsletter@dirk.my1.cc>
X-From: git-owner@vger.kernel.org Tue May 20 21:45:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JyXle-0002U9-JZ
	for gcvg-git-2@gmane.org; Tue, 20 May 2008 21:45:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757705AbYETToL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2008 15:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757567AbYETToK
	(ORCPT <rfc822;git-outgoing>); Tue, 20 May 2008 15:44:10 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:51806 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757001AbYETToJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2008 15:44:09 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JyXkb-0002kN-TH; Tue, 20 May 2008 15:43:57 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 4142D20FBAE; Tue, 20 May 2008 15:44:04 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <4833206E.1080300@dirk.my1.cc>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82491>

Dirk Ssserott <newsletter@dirk.my1.cc> wrote:
> 
> thanks for your patch. Actually I had problems applying it and
> finally gave up. I'm using the msysGit package which seems quite
> similar to the cygwin package but not in all cases, apparently.

Well, msysGit is perhaps on an older version of git-gui.  But
I had thought they were fairly current and that the section of
code the patch touches hasn't been modified in a while.  Maybe
there was an issue with CRLF?
 
> However, you were right. The trace doesn't show the commands I
> would use on a regular basis (I couldn't stop you :-)).
> On the other hand it possibly helps to /understand/ (or at least
> /see/) what's going on under the hood.
> 
> For that reason I'd greatly appreciate seeing your patch in some
> future version of Git. It doesn't do any harm, does it? People
> that don't like it can simply omit the '--trace' switch.
> 
> Junio? The list?

Junio defers almost all git-gui things to me, as I am the current
maintainer of git-gui.  You are right, it doesn't really hurt to
include it, and now that it is written, the hard part is already
done.  I'll apply it to my main git-gui tree and ask Junio to
include it in a future version of Git.

-- 
Shawn.

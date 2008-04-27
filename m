From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH resend] make "git push" update origin and mirrors, "git push --mirror" update mirrors
Date: Sun, 27 Apr 2008 00:40:49 -0400
Message-ID: <20080427044049.GJ29771@spearce.org>
References: <4812DA50.3000702@gnu.org> <20080426170126.GC29771@spearce.org> <7vzlrgmrvb.fsf@gitster.siamese.dyndns.org> <20080427043014.GI29771@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Paolo Bonzini <bonzini@gnu.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 27 06:42:02 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jpyi7-0003X1-Fg
	for gcvg-git-2@gmane.org; Sun, 27 Apr 2008 06:41:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751397AbYD0Eky (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Apr 2008 00:40:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750844AbYD0Eky
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Apr 2008 00:40:54 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:45721 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750767AbYD0Eky (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Apr 2008 00:40:54 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Jpyh2-000781-0S; Sun, 27 Apr 2008 00:40:52 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id E27DD20FBAE; Sun, 27 Apr 2008 00:40:49 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20080427043014.GI29771@spearce.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80407>

"Shawn O. Pearce" <spearce@spearce.org> wrote:
> 
> In git being able to configure two different remotes and specifically
> pushing to the destination is very easy.  What is less easy is our
> reliance on a default named "origin" and the syntax we have for
> the remote configuration.  It is fairly simple, but new users do
> seem to struggle with it a bit.

Perhaps I should clarify this statement a bit.

I _hate_ the default remote.  One of the first things I wind up
doing is deleting it and creating a new one.  At least git-clone has
the -o flag to setup your own name, which then the tools (git-fetch
and git-push) cannot find.

Anytime I use git-fetch, git-pull or git-push I am always giving
it a remote name, or a remote name and a refspec.  So having these
tools default to 'origin' is of little to no value to me.

-- 
Shawn.

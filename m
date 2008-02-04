From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Add platform-independent .git "symlink"
Date: Sun, 3 Feb 2008 21:00:32 -0500
Message-ID: <20080204020032.GI24004@spearce.org>
References: <8c5c35580802020959v613b9e32v321e97f93f2af761@mail.gmail.com> <1201975757-13771-1-git-send-email-hjemli@gmail.com> <alpine.LSU.1.00.0802021815510.7372@racer.site> <8c5c35580802021047o41a7de9fi84a6b33f0f779e2e@mail.gmail.com> <7vwsplporv.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0802040024030.7372@racer.site> <20080204013559.GE24004@spearce.org> <7vr6fto5oe.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Lars Hjemli <hjemli@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 04 03:01:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLqdz-0006Ie-Fv
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 03:01:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754982AbYBDCAi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2008 21:00:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754971AbYBDCAi
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Feb 2008 21:00:38 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:34227 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754887AbYBDCAh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2008 21:00:37 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JLqdG-0003BT-Ht; Sun, 03 Feb 2008 21:00:26 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 77EB420FBAE; Sun,  3 Feb 2008 21:00:33 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7vr6fto5oe.fsf@gitster.siamese.dyndns.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72450>

Junio C Hamano <gitster@pobox.com> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> >
> > I would suggest a slightly different name, "GIT_DIR: ", as the
> > line prefix, because the environment variable is also GIT_DIR.
> >
> > But that's just me.
> 
> I think that was modelled after symref HEAD that would point at
> the real ref with "ref: refs/heads/master", as if you have a
> symlink whose value is "refs/heads/master".  So reusing "ref: "
> might be Ok, and saying "directory: " or "gitdir: " would be
> also Ok.
> 
> If we would want to reuse the mechanism in the future to allow
> symlink challenged systems to use it in contrib/workdir/, we may
> want to keep the name a bit more generic than "gitdir: ".

I could easily get behind "gitdir: " or "directory: ".  Both are
all lowercase, and thus look a lot like "ref: ", which already has
been in heavy use for quite some time.

But "GITDIR: " isn't very close to GIT_DIR (its environment based
sister) or "ref: " (its file based very-distant cousin).

As a bike-shed painter I like to keep colors matching when possible.

:-)

-- 
Shawn.

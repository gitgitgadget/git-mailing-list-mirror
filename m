From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Add platform-independent .git "symlink"
Date: Sun, 3 Feb 2008 20:35:59 -0500
Message-ID: <20080204013559.GE24004@spearce.org>
References: <8c5c35580802020959v613b9e32v321e97f93f2af761@mail.gmail.com> <1201975757-13771-1-git-send-email-hjemli@gmail.com> <alpine.LSU.1.00.0802021815510.7372@racer.site> <8c5c35580802021047o41a7de9fi84a6b33f0f779e2e@mail.gmail.com> <7vwsplporv.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0802040024030.7372@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Lars Hjemli <hjemli@gmail.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 04 02:36:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLqGU-00029Y-2c
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 02:36:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754355AbYBDBgJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2008 20:36:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754837AbYBDBgI
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Feb 2008 20:36:08 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:54448 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754215AbYBDBgH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2008 20:36:07 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JLqFY-0000ZV-3X; Sun, 03 Feb 2008 20:35:56 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 90CCD20FBAE; Sun,  3 Feb 2008 20:36:00 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0802040024030.7372@racer.site>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72445>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Sun, 3 Feb 2008, Junio C Hamano wrote:
> 
> > "Lars Hjemli" <hjemli@gmail.com> writes:
> > 
> > > Maybe this as a compromise?
> > >
> > > 	static char buf[PATH_MAX + 9];  /* "GITDIR: " + "\n"  */
> > > ...
> > > 	if (!len || buf[len - 1] != '\n')
> > > 		return NULL;
> > > 	buf[len - 1] = '\0';
> > > 	if (prefixcmp(buf, "GITDIR: "))
> > > 		return NULL;
> > 
> > Perhaps that is easier to read.
> > 
> > For now I haven't picked up any of the "how about this way"
> > revisions.
> 
> Yeah, I think all my comments have been addressed...  Lars, care to send a 
> new version?

I would suggest a slightly different name, "GIT_DIR: ", as the
line prefix, because the environment variable is also GIT_DIR.

But that's just me.

-- 
Shawn.

From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Tracability in git commits
Date: Wed, 30 Apr 2008 20:28:27 -0400
Message-ID: <20080501002827.GX29771@spearce.org>
References: <1209473739.5642.31.camel@dax.rpnet.com> <7vd4o873cm.fsf@gitster.siamese.dyndns.org> <46dff0320804301033k1dea34ecx863ecfa8e386e0af@mail.gmail.com> <20080430194651.GC23672@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ping Yin <pkufranky@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Richard Purdie <rpurdie@rpsys.net>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Thu May 01 02:29:32 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JrMfr-00081Q-UC
	for gcvg-git-2@gmane.org; Thu, 01 May 2008 02:29:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756259AbYEAA2g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2008 20:28:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756083AbYEAA2g
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Apr 2008 20:28:36 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:59956 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755498AbYEAA2f (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2008 20:28:35 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JrMeo-0005JF-Sl; Wed, 30 Apr 2008 20:28:19 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 5699020FBAE; Wed, 30 Apr 2008 20:28:27 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20080430194651.GC23672@genesis.frugalware.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80882>

Miklos Vajna <vmiklos@frugalware.org> wrote:
> On Thu, May 01, 2008 at 01:33:53AM +0800, Ping Yin <pkufranky@gmail.com> wrote:
> > I don't find reflog for bare repository, or must i enable it manually?
> 
> Right, reflog is disabled by default for bare repos.

`git config core.logAllRefUpdates true` right after you make the
repository solves that nicely.  I actually have a script that I use
to make a new bare central repo:

	#!/bin/sh
	git --git-dir="$1" init &&
	git --git-dir="$1" config core.logAllRefUpdates true ||
	exit

;-)

-- 
Shawn.

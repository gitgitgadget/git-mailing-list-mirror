From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Ask for "git program" even against git-daemon
Date: Wed, 25 Jun 2008 19:57:24 -0400
Message-ID: <20080625235724.GV11793@spearce.org>
References: <20080625044409.GE11793@spearce.org> <7v8wwu6qxr.fsf@gitster.siamese.dyndns.org> <7v4p7i6qs1.fsf@gitster.siamese.dyndns.org> <7vy74u5bkk.fsf@gitster.siamese.dyndns.org> <20080625053848.GJ11793@spearce.org> <7v4p7hxhbd.fsf@gitster.siamese.dyndns.org> <7vvdzxw2eo.fsf_-_@gitster.siamese.dyndns.org> <7vr6alw28s.fsf_-_@gitster.siamese.dyndns.org> <20080625232727.GU11793@spearce.org> <7viqvxw0i7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?44GX44KJ44GE44GX44Gq44Gq44GT?= <nanako3@lavabit.com>,
	Miklos Vajna <vmiklos@frugalware.org>, pclouds@gmail.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pieter de Bie <pdebie@ai.rug.nl>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 26 01:58:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBeso-0007U7-58
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 01:58:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755049AbYFYX5k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 19:57:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755127AbYFYX5k
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 19:57:40 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:53901 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751873AbYFYX5j (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 19:57:39 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.69)
	(envelope-from <spearce@spearce.org>)
	id 1KBerU-0005DR-Bj; Wed, 25 Jun 2008 19:57:16 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 25CAD20FBAE; Wed, 25 Jun 2008 19:57:25 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7viqvxw0i7.fsf@gitster.siamese.dyndns.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86377>

Junio C Hamano <gitster@pobox.com> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> >
> > But I wonder if this patch is even worth it at some later point
> > in time.  Are we also going to change git-daemon to stop accepting
> > "git-" form?  Is it a worthwhile change?
> 
> This was merely responding to...
> 
>     From: "Shawn O. Pearce" <spearce@spearce.org>
>     Subject: Re: [PATCH] Keep some git-* programs in $(bindir)
>     Date: Wed, 25 Jun 2008 00:37:41 -0400
>     Message-ID: <20080625043741.GD11793@spearce.org>
> 
>     Daniel Barkalow <barkalow@iabervon.org> wrote:
>     > ...
>     > Should they use "git upload-pack" [...]
> 
>     IMHO they should in the future use "git upload-pack".

Sorry I wasn't clear. I was talking about the SSH transport only.
For git:// we could just always send git-upload-pack, like your
transitional patch does.  Then we stay compatible with even very
old git:// servers.

-- 
Shawn.

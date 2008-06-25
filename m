From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Ask for "git program" even against git-daemon
Date: Wed, 25 Jun 2008 19:27:27 -0400
Message-ID: <20080625232727.GU11793@spearce.org>
References: <20080625034538.GW11793@spearce.org> <7vk5ge6soc.fsf@gitster.siamese.dyndns.org> <20080625044409.GE11793@spearce.org> <7v8wwu6qxr.fsf@gitster.siamese.dyndns.org> <7v4p7i6qs1.fsf@gitster.siamese.dyndns.org> <7vy74u5bkk.fsf@gitster.siamese.dyndns.org> <20080625053848.GJ11793@spearce.org> <7v4p7hxhbd.fsf@gitster.siamese.dyndns.org> <7vvdzxw2eo.fsf_-_@gitster.siamese.dyndns.org> <7vr6alw28s.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?44GX44KJ44GE44GX44Gq44Gq44GT?= <nanako3@lavabit.com>,
	Miklos Vajna <vmiklos@frugalware.org>, pclouds@gmail.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pieter de Bie <pdebie@ai.rug.nl>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 26 01:28:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBeQ0-0007wm-IS
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 01:28:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753445AbYFYX1o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 19:27:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753414AbYFYX1o
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 19:27:44 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:36651 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753293AbYFYX1n (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 19:27:43 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.69)
	(envelope-from <spearce@spearce.org>)
	id 1KBeOV-0008Pj-JQ; Wed, 25 Jun 2008 19:27:20 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 3220E20FBAE; Wed, 25 Jun 2008 19:27:28 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7vr6alw28s.fsf_-_@gitster.siamese.dyndns.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86371>

Junio C Hamano <gitster@pobox.com> wrote:
> This drops backward compatibility support to ask for "git-program"
> form when talking to git-daemon.  Now all git native requests use
> "git program" form over ssh, local and git transports.
> 
> This needs to be held back until everybody runs git-daemon from 1.5.6.1 or
> 1.6.0 or newer.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  * According to the roadmap we exchanged earlier, this should happen in a
>    major release (that increments the second dewey-decimal digit from the
>    left) that ships at least 6 months after 1.5.6.1 and 1.6.0 (which will
>    have the "git daemon preparation" patch included) are released.

Agreed about holding back.

But I wonder if this patch is even worth it at some later point
in time.  Are we also going to change git-daemon to stop accepting
"git-" form?  Is it a worthwhile change?

-- 
Shawn.

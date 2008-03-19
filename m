From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Re* git remote --mirror bug?
Date: Wed, 19 Mar 2008 00:35:42 +0000 (GMT)
Message-ID: <alpine.DEB.1.00.0803190033070.2251@eeepc-johanness>
References: <1205499956.7589.4.camel@gentoo-jocke.transmode.se> <1205604534.7589.20.camel@gentoo-jocke.transmode.se> <7v1w6bj7f9.fsf_-_@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0803181503240.3200@eeepc-johanness>
 <7v4pb37t3w.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: joakim.tjernlund@transmode.se, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 19 23:24:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jc6hx-00036K-1Q
	for gcvg-git-2@gmane.org; Wed, 19 Mar 2008 23:24:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757753AbYCSWWh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2008 18:22:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762844AbYCSWWf
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Mar 2008 18:22:35 -0400
Received: from mail.gmx.net ([213.165.64.20]:34027 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1764048AbYCSWW1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2008 18:22:27 -0400
Received: (qmail invoked by alias); 19 Mar 2008 00:35:44 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO eeepc-johanness.home) [86.138.198.40]
  by mail.gmx.net (mp005) with SMTP; 19 Mar 2008 01:35:44 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19wQ/FvP3FwD2XLmmeskbsJYfcinLs6/mWfYzjrFl
	UrJWGDtCjzQiWj
X-X-Sender: user@eeepc-johanness
In-Reply-To: <7v4pb37t3w.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77571>

Hi,

On Tue, 18 Mar 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Sun, 16 Mar 2008, Junio C Hamano wrote:
> >
> >> Joakim Tjernlund <joakim.tjernlund@transmode.se> writes:
> >> 
> >> >> git remote show os2kernel 
> >> >> * remote os2kernel
> >> >>   URL: /usr/local/src/os2kernel
> >> >> Warning: unrecognized mapping in remotes.os2kernel.fetch: +refs/*:refs/*
> >> 
> >> This is very unfortunate.
> >>
> >> [...]
> >>
> >>  builtin-check-ref-format.c |    2 +-
> >>  git-parse-remote.sh        |    9 +++++++--
> >>  remote.c                   |   16 +++++++++++++---
> >>  3 files changed, 21 insertions(+), 6 deletions(-)
> >
> > Thanks for the fix,...
> 
> As I alluded to in the message, I do not think this was a fix.

I am very sorry, as I read the mail under extreme time pressure, this must 
have slipped by.  I hope that my time management reverts to normal 
beginning tomorrow.

I looked into this issue, and I seem not to be able to reproduce with my 
current git (which is based on next).

Ciao,
Dscho

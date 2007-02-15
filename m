From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] config: read system-wide defaults from /etc/gitconfig
Date: Thu, 15 Feb 2007 13:05:13 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702151302540.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200702140909.28369.andyparkins@gmail.com> <slrnet5p5h.s9h.siprbaum@xp.machine.xx>
 <Pine.LNX.4.63.0702141246160.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45D35092.8040901@xs4all.nl> <7vr6sso8w8.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0702142015150.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vfy98o78i.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0702142049430.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v1wkshtxg.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0702151126300.448@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vvei3d5n5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: hanwen@xs4all.nl,
	Peter Baumann <siprbaum@stud.informatik.uni-erlangen.de>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Feb 15 13:05:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHfMW-0007aV-TC
	for gcvg-git@gmane.org; Thu, 15 Feb 2007 13:05:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965706AbXBOMFR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Feb 2007 07:05:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965709AbXBOMFR
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Feb 2007 07:05:17 -0500
Received: from mail.gmx.net ([213.165.64.20]:57174 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965706AbXBOMFP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Feb 2007 07:05:15 -0500
Received: (qmail invoked by alias); 15 Feb 2007 12:05:14 -0000
X-Provags-ID: V01U2FsdGVkX1/ZkdwwIdLZRVXMb7Ta0uysuNykc+Xe3rfaWSGp77
	JzXQ==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vvei3d5n5.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39824>

Hi,

On Thu, 15 Feb 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Okay for GIT_LOCAL_CONFIG. I do not remember off-hand who wanted it 
> > (Jakub? Pasky?), but it was in the context of gitweb.
> >
> > However, GIT_CONFIG is meant to parse arbitrary config files.
> > ...
> > But this "core.*" stuff is insane. Please no.
> 
> Ok, Eric's example and yours made it clear that GIT_CONFIG is an
> interface meant to reuse (or abuse) git-config to read some file
> that is not at all related to git, and should never be used by
> other plumbing.  As long as that is clear (could we have that in
> the documentation, by the way, please?), I have no problem with
> that.

I am no particularly good with documentation, but the good people who 
wanted this feature in the first place are.

> I mildly disagree with you on having an ability to disable
> /etc/gitconfig.

I'm okay either way. But I thought /etc/gitconfig was not so much like 
/etc/skel/, but more like /etc/profile.

> I've queued that insane "core.*" stuff in 'pu' and pushed out,
> but I'll drop that topic altogether.  But before doing that,
> it's past my bedtime ;-).

Hey, take it easy, now that Git "snog" is out!

Ciao,
Dscho

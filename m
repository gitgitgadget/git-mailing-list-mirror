From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add --show-touched option to show "diff --git" line when
 contents are unchanged
Date: Sun, 5 Aug 2007 20:45:54 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708052044570.14781@racer.site>
References: <vpqwswf8c1i.fsf@bauges.imag.fr> <7v4pjj5fp6.fsf@assigned-by-dhcp.cox.net>
 <vpqhcni47ek.fsf@bauges.imag.fr> <Pine.LNX.4.64.0708021050500.14781@racer.site>
 <vpqbqdq45ua.fsf@bauges.imag.fr> <Pine.LNX.4.64.0708021147110.14781@racer.site>
 <AF1190E2-A0F4-479F-B0A1-50B2C7278995@yahoo.ca> <Pine.LNX.4.64.0708021541520.14781@racer.site>
 <46B1F3F4.5030504@midwinter.com> <Pine.LNX.4.64.0708021614420.14781@racer.site>
 <20070803053717.GA16379@midwinter.com> <7v3az1qgdg.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0708031121000.14781@racer.site> <7vir7wmk84.fsf@assigned-by-dhcp.cox.net>
 <vpqps24i9sx.fsf@bauges.imag.fr> <7v1wekmgo8.fsf@assigned-by-dhcp.cox.net>
 <vpqir7wi5oc.fsf@bauges.imag.fr> <7vlkcskx5z.fsf@assigned-by-dhcp.cox.net>
 <vpqr6mhahtx.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Steven Grimm <koreth@midwinter.com>,
	Jean-Francois Veillette <jean_francois_veillette@yahoo.ca>,
	git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Sun Aug 05 21:46:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHm3c-0006QH-9K
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 21:46:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756098AbXHETq3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 15:46:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756088AbXHETq3
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 15:46:29 -0400
Received: from mail.gmx.net ([213.165.64.20]:51103 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756060AbXHETq2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2007 15:46:28 -0400
Received: (qmail invoked by alias); 05 Aug 2007 19:46:27 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp019) with SMTP; 05 Aug 2007 21:46:27 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19AOlU8TiZA+sE2JNB9zChtugRQJFsBeojI4fwGlC
	l5XAUQw+t4Lhhk
X-X-Sender: gene099@racer.site
In-Reply-To: <vpqr6mhahtx.fsf@bauges.imag.fr>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55063>

Hi,

On Sun, 5 Aug 2007, Matthieu Moy wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Matthieu Moy <Matthieu.Moy@imag.fr> writes:
> >
> >>> "git-status $args" on the other hand is a preview of "what would
> >>> happen if I say 'git-commit $args'", and in order to compute
> >>> that, you would fundamentally need to be able to write into the
> >>> object store.  In a special case of giving empty $args it can be
> >>> read-only.
> >>
> >> Can you give an example where it _could_ not be read-only?
> >
> > Think of what "git commit -a" would have to do.
> 
> I don't know whether it was a typo, but we're not talking about
> "commit", but "status".

No typo.  "git status" is literally "git commit --dry-run".  Why?  Because 
people expected it to be called "git status".

And even if I think about it over and over again, it makes sense.

Ciao,
Dscho

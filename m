From: Francis Galiegue <fg@one2team.com>
Subject: Re: [PATCH] git send-email: edit recipient addresses with the --compose flag
Date: Tue, 11 Nov 2008 12:30:27 +0100
Organization: One2team
Message-ID: <200811111230.28076.fg@one2team.com>
References: <1226235588-2997-1-git-send-email-ian.hilt@gmx.com> <alpine.LFD.2.00.0811091344480.20499@sys-0.hiltweb.site> <20081111014919.GI7408@ece.pdx.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Tait <git.git@t41t.com>
X-From: git-owner@vger.kernel.org Tue Nov 11 12:33:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzrUP-0001eY-07
	for gcvg-git-2@gmane.org; Tue, 11 Nov 2008 12:32:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755134AbYKKLbJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Nov 2008 06:31:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755797AbYKKLbJ
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Nov 2008 06:31:09 -0500
Received: from ns35774.ovh.net ([213.251.185.197]:50377 "EHLO ns35774.ovh.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755134AbYKKLbH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Nov 2008 06:31:07 -0500
Received: from smtp.olympe.o2t (138.193.65-86.rev.gaoland.net [86.65.193.138])
	by ns35774.ovh.net (Postfix) with ESMTP id 6600592C002;
	Tue, 11 Nov 2008 12:31:00 +0100 (CET)
Received: from erwin.kitchen.eel (unknown [10.8.0.6])
	by smtp.olympe.o2t (Postfix) with ESMTP id 569C97001F;
	Tue, 11 Nov 2008 12:31:05 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <20081111014919.GI7408@ece.pdx.edu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100641>

Le Tuesday 11 November 2008 02:49:19 Tait, vous avez =E9crit=A0:
> > > > +	if ($c_file =3D~ /^To:\s*+(.+)\s*\nCc:/ism) {
> > >
> > > Greedy operators are only supported with perl 5.10 or more... I t=
hink
> > > it's a bad idea to use them...
> >
> > The problem here was that a space should follow the field, but it m=
ay
> > not.  The user may unwarily backup over it.  "\s*" would match this
> > case.
> >
> > But if there is a space, it is included in the "(.+)".
>
> Not in any version of Perl to which I have access.
>

And if you see a space in (.+), your regex engine is buggy anyway.


--=20
=46rancis Galiegue
ONE2TEAM
Ing=E9nieur syst=E8me
Mob : +33 (0) 6 83 87 78 75
Tel : +33 (0) 1 78 94 55 52
fge@one2team.com
40 avenue Raymond Poincar=E9
75116 Paris

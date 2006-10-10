From: Edesio Costa e Silva <edesio@softaplic.com.br>
Subject: Re: Approxidate licensing
Date: Tue, 10 Oct 2006 15:33:25 -0300
Message-ID: <20061010183325.GC12993@softaplic.com.br>
References: <Pine.LNX.4.64.0610101246241.9789@iabervon.org> <1073a5540610101128q3fb9f68fsf3a28fbda20927d1@mail.gmail.com>
Reply-To: Edesio Costa e Silva <edesio@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Edesio Costa e Silva <edesio@task.com.br>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 10 20:33:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXMQ8-00063l-22
	for gcvg-git@gmane.org; Tue, 10 Oct 2006 20:33:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965093AbWJJSdg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 10 Oct 2006 14:33:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965094AbWJJSdg
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Oct 2006 14:33:36 -0400
Received: from master.softaplic.com.br ([200.162.94.241]:33991 "EHLO
	overlord.softaplic.com.br") by vger.kernel.org with ESMTP
	id S965093AbWJJSdf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Oct 2006 14:33:35 -0400
Received: from edesio by overlord.softaplic.com.br with local (Exim 4.50)
	id 1GXMPt-0004lV-Cj; Tue, 10 Oct 2006 15:33:25 -0300
To: barkalow@iabervon.org
Content-Disposition: inline
In-Reply-To: <1073a5540610101128q3fb9f68fsf3a28fbda20927d1@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28651>

Try the TCL modules that parse date and time (tclGetDate.y and
tclClock.c). They are licensed BSD style.

Ed=E9sio

> From: Daniel Barkalow <barkalow@iabervon.org>
> Date: Oct 10, 2006 2:39 PM
> Subject: Approxidate licensing
> To: Linus Torvalds <torvalds@osdl.org>, Junio C Hamano
> <junkio@cox.net>, dwmw2@infradead.org
> Cc: git@vger.kernel.org
>=20
>=20
> I'm working on an LGPL project (for my company; it's obscure enough a=
nd
> we're lazy enough that we're not really distributing it in general in
> either source or binary form), and I'm running into the usual date pa=
rsing
> issue (i.e., all the standard functions are broken in various ways). =
My
> plan has been to write my own, but it's hard to get the motivation wh=
en
> approxidate exists, works well, and is open source.
>=20
> Would the three of you agree to license date.c under the LGPL or BSD?=
 It
> looks like you're the only authors of non-trivial changes [1]. And it=
 seems
> reasonable to want the date parsing thing under non-GPL terms outside=
 of
> git.
>=20
>        -Daniel
> *This .sig left intentionally blank*
>=20
> [1] git log and git blame are pretty impressive, but they don't quite
> catch that most of date.c was written by David as part of commit-tree=
=2Ec,
> then Tony replaced it with a version that uses curl, then Edgar separ=
ated
> it out into a date.c and simultaneously reverted Tony's changes. On t=
he
> other hand, the commit messages do say this, and you can use git log =
and
> git blame to verify that they're true. The only thing they don't let
> you verify is what the differences are between the date.c added in
> ecee9d9e and the similar part of commit-tree.c in 812666c8. If someon=
e
> wants to make git blame *really* magic, date.c would be a good test c=
ase.
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

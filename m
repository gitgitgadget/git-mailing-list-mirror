From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: Finding all branches(remote and local) include given commit?
Date: Sat, 12 May 2012 14:48:39 +0200
Message-ID: <1336826919.3002.18.camel@centaur.lab.cmartin.tk>
References: <CAFT+Tg9nJZ7E3FB3nA6+_TR=KUqu80128rL8b2DuRGtBavsj-Q@mail.gmail.com>
	 <1336824434.3002.17.camel@centaur.lab.cmartin.tk>
	 <CAFT+Tg-cYCatcaP3fR7X7+GnpazUb3ys96A5AP6HTjvD_=+UyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: semtlenori@gmail.com
X-From: git-owner@vger.kernel.org Sat May 12 14:49:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1STBl5-0007cO-Dj
	for gcvg-git-2@plane.gmane.org; Sat, 12 May 2012 14:49:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755636Ab2ELMtF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 May 2012 08:49:05 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:38935 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754383Ab2ELMsh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 May 2012 08:48:37 -0400
Received: from [192.168.1.3] (brln-4d0c2fce.pool.mediaWays.net [77.12.47.206])
	by kimmy.cmartin.tk (Postfix) with ESMTPSA id 95B7546051;
	Sat, 12 May 2012 14:48:27 +0200 (CEST)
In-Reply-To: <CAFT+Tg-cYCatcaP3fR7X7+GnpazUb3ys96A5AP6HTjvD_=+UyQ@mail.gmail.com>
X-Mailer: Evolution 3.2.2-1+b1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197732>

On Sat, 2012-05-12 at 21:25 +0900, Yi, EungJun wrote:
> Wow, I should do like this:
>=20
> $ git branch -a --contains 499e7b31509cfbb59dcb2a046f8e2fd1a3e73d6f
> * master
>   remotes/origin/HEAD -> origin/master
>   remotes/origin/master
>   remotes/origin/next
>   remotes/origin/pu
>=20
> git-branch has '-a' but not '-all', and git-remote has '--all' but no=
t '-a'.

The branch command has had long-form since 1.7.8

>=20
> This is a bit confusing for me. Why don't the two commands have the
> option under the same name?
>=20
>=20
> 2012/5/12 Carlos Mart=C3=ADn Nieto <cmn@elego.de>:
> > On Sat, 2012-05-12 at 20:42 +0900, Yi, EungJun wrote:
> >> Is there any way to find remote and local branches include given c=
ommit?
> >>
> >> e.g.
> >>
> >> $ git branch --all --contains 499e7b31509cfbb59dcb2a046f8e2fd1a3e7=
3d6f
> >> * master
> >>   remotes/origin/next
> >>
> >> As you know, it does not work and "git branch --contains" finds on=
ly
> >> local branches.
> >
> > Works For Me. What version are you trying it with? Are you sure tha=
t
> > remote-tracking branches do contain that commit?
> >
> > From a quick look through the log and release notes, it was never
> > mentioned as a fix. The log contains 3f7701a4 from 2007 which fixes=
 'git
> > describe --all --contains' which, though unlikely, might be related=
=2E
> > This commit was however part of release 1.5.4, which makes it unlik=
ely
> > you'd be using something older.
> >
> >   cmn
> >
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

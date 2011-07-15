From: "J. Bakshi" <joydeep@infoservices.in>
Subject: Re: git with detached worktrees , push has no effect
Date: Fri, 15 Jul 2011 10:56:40 +0530
Message-ID: <20110715105640.694fb3ea@shiva.selfip.org>
References: <20110714181019.2453e3a8@shiva.selfip.org>
 <1310647767.6041.73.camel@centaur.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Carlos =?UTF-8?B?TWFydMOtbg==?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Fri Jul 15 07:26:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QhavF-0006Le-UV
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jul 2011 07:26:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752827Ab1GOF0l convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Jul 2011 01:26:41 -0400
Received: from static.206.87.46.78.clients.your-server.de ([78.46.87.206]:40354
	"EHLO Kolkata.infoservices.in" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750868Ab1GOF0k convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jul 2011 01:26:40 -0400
Received: from shiva.selfip.org (unknown [122.176.30.116])
	by Kolkata.infoservices.in (Postfix) with ESMTPSA id 0D8463804001;
	Fri, 15 Jul 2011 07:26:37 +0200 (CEST)
In-Reply-To: <1310647767.6041.73.camel@centaur.lab.cmartin.tk>
X-Mailer: Claws Mail 3.7.9 (GTK+ 2.24.4; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177190>

On Thu, 14 Jul 2011 14:49:27 +0200
Carlos Mart=C3=ADn Nieto <cmn@elego.de> wrote:

> On Thu, 2011-07-14 at 18:10 +0530, J. Bakshi wrote:
> [...] snip snip snip
> > warning: You appear to have cloned an empty repository.
> >=20
> >  touch A
> >  git add A
> >=20
> >  git commit -m "add A"
> >=20
> > [master (root-commit) 7662edd] add A
> >  0 files changed, 0 insertions(+), 0 deletions(-)
> >  create mode 100644 A
> >=20
> >  git push
> >  Username:
> >  Password:
> >  Everything up-to-date
> >=20
> >=20
> > Why reports  [Everything up-to-date] rather than modify the remote =
git ?
>=20
> That's because your remote repository has no branches and per default
> git-push will only push matching branches; as no branches match, ther=
e
> is nothing to do. This is what "warning: You appear to have cloned an
> empty repository." is trying to tell you (the message could certainly=
 be
> made much more friendly). Your master branch in this case doesn't exi=
st
> in the server, so you have to tell git to push it explicitly.
>=20
>     git push origin master
>=20
> will do the trick.
>=20

Great !!

Working like a charm and the hook is also working fine. Can we make the=
=20
empty master branch at the server, so that client can continue with pla=
in "git push" ?

Thanks

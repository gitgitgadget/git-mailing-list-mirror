From: Enrico Weigelt <weigelt@metux.de>
Subject: Re: mirroring and development with three levels of repositories?
Date: Tue, 28 Sep 2010 20:41:18 +0200
Message-ID: <20100928184116.GA27401@nibiru.local>
References: <AANLkTinFiOA6Grzk16W2D=k8Xt+EgTanrS7iryW2evop@mail.gmail.com> <20100928173710.GA31419@nibiru.local> <AANLkTin2UPUPn5Sr=7dqT5bxFB7a-BYFzJhGV74r6taF@mail.gmail.com>
Reply-To: weigelt@metux.de
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 28 20:45:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0fAs-0000mW-0f
	for gcvg-git-2@lo.gmane.org; Tue, 28 Sep 2010 20:45:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757726Ab0I1SpD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Sep 2010 14:45:03 -0400
Received: from caprica.metux.de ([82.165.128.25]:45537 "EHLO
	mailgate.caprica.metux.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756015Ab0I1SpB convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Sep 2010 14:45:01 -0400
Received: from mailgate.caprica.metux.de (localhost.localdomain [127.0.0.1])
	by mailgate.caprica.metux.de (8.14.4/8.14.4) with ESMTP id o8SIjqLJ022914
	for <git@vger.kernel.org>; Tue, 28 Sep 2010 20:45:54 +0200
Received: (from uucp@localhost)
	by mailgate.caprica.metux.de (8.14.4/8.14.4/Submit) with UUCP id o8SIjIDd022901
	for git@vger.kernel.org; Tue, 28 Sep 2010 20:45:18 +0200
Received: (from weigelt@localhost)
	by nibiru.metux.de (8.12.10/8.12.10) id o8SIfIRa018433
	for git@vger.kernel.org; Tue, 28 Sep 2010 20:41:18 +0200
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <AANLkTin2UPUPn5Sr=7dqT5bxFB7a-BYFzJhGV74r6taF@mail.gmail.com>
User-Agent: Mutt/1.4.1i
X-Terror: bin laden, kill bush, Briefbombe, Massenvernichtung, KZ, 
X-Nazi: Weisse Rasse, Hitlers Wiederauferstehung, 42, 
X-Antichrist: weg mit schaeuble, ausrotten, heiliger krieg, al quaida, 
X-Killer: 23, endloesung, Weltuntergang, 
X-Doof: wer das liest ist doof
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157457>

* John Clemens <clemej@gmail.com> wrote:
> > [remote "origin"]
> > =A0 =A0url =3D ...
> > =A0 =A0fetch =3D +refs/heads/*:refs/heads/origin/*
> > =A0 =A0fetch =3D +refs/tags/*:refs/tags/origin/*
>=20
> Hmm.. I do actually see the branches on dev machine.  When I clone fr=
om our
> local mirror, everything works fine UNTIL I create a new branch and p=
ush it
> to our local mirror.  From that moment on, all new clones fail (more =
precisely,
> they do download all the blobs, but the refs only point to the newly =
created
> branches, and HEAD is messed up.
>=20
> config on the local mirror is this:
>=20
> [remote "origin"]
>         fetch =3D +refs/*:refs/*
>         mirror =3D true
>         url =3D xxx

Ah, maybe it corrupts refs/HEAD somehow ? What does it point to ?

Perhaps you better don't fetch the whole refs/* but refs/heads/* and
refs/tags/* namespaces separately (as described above).

> On the local mirror, HEAD is:
> ref: refs/heads/xxx/stable

Does that ref exist there ?=20
What does it tell on the upstream (big central) repo ?


cu
--=20
----------------------------------------------------------------------
 Enrico Weigelt, metux IT service -- http://www.metux.de/

 phone:  +49 36207 519931  email: weigelt@metux.de
 mobile: +49 151 27565287  icq:   210169427         skype: nekrad666
----------------------------------------------------------------------
 Embedded-Linux / Portierung / Opensource-QM / Verteilte Systeme
----------------------------------------------------------------------

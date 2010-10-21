From: Enrico Weigelt <weigelt@metux.de>
Subject: Re: GIT as binary repository
Date: Thu, 21 Oct 2010 21:54:16 +0200
Message-ID: <20101021195416.GF28700@nibiru.local>
References: <2EBB46ACFCD6CF48B45E2B1865BD02338037D36B4E@GVW1098EXB.americas.hpqcorp.net> <AANLkTim6qsUDf5LS7C9o+C92Aqh7CohLLJ=+13BE3Tze@mail.gmail.com>
Reply-To: weigelt@metux.de
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 21 22:03:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P91MR-0003zL-6t
	for gcvg-git-2@lo.gmane.org; Thu, 21 Oct 2010 22:03:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754303Ab0JUUDd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 Oct 2010 16:03:33 -0400
Received: from caprica.metux.de ([82.165.128.25]:46475 "EHLO
	mailgate.caprica.metux.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751441Ab0JUUDc convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Oct 2010 16:03:32 -0400
Received: from mailgate.caprica.metux.de (localhost.localdomain [127.0.0.1])
	by mailgate.caprica.metux.de (8.14.4/8.14.4) with ESMTP id o9LK4vMu024914
	for <git@vger.kernel.org>; Thu, 21 Oct 2010 22:05:00 +0200
Received: (from uucp@localhost)
	by mailgate.caprica.metux.de (8.14.4/8.14.4/Submit) with UUCP id o9LK4AX6024855
	for git@vger.kernel.org; Thu, 21 Oct 2010 22:04:10 +0200
Received: (from weigelt@localhost)
	by nibiru.metux.de (8.12.10/8.12.10) id o9LJsGfs027634
	for git@vger.kernel.org; Thu, 21 Oct 2010 21:54:16 +0200
Mail-Followup-To: "git@vger.kernel.org" <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <AANLkTim6qsUDf5LS7C9o+C92Aqh7CohLLJ=+13BE3Tze@mail.gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159556>

* Tay Ray Chuan <rctay89@gmail.com> wrote:
> Hi,
>=20
> On Thu, Oct 21, 2010 at 8:52 PM, Wilson, Kevin Lee (OpenView Engineer=
)
> <kevin.l.wilson@hp.com> wrote:
> > We are investigating the use of GIT as a binary repository solution=
=2E Our larger files are near 800MB and the total checked out repo size=
 is about 3 GB the repo size in SVN is more like 20-30GB, if we could p=
rune the history prior to MR, we could get these sizes down considerabl=
y. This binary repo is really for our super project build. =A0From what=
 I have read and learned, this is not a good fit for the GIT tool. Have=
 there been performance improvements lately? Some of the posts I have r=
ead have been quite old?
>=20
> check this out:
>=20
>   http://github.com/apenwarr/bup
>=20
> It's a modified git system that's purpose-built for large files.
> That's just about all the sensible information I can share you with
> you.

Looks quite promising, perhaps it can help solving my current
backup problems.

Maybe we could implement some of the features, eg. the hashsplit
format (maybe it could even combined w/ xdelta ?) or the bupindex
and some extended metadata directly in git ?


BTW: how are the current tree objects structured ? Is there always
one big tree object representing the whole tree or can it be
splitted hierachically ?


cu
--=20
----------------------------------------------------------------------
 Enrico Weigelt, metux IT service -- http://www.metux.de/

 phone:  +49 36207 519931  email: weigelt@metux.de
 mobile: +49 151 27565287  icq:   210169427         skype: nekrad666
----------------------------------------------------------------------
 Embedded-Linux / Portierung / Opensource-QM / Verteilte Systeme
----------------------------------------------------------------------

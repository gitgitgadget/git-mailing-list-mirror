From: Enrico Weigelt <weigelt@metux.de>
Subject: Re: Massive repository corruptions
Date: Tue, 13 Jul 2010 12:22:45 +0200
Message-ID: <20100713102245.GE29392@nibiru.local>
References: <20100713015600.GA29392@nibiru.local> <AANLkTilXQ3VgPjihf0pjt4QPN-nCjwAWyHwoosLMeRpH@mail.gmail.com> <20100713050350.GB29392@nibiru.local> <AANLkTimQPv5MhLo4wwVTt2LiaWxqWwoYykEbz3wBS-OY@mail.gmail.com>
Reply-To: weigelt@metux.de
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 13 12:30:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYckf-0006ql-B1
	for gcvg-git-2@lo.gmane.org; Tue, 13 Jul 2010 12:30:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754936Ab0GMKaG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Jul 2010 06:30:06 -0400
Received: from forum.psychotherapie.org ([217.160.22.205]:49950 "EHLO
	s15216962.onlinehome-server.info" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752126Ab0GMKaE convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jul 2010 06:30:04 -0400
Received: (from uucp@localhost)
	by s15216962.onlinehome-server.info (8.13.3/8.13.3) with UUCP id o6DAU0B7025978
	for git@vger.kernel.org; Tue, 13 Jul 2010 12:30:00 +0200
Received: (from weigelt@localhost)
	by nibiru.metux.de (8.12.10/8.12.10) id o6DAMjmY016825
	for git@vger.kernel.org; Tue, 13 Jul 2010 12:22:45 +0200
Content-Disposition: inline
In-Reply-To: <AANLkTimQPv5MhLo4wwVTt2LiaWxqWwoYykEbz3wBS-OY@mail.gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150895>

* Avery Pennarun <apenwarr@gmail.com> wrote:
> On Tue, Jul 13, 2010 at 1:03 AM, Enrico Weigelt <weigelt@metux.de> wr=
ote:
> > * Avery Pennarun <apenwarr@gmail.com> wrote:
> >> Do you know which packfiles are corrupted? =A0Does 'git index-pack=
' on
> >> the files reveal anything?
> >
> > git@blackwidow ~/metux/work.git/pack $ git index-pack pack-3b6cbd5d=
c5f54cf390cfaa479cac6a99d7401375.pack
> > error: inflate: data stream error (incorrect data check)
> > fatal: pack has bad object at offset 37075832: inflate returned -3
> >
> > (that's essentially the same git-gc says)
>=20
> What's the size of that .pack file?

Somewhat over 300MB.=20

Lowering the packfile size seemed to help.
(but I still only can do that for git-repack, not remote transfers)


cu
--=20
----------------------------------------------------------------------
 Enrico Weigelt, metux IT service -- http://www.metux.de/

 phone:  +49 36207 519931  email: weigelt@metux.de
 mobile: +49 151 27565287  icq:   210169427         skype: nekrad666
----------------------------------------------------------------------
 Embedded-Linux / Portierung / Opensource-QM / Verteilte Systeme
----------------------------------------------------------------------

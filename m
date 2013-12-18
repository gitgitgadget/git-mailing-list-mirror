From: "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: I have end-of-lifed cvsps
Date: Tue, 17 Dec 2013 19:21:22 -0500
Organization: Eric Conspiracy Secret Labs
Message-ID: <20131218002122.GA20152@thyrsus.com>
References: <20131212001738.996EB38055C@snark.thyrsus.com>
 <CACPiFCK+Z7dOfO2v29PMKz+Y_fH1++xqMuTquSQ84d8KyjjFeQ@mail.gmail.com>
 <20131212042624.GB8909@thyrsus.com>
 <CACPiFC+bopf32cgDcQcVpL5vW=3KxmSP8Oh1see4KduQ1BNcPw@mail.gmail.com>
 <52B02DFF.5010408@gmail.com>
 <20131217140746.GB15010@thyrsus.com>
 <CANQwDwe8AcbCYG5GZcY1tn9BN0x5KWux_CNQY2OWG+qZJ5rS4Q@mail.gmail.com>
 <20131217210255.GA18217@thyrsus.com>
 <CANQwDwdQZGhR=hhFHe7wRAeNej_F5fHspN7+f-LiJu06utwC-w@mail.gmail.com>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 18 01:21:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vt4tE-0005p9-BH
	for gcvg-git-2@plane.gmane.org; Wed, 18 Dec 2013 01:21:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751853Ab3LRAVY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Dec 2013 19:21:24 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:37669
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751553Ab3LRAVX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Dec 2013 19:21:23 -0500
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id 096BF380868; Tue, 17 Dec 2013 19:21:22 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <CANQwDwdQZGhR=hhFHe7wRAeNej_F5fHspN7+f-LiJu06utwC-w@mail.gmail.com>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239416>

Jakub Nar=C4=99bski <jnareb@gmail.com>:
> > No, cvs-fast-export does not have --export-marks. It doesn't genera=
te the
> > SHA1s that would require. Even if it did, it's not clear how that w=
ould help.
>=20
> I was thinking about how the following part of git-fast-export
> `--import-marks=3D<file>`
>=20
>   Any commits that have already been marked will not be exported agai=
n.
>   If the backend uses a similar --import-marks file, this allows for =
incremental
>   bidirectional exporting of the repository by keeping the marks the =
same
>   across runs.

I understand that. But it's not relevant - cvs-fast-import doesn't know=
 about
git SHA1s, and cannot.
=20
> How cvs-fast-export know where to start exporting from in incremental=
 mode?

You give it a cutoff date. This is the same way cvsps-2.x and 3.x worke=
d,
and it's what the cvsimport wrapper expects to pass down.

> BTW. does cvs-fast-export support incremental *output*, or does it
> perform also incremental *work*?

As I tried to explain previously in my response to John Herland, it's
incremental output only.  There is *no* CVS exporter known to me, or
him, that supports incremental work.  That would be at best be impracti=
cally
difficult; given CVS's limitations it may be actually impossible. I wou=
ldn't
bet against impossible.

> Anyway, that might mean that generic fast-import stream based increme=
ntal
> (i.e. supporting proper thin fetch) remote helper is out of question,=
 perhaps
> writing one for cvs / cvs-fe would bring incremental import from CVS =
to
> git?

Sorry, I don't understand that.
--=20
		<a href=3D"http://www.catb.org/~esr/">Eric S. Raymond</a>

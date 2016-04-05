From: Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
Subject: Re: [RFC/PATCH] git.spec: fix changelog dates
Date: Tue, 5 Apr 2016 16:17:22 +0200 (CEST)
Message-ID: <746021769.2985589.1459865842453.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <6ef7d9d87f0c14147267c44e8b382f988936875b.1459858117.git.git@drmicha.warpmail.net> <833355852.2977267.1459859316816.JavaMail.zimbra@ensimag.grenoble-inp.fr> <5703C084.1040405@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Apr 05 16:13:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anRjk-0007KG-7M
	for gcvg-git-2@plane.gmane.org; Tue, 05 Apr 2016 16:13:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759120AbcDEONj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Apr 2016 10:13:39 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:33997 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756517AbcDEONi convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 5 Apr 2016 10:13:38 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id CBC03216E;
	Tue,  5 Apr 2016 16:13:34 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Nwrnfv7mqvy7; Tue,  5 Apr 2016 16:13:34 +0200 (CEST)
Received: from zm-int-mbx1.grenet.fr (zm-int-mbx1.grenet.fr [130.190.242.140])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id B5636215B;
	Tue,  5 Apr 2016 16:13:34 +0200 (CEST)
In-Reply-To: <5703C084.1040405@drmicha.warpmail.net>
X-Originating-IP: [130.190.242.137]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF39 (Linux)/8.0.9_GA_6191)
Thread-Topic: git.spec: fix changelog dates
Thread-Index: bxv7dg6HzYuo7NdJBc2XkTSNecmcrA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290781>

Michael J Gruber <git@drmicha.warpmail.net> wrote:
> Remi Galan Alfonso venit, vidit, dixit 05.04.2016 14:28:
> > Michael J Gruber <git@drmicha.warpmail.net> wrote:
> >> A few changelog entries have inconsistent dates, which rpmlint rep=
orts
> >> as errors.
> >>
> >> Fix them based on these assumptions:
> >> - It's easier to mistype a number than a weekday abbreviation.
> >> - changelog date must be before git commit date
> >> - The mistyped date is just a few days off.
> >>
> >> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> >> ---
> >> I dunno if this is worthwhile, but rpmlint is the first thing we t=
ell
> >> packagers and reviewers to check.
> >>
> >>  git.spec.in | 8 ++++----
> >>  1 file changed, 4 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/git.spec.in b/git.spec.in
> >> index bfd1cfb..eb581a3 100644
> >> --- a/git.spec.in
> >> +++ b/git.spec.in
> >> @@ -229,7 +229,7 @@ rm -rf $RPM_BUILD_ROOT
> >>  * Sat Jan 30 2010 Junio C Hamano <gitster@pobox.com>
> >>  - We don't ship Python bits until a real foreign scm interface co=
mes.
> >> =20
> >> -* Mon Feb 04 2009 David J. Mellor <dmellor@whistlingcat.com>
> >> +* Mon Feb 02 2009 David J. Mellor <dmellor@whistlingcat.com>
> >>  - fixed broken git help -w after renaming the git-core package to=
 git.
> >> =20
> >>  * Fri Sep 12 2008 Quy Tonthat <qtonthat@gmail.com>
> >> @@ -262,7 +262,7 @@ rm -rf $RPM_BUILD_ROOT
> >>  * Thu Jun 21 2007 Shawn O. Pearce <spearce@spearce.org>
> >>  - Added documentation files for git-gui
> >> =20
> >> -* Tue May 13 2007 Quy Tonthat <qtonthat@gmail.com>
> >> +* Sun May 13 2007 Quy Tonthat <qtonthat@gmail.com>
> >
> > It is inconsistent with what you said in the commit message ("It's
> > easier to mistype a number than a weekday abbreviation.").
> >
> > Following that logic, it should be:
> >         * Tue May 15 2007 Quy Tonthat <qtonthat@gmail.com>
> >
> > (or 08, I didn't check the condition "changelog date must be before
> > git commit date")
>=20
> I did.
>=20
> The thing is that you can't always fulfill all of these 3 conditions.
> "Easier" doesn't mean that the other case is impossible, just less li=
kely.

Ah alright. Makes sense then, it is much harder to mistype 13 from 08
than from 15.

Sorry for the noise.

Thanks,
R=C3=A9mi

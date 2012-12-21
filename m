From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: RE: Python version auditing followup
Date: Fri, 21 Dec 2012 08:26:52 +0100
Message-ID: <000d01cddf4c$8cbf2ca0$a63d85e0$@schmitz-digital.de>
References: <20121220143411.BEA0744105@snark.thyrsus.com> <7vobho60fs.fsf@alter.siamese.dyndns.org> <kb001v$vps$1@ger.gmane.org> <7vzk182yka.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "'Junio C Hamano'" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 21 08:27:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tlx0w-0007sT-Sn
	for gcvg-git-2@plane.gmane.org; Fri, 21 Dec 2012 08:27:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750868Ab2LUH1J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2012 02:27:09 -0500
Received: from moutng.kundenserver.de ([212.227.126.171]:63152 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750740Ab2LUH1G (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Dec 2012 02:27:06 -0500
Received: from DualCore (dsdf-4d0a157e.pool.mediaWays.net [77.10.21.126])
	by mrelayeu.kundenserver.de (node=mreu0) with ESMTP (Nemesis)
	id 0MgJSU-1TPTub2Taw-00NrPL; Fri, 21 Dec 2012 08:27:03 +0100
In-Reply-To: <7vzk182yka.fsf@alter.siamese.dyndns.org>
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQGJcJ0OStfQbsM1tIQ7oyx+MGbnCwL3z68DAeXO9zcB00FfDph2LEBg
Content-Language: de
X-Provags-ID: V02:K0:YuRbBGuL0xVOgkvauF8eEB39HjbNjCFppaEcHg6enVt
 HFzi06PVZRIqrDZK26QNFb19zvA+h0PwJkqZjihbnmofr638T0
 zs5wRG3E1SYzka5XMUWCIQFI5/cm6oRVgBhxgW7BCkLfzuHM67
 bMC64PkM+5HZ8HudpmCz29JE4SBAq774OSYfJFZtGUtEZ8V0ac
 iUBKJszX7LsDPuURDV6fbskiRJR07g9KVpvPbUFKFOQg/pFmWu
 0PaUjzq9VaY7ID74lHV5d5uwFu8U5jCqWyW/sQAKqQfl2G2ltc
 fkSpomPlSOAF9j+5Yg3CPGm99fTOPrbPb38vpwtw4i1jc6mOwN
 zmFotryjd/Sj7O2RpHS+MkFB1wj3q2dUX5O4wcs0R9HUSB7zCa
 J2e8iX0tcEy4A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211954>

> From: Junio C Hamano [mailto:gitster@pobox.com]
> Sent: Thursday, December 20, 2012 10:39 PM
> To: Joachim Schmitz
> Cc: git@vger.kernel.org
> Subject: Re: Python version auditing followup
> 
> "Joachim Schmitz" <jojo@schmitz-digital.de> writes:
> 
> > Junio C Hamano wrote:
> >> I personally would think 2.6 is recent enough.  Which platforms that
> >> are long-term-maintained by their vendors still pin their Python at
> >> 2.4.X?  2.4.6 was in 2008 that was source only, 2.4.4 was in late
> >> 2006 that was the last 2.4 with binary release.
> >>
> >> Objections?  Comments?
> >
> > We have a working 2.4.2 for HP-NonStop and some major problems getting
> > 2.7.3 to work.
> 
> I do not think a platform that stops at 2.4.2 instead of going to
> higher 2.4.X series deserves to be called "long term maintained by
> their vendors".  It sounds more like "attempted to supply 2.4.X and
> abandoned the users once one port was done" to me.

Well, not entirely wrong, but not all true at too.
I guess I need to defend the vendor here: It is not really the Vendor (HP) that provided Python 2.4.2 or tries to provide 2.7.3, it
is a volunteer and community effort. HP did sponsor the 2.4.2 port though (by allowing an HP employee to do the port inn his regular
working hours). It is not doing this any longer (since 2007). Since then it is a small group doing this on a purely voluntary basis
in their spare time (one HP employee amongst them, me).
Same goes for the git port BTW. And for every other port provided on http://ituglib.connect-cummunity.org (this machine is sponsored
by HP).
Almost every other port, as some pretty recently made it into the officially supported O/S version, so far: Samba, bash, coreutils,
vim, gzip, bzip2, Perl, PHP.

Bye, Jojo

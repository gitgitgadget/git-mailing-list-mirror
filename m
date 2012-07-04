From: Brian Foster <brian.foster@maxim-ic.com>
Subject: Re: [Q] Branch aliases (synonyms)?
Date: Wed, 4 Jul 2012 09:31:40 +0200
Message-ID: <4417201.NtYkVMYjv0@laclwks004>
References: <1919214.YKUdgul2iY@laclwks004> <4261222.bYBuBBxnOa@laclwks004> <4FF30FD6.6020501@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Hallvard Breien Furuseth <h.b.furuseth@usit.uio.no>,
	git mailing list <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Jul 04 09:31:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SmK3y-000713-Kj
	for gcvg-git-2@plane.gmane.org; Wed, 04 Jul 2012 09:31:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932097Ab2GDHbq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Jul 2012 03:31:46 -0400
Received: from antispam01.maxim-ic.com ([205.153.101.182]:60464 "EHLO
	antispam01.maxim-ic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752000Ab2GDHbp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Jul 2012 03:31:45 -0400
X-ASG-Debug-ID: 1341387104-02ae985855284140001-QuoKaX
Received: from maxdalex02.maxim-ic.internal (maxdalex02.maxim-ic.internal [10.16.15.104]) by antispam01.maxim-ic.com with ESMTP id AFNGFh2mmCSO90ML; Wed, 04 Jul 2012 02:31:44 -0500 (CDT)
X-Barracuda-Envelope-From: brian.foster@maxim-ic.com
Received: from maxsvlex02.maxim-ic.internal (10.32.112.18) by
 maxdalex02.maxim-ic.internal (10.16.15.104) with Microsoft SMTP Server (TLS)
 id 8.3.192.1; Wed, 4 Jul 2012 02:31:43 -0500
Received: from laclwks004.localnet (10.201.0.45) by
 maxsvlex02.maxim-ic.internal (10.32.112.18) with Microsoft SMTP Server (TLS)
 id 8.3.192.1; Wed, 4 Jul 2012 00:31:42 -0700
X-ASG-Orig-Subj: Re: [Q] Branch aliases (synonyms)?
User-Agent: KMail/4.7.3 (Linux/3.0.0-22-generic; KDE/4.7.4; x86_64; ; )
In-Reply-To: <4FF30FD6.6020501@alum.mit.edu>
X-Barracuda-Connect: maxdalex02.maxim-ic.internal[10.16.15.104]
X-Barracuda-Start-Time: 1341387104
X-Barracuda-URL: http://AntiSpam02.maxim-ic.com:8000/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at maxim-ic.com
X-Barracuda-Spam-Score: 0.12
X-Barracuda-Spam-Status: No, SCORE=0.12 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=5.0 tests=CN_BODY_332
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.2.101708
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.12 CN_BODY_332            BODY: CN_BODY_332
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200994>

On Tuesday 03-July-2012 08:29:26 Michael Haggerty wrote:
> On 07/03/2012 03:40 PM, Brian Foster wrote:
> > On Tuesday 03-July-2012 05:23:29 Hallvard Breien Furuseth wrote:
> >>              E.g. if it's hard to teach developers to switch
> >>   from B to A, a hook which rejects pushes to B might help.
> >
> >   Whilst we _may_ have problems with some of the
> >   internal developers [...], the concern is about the
> >   external users (clients who clone but never push)
> >   becoming confused.  Hence the requirement about
> >   continuing to use the same branch name as you are
> >   used to using.  That's it!  It's that simple.
>=20
> Maybe create a new branch B (an orphan commit unconnected
> to the old branch B) with a single README file telling the
> person that from now on they should be using branch A.

 Hum....  This idea, at first glance, looks
 extremely intriguing (with, perhaps, the minor
 tweak there is also a =E2=80=98Makefile=E2=80=99 which shows
 the =E2=80=98READ_ME=E2=80=99 and then always =E2=80=9Cfails=E2=80=9D =
 =E2=80=94  That
 would fit better into how the overall system
 works / is typically used).  I will run it by
 my colleagues, and if they think it can fly,
 will try some tests.  Many Thanks!

cheers!
	-blf-
--=20
Brian Foster
Principal MTS, Software        |  La Ciotat, France
Maxim Integrated Products      |  Web:  http://www.maxim-ic.com/

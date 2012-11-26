From: Thorsten Glaser <tg@debian.org>
Subject: Re: Multiple threads of compression
Date: Mon, 26 Nov 2012 09:59:55 +0000 (UTC)
Message-ID: <Pine.BSM.4.64L.1211260956460.27253@herc.mirbsd.org>
References: <loom.20121125T171702-64@post.gmane.org>
 <CA+sFfMerMWnJwiBz0=MxO0gn8B2M8g12mt5VzZaRj591oMPVow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 26 11:17:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TcvlC-0001zM-MJ
	for gcvg-git-2@plane.gmane.org; Mon, 26 Nov 2012 11:17:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754131Ab2KZKRj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Nov 2012 05:17:39 -0500
Received: from static-87-79-237-121.netcologne.de ([87.79.237.121]:25879 "EHLO
	herc.mirbsd.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753671Ab2KZKRj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Nov 2012 05:17:39 -0500
X-Greylist: delayed 703 seconds by postgrey-1.27 at vger.kernel.org; Mon, 26 Nov 2012 05:17:38 EST
Received: from herc.mirbsd.org (tg@herc.mirbsd.org [192.168.0.82])
	by herc.mirbsd.org (8.14.5/8.14.5) with ESMTP id qAQ9xu59023926
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 26 Nov 2012 09:59:59 GMT
X-X-Sender: tg@herc.mirbsd.org
In-Reply-To: <CA+sFfMerMWnJwiBz0=MxO0gn8B2M8g12mt5VzZaRj591oMPVow@mail.gmail.com>
X-Message-Flag: Your mailer is broken. Get an update at http://www.washington.edu/pine/getpine/pcpine.html for free.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210427>

Brandon Casey dixit:

>The number of threads that pack uses can be configured in the global
>or system gitconfig file by setting pack.threads.
[=E2=80=A6]
>The other setting you should probably look at is pack.windowMemory
>which should help you control the amount of memory git uses while
>packing.  Also look at core.packedGitWindowSize and
>core.packedGitLimit if your repository is really large.

OK, thanks a lot!

I can=E2=80=99t really say much about the repositories beforehand
because it=E2=80=99s a generic code hosting platform, several instances
of which we run at my employer=E2=80=99s place (I also run one privatel=
y
now), and which is also run by e.g. Debian. But I=E2=80=99ll try to fig=
ure
out some somewhat sensible defaults.

>Running 'git gc' with --aggressive should be as safe as running it
>without --aggressive.

OK, thanks.

>But, you should think about whether you really need to run it more
>than once, or at all.  When you use --aggressive, git will perform the
[=E2=80=A6]

Great explanation!

I think that I=E2=80=99d want to run it once, after the repository has
been begun to be used (probably not correct English but you know
what I want to say), but have to figure out a way to do so=E2=80=A6 but
I=E2=80=99ll just leave out the --aggressive from the cronjob then.

Much appreciated,
//mirabilos
--=20
Sometimes they [people] care too much: pretty printers [and syntax high=
ligh-
ting, d.A.] mechanically produce pretty output that accentuates irrelev=
ant
detail in the program, which is as sensible as putting all the preposit=
ions
in English text in bold font.	-- Rob Pike in "Notes on Programming in C=
"

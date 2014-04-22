From: David Kastrup <dak@gnu.org>
Subject: Re: [ANNOUNCE] WinGit - native x86/x64 Git for Windows
Date: Tue, 22 Apr 2014 16:17:12 +0200
Message-ID: <87r44pe9ef.fsf@fencepost.gnu.org>
References: <rfujmbew27f1gaa6dbk706li.1397911737867@email.android.com>
	<20140419184210.GB3617@book-mint>
	<alpine.DEB.1.00.1404210003540.14982@s15462909.onlinehome-server.info>
	<53556579.3050709@gmail.com>
	<alpine.DEB.1.00.1404212053420.14982@s15462909.onlinehome-server.info>
	<535569e92cbcc_32c48493101f@nysa.notmuch>
	<alpine.DEB.1.00.1404221512130.14982@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Marat Radchenko <marat@slonopotamus.org>, git@vger.kernel.org,
	msysGit Mailinglist <msysgit@googlegroups.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Apr 22 16:17:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcbVh-0005K0-LA
	for gcvg-git-2@plane.gmane.org; Tue, 22 Apr 2014 16:17:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756419AbaDVORR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Apr 2014 10:17:17 -0400
Received: from fencepost.gnu.org ([208.118.235.10]:38261 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755956AbaDVORP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Apr 2014 10:17:15 -0400
Received: from localhost ([127.0.0.1]:37293 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WcbVY-00059t-W5; Tue, 22 Apr 2014 10:17:13 -0400
Received: by lola (Postfix, from userid 1000)
	id 9BA7AE0524; Tue, 22 Apr 2014 16:17:12 +0200 (CEST)
In-Reply-To: <alpine.DEB.1.00.1404221512130.14982@s15462909.onlinehome-server.info>
	(Johannes Schindelin's message of "Tue, 22 Apr 2014 15:14:23 +0200
	(CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246738>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Mon, 21 Apr 2014, Felipe Contreras wrote:
>
>> Johannes Schindelin wrote:
>> > Now, clearly you have all the motivation that is needed to get 64-=
bit
>> > builds of Git for Windows going, and all the motivation required t=
o make
>> > sure that the MSVC support of the msysGit project works.
>>=20
>> s/msysGit/Git/
>
> No. I meant the msysGit project; the project that maintains the curre=
nt
> development environment for Git for Windows. Please do not try to
> reinterpret what I am saying.
>
>> Personally I don't see why ideally I shouldn't be able to build upst=
ream
>> Git for Windows with mingw without leaving my Linux system.
>
> Maybe because you could not even test it properly, let alone run the =
test
> suite? And maybe because according to the famous "scratch your own it=
ch"
> credo, it is actually the duty of Windows users -- i.e. users who do =
not
> even have your Linux system -- to fix the bugs that would never be
> encountered anywhere but Windows?

<URL:http://www.lilypond.org/gub>

The LilyPond project uses this to do automated builds for Windows,
MacOSX, FreeBSD, GNU/Linux on several CPUs.  The installation includes =
a
Python interpreter, GUILE, bash, and some other run-time necessary stuf=
f
for executing scripts of various kinds.

LilyPond contains quite a few dependencies: efforts to do this natively
under the "everything that should be necessary is available somewhere"
assumptions led to bugs and time lags not dissimilar to what plagues
msysGit.

"duty of Windows users" sounds like a theory expounded by non-Windows
users.  Maintaining ports requires highly skilled programmers, and
highly skilled programmers tend to scratch a _lot_ of itches by not
using Windows in the first place.

It's been a long time since I had a grasp of the Windows/Git situation,
but my impression was that much of the msysGit stuff was done by you
yourself to scratch your personal itch of stopping people to say "Git i=
s
not useful for large projects since it does not run under Windows" whil=
e
not actually being a Windows user yourself.

So if my memory does not do me a disfavor, you have kicked the "duty of
Windows users" theory in the curb yourself.

The developer demographic of LilyPond is similar: we actually have a
predominance of Windows users on the user mailing list.  But power user=
s
and compile farm providers (all the cross-compiling is taking a serious
toll, even though most is in compiling the embedded example images in
the various manuals and their translations) use GNU/Linux, and where
their native system is Windows, in the form of a Ubuntu VM ("LilyDev")
put together for that purpose.

As a consequence, the bug tracker contains comparatively few and often
minor operating system specific bug reports (cf
<URL:http://code.google.com/p/lilypond/issues/list?can=3D1&q=3DOpSys%3D=
Windows>).
Many of them are catered for by programmers not even having a system
available for testing.  Stuff that is really only reproducible on
Windows tends to take longer to fix.  That involves things like
=46ont=A0handling, PDF=A0handling, filename issues, memory allocation h=
andling
and others, often in the form of performance regressions that also
happen on GNU/Linux but are much less noticeable because the respective
facilities are much more efficient and thus mask unnecessarily repeated
operations much better.

While the user demographic of Git is likely leaning less towards Window=
s
than that of LilyPond, I=A0expect some similar tendencies.  As a result=
 of
the GUB crosscompiling environment, LilyPond offers a high quality
up-to-date Windows distribution with a somewhat typical installer
(though with acceptability problems that would not be dissimilar for
Git, cf
<URL:http://download.cnet.com/LilyPond/9241-2141_4-10995890.html?messag=
eID=3D10589553&tag=3Duo;uo>).

In a way, using such a cross-building environment is a copout regarding
the defensible "duty of end users" line of thought.  But it's not like
the msysGit history supports that theory all that convincingly anyway.

--=20
David Kastrup

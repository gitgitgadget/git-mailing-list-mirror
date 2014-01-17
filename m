From: SH <saajey@yahoo.com>
Subject: Re: file permissions in Git repo
Date: Fri, 17 Jan 2014 11:20:59 -0800 (PST)
Message-ID: <1389986459.3994.YahooMailNeo@web124902.mail.ne1.yahoo.com>
References: <1389916737.92225.YahooMailNeo@web124906.mail.ne1.yahoo.com> <20140117022623.GC12444@sigill.intra.peff.net> <52D971A7.1040104@web.de>
Reply-To: SH <saajey@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: =?iso-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 17 20:21:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W4Eyd-0005Xo-4t
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jan 2014 20:21:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753457AbaAQTVG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 17 Jan 2014 14:21:06 -0500
Received: from nm1-vm4.bullet.mail.ne1.yahoo.com ([98.138.91.161]:48005 "EHLO
	nm1-vm4.bullet.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752601AbaAQTVC convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jan 2014 14:21:02 -0500
Received: from [98.138.100.112] by nm1.bullet.mail.ne1.yahoo.com with NNFMP; 17 Jan 2014 19:21:00 -0000
Received: from [98.138.88.235] by tm103.bullet.mail.ne1.yahoo.com with NNFMP; 17 Jan 2014 19:21:00 -0000
Received: from [127.0.0.1] by omp1035.mail.ne1.yahoo.com with NNFMP; 17 Jan 2014 19:21:00 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 86630.72040.bm@omp1035.mail.ne1.yahoo.com
Received: (qmail 23905 invoked by uid 60001); 17 Jan 2014 19:20:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1389986459; bh=6AWpo2pigxIBJJpFIwWCXmevhMnU36ejpI/Q9F8p+mE=; h=X-YMail-OSG:Received:X-Rocket-MIMEInfo:X-Mailer:References:Message-ID:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding; b=REcO4iAI/ru9BvePuRhWehEYsKU2l1WwP+DSMbfVlXng9cwLcMLB61reVfeNRIW+jZA3EyG6WBjLwFwG0mYakRnr+H6oS8Nnn97bOOGnsIGUOC3VEgZjheDnBRSduymSTvSRa7332XtWqmFwbFBNZCcLvgQJfDQPw8EcNWOq78g=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:X-Rocket-MIMEInfo:X-Mailer:References:Message-ID:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=LSnLbjoMf6PLsAMytrOL5s36gou/4Ph5LTWTwtGob5S5aqLuGJMHUUMf32Xd7wCFj0RpVbHwmEvufezdG9V6octXMwqUl8FmsjY2yqfEu4/3UzOSnvi+fJyyFkNPQKy5xHDqjD/CwaovevkitLeJdZ9PTYuBjxxUxAlHV5KiaOU=;
X-YMail-OSG: Aln9SX8VM1nrlT6FFjUV0TdsjusE_12EbT8Hsxe2O.BsMav
 qc9hykkLPm4w08TjJCAV7IX_jixvs0mRxaPXGgfEu56oNpPYb2S19SPQdudc
 vaGq59G8og9yPJykik8y.UO22Phday.pjcVReG0C8e9BpD.iVUEQHxTcQb3n
 pzcHcZ9iSAySgQyfplU6l1s6jC3mHytYaAtOw6l4oe03lAgRbdRxb.vJcUlm
 G5bYiIbSNAX04Qor5S3ejavSr4OAufyu.i1yAzvhvzMA7Puu6s_XcA41qeQ.
 8uYMPeh6mJ_cnb1AWnguPTqCAh8FGQAKnGvDI2s3wDfmeq485CYyvHnKXb0r
 MOzddORUv6wDyKEIMyStNd4tKqyiM_zYCmBzV1L6V30OBxHgqXlftRufagCK
 ryHwEonDu1EUqC49wjwunDo.JbGItdN.ji4q8gkQJrp7wQBBX25JrWE46g.H
 ayvVYNbXe_gTpskXv03iohd5SYEkz7Z6YJJn7vtxIbNYJfQPF4ica3W8FTcI
 zbqRwyEnPUeeAgUNuQUcDGuPB8Cp8FMnsPYfz4diAb1d7DIYJPiK.9k60SAr
 FgIDd0oaodj8mUD7FiE21ikDTpDNee9I90CMByY.fFIqyCebVdjF6X2L.jBQ
 eYQBfSSUIXUZyiVzvJQpyJdkRVmYp
Received: from [70.42.18.1] by web124902.mail.ne1.yahoo.com via HTTP; Fri, 17 Jan 2014 11:20:59 PST
X-Rocket-MIMEInfo: 002.001,VGhhbmtzIGd1eXMuwqAgU29ycnkgYnV0IG9uZSBtb3JlIHF1ZXN0aW9uLCBsaWtlIEkgbWVudGlvbmVkIHdlIGhhdmUgaG9zdGVkIHJlcG9zaXRvcmllcyBzbyBob3cgZG8gSSBtYWtlIHNvbWUgY29uZmlndXJhdGlvbiBjaGFuZ2VzIGFyZSBzZXJ2ZXIgYmFzZWQgc28gd2hldGhlciB0aGUgY2xpZW50IGhhdmUgdGhvc2UgY2hhbmdlcyBvciBub3QsIGl0IHdvdWxkbid0IG1hdHRlci4gQWxzbyBJIGhhdmUgb25lIGNsaWVudCBvbiBsaW51eCBhbmQgYW5vdGhlciBvbmUgb24gd2luZG93cyAoZm9yIG15IHRlc3QBMAEBAQE-
X-Mailer: YahooMailWebService/0.8.173.622
In-Reply-To: <52D971A7.1040104@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240613>

Thanks guys.=A0 Sorry but one more question, like I mentioned we have h=
osted repositories so how do I make some configuration changes are serv=
er based so whether the client have those changes or not, it wouldn't m=
atter. Also I have one client on linux and another one on windows (for =
my testing purpose) and I see that .git/config on both machines are lit=
tle different. Is that normal?

Thanks Again.





On Friday, January 17, 2014 10:08 AM, Torsten B=F6gershausen <tboegi@we=
b.de> wrote:
On 01/17/2014 03:26 AM, Jeff King wrote:

> On Thu, Jan 16, 2014 at 03:58:57PM -0800, SH wrote:
>
>> We have a repository which holds lots of shell and perl scripts. We =
add the
>> files to repository (from windows client) with executable permission=
s (using
>> cygwin) but when we pull that repository on another machine (windows=
 or linux),
>> files dont have executable permission. Can you please provide a solu=
tions for
>> this?
>
> Git does not preserve file permissions _except_ for the executable bi=
t.
> So this should be working.
>
> However, I suspect that `core.fileMode` is set to `false` in your
> repository, which causes git to ignore the executable bit. When a
> repository is initialized, we check whether the filesystem simply
> creates everything with the executable bit. If so, we turn off
> core.fileMode for the repository (since otherwise every file would ha=
ve
> it set).
>
> -Peff
Cygwin has been a little bit special (and mingw still is).
Until this commit:
Author: Junio C Hamano <gitster@pobox.com>
Date:=A0  Wed Jul 24 19:22:49 2013 -0700

=A0 =A0 Merge branch 'ml/cygwin-updates'

=A0 =A0 The tip one does _not_ revert c869753e (Force core.filemode to
=A0 =A0 false on Cygwin., 2006-12-30) on purpose, so that people can
=A0 =A0 still retain the old behaviour if they wanted to.

=A0 =A0 * ml/cygwin-updates:
=A0 =A0 =A0 cygwin: stop forcing core.filemode=3Dfalse
=A0 =A0 =A0 Cygwin 1.7 supports mmap
=A0 =A0 =A0 Cygwin 1.7 has thread-safe pread
=A0 =A0 =A0 Cygwin 1.7 needs compat/regex
the repositories created by cygwin had always core.filemode=3Dfalse.

You can easily check your configuration by running
git config -l
on the cygwin machine, as Peff suggested.

The next step is to check how the files had been recored in git, using
git ls-files -s | less
on any machine.

If I do this on git.git, we find lines like this, where
100755 means an executable file,
100644 means non-executable file.

100755 9c3f4131b8586408acd81d1e60912b51688575ed 0=20
Documentation/technical/api-index.sh
100644 dd894043ae8b04269b3aa2108f96cb935217181d 0=20
Documentation/technical/api-lockfile.txt


The 3rd step is to check how file are shown in cygwin, run
ls -l
(Do they have the executable bit set ?)

Side note:
And I think the way the auto-probing of the file system works is
like this:
When a git repo is initialized, the .git/config file is created.
After that, we try to toggle the executable bit, and if lstat reports
it as toggled, we set core.filemode=3Dtrue.
(See builtin/init-db.c, search for core.filemode)

I tested to create a repo on a network share exported by SAMBA.
The Server was configured so that all new created files had the
executable bit set by default.
Git detected that the executable bit could be switched off,
and configured core.filemode=3Dtrue
Nice.

/Torsten

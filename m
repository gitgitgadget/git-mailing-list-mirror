From: Christian MICHON <christian.michon@gmail.com>
Subject: Re: Announce: Git for Windows 1.6.3
Date: Thu, 7 May 2009 22:59:42 +0200
Message-ID: <46d6db660905071359l66ff81afkc442f435edadb07f@mail.gmail.com>
References: <alpine.DEB.1.00.0905071554070.16585@intel-tinevez-2-302>
Reply-To: christian.michon@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Cc: msysgit@googlegroups.com, git@vger.kernel.org
To: Johannes.Schindelin@gmx.de
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Thu May 07 22:59:59 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from yw-out-2122.google.com ([74.125.46.24])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2Ah9-0004VF-Vu
	for gcvm-msysgit@m.gmane.org; Thu, 07 May 2009 22:59:56 +0200
Received: by yw-out-2122.google.com with SMTP id 4so202930ywc.63
        for <gcvm-msysgit@m.gmane.org>; Thu, 07 May 2009 13:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :dkim-signature:domainkey-signature:mime-version:received
         :in-reply-to:references:date:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding:reply-to:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=BiE4lqvntgroz2Id/5Qh6C93Rdr7uGVyoyZM4nMNS5Q=;
        b=zhaFaFvotfJeRKRcJVslvPLO56wP79vSv3O/6kfs+EQPs5Dqn8SlljHZN6rMwz9VHX
         8uzwg4jN0Yb2JPFacQ9kW5hTvBvHZlwGO41FMk3kCASwy3X6Q0JDVgbw4OnFJh6WmMfM
         IGFhuElpoerh7U2nhE6O7ojeQ4e792+EwA2mY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:mime-version:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding:reply-to:sender:precedence:x-google-loop
         :mailing-list:list-id:list-post:list-help:list-unsubscribe
         :x-beenthere-env:x-beenthere;
        b=MjVSle1hLKlWTH50z0wTRVMA+01iHnsfu1Uo7EMo8d2QXOGolpvMkQwwqdclDSiPBP
         mDVjEhnrWDN0OLNBshnpnUzGAVcHh+LbtSdG3YCEmXL7iAHsozaAnKDs+SzXxH+spvlp
         XMkffol7rxeXHrKBDB3LuHVRpsNPKcP9onc2E=
Received: by 10.151.141.8 with SMTP id t8mr409465ybn.6.1241729984476;
        Thu, 07 May 2009 13:59:44 -0700 (PDT)
Received: by 10.106.129.7 with SMTP id b7gr5090prd.0;
	Thu, 07 May 2009 13:59:44 -0700 (PDT)
X-Sender: christian.michon@gmail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.204.31.103 with SMTP id x39mr82494bkc.11.1241729984054; Thu, 07 May 2009 13:59:44 -0700 (PDT)
Received: from mail-bw0-f168.google.com (mail-bw0-f168.google.com [209.85.218.168]) by gmr-mx.google.com with ESMTP id e3si20743fga.2.2009.05.07.13.59.42; Thu, 07 May 2009 13:59:43 -0700 (PDT)
Received-SPF: pass (google.com: domain of christian.michon@gmail.com designates 209.85.218.168 as permitted sender) client-ip=209.85.218.168;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of christian.michon@gmail.com designates 209.85.218.168 as permitted sender) smtp.mail=christian.michon@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Received: by mail-bw0-f168.google.com with SMTP id 12so1088916bwz.17 for <msysgit@googlegroups.com>; Thu, 07 May 2009 13:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma; h=domainkey-signature:mime-version:received:in-reply-to:references :date:message-id:subject:from:to:cc:content-type :content-transfer-encoding; bh=aBEw8jHK//v7D87Rzs3U51Rz8leHd+8ZBDknrNm4Dn0=; b=Z8mtU+Pq0MrzL9KPawrl5jHHBiyAU434CVJUeGJL8vrsTD7XOPl8MSgBB+/Ev1dKnT wf42v+4SLOmgp3oqpD3WDgNzA2zIyYrbEZAc4NlihvdBx3//+grcHh3rxjXbtfUsVBto 9Aub6UHUEVt6d0SCbnepDKkco5sQrRd9eqWsM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma; h=mime-version:in-reply-to:references:date:message-id:subject:from:to :cc:content-type:content-transfer-encoding; b=IxrsMddztRoUDOAr/Hx6nd1BvZXm1ybLJ237l4QOGdtcj2cyB6Of68dbBdRjOQlGZv NjmxHc15n5IGgutTsGg9bubmoJGOP3BRZmawIC98/8i8xySw5Yi1SOb36a/rCpIeaNH3 QYLa9rlNlyMyfuL7pbOwehzEDtHBotloKnUno=
Received: by 10.204.31.75 with SMTP id x11mr2527286bkc.0.1241729982884; Thu,  07 May 2009 13:59:42 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0905071554070.16585@intel-tinevez-2-302>
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit+owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit+help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit+unsubscribe@googlegroups.com>
X-BeenThere-Env: msysgit@googlegroups.com
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118522>


On Thu, May 7, 2009 at 7:27 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi,
>
> this mail tries to inform you that a new version of Git for Windows has
> been released. =A0Overall, the differences to Git 1.6.3 have been reduced
> dramatically, thanks to the immense efforts of Johannes Sixt on the test
> suite.
>
> There are two major modifications relative to git.git, though: Marius
> Storm-Olsen's readdir() and nedmalloc patches. =A0They are rather large, =
but
> well-contained changes, and we tested extensively in the last few weeks.
>
> One consequence is that the test-suite no longer takes 45 minutes on the
> machine I test on, but less than 20 minutes.
>
> And now, without further ado, the release notes:
>
> Git Release Notes (Git-1.6.3-preview20090507)
> Last update: 07 May 2009
>
> Known issues
>
> - Some commands are not yet supported on Windows and excluded from the
> =A0installation; namely: git archimport, git cvsexportcommit, git
> =A0cvsimport, git cvsserver, git instaweb, git send-email, git shell.
> - The Logitec QuickCam software can cause spurious crashes. See "Why does
> =A0make often crash creating a sh.exe.stackdump file when I try to compil=
e
> =A0my source code?" on the MinGW Wiki
> =A0(http://www.mingw.org/wiki/Environment_issues)
> - The Quick Launch icon will only be installed for the user running setup
> =A0(typically the Administrator). This is a technical restriction and wil=
l
> =A0not change.
> - Git Bash launched through the Explorer shell extension does not have th=
e
> =A0git icon in its taskbar. This is a technical restriction and will not
> =A0change.
> - git send-mail does not work properly (Issue 27).
> - curl uses $HOME/_netrc instead of $HOME/.netrc.
> - If you want to specify a different location for --upload-pack, you have
> =A0to start the absolute path with two slashes. Otherwise MSys will mangl=
e
> =A0the path.
> - git and bash have serious problems with non-ASCII file names (Issue 80,
> =A0108, 159, 188).
> - If configured to use plink, you will have to connect with putty first,
> =A0as you cannot accept the host key due to the console window being
> =A0blocked (Issue 96).
> - MinGW does not support IPv6 yet (Issue 182).
> - When run from cmd.exe instead of Git Bash, some characters seem to be
> =A0"swallowed" from Git's output (Issue 192).
> - There are a spurious write errors during rebase (Issue 200) that seem
> =A0not to be reproducible on most computers.
> - As merge tools are executed using the MSys bash, options starting with
> =A0"/" need to be handled specially: MSys would interpret that as a POSIX
> =A0path, so you need to double the slash (Issue 226). =A0Example: instead=
 of
> =A0"/base", say "//base". =A0Also, extra care has to be paid to pass Wind=
ows
> =A0programs Windows paths, as they have no clue about MSys style POSIX
> =A0paths -- You can use something like $(cmd //c echo "$POSIXPATH").
>
> Changes since Git-1.6.2.2-preview20090408
>
> New Features
>
> - Comes with official git 1.6.3.
> - Thanks to Marius Storm-Olsen, Git has a substantially faster readdir()
> =A0implementation now.
> - Marius Storm-Olsen also contributed a patch to include nedmalloc, again
> =A0speeding up Git noticably.
> - Compiled with GCC 4.4.0
>
> Bugfixes
>
> - Portable Git contains a README.portable.
> - Portable Git now actually includes the builtins.
> - Portable Git includes git-cmd.bat and git-bash.bat.
> - Portable Git is now shipped as a .7z; it still is a self-extracting
> =A0archive if you rename it to .exe.
> - Git includes the Perl Encode module now.
> - Git now includes the filter-branch tool.
> - There is a workaround for a Windows 7 regression triggering a crash in
> =A0the progress reporting (e.g. during a clone). This fixes issues 236 an=
d
> =A0247.
> - gitk tries not to crash when it is closed while reading references
> =A0(Issue 125, thanks Pat Thoyts).
> - In some setups, hard-linking is not as reliable as it should be, so we
> =A0have a workaround which avoids hard links in some situations (Issues 2=
22
> =A0and 229).
> - git-svn sets core.autocrlf to false now, hopefully shutting up most of
> =A0the git-svn reports.
>
> Ciao,
> Dscho (on behalf of the msysGit team)
>
>

1st: thanks to all participants for making this possible.

2nd: on my vista system (family premium sp1, French edition), I get a
git setup window towards the end of setup saying

Line 620: Unable to read file "etc\fileList-builtins.txt"

Beyond this setup hickup, all seems to be in order and working locally
(I have not tried pushing stuff yet).

--=20
Christian
--
http://detaolb.sourceforge.net/, a linux distribution for Qemu with Git ins=
ide !

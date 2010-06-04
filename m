From: Dario Rodriguez <soft.d4rio@gmail.com>
Subject: Re: Installing on AIX fails
Date: Fri, 4 Jun 2010 12:07:19 -0300
Message-ID: <AANLkTilC1AKp2meQNlU8yeISV3qbzTDrQ2B4CbooRDZT@mail.gmail.com>
References: <AANLkTinKjEBkn-9ajO4QXyHqY0EOQBGPRgNREaC_p_vQ@mail.gmail.com>
	<AANLkTilsQaMQyDP_od2NrfwIV7gvoD3R-yKNlMJjVKCA@mail.gmail.com>
	<AANLkTikfQdwDoZylaKC_siuwaLrLP4JkMh2fnvwNbxqe@mail.gmail.com>
	<AANLkTin-jf2ihZlAy-p4-75PSe6X78tz8XlzySE5fogN@mail.gmail.com>
	<AANLkTin03pWueh-6001RUrWMBzhn98cNWirSCQJ4s7EN@mail.gmail.com>
	<AANLkTikdfXz7lk41czdRZKnnB3xpLFannCaUzSk7tL2_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 04 17:07:28 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKYUZ-0005z4-5P
	for gcvg-git-2@lo.gmane.org; Fri, 04 Jun 2010 17:07:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756280Ab0FDPHV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Jun 2010 11:07:21 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:38509 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755586Ab0FDPHV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Jun 2010 11:07:21 -0400
Received: by fxm8 with SMTP id 8so875123fxm.19
        for <git@vger.kernel.org>; Fri, 04 Jun 2010 08:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=OV9kkYi8VeJaHpAZAoSN5jnk3jFchA2Jky6uqfRBFbc=;
        b=eW+/+21AqojIl4VsYLHrLEoN2gBPS2R3seJInr5Tf6mO+mGhi2LnSYXLiGCpqtIvsP
         8VDcCobSN1sk05iFwcBxQI4aUtjrJO1jl78QZ/Vo3r3CvvxhPCsCzxw7JVDHk+GEiLk5
         yhekyLNZnoX4pKyfKS023rDll6eJVqciCddv0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=sTJebkPOphwde8NhK6AWBanCJvRQiUzODUSgXv8Lbk5DNVfl7w3easQXEykVifUIYS
         f9Ar/F8rf5wYpfys05Dy0vXhjqLW1jM1rLDumPGkpPWk/cKJ1CnpFnwZs+ErVkauRqIO
         P6zBg1gh/0j/nMthdh/JxJgZexxGcdVlJp68U=
Received: by 10.204.74.25 with SMTP id s25mr4122719bkj.76.1275664039207; Fri, 
	04 Jun 2010 08:07:19 -0700 (PDT)
Received: by 10.204.18.207 with HTTP; Fri, 4 Jun 2010 08:07:19 -0700 (PDT)
In-Reply-To: <AANLkTikdfXz7lk41czdRZKnnB3xpLFannCaUzSk7tL2_@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148423>

On Fri, Jun 4, 2010 at 11:28 AM, =C6var Arnfj=F6r=F0 Bjarmason
<avarab@gmail.com> wrote:
> On Thu, Jun 3, 2010 at 21:22, Dario Rodriguez <soft.d4rio@gmail.com> =
wrote:
>> On Thu, Jun 3, 2010 at 5:21 PM, =C6var Arnfj=F6r=F0 Bjarmason
>>> What do you mean by "disappears" anyway, was it like $(echo|less), =
or
>>> did it just return with no output? What was the exit code?
>>>
>>
>> 'dissapears'? I will paste my output as is, there are 2 commits, but
>> 'git log' simply don't show them if $PAGER is not present:
>>
>> $ ../git log
>> $ echo $?
>> 0
>> $ PAGER=3D/bin/cat ../git log
>> commit 3274a12f940680612e3bfd3d022a0eab460c0f1f
>> Author: usuario tuxedo ####### <tx#####@MachineName.(none)>
>> Date: =A0 Thu Jun 3 20:02:23 2010 +0200
>>
>> =A0 =A0OtherCom
>>
>> commit acf110f7c878a37e4a5af8499134df28da0e8ab3
>> Author: usuario tuxedo ####### <tx#####@MachineName.(none)>
>> Date: =A0 Thu Jun 3 20:01:37 2010 +0200
>>
>> =A0 =A0inicial
>
> That's interesting.
>

Yes, I will check it better today at home.

>>> In any case, running git's make test might reveal other problems on
>>> AIX worth fixing. Maybe do that and post the results?
>>>
>>
>> The make test execution output is fairly long... do I post it all, o=
r
>> attach MIME? However I'm leaving here and I cannot access the server
>> until tomorrow...
>
> The best thing would be to post cd t && ./$some_test -d -v for all
> tests that fail, I guess.
>
>>>>>> $ /usr/linux/bin/make prefix=3D$HOME/apps/ NO_OPENSSL=3D1 NO_TCL=
TK=3D1
>>>>>> NO_EXPAT=3D1 PYTHON_PATH=3D/usr/local/bin/python install
>>>>>>
>>>>>> [...]
>>>>>> install -d -m 755 '/myhomedir/apps/bin'
>>>>>> getopt: illegal option -- d
>>>>>> Usage: install [-c dira] [-f dirb] [-i] [-m] [-M mode] [-O owner=
]
>>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 [-G group] [-S] [-n dirc] [-o] [-s] =
file [dirx ...]
>>>>>> make: *** [install] Error 2
>>>>>>
>>>>>> Now the installing process fails because of the AIX 'install' to=
ol and
>>>>>> I wonder, can I patch/configure the installing process for AIX? =
May be
>>>>>> a set of utils for building in such systems would help some peop=
le.
>>>>>
>>>>> Does AIX's install have something equivalent to GNU install's -d?=
 The
>>>>> -c and -f options look likely from that synopsis.
>>>>>
>>>>
>>>> I don't know since I just use this system for development and test=
ing
>>>> (I'm debian user), but let me post the manpage info, for -c and -f=
:
>>>>
>>>> -c DirectoryA Installs a new command file in the DirectoryA variab=
le only if
>>>> that file does not already exist there. If it finds a copy of File=
 there, it
>>>> issues a message and exits without overwriting the file. This flag=
 can be used
>>>> alone or with the -s, -M, -O, -G, or -S flag.
>>>>
>>>> -f DirectoryB Forces installation of File in DirectoryB whether or=
 not File
>>>> already exists. If the file being installed does not already exist=
, the command
>>>> sets the permission code and owner of the new file to 755 and bin,=
 respectively.
>>>> This flag can be used alone or with the -o,-s, -M, -O, -G, or -S f=
lag.
>>>
>>> Looks like there's no equivalent to -d. FWIW perl uses a installper=
l
>>> script that also works on AIX. Maybe a similar fallback or default
>>> would make sense for Git.
>>>
>>
>> Yes, I installed 'top' on other AIX machine today, and it uses it's
>> own install script too... may be it's the best way for systems havin=
g
>> a poor 'install' tool.
>>
>>>>>> PD2: I don't know if AIX python path is always /usr/local/bin/py=
thon,
>>>>>> but I've seen that git Makefiles set /usr/local/bin/python for F=
reeBSD
>>>>>> only:
>>>>>>
>>>>>> git_remote_helpers/Makefile:
>>>>>> ifndef PYTHON_PATH
>>>>>> =A0 =A0 =A0 =A0ifeq ($(uname_S),FreeBSD)
>>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0PYTHON_PATH =3D /usr/local/bin/py=
thon
>>>>>> =A0 =A0 =A0 =A0else
>>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0PYTHON_PATH =3D /usr/bin/python
>>>>>> =A0 =A0 =A0 =A0endif
>>>>>> endif
>>>>>
>>>>> That's presumably because Python is most likely installed via the
>>>>> ports system on FreeBSD which drops it in /usr/local. How did you
>>>>> install Python on AIX? Is it from some IBM package or another met=
hod
>>>>> that's the most common & standard way to do it on AIX?.
>>>>>
>>>>
>>>> Again, I don't know since I'm not the sysadmin. I just looked for
>>>> python and found it's in /usr/local/bin
>>>
>>> Does using /usr/bin/env python instead work?
>>>
>>> =A0 =A0$ cat /tmp/py.py
>>> =A0 =A0#!/usr/bin/env python
>>> =A0 =A0print "hello"
>>> =A0 =A0$ /tmp/py.py
>>> =A0 =A0hello
>>>
>>
>> Yes, it works... at least the executable is found :P
>>
>> $ cat temp.py
>> #!/usr/bin/env python
>> print "hello"
>>
>> $ ./temp.py
>> Could not find platform dependent libraries <exec_prefix>
>> Consider setting $PYTHONHOME to <prefix>[:<exec_prefix>]
>> hello
>
> That's one reason why I think we should just use /usr/bin/env for
> perl/python instead of hardcoding it to /usr/bin/{perl,python}. It's
> more likely to work on systems like AIX.
>

I agree... it's off topic, but something like this is what I say with
'test' for python, and I think those 2 are the only files impacted:

=46rom e89f18c29c171207002d4718ea4b9d08c7efe1d7 Mon Sep 17 00:00:00 200=
1
=46rom: Dario Rodriguez <soft.d4rio@gmail.com>
Date: Fri, 4 Jun 2010 00:28:56 -0300
Subject: [PATCH] Now Makefiles check for Python executable

Check for python executable instead of predicting based on the system
---
 Makefile                    |    9 +++++++--
 git_remote_helpers/Makefile |   12 +++++++-----
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/Makefile b/Makefile
index d5d6565..29cf8ff 100644
--- a/Makefile
+++ b/Makefile
@@ -449,7 +449,13 @@ ifndef PERL_PATH
 	PERL_PATH =3D /usr/bin/perl
 endif
 ifndef PYTHON_PATH
-	PYTHON_PATH =3D /usr/bin/python
+    ifeq ($(shell test -x /usr/bin/python && echo y), y)
+        PYTHON_PATH =3D /usr/bin/python
+    else
+        ifeq ($(shell test -x /usr/local/bin/python && echo y), y)
+            PYTHON_PATH =3D /usr/local/bin/python
+        endif
+    endif
 endif

 export PERL_PATH
@@ -875,7 +881,6 @@ ifeq ($(uname_S),FreeBSD)
 		NO_UINTMAX_T =3D YesPlease
 		NO_STRTOUMAX =3D YesPlease
 	endif
-	PYTHON_PATH =3D /usr/local/bin/python
 	HAVE_PATHS_H =3D YesPlease
 endif
 ifeq ($(uname_S),OpenBSD)
diff --git a/git_remote_helpers/Makefile b/git_remote_helpers/Makefile
index 74b05dc..8b5f50c 100644
--- a/git_remote_helpers/Makefile
+++ b/git_remote_helpers/Makefile
@@ -7,11 +7,13 @@ pysetupfile:=3Dsetup.py
 DESTDIR_SQ =3D $(subst ','\'',$(DESTDIR))

 ifndef PYTHON_PATH
-	ifeq ($(uname_S),FreeBSD)
-		PYTHON_PATH =3D /usr/local/bin/python
-	else
-		PYTHON_PATH =3D /usr/bin/python
-	endif
+    ifeq ($(shell test -x /usr/bin/python && echo y), y)
+        PYTHON_PATH =3D /usr/bin/python
+    else
+        ifeq ($(shell test -x /usr/local/bin/python && echo y), y)
+            PYTHON_PATH =3D /usr/local/bin/python
+        endif
+    endif
 endif
 ifndef prefix
 	prefix =3D $(HOME)
--=20
1.7.1


Then, the path is checked if ever it's empty (after this stuff), but
the case is that no matter the system, '/usr/bin' and '/usr/local/bin'
are the most common places... I think it's totally sane the needing of
PYTHON_PATH if it's not in those commonly used dirs.

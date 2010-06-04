From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Installing on AIX fails
Date: Fri, 4 Jun 2010 14:28:17 +0000
Message-ID: <AANLkTikdfXz7lk41czdRZKnnB3xpLFannCaUzSk7tL2_@mail.gmail.com>
References: <AANLkTinKjEBkn-9ajO4QXyHqY0EOQBGPRgNREaC_p_vQ@mail.gmail.com>
	<AANLkTilsQaMQyDP_od2NrfwIV7gvoD3R-yKNlMJjVKCA@mail.gmail.com>
	<AANLkTikfQdwDoZylaKC_siuwaLrLP4JkMh2fnvwNbxqe@mail.gmail.com>
	<AANLkTin-jf2ihZlAy-p4-75PSe6X78tz8XlzySE5fogN@mail.gmail.com>
	<AANLkTin03pWueh-6001RUrWMBzhn98cNWirSCQJ4s7EN@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Dario Rodriguez <soft.d4rio@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 04 16:28:26 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKXsn-00005w-HV
	for gcvg-git-2@lo.gmane.org; Fri, 04 Jun 2010 16:28:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756272Ab0FDO2T convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Jun 2010 10:28:19 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:53619 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755580Ab0FDO2S convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Jun 2010 10:28:18 -0400
Received: by iwn37 with SMTP id 37so1055847iwn.19
        for <git@vger.kernel.org>; Fri, 04 Jun 2010 07:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=6C1T6N6aOlKG5EwMAyjaslaJ7mJoesCqZQq1yYhwAcQ=;
        b=HwXNxoom3rPZKjqq/0L1YTB19sKO1x1t1gu5aRo85Ug2rYmJMxeMbb4l8Gnd+Sc1h6
         drpdoT5CUHHBWdgezSAY3Bxj/B7f9rD+0ke2fMcCaEo/dTeUuH2UmFyw++FAlr8vHgcQ
         +ZKZHmKRtqTiXP6jIoMdWXKCXg3fEO0XzHJwo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=pdLQcYGRup6YSLRmTTTyLTOXkKqiekc0xHz06vBKPtncDEdRpCHY40E++2V+X05oSN
         +81oimDJCSVOILeoh79EahP++nQwBp/syl0JBzNtLmmTpLY/9VmDHq0bax7wWgp67ZDn
         Xv7NkXvGUlYEBcrpufiqpBw/pIjYfXdzFYSj4=
Received: by 10.231.82.145 with SMTP id b17mr903280ibl.187.1275661697904; Fri, 
	04 Jun 2010 07:28:17 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Fri, 4 Jun 2010 07:28:17 -0700 (PDT)
In-Reply-To: <AANLkTin03pWueh-6001RUrWMBzhn98cNWirSCQJ4s7EN@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148420>

On Thu, Jun 3, 2010 at 21:22, Dario Rodriguez <soft.d4rio@gmail.com> wr=
ote:
> On Thu, Jun 3, 2010 at 5:21 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmaso=
n
>> What do you mean by "disappears" anyway, was it like $(echo|less), o=
r
>> did it just return with no output? What was the exit code?
>>
>
> 'dissapears'? I will paste my output as is, there are 2 commits, but
> 'git log' simply don't show them if $PAGER is not present:
>
> $ ../git log
> $ echo $?
> 0
> $ PAGER=3D/bin/cat ../git log
> commit 3274a12f940680612e3bfd3d022a0eab460c0f1f
> Author: usuario tuxedo ####### <tx#####@MachineName.(none)>
> Date: =C2=A0 Thu Jun 3 20:02:23 2010 +0200
>
> =C2=A0 =C2=A0OtherCom
>
> commit acf110f7c878a37e4a5af8499134df28da0e8ab3
> Author: usuario tuxedo ####### <tx#####@MachineName.(none)>
> Date: =C2=A0 Thu Jun 3 20:01:37 2010 +0200
>
> =C2=A0 =C2=A0inicial

That's interesting.

>> In any case, running git's make test might reveal other problems on
>> AIX worth fixing. Maybe do that and post the results?
>>
>
> The make test execution output is fairly long... do I post it all, or
> attach MIME? However I'm leaving here and I cannot access the server
> until tomorrow...

The best thing would be to post cd t && ./$some_test -d -v for all
tests that fail, I guess.

>>>>> $ /usr/linux/bin/make prefix=3D$HOME/apps/ NO_OPENSSL=3D1 NO_TCLT=
K=3D1
>>>>> NO_EXPAT=3D1 PYTHON_PATH=3D/usr/local/bin/python install
>>>>>
>>>>> [...]
>>>>> install -d -m 755 '/myhomedir/apps/bin'
>>>>> getopt: illegal option -- d
>>>>> Usage: install [-c dira] [-f dirb] [-i] [-m] [-M mode] [-O owner]
>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [-G group] [-S] =
[-n dirc] [-o] [-s] file [dirx ...]
>>>>> make: *** [install] Error 2
>>>>>
>>>>> Now the installing process fails because of the AIX 'install' too=
l and
>>>>> I wonder, can I patch/configure the installing process for AIX? M=
ay be
>>>>> a set of utils for building in such systems would help some peopl=
e.
>>>>
>>>> Does AIX's install have something equivalent to GNU install's -d? =
The
>>>> -c and -f options look likely from that synopsis.
>>>>
>>>
>>> I don't know since I just use this system for development and testi=
ng
>>> (I'm debian user), but let me post the manpage info, for -c and -f:
>>>
>>> -c DirectoryA Installs a new command file in the DirectoryA variabl=
e only if
>>> that file does not already exist there. If it finds a copy of File =
there, it
>>> issues a message and exits without overwriting the file. This flag =
can be used
>>> alone or with the -s, -M, -O, -G, or -S flag.
>>>
>>> -f DirectoryB Forces installation of File in DirectoryB whether or =
not File
>>> already exists. If the file being installed does not already exist,=
 the command
>>> sets the permission code and owner of the new file to 755 and bin, =
respectively.
>>> This flag can be used alone or with the -o,-s, -M, -O, -G, or -S fl=
ag.
>>
>> Looks like there's no equivalent to -d. FWIW perl uses a installperl
>> script that also works on AIX. Maybe a similar fallback or default
>> would make sense for Git.
>>
>
> Yes, I installed 'top' on other AIX machine today, and it uses it's
> own install script too... may be it's the best way for systems having
> a poor 'install' tool.
>
>>>>> PD2: I don't know if AIX python path is always /usr/local/bin/pyt=
hon,
>>>>> but I've seen that git Makefiles set /usr/local/bin/python for Fr=
eeBSD
>>>>> only:
>>>>>
>>>>> git_remote_helpers/Makefile:
>>>>> ifndef PYTHON_PATH
>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0ifeq ($(uname_S),FreeBSD)
>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PYTHON_PAT=
H =3D /usr/local/bin/python
>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0else
>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PYTHON_PAT=
H =3D /usr/bin/python
>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0endif
>>>>> endif
>>>>
>>>> That's presumably because Python is most likely installed via the
>>>> ports system on FreeBSD which drops it in /usr/local. How did you
>>>> install Python on AIX? Is it from some IBM package or another meth=
od
>>>> that's the most common & standard way to do it on AIX?.
>>>>
>>>
>>> Again, I don't know since I'm not the sysadmin. I just looked for
>>> python and found it's in /usr/local/bin
>>
>> Does using /usr/bin/env python instead work?
>>
>> =C2=A0 =C2=A0$ cat /tmp/py.py
>> =C2=A0 =C2=A0#!/usr/bin/env python
>> =C2=A0 =C2=A0print "hello"
>> =C2=A0 =C2=A0$ /tmp/py.py
>> =C2=A0 =C2=A0hello
>>
>
> Yes, it works... at least the executable is found :P
>
> $ cat temp.py
> #!/usr/bin/env python
> print "hello"
>
> $ ./temp.py
> Could not find platform dependent libraries <exec_prefix>
> Consider setting $PYTHONHOME to <prefix>[:<exec_prefix>]
> hello

That's one reason why I think we should just use /usr/bin/env for
perl/python instead of hardcoding it to /usr/bin/{perl,python}. It's
more likely to work on systems like AIX.

From: Dario Rodriguez <soft.d4rio@gmail.com>
Subject: Re: Installing on AIX fails
Date: Thu, 3 Jun 2010 18:22:16 -0300
Message-ID: <AANLkTin03pWueh-6001RUrWMBzhn98cNWirSCQJ4s7EN@mail.gmail.com>
References: <AANLkTinKjEBkn-9ajO4QXyHqY0EOQBGPRgNREaC_p_vQ@mail.gmail.com>
	<AANLkTilsQaMQyDP_od2NrfwIV7gvoD3R-yKNlMJjVKCA@mail.gmail.com>
	<AANLkTikfQdwDoZylaKC_siuwaLrLP4JkMh2fnvwNbxqe@mail.gmail.com>
	<AANLkTin-jf2ihZlAy-p4-75PSe6X78tz8XlzySE5fogN@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 03 23:22:27 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKHrs-0007hC-Fz
	for gcvg-git-2@lo.gmane.org; Thu, 03 Jun 2010 23:22:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752413Ab0FCVWT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Jun 2010 17:22:19 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:55812 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750970Ab0FCVWS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Jun 2010 17:22:18 -0400
Received: by fg-out-1718.google.com with SMTP id l26so2326530fgb.1
        for <git@vger.kernel.org>; Thu, 03 Jun 2010 14:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=KbwbPqDPFfnwYI4qupnTCYX1ooJcSokXoKesG5kkgo4=;
        b=oxcExmDhVlnSrSCC6UK2S9mKWO5mgg4GwIKRuogitMyBsU1gEdEx74ay0TdQd2huRj
         IFfGnVW6po2vAd8Jneext1SRRKgnQT2ghd4WNnhgdya1tK7Y/VNg/ljrY3FlMbudP+00
         REo+Wjh3ytptBZRXSU+OpFWaiLVrM7TLHln7I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=GGx8NlNE644zDFWnAkItAgcTS8Toj7r4m3YUeGQJ2DK9gQQrCh10q42CWrUs28szAR
         SbQ4IZNSjAupyQBTIo5aVf7Uah2WV5OGHabzU5/9kKZeBGr73lf+AqAnwU6RDsT3WSQM
         bCKcGXqgr/tyKxwjH2iit/x7ucCtz4DXbuYEM=
Received: by 10.204.81.160 with SMTP id x32mr3315875bkk.74.1275600136403; Thu, 
	03 Jun 2010 14:22:16 -0700 (PDT)
Received: by 10.204.18.207 with HTTP; Thu, 3 Jun 2010 14:22:16 -0700 (PDT)
In-Reply-To: <AANLkTin-jf2ihZlAy-p4-75PSe6X78tz8XlzySE5fogN@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148366>

On Thu, Jun 3, 2010 at 5:21 PM, =C6var Arnfj=F6r=F0 Bjarmason
<avarab@gmail.com> wrote:
> On Thu, Jun 3, 2010 at 20:01, Dario Rodriguez <soft.d4rio@gmail.com> =
wrote:
>> On Thu, Jun 3, 2010 at 12:41 PM, =C6var Arnfj=F6r=F0 Bjarmason
>> <avarab@gmail.com> wrote:
>>> On Thu, Jun 3, 2010 at 15:32, Dario Rodriguez <soft.d4rio@gmail.com=
> wrote:
>>>> and it all works, with angels singing and everything... a testing =
repo
>>>> works fine for a test drive without installing, excepting 'git log=
'
>>>> that just don't display anything.
>>>
>>> How about PAGER=3D/bin/cat git log? If that works what's your pager=
, and
>>> do other git commands that use the pager (like git show) work or fa=
il?
>>>
>>
>> PAGER is not set by default as I see, but... isn't there any default
>> pager for git in case of PAGER being unset?
>>
>> Using /bin/cat or /bin/more it works (either 'log' or 'show')
>
> What do you mean by "disappears" anyway, was it like $(echo|less), or
> did it just return with no output? What was the exit code?
>

'dissapears'? I will paste my output as is, there are 2 commits, but
'git log' simply don't show them if $PAGER is not present:

$ ../git log
$ echo $?
0
$ PAGER=3D/bin/cat ../git log
commit 3274a12f940680612e3bfd3d022a0eab460c0f1f
Author: usuario tuxedo ####### <tx#####@MachineName.(none)>
Date:   Thu Jun 3 20:02:23 2010 +0200

    OtherCom

commit acf110f7c878a37e4a5af8499134df28da0e8ab3
Author: usuario tuxedo ####### <tx#####@MachineName.(none)>
Date:   Thu Jun 3 20:01:37 2010 +0200

    inicial

> In any case, running git's make test might reveal other problems on
> AIX worth fixing. Maybe do that and post the results?
>

The make test execution output is fairly long... do I post it all, or
attach MIME? However I'm leaving here and I cannot access the server
until tomorrow...


>>>> $ /usr/linux/bin/make prefix=3D$HOME/apps/ NO_OPENSSL=3D1 NO_TCLTK=
=3D1
>>>> NO_EXPAT=3D1 PYTHON_PATH=3D/usr/local/bin/python install
>>>>
>>>> [...]
>>>> install -d -m 755 '/myhomedir/apps/bin'
>>>> getopt: illegal option -- d
>>>> Usage: install [-c dira] [-f dirb] [-i] [-m] [-M mode] [-O owner]
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 [-G group] [-S] [-n dirc] [-o] [-s] fi=
le [dirx ...]
>>>> make: *** [install] Error 2
>>>>
>>>> Now the installing process fails because of the AIX 'install' tool=
 and
>>>> I wonder, can I patch/configure the installing process for AIX? Ma=
y be
>>>> a set of utils for building in such systems would help some people=
=2E
>>>
>>> Does AIX's install have something equivalent to GNU install's -d? T=
he
>>> -c and -f options look likely from that synopsis.
>>>
>>
>> I don't know since I just use this system for development and testin=
g
>> (I'm debian user), but let me post the manpage info, for -c and -f:
>>
>> -c DirectoryA Installs a new command file in the DirectoryA variable=
 only if
>> that file does not already exist there. If it finds a copy of File t=
here, it
>> issues a message and exits without overwriting the file. This flag c=
an be used
>> alone or with the -s, -M, -O, -G, or -S flag.
>>
>> -f DirectoryB Forces installation of File in DirectoryB whether or n=
ot File
>> already exists. If the file being installed does not already exist, =
the command
>> sets the permission code and owner of the new file to 755 and bin, r=
espectively.
>> This flag can be used alone or with the -o,-s, -M, -O, -G, or -S fla=
g.
>
> Looks like there's no equivalent to -d. FWIW perl uses a installperl
> script that also works on AIX. Maybe a similar fallback or default
> would make sense for Git.
>

Yes, I installed 'top' on other AIX machine today, and it uses it's
own install script too... may be it's the best way for systems having
a poor 'install' tool.

>>>> PD2: I don't know if AIX python path is always /usr/local/bin/pyth=
on,
>>>> but I've seen that git Makefiles set /usr/local/bin/python for Fre=
eBSD
>>>> only:
>>>>
>>>> git_remote_helpers/Makefile:
>>>> ifndef PYTHON_PATH
>>>> =A0 =A0 =A0 =A0ifeq ($(uname_S),FreeBSD)
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0PYTHON_PATH =3D /usr/local/bin/pyth=
on
>>>> =A0 =A0 =A0 =A0else
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0PYTHON_PATH =3D /usr/bin/python
>>>> =A0 =A0 =A0 =A0endif
>>>> endif
>>>
>>> That's presumably because Python is most likely installed via the
>>> ports system on FreeBSD which drops it in /usr/local. How did you
>>> install Python on AIX? Is it from some IBM package or another metho=
d
>>> that's the most common & standard way to do it on AIX?.
>>>
>>
>> Again, I don't know since I'm not the sysadmin. I just looked for
>> python and found it's in /usr/local/bin
>
> Does using /usr/bin/env python instead work?
>
> =A0 =A0$ cat /tmp/py.py
> =A0 =A0#!/usr/bin/env python
> =A0 =A0print "hello"
> =A0 =A0$ /tmp/py.py
> =A0 =A0hello
>

Yes, it works... at least the executable is found :P

$ cat temp.py
#!/usr/bin/env python
print "hello"

$ ./temp.py
Could not find platform dependent libraries <exec_prefix>
Consider setting $PYTHONHOME to <prefix>[:<exec_prefix>]
hello


Cheers,
Dario

From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Installing on AIX fails
Date: Thu, 3 Jun 2010 20:21:54 +0000
Message-ID: <AANLkTin-jf2ihZlAy-p4-75PSe6X78tz8XlzySE5fogN@mail.gmail.com>
References: <AANLkTinKjEBkn-9ajO4QXyHqY0EOQBGPRgNREaC_p_vQ@mail.gmail.com>
	<AANLkTilsQaMQyDP_od2NrfwIV7gvoD3R-yKNlMJjVKCA@mail.gmail.com>
	<AANLkTikfQdwDoZylaKC_siuwaLrLP4JkMh2fnvwNbxqe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Dario Rodriguez <soft.d4rio@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 03 22:22:00 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKGvP-00036q-Ta
	for gcvg-git-2@lo.gmane.org; Thu, 03 Jun 2010 22:22:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754494Ab0FCUVz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Jun 2010 16:21:55 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:48057 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754178Ab0FCUVy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Jun 2010 16:21:54 -0400
Received: by iwn37 with SMTP id 37so283221iwn.19
        for <git@vger.kernel.org>; Thu, 03 Jun 2010 13:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=nxCo7u1x1QKvZQsjIqfktplibOvZjhXOxw0wsZbXl40=;
        b=WVsPI0MVvOgWsZenSD58/7YUfTUvvZ63zjx99oabpMdVoamBBgtoMSUFhJ3EBKk/S9
         6mjHX9S+7Yi6NyzfM+mdv5vYnzv+mYHcAR6RDbFXmpikMh722tzFbWzB9IjC6p+yleju
         4wh2tDSlGrNd8DBFelwtG6e7bFen9pvIIEMJs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=qVt9HaD03ZJzFaa/OsTRiTbqD1pdi4dRKq+ZCt0mIpFe9y3r9xHVOFO+p4Dhm3qoFJ
         9PWk/w6+K5anmOGIEI7uTEJlFTqJJG4kLYdh2UjCpKN3X8o5DU3YgzPdSW2SCMjijMyy
         hWAi2cuPb68dQXa0pnSKUrOfCl/u+G+PT9gy8=
Received: by 10.231.148.145 with SMTP id p17mr560743ibv.28.1275596514126; Thu, 
	03 Jun 2010 13:21:54 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Thu, 3 Jun 2010 13:21:54 -0700 (PDT)
In-Reply-To: <AANLkTikfQdwDoZylaKC_siuwaLrLP4JkMh2fnvwNbxqe@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148360>

On Thu, Jun 3, 2010 at 20:01, Dario Rodriguez <soft.d4rio@gmail.com> wr=
ote:
> On Thu, Jun 3, 2010 at 12:41 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmas=
on
> <avarab@gmail.com> wrote:
>> On Thu, Jun 3, 2010 at 15:32, Dario Rodriguez <soft.d4rio@gmail.com>=
 wrote:
>>> and it all works, with angels singing and everything... a testing r=
epo
>>> works fine for a test drive without installing, excepting 'git log'
>>> that just don't display anything.
>>
>> How about PAGER=3D/bin/cat git log? If that works what's your pager,=
 and
>> do other git commands that use the pager (like git show) work or fai=
l?
>>
>
> PAGER is not set by default as I see, but... isn't there any default
> pager for git in case of PAGER being unset?
>
> Using /bin/cat or /bin/more it works (either 'log' or 'show')

What do you mean by "disappears" anyway, was it like $(echo|less), or
did it just return with no output? What was the exit code?

In any case, running git's make test might reveal other problems on
AIX worth fixing. Maybe do that and post the results?

>>> $ /usr/linux/bin/make prefix=3D$HOME/apps/ NO_OPENSSL=3D1 NO_TCLTK=3D=
1
>>> NO_EXPAT=3D1 PYTHON_PATH=3D/usr/local/bin/python install
>>>
>>> [...]
>>> install -d -m 755 '/myhomedir/apps/bin'
>>> getopt: illegal option -- d
>>> Usage: install [-c dira] [-f dirb] [-i] [-m] [-M mode] [-O owner]
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [-G group] [-S] [-=
n dirc] [-o] [-s] file [dirx ...]
>>> make: *** [install] Error 2
>>>
>>> Now the installing process fails because of the AIX 'install' tool =
and
>>> I wonder, can I patch/configure the installing process for AIX? May=
 be
>>> a set of utils for building in such systems would help some people.
>>
>> Does AIX's install have something equivalent to GNU install's -d? Th=
e
>> -c and -f options look likely from that synopsis.
>>
>
> I don't know since I just use this system for development and testing
> (I'm debian user), but let me post the manpage info, for -c and -f:
>
> -c DirectoryA Installs a new command file in the DirectoryA variable =
only if
> that file does not already exist there. If it finds a copy of File th=
ere, it
> issues a message and exits without overwriting the file. This flag ca=
n be used
> alone or with the -s, -M, -O, -G, or -S flag.
>
> -f DirectoryB Forces installation of File in DirectoryB whether or no=
t File
> already exists. If the file being installed does not already exist, t=
he command
> sets the permission code and owner of the new file to 755 and bin, re=
spectively.
> This flag can be used alone or with the -o,-s, -M, -O, -G, or -S flag=
=2E

Looks like there's no equivalent to -d. FWIW perl uses a installperl
script that also works on AIX. Maybe a similar fallback or default
would make sense for Git.

>>> PD2: I don't know if AIX python path is always /usr/local/bin/pytho=
n,
>>> but I've seen that git Makefiles set /usr/local/bin/python for Free=
BSD
>>> only:
>>>
>>> git_remote_helpers/Makefile:
>>> ifndef PYTHON_PATH
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0ifeq ($(uname_S),FreeBSD)
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PYTHON_PATH =
=3D /usr/local/bin/python
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0else
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PYTHON_PATH =
=3D /usr/bin/python
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0endif
>>> endif
>>
>> That's presumably because Python is most likely installed via the
>> ports system on FreeBSD which drops it in /usr/local. How did you
>> install Python on AIX? Is it from some IBM package or another method
>> that's the most common & standard way to do it on AIX?.
>>
>
> Again, I don't know since I'm not the sysadmin. I just looked for
> python and found it's in /usr/local/bin

Does using /usr/bin/env python instead work?

    $ cat /tmp/py.py
    #!/usr/bin/env python
    print "hello"
    $ /tmp/py.py
    hello

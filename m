From: =?koi8-r?B?y9PP18nSwc4=?= <xowirun@yandex.ru>
Subject: Re: git and cyrillic branches
Date: Fri, 26 Jul 2013 11:35:01 +0400
Message-ID: <1094181374824101@web4h.yandex.ru>
References: <922031374754788@web29h.yandex.ru> <51F1D5F7.5060101@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Konstantin Khomoutov <kostix+git@007spb.ru>,
	martin.langhoff@gmail.com
To: =?utf-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Fri Jul 26 09:41:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V2ceJ-0000Jm-Uh
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jul 2013 09:41:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753454Ab3GZHlM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Jul 2013 03:41:12 -0400
Received: from forward1h.mail.yandex.net ([84.201.187.146]:46630 "EHLO
	forward1h.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752595Ab3GZHlL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jul 2013 03:41:11 -0400
X-Greylist: delayed 363 seconds by postgrey-1.27 at vger.kernel.org; Fri, 26 Jul 2013 03:41:11 EDT
Received: from web4h.yandex.ru (web4h.yandex.ru [84.201.186.33])
	by forward1h.mail.yandex.net (Yandex) with ESMTP id BD2EF9E0690;
	Fri, 26 Jul 2013 11:35:02 +0400 (MSK)
Received: from 127.0.0.1 (localhost.localdomain [127.0.0.1])
	by web4h.yandex.ru (Yandex) with ESMTP id 87EF3D5801A;
	Fri, 26 Jul 2013 11:35:01 +0400 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1374824102; bh=PoaW7Gg5OsCYzxAzJOrzE8lrfhXXup0wKgC2NB4PjbQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Bsbt/K8rc7MMeZv4t3CQIzjKwFFfjOCXaEuF8AcyiHfJcB+uWwMXC4GqIzYFbhDEo
	 +b25CgI9m/uCzskqd76aKSfzF8Beq+RWDHbQrDwUDMZrddUmx1pGx+xAJADNO5il0c
	 XwQNkJF6WytTubGFzfn7Bh7otqhhPdHqaL+LKc8Y=
Received: from client.yota.ru (client.yota.ru [188.162.36.99]) by web4h.yandex.ru with HTTP;
	Fri, 26 Jul 2013 11:35:01 +0400
In-Reply-To: <51F1D5F7.5060101@web.de>
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231172>



26.07.2013, 05:50, "Torsten B=C3=B6gershausen" <tboegi@web.de>:
> On 2013-07-25 14.19, =D0=B8=D0=B2=D0=B0=D0=BD=D0=BE=D0=B2 =D0=B8=D0=B2=
=D0=B0=D0=BD wrote:
>
>> =C2=A0hello! there is problem vith git and cyrillic (utf-8) names of=
 branches. branch creates perfectly, but when i clone this remote branc=
h to local host, there are 2 bugs:
>> =C2=A01) "git branch" doesnt show checked branch with asterisk (whil=
e on remote server it does)
>> =C2=A02) "git push" gives 2 errors: "fatal: BRANCH_NAME cannot be re=
solved to branch." and "fatal: The remote end hung up unexpectedly"
>> =C2=A0thanks.
>
> It could be helpful if you could provide more information.
> The best could be a step-by-step instruction using a some "mini repo"=
,
> so that we we can reproduce the problem.
> I have done an illustrating example using UTF-8,
> (not cyrillic, I don't have these letters on my keyboard ;-)
>
> tb@linux:~$ mkdir cyrill
> tb@linux:~$ cd cyrill/
> tb@linux:~/cyrill$ git init
> Initialized empty Git repository in /home/tb/cyrill/.git/
> tb@linux:~/cyrill$ echo File>File
> tb@linux:~/cyrill$ git checkout -b br=C3=A4nch
> Switched to a new branch 'br=C3=A4nch'
> tb@linux:~/cyrill$ git add File
> tb@linux:~/cyrill$ git commit -m "Add File"
> [br=C3=A4nch (root-commit) e39d84e] Add File
> =C2=A01 file changed, 1 insertion(+)
> =C2=A0create mode 100644 "File"
> tb@linux:~/cyrill$ git branch
> * br=C3=A4nch
> tb@linux:~/cyrill$
>
> tb@macos:~> git clone tb@linux:~/cyrill
> Cloning into 'cyrill'...
> tb@linux's password:
> remote: Counting objects: 3, done.
> Receiving objects: 100% (3/3), done.
> remote: Total 3 (delta 0), reused 0 (delta 0)
> tb@macos:~> cd cyrill/
> tb@macos:~/cyrill> git branch
> * br=C3=A4nch
> tb@macos:~/cyrill> ls -l
> total 8
> -rw-r--r-- =C2=A01 tb =C2=A0staff =C2=A06 Jul 26 03:39 File
> tb@macos:~/cyrill>
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Other question:
> what does (on Mac OS)
> git config core.precomposeunicode
> give you?
> /Torsten

okay, i've changed core.precomposeunicode to true and seems it solved t=
he problem, branches are listed just fine and git push goes good as wel=
l. i didn't look that way at first time, thought that is case for filen=
ames only, not branches.
thank you all for responces, i guess this time problem is really solved=
 now. :)

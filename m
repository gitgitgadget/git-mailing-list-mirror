From: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
Subject: Re: problem with BOINC repository and CR/LF
Date: Mon, 17 Dec 2012 17:01:47 +0100
Message-ID: <50CF41EB.1060402@gmx.de>
References: <50CEF289.4040503@gmx.de> <CAH5451=FpmtGVVJ=mubE0KeD-tTVaNU96audzTRnNQh2BEEXPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Andrew Ardill <andrew.ardill@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 17 17:02:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tkd8r-0001Ae-2m
	for gcvg-git-2@plane.gmane.org; Mon, 17 Dec 2012 17:02:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752785Ab2LQQBv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Dec 2012 11:01:51 -0500
Received: from mout.gmx.net ([212.227.17.21]:49342 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752175Ab2LQQBu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2012 11:01:50 -0500
Received: from mailout-de.gmx.net ([10.1.76.72]) by mrigmx.server.lan
 (mrigmx001) with ESMTP (Nemesis) id 0MaGJS-1TQlrp0fdo-00Jt89 for
 <git@vger.kernel.org>; Mon, 17 Dec 2012 17:01:49 +0100
Received: (qmail invoked by alias); 17 Dec 2012 16:01:48 -0000
Received: from f054055138.adsl.alicedsl.de (EHLO [78.54.55.138]) [78.54.55.138]
  by mail.gmx.net (mp072) with SMTP; 17 Dec 2012 17:01:48 +0100
X-Authenticated: #5108953
X-Provags-ID: V01U2FsdGVkX18zetdtuxMzLpWSIWNLtFXgtb7yjK9n/yW50NzMmT
	t1Bbvn2HtG71E0
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <CAH5451=FpmtGVVJ=mubE0KeD-tTVaNU96audzTRnNQh2BEEXPg@mail.gmail.com>
X-Enigmail-Version: 1.4.6
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211689>

On 12/17/2012 12:38 PM, Andrew Ardill wrote:
> On 17 December 2012 21:23, Toralf F=C3=B6rster <toralf.foerster@gmx.d=
e> wrote:
>> Hello,
>>
>> I'm faced with this situation :
>> http://lists.ssl.berkeley.edu/mailman/private/boinc_alpha/2012-Decem=
ber/017371.html
>> and even a "git stash" doesn't help.
>=20
> Hi Toralf,
>=20
> That list is private and not visible without an account. Can you
> transcribe the relevant parts?
>=20
> Regards,
>=20
> Andrew Ardill
>=20
Oh of course :


On 12/17/2012 12:03 AM, Gianfranco Costamagna wrote:
> So if you have further issues with boinc feel free to look in our deb=
ian
> git and feel free to download appropriate patches :-)
>
> Gianfranco
thx

Currently I'm struggling with a git problem of the boinc repository
itself and b/c I'm using git for the linux kernel tree w/o any problems
since eons /me wonders whether this is a BOINC-repository specific prob=
lem :


After doing the following sequence with git 1.8.0.2 :

$> git clone git://boinc.berkeley.edu/boinc.git
$> cd boinc
$> git checkout client_release_7.0.39
$> git checkout master
(sometimes I've to repeat this :
	$> git checkout client_release_7.0.39
	$> git checkout master
)
I'm faced with this situation :

$ git status
# On branch master
# Changes not staged for commit:
#   (use "git add <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working
directory)
#
#       modified:   clientgui/AsyncRPC.cpp
#       modified:   clientgui/sg_BoincSimpleFrame.cpp
#
no changes added to commit (use "git add" and/or "git commit -a")

(sometimes only clientgui/sg_BoincSimpleFrame.cpp is mentioned)

Now these commands

$ git checkout -- clientgui/AsyncRPC.cpp
$ git checkout -- clientgui/sg_BoincSimpleFrame.cpp

doesn't help - the status is still the same (and ofc now I'm no longer
allowed to make a "git checkout" - due to un-commited changes).

Now I'm wondering where to start to investigate this issue ...

--=20
MfG/Sincerely
Toralf F=C3=B6rster
pgp finger print: 7B1A 07F4 EC82 0F90 D4C2 8936 872A E508 7DB6 9DA3

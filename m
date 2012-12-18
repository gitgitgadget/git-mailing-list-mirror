From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: problem with BOINC repository and CR/LF
Date: Tue, 18 Dec 2012 13:15:30 +0100
Message-ID: <50D05E62.7090605@web.de>
References: <50CEF289.4040503@gmx.de> <CAH5451=FpmtGVVJ=mubE0KeD-tTVaNU96audzTRnNQh2BEEXPg@mail.gmail.com> <50CF41EB.1060402@gmx.de> <CAH5451=xiipSKrAb_DFXCW=+NAn+mnSm1zPzjhEVc8fZ2KGcnw@mail.gmail.com> <50D03D80.3090005@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andrew Ardill <andrew.ardill@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
X-From: git-owner@vger.kernel.org Tue Dec 18 13:15:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tkw5P-00057E-Gh
	for gcvg-git-2@plane.gmane.org; Tue, 18 Dec 2012 13:15:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754648Ab2LRMPe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Dec 2012 07:15:34 -0500
Received: from mout.web.de ([212.227.15.4]:53476 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754352Ab2LRMPd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2012 07:15:33 -0500
Received: from [192.168.209.26] ([195.67.191.23]) by smtp.web.de (mrweb102)
 with ESMTPA (Nemesis) id 0LlneG-1TBsNW38xk-00ZTGx; Tue, 18 Dec 2012 13:15:31
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <50D03D80.3090005@gmx.de>
X-Provags-ID: V02:K0:0Y9+lpL+MHH+fjmz48QYbXL34byLHKFQtKYg7KAEv57
 uHRh5zh4rZnWjzafF3zNJaeNG/xo/PrEFm27nWnUf1VvwdMe2X
 PqI/MLujHMUFG3l2PUulELzfjJvFerWqbb50BW7G4YgH/J4DC4
 VOLGEuLqs0dGDhEeyfHOXklVq5FCk92DGtG/T50HLHTDl5zEYm
 aVENMinbGFOzU5a1JRhAw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211745>

On 18.12.12 10:55, Toralf F=C3=B6rster wrote:
> On 12/18/2012 02:56 AM, Andrew Ardill wrote:
>> On 18 December 2012 03:01, Toralf F=C3=B6rster <toralf.foerster@gmx.=
de> wrote:
>>> On 12/17/2012 12:38 PM, Andrew Ardill wrote:
>>>> On 17 December 2012 21:23, Toralf F=C3=B6rster <toralf.foerster@gm=
x.de> wrote:
>>>>> Hello,
>>>>>
>>>>> I'm faced with this situation :
>>>>> http://lists.ssl.berkeley.edu/mailman/private/boinc_alpha/2012-De=
cember/017371.html
>>>>> and even a "git stash" doesn't help.
>>>>
>>>> Hi Toralf,
>>>>
>>>> That list is private and not visible without an account. Can you
>>>> transcribe the relevant parts?
>>>>
>>>> Regards,
>>>>
>>>> Andrew Ardill
>>>>
>>> Oh of course :
>>>
>>>
>>> On 12/17/2012 12:03 AM, Gianfranco Costamagna wrote:
>>>> So if you have further issues with boinc feel free to look in our =
debian
>>>> git and feel free to download appropriate patches :-)
>>>>
>>>> Gianfranco
>>> thx
>>>
>>> Currently I'm struggling with a git problem of the boinc repository
>>> itself and b/c I'm using git for the linux kernel tree w/o any prob=
lems
>>> since eons /me wonders whether this is a BOINC-repository specific =
problem :
>>>
>>>
>>> After doing the following sequence with git 1.8.0.2 :
>>>
>>> $> git clone git://boinc.berkeley.edu/boinc.git
>>> $> cd boinc
>>> $> git checkout client_release_7.0.39
>>> $> git checkout master
>>> (sometimes I've to repeat this :
>>>         $> git checkout client_release_7.0.39
>>>         $> git checkout master
>>> )
>>> I'm faced with this situation :
>>>
>>> $ git status
>>> # On branch master
>>> # Changes not staged for commit:
>>> #   (use "git add <file>..." to update what will be committed)
>>> #   (use "git checkout -- <file>..." to discard changes in working
>>> directory)
>>> #
>>> #       modified:   clientgui/AsyncRPC.cpp
>>> #       modified:   clientgui/sg_BoincSimpleFrame.cpp
>>> #
>>> no changes added to commit (use "git add" and/or "git commit -a")
>>>
>>> (sometimes only clientgui/sg_BoincSimpleFrame.cpp is mentioned)
>>>
>>> Now these commands
>>>
>>> $ git checkout -- clientgui/AsyncRPC.cpp
>>> $ git checkout -- clientgui/sg_BoincSimpleFrame.cpp
>>>
>>> doesn't help - the status is still the same (and ofc now I'm no lon=
ger
>>> allowed to make a "git checkout" - due to un-commited changes).
>>>
>>> Now I'm wondering where to start to investigate this issue ...
>>
>> Hi Toralf,
>>
>> That does look like a weird issue. What operating system are you on?
>=20
> I'm running a stable Gentoo Linux x86, 32bit with gcc 4.6.3 and curre=
nt
> stable kernel 3.6.1x and 3.7.1, file system is ext4 at an external US=
B
> 2.0 drive.
>=20
> FWIW from the boinc maintainer I know that all tags till 7.0.3X are
> imported from svn.
>=20
> I upgraded to git 1.8.0.2 from 1.7.8.6 - situation is the same. The
> emerge gave :
>=20
> failed test(s): t3600 t7508
>=20
> fixed   0
> success 8342
> failed  8
> broken  56
> total   8528
>=20
> Ok, now answering your other questions:
>=20
>=20
> $> git stash
> warning: CRLF will be replaced by LF in clientgui/AsyncRPC.cpp.
> The file will have its original line endings in your working director=
y.
> warning: CRLF will be replaced by LF in clientgui/sg_BoincSimpleFrame=
=2Ecpp.
> The file will have its original line endings in your working director=
y.
> warning: CRLF will be replaced by LF in clientgui/AsyncRPC.cpp.
> The file will have its original line endings in your working director=
y.
> warning: CRLF will be replaced by LF in clientgui/sg_BoincSimpleFrame=
=2Ecpp.
> The file will have its original line endings in your working director=
y.
> Saved working directory and index state WIP on master: 4a296dc - clie=
nt
> simulator: fix build errors
> HEAD is now at 4a296dc - client simulator: fix build errors
>=20
> After that the situation is unchanged.
>=20
>> What happens if you do a hard reset to the branch?
>=20
> $> git reset --hard HEAD~1
>=20
> not better.
>=20
>=20
>> What is the ouptut of git diff --cached ?
>=20
> The output is empty but "git status" shows still modified files.
>=20
>=20
>=20
> FWIW there's a related issue I'm wondering about which might help:
>=20
> $> git clone git://boinc.berkeley.edu/boinc.git
> $> tar -cpf boinc.tar boinc/
> $> rm -rf boinc/
> $> tar -xpf boinc.tar
> $> cd boinc/
> $> git status
> # On branch master
> # Changes not staged for commit:
> #   (use "git add <file>..." to update what will be committed)
> #   (use "git checkout -- <file>..." to discard changes in working
> directory)
> #
> #       modified:   client/win/boinc_log.h
> #       modified:   client/win/boinc_log.rc
> #       modified:   clientctrl/boincsvcctrl.cpp
> #       modified:   clientctrl/boincsvcctrl.h
> #       modified:   clientctrl/boincsvcctrl.rc
> #       modified:   clientgui/AsyncRPC.cpp
> #       modified:   clientgui/DlgEventLog.cpp
> #       modified:   clientgui/DlgEventLog.h
> #       modified:   clientgui/DlgEventLogListCtrl.cpp
> #       modified:   clientgui/DlgEventLogListCtrl.h
> #       modified:   clientgui/DlgExitMessage.h
> #       modified:   clientgui/DlgItemProperties.h
> #       modified:   clientgui/TermsOfUsePage.cpp
> #       modified:   clientgui/TermsOfUsePage.h
> #       modified:   clientgui/ViewNotices.cpp
> #       modified:   clientgui/ViewNotices.h
> #       modified:   clientgui/sg_BoincSimpleFrame.cpp
> #       modified:   clientscr/boinc_ss_opengl.h
> #       modified:   clientscr/boinc_ss_opengl.rc
> #       modified:   clientscr/screensaver.cpp
> #       modified:   clienttray/boinc_tray.h
> #       modified:   clienttray/boinc_tray.rc
> #       modified:   clienttray/tray_win.cpp
> #       modified:   clienttray/tray_win.h
> #       modified:   coprocs/NVIDIA/include/nvapi.h
> #
> no changes added to commit (use "git add" and/or "git commit -a")
> $> git diff --cached
> $>
>=20
>=20
>=20
> Meaning, w/o any other interaction a tar'ed archive has modified file=
s -
> and the diff is empty...
>=20
Hej,

I could re-produce the problem here:
git version 1.8.0.197.g5a90748
Mac OS X (that what I had at hands fastest)


After doing=20
git checkout 5db4a05b5c8f9c420fc418727cafbb58e6051f1e
(same as master ?)
We see that=20
clientgui/AsyncRPC.cpp
is full of CRLF and as it seems only CRLF, no single LF.

The file is classified as text:
$git check-attr text  clientgui/AsyncRPC.cpp
$clientgui/AsyncRPC.cpp: text: set
(And we can see this in .gitattributes as well)

(And there are more files affected, but I will only look at one of them=
)

If we remove the text attribute like this:
$mv .gitattributes .gitattributes.sav
we see

$git status
deleted:    .gitattributes
#       modified:   clientgui/sg_BoincSimpleFrame.cpp


If we dig into the file:
$git ls-files -s clientgui/AsyncRPC.cpp
100644 6832333ad133181986ada54fe0229b45a30c614a 0       clientgui/Async=
RPC.cpp

We see that it is recorded under 6832333ad1
And if we look into it:
$git show  6832333 | od -c
[snip]
we can see that the file has CRLF in the repo.

So my conclusion is:
The file has CRLF in the repo, but should have LF.
This is not a good thing, and the files need to be normalized.

A very good instruction how to do this, is found here:
http://kernel.org/pub/software/scm/git/docs/gitattributes.html
(You may want to search for "End-of-line conversion" or "core.autocrlf"=
)

HTH
/Torsten


=20

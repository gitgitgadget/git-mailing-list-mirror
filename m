From: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
Subject: Re: problem with BOINC repository and CR/LF
Date: Tue, 18 Dec 2012 10:55:12 +0100
Message-ID: <50D03D80.3090005@gmx.de>
References: <50CEF289.4040503@gmx.de> <CAH5451=FpmtGVVJ=mubE0KeD-tTVaNU96audzTRnNQh2BEEXPg@mail.gmail.com> <50CF41EB.1060402@gmx.de> <CAH5451=xiipSKrAb_DFXCW=+NAn+mnSm1zPzjhEVc8fZ2KGcnw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Andrew Ardill <andrew.ardill@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 18 11:00:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tktyf-0006Fi-1L
	for gcvg-git-2@plane.gmane.org; Tue, 18 Dec 2012 11:00:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754454Ab2LRKA1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Dec 2012 05:00:27 -0500
Received: from mout.gmx.net ([212.227.15.19]:61658 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753862Ab2LRKA0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2012 05:00:26 -0500
X-Greylist: delayed 302 seconds by postgrey-1.27 at vger.kernel.org; Tue, 18 Dec 2012 05:00:25 EST
Received: from mailout-de.gmx.net ([10.1.76.32]) by mrigmx.server.lan
 (mrigmx002) with ESMTP (Nemesis) id 0MB0os-1TulGW4BL2-009u3j for
 <git@vger.kernel.org>; Tue, 18 Dec 2012 10:55:21 +0100
Received: (qmail invoked by alias); 18 Dec 2012 09:55:20 -0000
Received: from g224044128.adsl.alicedsl.de (EHLO [92.224.44.128]) [92.224.44.128]
  by mail.gmx.net (mp032) with SMTP; 18 Dec 2012 10:55:20 +0100
X-Authenticated: #5108953
X-Provags-ID: V01U2FsdGVkX1/XZpkpB4nXwmZVnXBQyMf7CZaHGXlp/Hm3g2CJMJ
	bVc6p3ipbP4uIW
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <CAH5451=xiipSKrAb_DFXCW=+NAn+mnSm1zPzjhEVc8fZ2KGcnw@mail.gmail.com>
X-Enigmail-Version: 1.4.6
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211742>

On 12/18/2012 02:56 AM, Andrew Ardill wrote:
> On 18 December 2012 03:01, Toralf F=C3=B6rster <toralf.foerster@gmx.d=
e> wrote:
>> On 12/17/2012 12:38 PM, Andrew Ardill wrote:
>>> On 17 December 2012 21:23, Toralf F=C3=B6rster <toralf.foerster@gmx=
=2Ede> wrote:
>>>> Hello,
>>>>
>>>> I'm faced with this situation :
>>>> http://lists.ssl.berkeley.edu/mailman/private/boinc_alpha/2012-Dec=
ember/017371.html
>>>> and even a "git stash" doesn't help.
>>>
>>> Hi Toralf,
>>>
>>> That list is private and not visible without an account. Can you
>>> transcribe the relevant parts?
>>>
>>> Regards,
>>>
>>> Andrew Ardill
>>>
>> Oh of course :
>>
>>
>> On 12/17/2012 12:03 AM, Gianfranco Costamagna wrote:
>>> So if you have further issues with boinc feel free to look in our d=
ebian
>>> git and feel free to download appropriate patches :-)
>>>
>>> Gianfranco
>> thx
>>
>> Currently I'm struggling with a git problem of the boinc repository
>> itself and b/c I'm using git for the linux kernel tree w/o any probl=
ems
>> since eons /me wonders whether this is a BOINC-repository specific p=
roblem :
>>
>>
>> After doing the following sequence with git 1.8.0.2 :
>>
>> $> git clone git://boinc.berkeley.edu/boinc.git
>> $> cd boinc
>> $> git checkout client_release_7.0.39
>> $> git checkout master
>> (sometimes I've to repeat this :
>>         $> git checkout client_release_7.0.39
>>         $> git checkout master
>> )
>> I'm faced with this situation :
>>
>> $ git status
>> # On branch master
>> # Changes not staged for commit:
>> #   (use "git add <file>..." to update what will be committed)
>> #   (use "git checkout -- <file>..." to discard changes in working
>> directory)
>> #
>> #       modified:   clientgui/AsyncRPC.cpp
>> #       modified:   clientgui/sg_BoincSimpleFrame.cpp
>> #
>> no changes added to commit (use "git add" and/or "git commit -a")
>>
>> (sometimes only clientgui/sg_BoincSimpleFrame.cpp is mentioned)
>>
>> Now these commands
>>
>> $ git checkout -- clientgui/AsyncRPC.cpp
>> $ git checkout -- clientgui/sg_BoincSimpleFrame.cpp
>>
>> doesn't help - the status is still the same (and ofc now I'm no long=
er
>> allowed to make a "git checkout" - due to un-commited changes).
>>
>> Now I'm wondering where to start to investigate this issue ...
>=20
> Hi Toralf,
>=20
> That does look like a weird issue. What operating system are you on?

I'm running a stable Gentoo Linux x86, 32bit with gcc 4.6.3 and current
stable kernel 3.6.1x and 3.7.1, file system is ext4 at an external USB
2.0 drive.

=46WIW from the boinc maintainer I know that all tags till 7.0.3X are
imported from svn.

I upgraded to git 1.8.0.2 from 1.7.8.6 - situation is the same. The
emerge gave :

failed test(s): t3600 t7508

fixed   0
success 8342
failed  8
broken  56
total   8528

Ok, now answering your other questions:


$> git stash
warning: CRLF will be replaced by LF in clientgui/AsyncRPC.cpp.
The file will have its original line endings in your working directory.
warning: CRLF will be replaced by LF in clientgui/sg_BoincSimpleFrame.c=
pp.
The file will have its original line endings in your working directory.
warning: CRLF will be replaced by LF in clientgui/AsyncRPC.cpp.
The file will have its original line endings in your working directory.
warning: CRLF will be replaced by LF in clientgui/sg_BoincSimpleFrame.c=
pp.
The file will have its original line endings in your working directory.
Saved working directory and index state WIP on master: 4a296dc - client
simulator: fix build errors
HEAD is now at 4a296dc - client simulator: fix build errors

After that the situation is unchanged.

> What happens if you do a hard reset to the branch?

$> git reset --hard HEAD~1

not better.


> What is the ouptut of git diff --cached ?

The output is empty but "git status" shows still modified files.



=46WIW there's a related issue I'm wondering about which might help:

$> git clone git://boinc.berkeley.edu/boinc.git
$> tar -cpf boinc.tar boinc/
$> rm -rf boinc/
$> tar -xpf boinc.tar
$> cd boinc/
$> git status
# On branch master
# Changes not staged for commit:
#   (use "git add <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working
directory)
#
#       modified:   client/win/boinc_log.h
#       modified:   client/win/boinc_log.rc
#       modified:   clientctrl/boincsvcctrl.cpp
#       modified:   clientctrl/boincsvcctrl.h
#       modified:   clientctrl/boincsvcctrl.rc
#       modified:   clientgui/AsyncRPC.cpp
#       modified:   clientgui/DlgEventLog.cpp
#       modified:   clientgui/DlgEventLog.h
#       modified:   clientgui/DlgEventLogListCtrl.cpp
#       modified:   clientgui/DlgEventLogListCtrl.h
#       modified:   clientgui/DlgExitMessage.h
#       modified:   clientgui/DlgItemProperties.h
#       modified:   clientgui/TermsOfUsePage.cpp
#       modified:   clientgui/TermsOfUsePage.h
#       modified:   clientgui/ViewNotices.cpp
#       modified:   clientgui/ViewNotices.h
#       modified:   clientgui/sg_BoincSimpleFrame.cpp
#       modified:   clientscr/boinc_ss_opengl.h
#       modified:   clientscr/boinc_ss_opengl.rc
#       modified:   clientscr/screensaver.cpp
#       modified:   clienttray/boinc_tray.h
#       modified:   clienttray/boinc_tray.rc
#       modified:   clienttray/tray_win.cpp
#       modified:   clienttray/tray_win.h
#       modified:   coprocs/NVIDIA/include/nvapi.h
#
no changes added to commit (use "git add" and/or "git commit -a")
$> git diff --cached
$>



Meaning, w/o any other interaction a tar'ed archive has modified files =
-
and the diff is empty...

--=20
MfG/Sincerely
Toralf F=C3=B6rster
pgp finger print: 7B1A 07F4 EC82 0F90 D4C2 8936 872A E508 7DB6 9DA3

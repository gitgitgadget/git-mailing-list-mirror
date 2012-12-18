From: Andrew Ardill <andrew.ardill@gmail.com>
Subject: Re: problem with BOINC repository and CR/LF
Date: Tue, 18 Dec 2012 12:56:46 +1100
Message-ID: <CAH5451=xiipSKrAb_DFXCW=+NAn+mnSm1zPzjhEVc8fZ2KGcnw@mail.gmail.com>
References: <50CEF289.4040503@gmx.de> <CAH5451=FpmtGVVJ=mubE0KeD-tTVaNU96audzTRnNQh2BEEXPg@mail.gmail.com>
 <50CF41EB.1060402@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: =?UTF-8?Q?Toralf_F=C3=B6rster?= <toralf.foerster@gmx.de>
X-From: git-owner@vger.kernel.org Tue Dec 18 02:57:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TkmQw-0001bY-M0
	for gcvg-git-2@plane.gmane.org; Tue, 18 Dec 2012 02:57:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754091Ab2LRB5J convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Dec 2012 20:57:09 -0500
Received: from mail-qc0-f173.google.com ([209.85.216.173]:32969 "EHLO
	mail-qc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753221Ab2LRB5H convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Dec 2012 20:57:07 -0500
Received: by mail-qc0-f173.google.com with SMTP id b12so36963qca.18
        for <git@vger.kernel.org>; Mon, 17 Dec 2012 17:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=AW5R2vfhdTqsWq6MNTQ5tVoRsVCTkd5nj+V3/UAIBn0=;
        b=N3DGvTEe9H3kakUHOhANE1IoH7tcnAgy0nsC301Iu9PW+RX3FtCIgHzwqnxL4BDXj2
         D/3PBjwkQVEtrNZ/xTzh1w3jq5tV48KInd0QCUy6eoWmSvvUtPwGnDf5Q/ffNW0AmG/5
         e7wVM/UsD9+lvPnHeHr0eahrhKnqTUiRlWLW/OvfEi8kNQLUzql5lonzbuEMpBJsVJNC
         akI0Nzq2pQUqi7zB0+ckaVjRb7jzMPaBHX/r5WIHcePlV4/xGstymvU008AkJSn8Z6Bt
         fGqPSni9J0f9pAShXmY9o0/z1lvN7YVQQNZVL7ws6y4G49bBXTE0EXz+0E6kDdvO5+AO
         zeQg==
Received: by 10.224.223.80 with SMTP id ij16mr247583qab.8.1355795826562; Mon,
 17 Dec 2012 17:57:06 -0800 (PST)
Received: by 10.49.14.3 with HTTP; Mon, 17 Dec 2012 17:56:46 -0800 (PST)
In-Reply-To: <50CF41EB.1060402@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211730>

On 18 December 2012 03:01, Toralf F=C3=B6rster <toralf.foerster@gmx.de>=
 wrote:
> On 12/17/2012 12:38 PM, Andrew Ardill wrote:
>> On 17 December 2012 21:23, Toralf F=C3=B6rster <toralf.foerster@gmx.=
de> wrote:
>>> Hello,
>>>
>>> I'm faced with this situation :
>>> http://lists.ssl.berkeley.edu/mailman/private/boinc_alpha/2012-Dece=
mber/017371.html
>>> and even a "git stash" doesn't help.
>>
>> Hi Toralf,
>>
>> That list is private and not visible without an account. Can you
>> transcribe the relevant parts?
>>
>> Regards,
>>
>> Andrew Ardill
>>
> Oh of course :
>
>
> On 12/17/2012 12:03 AM, Gianfranco Costamagna wrote:
>> So if you have further issues with boinc feel free to look in our de=
bian
>> git and feel free to download appropriate patches :-)
>>
>> Gianfranco
> thx
>
> Currently I'm struggling with a git problem of the boinc repository
> itself and b/c I'm using git for the linux kernel tree w/o any proble=
ms
> since eons /me wonders whether this is a BOINC-repository specific pr=
oblem :
>
>
> After doing the following sequence with git 1.8.0.2 :
>
> $> git clone git://boinc.berkeley.edu/boinc.git
> $> cd boinc
> $> git checkout client_release_7.0.39
> $> git checkout master
> (sometimes I've to repeat this :
>         $> git checkout client_release_7.0.39
>         $> git checkout master
> )
> I'm faced with this situation :
>
> $ git status
> # On branch master
> # Changes not staged for commit:
> #   (use "git add <file>..." to update what will be committed)
> #   (use "git checkout -- <file>..." to discard changes in working
> directory)
> #
> #       modified:   clientgui/AsyncRPC.cpp
> #       modified:   clientgui/sg_BoincSimpleFrame.cpp
> #
> no changes added to commit (use "git add" and/or "git commit -a")
>
> (sometimes only clientgui/sg_BoincSimpleFrame.cpp is mentioned)
>
> Now these commands
>
> $ git checkout -- clientgui/AsyncRPC.cpp
> $ git checkout -- clientgui/sg_BoincSimpleFrame.cpp
>
> doesn't help - the status is still the same (and ofc now I'm no longe=
r
> allowed to make a "git checkout" - due to un-commited changes).
>
> Now I'm wondering where to start to investigate this issue ...

Hi Toralf,

That does look like a weird issue. What operating system are you on?

What happens if you do a hard reset to the branch?

What is the ouptut of git diff --cached ?

Regards,

Andrew Ardill

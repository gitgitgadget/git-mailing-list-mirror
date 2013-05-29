From: =?UTF-8?B?IsOBa29zLCBUYWp0aSI=?= <akos.tajti@intland.com>
Subject: Re: git init doesn't create master branch
Date: Wed, 29 May 2013 15:01:11 +0200
Message-ID: <51A5FC17.8000608@intland.com>
References: <51A5F8E0.8060906@intland.com> <vpqk3migdb1.fsf@anie.imag.fr> <CALkWK0m=m89QcnMNg9gEVeb7ZHSRd7ZMcL+y8gYuzn8YCTsSYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 29 15:01:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uhg0K-0007Pz-FV
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 15:01:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965820Ab3E2NBQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 May 2013 09:01:16 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:49499 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935093Ab3E2NBO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 09:01:14 -0400
Received: from [127.0.0.1] (188-143-39-115.pool.digikabel.hu [188.143.39.115])
	by mrelayeu.kundenserver.de (node=mreu2) with ESMTP (Nemesis)
	id 0LgL5M-1U2moW2zBc-00oJUE; Wed, 29 May 2013 15:01:12 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
In-Reply-To: <CALkWK0m=m89QcnMNg9gEVeb7ZHSRd7ZMcL+y8gYuzn8YCTsSYw@mail.gmail.com>
X-Antivirus: avast! (VPS 130529-0, 2013.05.29), Outbound message
X-Antivirus-Status: Clean
X-Provags-ID: V02:K0:m5EM96pnMlSqNvJ76VZ3KrgfhUXPPDTFJgLFO5WEsvi
 UmbFafNVPfFtrBypaZI3RvwqPtEnrXAwFIku8ndj2K4v6RA49v
 Smy8+FAip8z8DEN2jJBk5Aem2YF7+upnEsDPg5LBmF5JItLv8E
 gG7dvJGOMeOnnjQcnw6HkFcr6MzU1wp3JiQakloMlFJ58ObLlh
 R/Pzs13RMJIqtqfIw0LxVL2SsncqJYKUJZAktxvmpc438C/+Fu
 T1t4+pjgfCI/YhJqAiVsGs/031IhsYqeMz+A121Fz+6O1okl66
 JFEas+pJ2tWCzIRbOOe4SThOiEeACrF+XR114wBjKeyAHxCspx
 VHWyGer2MGRuBgfkGfnc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225807>

Thanks for clarifying this thing for me! I don't really insist on havin=
g=20
a master branch it's just that I tried to pull from a repository bundle=
=20
and I got this error message:

"Cannot merge multiple branches into empty head"

The command was:

git pull ../dump.dmp refs/heads/*:refs/heads/*

Is this a better way of doing this?

Thanks,
=C3=81kos

2013.05.29. 14:54 keltez=C3=A9ssel, Ramkumar Ramachandra =C3=ADrta:
> Matthieu Moy wrote:
>>> the manual of git init says: "An initial HEAD file that references =
the
>>> HEAD of the master branch is also created."
>>>
>>> However, after creating the repository using git init there's no
>>> master branch.
>> Right, but HEAD still points to it ;-). We sometimes call this an
>> "unborn branch".
> Right.  Let me also add that our prompt has support for this; on an
> unborn branch, my prompt looks like:
>
> artagnon|master#:/tmp/foo$
>                 ^
> 	       the # indicates unborn branch
>
> Please consider using contrib/completion/git-prompt.sh to make your l=
ife easier.

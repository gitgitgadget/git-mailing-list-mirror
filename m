From: =?ISO-8859-1?Q?Dirk_S=FCsserott?= <newsletter@dirk.my1.cc>
Subject: Re: Which msysGit version corresponds to which official Git version?
Date: Sun, 25 May 2008 17:19:56 +0200
Message-ID: <4839839C.2040605@dirk.my1.cc>
References: <48380E05.9020103@dirk.my1.cc> <3F512BCF-1D2E-46B0-84E5-4807753A2618@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?Dirk_S=FCsserott?= <newsletter@dirk.my1.cc>,
	Git Mailing List <git@vger.kernel.org>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sun May 25 17:21:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0I2C-0000zp-2d
	for gcvg-git-2@gmane.org; Sun, 25 May 2008 17:21:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752998AbYEYPUB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 May 2008 11:20:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752358AbYEYPUB
	(ORCPT <rfc822;git-outgoing>); Sun, 25 May 2008 11:20:01 -0400
Received: from smtprelay08.ispgateway.de ([80.67.29.8]:48564 "EHLO
	smtprelay08.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751269AbYEYPUA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 May 2008 11:20:00 -0400
Received: from [84.176.113.252] (helo=[192.168.2.100])
	by smtprelay08.ispgateway.de with esmtpa (Exim 4.68)
	(envelope-from <newsletter@dirk.my1.cc>)
	id 1K0I0s-0000lA-Hh; Sun, 25 May 2008 17:19:58 +0200
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
In-Reply-To: <3F512BCF-1D2E-46B0-84E5-4807753A2618@zib.de>
X-Df-Sender: 757646
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82863>

Steffen Prohaska schrieb:
>
> On May 24, 2008, at 2:45 PM, Dirk S=FCsserott wrote:
> [...]
>> I'd like to know which official Git version (as cloned
>> from git://git.kernel.org/pub/scm/git/git.git) corresponds
>> to my msysGit version.
>
> It's not in official git.git.  msysgit is based on official
> git 1.5.5, i.e. tag v1.5.5 (9d8318051).  msysGit adds, however,
> a lot of commits that are (not yet) in official git.git.
>
>> git checkout 9d258 didn't work.
>>
>> Any hints? Is there a Website or another mailing
>> list for msysGit?
>
> http://code.google.com/p/msysgit/
>
>     Steffen
Thanks a lot, that's exactly what I was looking for. :-)

BTW, I couldn't checkout the commit '9d8318051' you mentioned from git.=
git.
No such something, it said. When I checked out 'v1.5.5' it said my HEAD=
 is
now '1d2375d'. Probably I messed up my clone, but I thought the commit =
id
was unique for all time.

Whoa, stop. I re-cloned git.git to a different directory and succesfull=
y=20
checked
out 9d8318051. Look:

$ git clone git://git.kernel.org/pub/scm/git/git.git
  > Initialized empty Git repository in [...]/test/git/.git/
  > remote: Counting objects: 72806, done.?[K
  > remote: Compressing objects: 100% (22377/22377), done.?[K
  > remote: Total 72806 (delta 52252), reused 68863 (delta 49051)?[K
  > Receiving objects: 100% (72806/72806), 15.67 MiB | 202 KiB/s, done.
  > Resolving deltas: 100% (52252/52252), done.

$ cd git

$ git checkout 9d8318051
  > Note: moving to "9d8318051" which isn't a local branch
  > If you want to create a new branch from this checkout, you may do s=
o
  > (now or later) by using -b with the checkout command again. Example=
:
  >   git checkout -b <new_branch_name>
  > HEAD is now at 1d2375d... GIT 1.5.5

I'd expected that "HEAD is now at 9d8318051...". Wrong?
When I checkout "1d2375d" it says the very same:
  > HEAD is now at 1d2375d... GIT 1.5.5

So what's the difference then between 9d8318051 and 1d2375d?
gitk doesn't know about 9d8318051 at all. Seems that there are
two ways to get to v1.5.5: via 9d... and via 1d.... Is that right
or did I misunderstand sth. here?

    Dirk

From: =?iso-8859-1?Q?David_K=E5gedal?= <davidk@lysator.liu.se>
Subject: Re: "Read my lips: no more merges" - aka Linux 2.6.14-rc1
Date: Thu, 15 Sep 2005 10:39:08 +0200
Message-ID: <u5tvf12sp1v.fsf@lysator.liu.se>
References: <7255.1126583985@kao2.melbourne.sgi.com>
	<1126674993.5681.9.camel@localhost.localdomain>
	<1126745323.7199.3.camel@localhost.localdomain>
	<Pine.LNX.4.58.0509142018410.26803@g5.osdl.org>
	<43290486.5020301@zytor.com> <7v7jdibwqq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Thu Sep 15 10:43:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFpJf-0004JG-Ky
	for gcvg-git@gmane.org; Thu, 15 Sep 2005 10:42:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932198AbVIOIlp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 15 Sep 2005 04:41:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932217AbVIOIlp
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Sep 2005 04:41:45 -0400
Received: from main.gmane.org ([80.91.229.2]:20690 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932198AbVIOIlo (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Sep 2005 04:41:44 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1EFpHw-0003vm-PB
	for git@vger.kernel.org; Thu, 15 Sep 2005 10:40:12 +0200
Received: from 212214120186-virtutech-ab.host.songnetworks.se ([212.214.120.186])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 15 Sep 2005 10:40:12 +0200
Received: from davidk by 212214120186-virtutech-ab.host.songnetworks.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 15 Sep 2005 10:40:12 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 212214120186-virtutech-ab.host.songnetworks.se
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Cancel-Lock: sha1:sq+DS+ZqDwoOEr70Oot4LG79xQI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8597>

Junio C Hamano <junkio@cox.net> writes:

> "H. Peter Anvin" <hpa@zytor.com> writes:
>
>> Linus Torvalds wrote:
>>> On Wed, 14 Sep 2005, Alejandro Bonilla Beeche wrote:
>>>
>>>>debian:~# cd linux-2.6/
>>>>debian:~/linux-2.6# git log
>>>>/usr/local/bin/git-log-script: line 4: less: command not found
>>> A very strange Linux installation that doesn't come with "less"...
>>> What a strange box. Anyway, that does point out that maybe the git
>>> RPM spec should have "less" as a dependency.
>>
>> Generally you want to honour $PAGER if it is defined.
>
> We do, in the form of "something | ${PAGER:-less}".
>
> On Debian, "less" is Priority "standard" and my understanding is
> that the only thing we can (and should if I recall correctly)
> omit from the dependency list is the packages of Priority
> "essential", so technically we are required to list "less" as
> our dependency.  I do not know about RPM/Fedora.

On my Debian system, there is a "sensible-pager" which does a
${PAGER:-pager}, and "pager" which is a symlink to an installed pager
(using the 'alternatives' system).  So a Debian package should
probably use one of those.

--=20
David K=E5gedal

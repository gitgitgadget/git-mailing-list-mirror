From: Junio C Hamano <junkio@cox.net>
Subject: Re: "Read my lips: no more merges" - aka Linux 2.6.14-rc1
Date: Thu, 15 Sep 2005 00:45:01 -0700
Message-ID: <7v7jdibwqq.fsf@assigned-by-dhcp.cox.net>
References: <7255.1126583985@kao2.melbourne.sgi.com>
	<1126674993.5681.9.camel@localhost.localdomain>
	<1126745323.7199.3.camel@localhost.localdomain>
	<Pine.LNX.4.58.0509142018410.26803@g5.osdl.org>
	<43290486.5020301@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 15 09:46:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFoQf-000558-Dp
	for gcvg-git@gmane.org; Thu, 15 Sep 2005 09:45:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030468AbVIOHpF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Sep 2005 03:45:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965228AbVIOHpF
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Sep 2005 03:45:05 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:33514 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S965174AbVIOHpD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Sep 2005 03:45:03 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050915074501.NRJK17436.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 15 Sep 2005 03:45:01 -0400
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <43290486.5020301@zytor.com> (H. Peter Anvin's message of "Wed,
	14 Sep 2005 22:20:06 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8592>

"H. Peter Anvin" <hpa@zytor.com> writes:

> Linus Torvalds wrote:
>> On Wed, 14 Sep 2005, Alejandro Bonilla Beeche wrote:
>>
>>>debian:~# cd linux-2.6/
>>>debian:~/linux-2.6# git log
>>>/usr/local/bin/git-log-script: line 4: less: command not found
>> A very strange Linux installation that doesn't come with "less"...
>> What a strange box. Anyway, that does point out that maybe the git
>> RPM spec should have "less" as a dependency.
>
> Generally you want to honour $PAGER if it is defined.

We do, in the form of "something | ${PAGER:-less}".

On Debian, "less" is Priority "standard" and my understanding is
that the only thing we can (and should if I recall correctly)
omit from the dependency list is the packages of Priority
"essential", so technically we are required to list "less" as
our dependency.  I do not know about RPM/Fedora.

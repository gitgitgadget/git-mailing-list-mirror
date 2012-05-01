From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: Newbie grief
Date: Tue, 01 May 2012 14:39:44 -0700
Message-ID: <86aa1rmvhb.fsf@red.stonehenge.com>
References: <4F9F128C.5020304@palm.com>
	<201204302331.q3UNVo7o032303@no.baka.org> <4F9F3919.6060805@palm.com>
	<CAMK1S_jwVsyKrGoL5uVAiuRrOa8bz79-DAueBmHZE2k=PpcJ2Q@mail.gmail.com>
	<20120501111415.GD5769@thunk.org>
	<CAMK1S_jN_WdZF4W4szzyJqLfC3FmnhKQ65XQiD-JS_jxwSm8_g@mail.gmail.com>
	<4FA02830.3040407@palm.com> <86havzoi8h.fsf@red.stonehenge.com>
	<4FA04D02.6090702@palm.com> <86mx5rmx32.fsf@red.stonehenge.com>
	<4FA055D0.7040102@palm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sitaram Chamarty <sitaramc@gmail.com>, "Ted Ts'o" <tytso@mit.edu>,
	Seth Robertson <in-gitvger@baka.org>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Rich Pixley <rich.pixley@palm.com>
X-From: git-owner@vger.kernel.org Tue May 01 23:39:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPKnX-0008Hf-4z
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 23:39:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752392Ab2EAVjq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 May 2012 17:39:46 -0400
Received: from lax-gw15.mailroute.net ([199.89.0.115]:46098 "EHLO
	gw15.lax01.mailroute.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751185Ab2EAVjq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2012 17:39:46 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gw15.lax01.mailroute.net (Postfix) with ESMTP id BBF96E3624E;
	Tue,  1 May 2012 21:39:45 +0000 (GMT)
X-Virus-Scanned: by MailRoute
Received: from gw15.lax01.mailroute.net ([199.89.0.115])
	by localhost (gw15.lax01.mailroute.net.mailroute.net [127.0.0.1]) (mroute_mailscanner, port 10026)
	with LMTP id LaLe0rLFShnK; Tue,  1 May 2012 21:39:44 +0000 (GMT)
Received: from red.stonehenge.com (red.stonehenge.com [208.79.95.2])
	by gw15.lax01.mailroute.net (Postfix) with ESMTP id 87142E36269;
	Tue,  1 May 2012 21:39:44 +0000 (GMT)
Received: by red.stonehenge.com (Postfix, from userid 1001)
	id 4EDC01385; Tue,  1 May 2012 14:39:44 -0700 (PDT)
x-mayan-date: Long count = 12.19.19.6.6; tzolkin = 4 Cimi; haab = 9 Uo
In-Reply-To: <4FA055D0.7040102@palm.com> (Rich Pixley's message of "Tue, 01
	May 2012 14:29:52 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196757>

>>>>> "Rich" == Rich Pixley <rich.pixley@palm.com> writes:

>> I can always "git fetch origin" in my repo, and the remote
>> branches are in "origin/master, origin/foo, origin/bar".  Totally
>> separate from my working tree.

Rich> Sure.  You can fetch other branches, (unless you happen to be
Rich> checked out from them).  But you can't fetch to master if you're
Rich> checked out from master.

No, you are still missing it.

"git fetch" updates the remote tracking branches, which you commonly
reference preceded by "origin".  So "git fetch" DOES NOT TOUCH "master".
It touches only "origin/master".

Only when you merge that remote in to your local master do you need to
worry about dirty trees or broken merges.

Rich> My particular situation is that I'm developing a "feature" and to
Rich> do that, I need to be testing on multiple machines.  Tens of them.

I think you're now confusing git with a deploy system.  That is also
something that will lead you to unnecessary grief.  Pick a deploy system
that's not git, and integrate git with it.

Rich> I really don't want hundreds of named branches that I must
Rich> manually merge from constantly.

I don't see how you would end up with this.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Smalltalk/Perl/Unix consulting, Technical writing, Comedy, etc. etc.
See http://methodsandmessages.posterous.com/ for Smalltalk discussion

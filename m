From: Kent Borg <kentborg@borg.org>
Subject: Re: git-p4
Date: Mon, 13 Sep 2010 10:23:27 -0400
Message-ID: <4C8E33DF.7010904@borg.org>
References: <4C8A8CE8.90600@borg.org>	<20100910235323.773d2c5b@varda>	<AANLkTinmG5BU+yswWQ8=cRKT5WL_h8vWuUCu2PjZYb87@mail.gmail.com>	<4C8CF231.6090403@borg.org>	<AANLkTi=yJ5kVA17+40xc6NpEczFjgmYh7=w5k=GL_U9w@mail.gmail.com>	<4C8D14F9.90705@borg.org>	<AANLkTi=NGsY3wDiTLwNLpw4TJMpiSY8A=az_=v2fYDLj@mail.gmail.com>	<4C8D3303.1030302@borg.org> <AANLkTikrSt4djXep-o4Hr8EZAsiNXnqCHa2fLrys8T==@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Tor Arvid Lund <torarvid@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 13 16:23:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ov9wW-0007J7-JL
	for gcvg-git-2@lo.gmane.org; Mon, 13 Sep 2010 16:23:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751931Ab0IMOXc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Sep 2010 10:23:32 -0400
Received: from borg.org ([64.105.205.123]:51324 "EHLO borg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751495Ab0IMOXb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Sep 2010 10:23:31 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: kentborg)
	by borg.org (Postfix) with ESMTP id 3376D87822;
	Mon, 13 Sep 2010 10:23:28 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.24 (X11/20100411)
In-Reply-To: <AANLkTikrSt4djXep-o4Hr8EZAsiNXnqCHa2fLrys8T==@mail.gmail.com>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156093>

Tor Arvid Lund wrote:
>> I don't have time to try the "git p4 submit" now, I am going to be late
>> in meeting my wife.  Tomorrow morning...will it work?
>>     
>
> I'm optimistic :)

Um, not so great.

Two problems:

 - I was on the wrong branch this morning when I did the
   "git p4 submit" (stupid me),

 - I realize that even if I had done that right, part of my
   history is a big lump of Linux kernel files with no history
   but a sync out of Perforce.

So it seems what I need to do is get on a clean branch that has good
history and cherry-pick all the bits I want off the branch with the bad
ancestry onto the clean branch.  (And get a good "[git-p4: depot-paths:
..." in place.)

Then...just point p4/HEAD and p4/master and master to the newest commit
on that new clean branch.  Voila!

Possibly one of my last stupid questions on this: How do I do that? 
"p4/master" looks like a remote, but "git remote" doesn't seem to know
about it.  In gitg "master" is green, just like a branch I might create,
so I figure I can delete and re-create it where I want, but "p4/master"
and "p4/HEAD" is blue.  What are these blue things?  How do I move them
to a different commit?

Thanks,

-kb

From: Junio C Hamano <junkio@cox.net>
Subject: Re: contrib/ area
Date: Sat, 18 Feb 2006 01:02:49 -0800
Message-ID: <7v1wy1qbt2.fsf@assigned-by-dhcp.cox.net>
References: <7vmzgq451m.fsf@assigned-by-dhcp.cox.net>
	<cc723f590602170436l5b33ae6s1780c3c8d6383627@mail.gmail.com>
	<7voe15upnl.fsf@assigned-by-dhcp.cox.net>
	<cc723f590602180038i4186b38axa1cc7e06be385da0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 18 10:02:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FANzT-0000fm-5U
	for gcvg-git@gmane.org; Sat, 18 Feb 2006 10:02:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751046AbWBRJCv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 18 Feb 2006 04:02:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751083AbWBRJCv
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Feb 2006 04:02:51 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:24537 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1751046AbWBRJCu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Feb 2006 04:02:50 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060218090021.DZAN17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 18 Feb 2006 04:00:21 -0500
To: "Aneesh Kumar" <aneesh.kumar@gmail.com>
In-Reply-To: <cc723f590602180038i4186b38axa1cc7e06be385da0@mail.gmail.com>
	(Aneesh Kumar's message of "Sat, 18 Feb 2006 14:08:06 +0530")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16403>

"Aneesh Kumar" <aneesh.kumar@gmail.com> writes:

> How about sending the patches as attachment below. I am not sure how
> to inline patches in gmail.

For some reason, attachment is usually frowned upon, but if you
cannot do anything else, then at least please do _not_ hide the
commit log message in the attachment.

The short description of the patch should be on the Subject:
line.  Make sure it makes sense if your short description
appeared in "git log --pretty=short" output without the rest of
the commit log message.  "Fix a typo" is an example of bad
description -- you cannot tell typo in what part of the tree was
fixed by the commit.

And the rest of the log message, including the sign-off,
should be in the main text.  Also short administrative message
should come *after* the three-dash separators.

So, I would have done the message I am replying to like this:

***	From: "Aneesh Kumar" <aneesh.kumar@gmail.com>
	To: gitster
	cc: git@vger.kernel.org
        Subject: gitview: typofix in documentation
***	Date: Sat Feb 18 13:54:50 2006 +0530

	I forgot to change the name of the program when I copy &
	pasted.

	Signed-off-by: An Ku <an.ku@g.com>

	---

          On 2/18/06, Junio C Hamano <junkio@cox.net> wrote:
          > Aneesh Kumar <aneesh.kumar@gmail.com> writes:
          >
          > > Attaching below the same in the form of patch genera...
          >
          > I'll let it pass this time, but you forgot a sign-off ...
          > perhaps forgot to read Documentation/SubmittingPatches...
          >

          How about sending the patches as attachment below. I am not
          sure how to inline patches in gmail.

          -aneesh

	[git-diff output comes here, preferrably inline but
	 otherwise as a text/plain attachment.]

Let your MUA fill in *** lines.  You _could_ override them with
the first lines of the _body_ of your message like this if you
really need it.  Most of the time you shouldn't care.


***	From: "Aneesh Kumar" <aneesh.kumar@gmail.com>
	To: gitster
	cc: git@vger.kernel.org
        Subject: gitview: typofix in documentation
***	Date: Sat Feb 18 13:54:50 2006 +0530

	From: "An Ku" <an.ku@gmail.com>
        Date: Fri Feb 17 10:00:00 2006 +0530

	I forgot to change the name of the program when I copy &
	pasted.

	Signed-off-by: An Ku <an.ku@g.com>

	---
	...

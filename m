From: Miles Bader <miles@gnu.org>
Subject: Re: EasyGit Integration
Date: Wed, 10 Jun 2009 12:11:14 +0900
Message-ID: <buoski87pgt.fsf@dhlpc061.dev.necel.com>
References: <d411cc4a0906091159r51e7d16t4d66c6225322fb60@mail.gmail.com>
	<alpine.LFD.2.01.0906091512350.6847@localhost.localdomain>
	<51419b2c0906091530t3dfa5267s2262f979f1e9982a@mail.gmail.com>
	<alpine.LFD.2.01.0906091535410.6847@localhost.localdomain>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Elijah Newren <newren@gmail.com>, Scott Chacon <schacon@gmail.com>,
	git list <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jun 10 05:13:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MEEFu-0005g2-Lg
	for gcvg-git-2@gmane.org; Wed, 10 Jun 2009 05:13:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751881AbZFJDNa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2009 23:13:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751749AbZFJDN3
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jun 2009 23:13:29 -0400
Received: from TYO202.gate.nec.co.jp ([202.32.8.206]:60849 "EHLO
	tyo202.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750844AbZFJDN2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2009 23:13:28 -0400
Received: from relay21.aps.necel.com ([10.29.19.50])
	by tyo202.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id n5A3CqeB008561;
	Wed, 10 Jun 2009 12:12:52 +0900 (JST)
Received: from relay21.aps.necel.com ([10.29.19.24] [10.29.19.24]) by relay21.aps.necel.com with ESMTP; Wed, 10 Jun 2009 12:11:22 +0900
Received: from dhlpc061 ([10.114.114.32] [10.114.114.32]) by relay21.aps.necel.com with ESMTP; Wed, 10 Jun 2009 12:11:14 +0900
Received: by dhlpc061 (Postfix, from userid 31295)
	id 8DE6152E1D2; Wed, 10 Jun 2009 12:11:14 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
Blat: Foop
In-Reply-To: <alpine.LFD.2.01.0906091535410.6847@localhost.localdomain> (Linus
	Torvalds's message of "Tue, 9 Jun 2009 15:40:35 -0700 (PDT)")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121245>

Linus Torvalds <torvalds@linux-foundation.org> writes:
> I'm not convinced it's a wonderful design, but I would not object to
>
>  - old behavior: revert the commit by creating an "anti-commit":
> 	git revert <cmit-name>
>  - new extension: revert the state of the working tree to the HEAD:
> 	git revert [--] pathspec
>
> which would kind of match the semantics of "git checkout" does.

That seems even more confusing, to _both_ svn users and git users...

The similar overloading of "checkout" (to have two completely different
meanings depending on whether a branch or pathname is specified) also
feels very awkward to me.

I sort of assumed that the "checkout -- pathname" form was added as a
sop to cvs/svn users, for which that's a very common idiom...

-Miles

-- 
In New York, most people don't have cars, so if you want to kill a person, you
have to take the subway to their house.  And sometimes on the way, the train
is delayed and you get impatient, so you have to kill someone on the subway.
  [George Carlin]

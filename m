From: David Miller <davem@davemloft.net>
Subject: Re: Git and GCC
Date: Wed, 05 Dec 2007 18:28:15 -0800 (PST)
Message-ID: <20071205.182815.249974508.davem@davemloft.net>
References: <4aca3dc20712051108s216d3331t8061ef45b9aa324a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: ismail@pardus.org.tr, gcc@gcc.gnu.org, git@vger.kernel.org
To: dberlin@dberlin.org
X-From: gcc-return-142710-gcc=m.gmane.org@gcc.gnu.org Thu Dec 06 03:28:41 2007
Return-path: <gcc-return-142710-gcc=m.gmane.org@gcc.gnu.org>
Envelope-to: gcc@gmane.org
Received: from sourceware.org ([209.132.176.174])
	by lo.gmane.org with smtp (Exim 4.50)
	id 1J06Tg-0002JQ-Ct
	for gcc@gmane.org; Thu, 06 Dec 2007 03:28:40 +0100
Received: (qmail 31276 invoked by alias); 6 Dec 2007 02:28:22 -0000
Received: (qmail 31265 invoked by uid 22791); 6 Dec 2007 02:28:22 -0000
X-Spam-Check-By: sourceware.org
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net (HELO sunset.davemloft.net) (74.93.104.97)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Thu, 06 Dec 2007 02:28:17 +0000
Received: from localhost (localhost [127.0.0.1]) 	by sunset.davemloft.net (Postfix) with ESMTP id 74BE1C8C15C; 	Wed,  5 Dec 2007 18:28:15 -0800 (PST)
In-Reply-To: <4aca3dc20712051108s216d3331t8061ef45b9aa324a@mail.gmail.com>
X-Mailer: Mew version 5.2 on Emacs 22.1 / Mule 5.0 (SAKAKI)
X-IsSubscribed: yes
Mailing-List: contact gcc-help@gcc.gnu.org; run by ezmlm
Precedence: bulk
List-Id: <gcc.gcc.gnu.org>
List-Unsubscribe: <mailto:gcc-unsubscribe-gcc=m.gmane.org@gcc.gnu.org>
List-Archive: <http://gcc.gnu.org/ml/gcc/>
List-Post: <mailto:gcc@gcc.gnu.org>
List-Help: <http://gcc.gnu.org/ml/>
Sender: gcc-owner@gcc.gnu.org
Delivered-To: mailing list gcc@gcc.gnu.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67223>

From: "Daniel Berlin" <dberlin@dberlin.org>
Date: Wed, 5 Dec 2007 14:08:41 -0500

> So I tried a full history conversion using git-svn of the gcc
> repository (IE every trunk revision from 1-HEAD as of yesterday)
> The git-svn import was done using repacks every 1000 revisions.
> After it finished, I used git-gc --aggressive --prune.  Two hours
> later, it finished.
> The final size after this is 1.5 gig for all of the history of gcc for
> just trunk.
> 
> dberlin@home:/compilerstuff/gitgcc/gccrepo/.git/objects/pack$ ls -trl
> total 1568899
> -r--r--r-- 1 dberlin dberlin 1585972834 2007-12-05 14:01
> pack-cd328fcf0bd673d8f2f72c42fbe67da64cbcd218.pack
> -r--r--r-- 1 dberlin dberlin   19008488 2007-12-05 14:01
> pack-cd328fcf0bd673d8f2f72c42fbe67da64cbcd218.idx
> 
> This is 3x bigger than hg *and* hg doesn't require me to waste my life
> repacking every so often.
> The hg operations run roughly as fast as the git ones
> 
> I'm sure there are magic options, magic command lines, etc, i could
> use to make it smaller.
> 
> I'm sure if i spent the next few weeks fucking around with git, it may
> even be usable!
> 
> But given that git is harder to use, requires manual repacking to get
> any kind of sane space usage, and is 3x bigger anyway, i don't see any
> advantage to continuing to experiment with git and gcc.

I would really appreciate it if you would share experiences
like this with the GIT community, who have been now CC:'d.

That's the only way this situation is going to improve.

When you don't CC: the people who can fix the problem, I can only
speculate that perhaps at least subconsciously you don't care if
the situation improves or not.

The OpenSolaris folks behaved similarly, and that really ticked me
off.

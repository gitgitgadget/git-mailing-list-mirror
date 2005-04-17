From: Tkil <tkil@scrye.com>
Subject: Re: SHA1 hash safety
Date: Sat, 16 Apr 2005 22:43:42 -0600
Message-ID: <gacny8135.fsf@brand.scrye.com>
References: <Pine.LNX.4.62.0504160519330.21837@qynat.qvtvafvgr.pbz>
	<20050416123155.GA19908@elte.hu>
	<Pine.LNX.4.62.0504160542190.21837@qynat.qvtvafvgr.pbz>
	<4261132A.3090907@khandalf.com> <ghdi684sm.fsf@brand.scrye.com>
	<20050416210934.11a27387.pj@sgi.com>
Reply-To: Tkil <tkil@scrye.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: omb@bluewin.ch, david.lang@digitalinsight.com, mingo@elte.hu,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 06:40:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DN1Zh-0004oz-LI
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 06:40:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261160AbVDQEnq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 00:43:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261252AbVDQEnq
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 00:43:46 -0400
Received: from scrye.com ([216.17.180.1]:32645 "EHLO mail.scrye.com")
	by vger.kernel.org with ESMTP id S261160AbVDQEnn (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2005 00:43:43 -0400
Received: by mail.scrye.com (Postfix, from userid 19)
	id BED8CF5634; Sat, 16 Apr 2005 22:43:42 -0600 (MDT)
To: Paul Jackson <pj@sgi.com>
X-Attribution: Tkil
In-Reply-To: <20050416210934.11a27387.pj@sgi.com> (Paul Jackson's message of
 "Sat, 16 Apr 2005 21:09:34 -0700")
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


>>>>> "Tkil" == Tkil <tkil@scrye.com> writes:

Tkil> but the chance of any collision at all wigs me out.

>>>>> "Paul" == Paul Jackson <pj@sgi.com> writes:

Paul> Guess you're just going to get wigged out then.

Wig wig.  :)

I didn't mean "wigs me out to the point I won't use it" but more of
"wigs me out so that I'm curious whether there are backup schemes
worth considering".

In particular, the comparisons between hash collisions and hardware
failure seem contrived -- if I have bad RAM, or a bad block on my HD,
I can recover it from known good sources.  But if the actual known
good source is structured in such a way that a particular set of data
cannot be represented, that bothers me.

In this case, the fact that it has to be the same length, same SHA-1,
correct C, and functionally similar C at that, makes for a comforting
cushion.  Further, git wouldn't be the only representation; there
would be periodic tarballs, different trees, etc.

On the other paw, if "effectively random" MS Word docs gave true MD5
collisions (when we have a proper MD5 hash computed over the entire
document) in a "mere" 1e7 space, that is interesting/scary.

(I was also trying to add a few factoids to the MSW comment, as their
structure could lead to collisions if (say) only the first 512 bytes
were considered -- it's possible that nothing but size and date might
change in that, and /those/ I can see colliding in 1e7 documents.)

Finally, I apologize for taking your time.  I'm just watching this
from the sidelines, and the questions above are just intellectual
curiosity.  :-/

(The only other thread I'm really following is people trying to chunk
files in a way that would increase storage efficiency; reading the
Venti paper, I was wondering how efficient it would be if a one-byte
addition at the top of the file would generate all-new blocks, while
the rsync-ish protocol seems to offer substantial relief.  But if the
"interesting history" fits in 10USD worth of HD, that might be enough.
Babble.)

Thanks,
t.


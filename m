From: martin f krafft <madduck@madduck.net>
Subject: Re: Using trees for metatagging
Date: Fri, 19 Feb 2010 11:57:59 +1300
Message-ID: <20100218225758.GL9756@lapse.rw.madduck.net>
References: <20100218041240.GA4127@lapse.rw.madduck.net>
 <201002182200.09100.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Johan Herland <johan@herland.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 18 23:58:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiFK3-0008Dd-Qs
	for gcvg-git-2@lo.gmane.org; Thu, 18 Feb 2010 23:58:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751239Ab0BRW6L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2010 17:58:11 -0500
Received: from clegg.madduck.net ([193.242.105.96]:46084 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750916Ab0BRW6K (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2010 17:58:10 -0500
Received: from lapse.rw.madduck.net (koruout.airnz.co.nz [162.112.38.5])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "lapse.rw.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTPS id D36761D409C;
	Thu, 18 Feb 2010 23:58:02 +0100 (CET)
Received: by lapse.rw.madduck.net (Postfix, from userid 1000)
	id 1CB5C24C; Fri, 19 Feb 2010 11:57:59 +1300 (NZDT)
Content-Disposition: inline
In-Reply-To: <201002182200.09100.johan@herland.net>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux squeeze/sid kernel 2.6.32-1-686 i686
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Virus-Scanned: clamav-milter 0.95.3 at clegg
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140390>

also sprach Johan Herland <johan@herland.net> [2010.02.19.1000 +1300]:
> Take a look at the (relatively) new notes feature. (See the
> jh/notes series in 'pu' and various recent discussions on this
> mailing list.) Git notes probably won't satisfy the exact
> requirements you list above, but it _does_ tackle some parallel
> issues (e.g. how to maintain a tree that is not checked out,
> storing metadata associated with Git objects, etc.). If you take
> a step back and reconsider your original problem, you might find
> that it's solvable by using commit notes.
> 
> For example, you could add a simple note to each blob that has
> been reviewed, on the refs/notes/reviewed notes ref. You could
> then write a simple script (using "git notes list") that lists all
> blobs (i.e. files) without a corresponding note in
> refs/notes/reviewed.

I am aware of notes, but so far I stayed away from them, simply
because it seems hackish to represent tag trees as text when dealing
with a tool that is essentially all about trees and refs.

Can I use notes to append information to blobs and trees, or just
commit objects?

-- 
martin | http://madduck.net/ | http://two.sentenc.es/
 
"without music, life would be a mistake."
                                                 - friedrich nietzsche
 
spamtraps: madduck.bogus@madduck.net

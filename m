From: Theodore Tso <tytso@mit.edu>
Subject: Re: Considering teaching plumbing to users harmful
Date: Thu, 17 Jul 2008 08:55:36 -0400
Message-ID: <20080717125536.GO2167@mit.edu>
References: <alpine.DEB.1.00.0807161804400.8950@racer> <487EF519.5070902@sneakemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Peter Valdemar =?iso-8859-1?Q?M=F8rch_=28Lists=29?= 
	<4ux6as402@sneakemail.com>
X-From: git-owner@vger.kernel.org Thu Jul 17 14:57:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJT2X-0002BM-Ff
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 14:56:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757951AbYGQMzn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Jul 2008 08:55:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753655AbYGQMzn
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 08:55:43 -0400
Received: from www.church-of-our-saviour.ORG ([69.25.196.31]:34515 "EHLO
	thunker.thunk.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754865AbYGQMzm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 08:55:42 -0400
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtp   (Exim 4.50 #1 (Debian))
	id 1KJT1E-0001zw-UH; Thu, 17 Jul 2008 08:55:37 -0400
Received: from tytso by closure.thunk.org with local (Exim 4.69)
	(envelope-from <tytso@mit.edu>)
	id 1KJT1E-000483-Bi; Thu, 17 Jul 2008 08:55:36 -0400
Content-Disposition: inline
In-Reply-To: <487EF519.5070902@sneakemail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@mit.edu
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88844>

On Thu, Jul 17, 2008 at 09:30:33AM +0200, "Peter Valdemar M=F8rch (List=
s)" wrote:
>
> As a total git newbie (5 days) coming from svn, I *am* bewildered. Ev=
en =20
> sticking to porcelain, it is a feature-rich new tool I have in my han=
ds!
>
> I'm missing clarity about what is porcelain and what is plumbing. `gi=
t =20
> help` shows

The top-level man page has a listing of what is porcelain and what is
plumbing --- although there is some disagreement.  Johannes was
complaining about people using git rev-parse in tutorials and saying
that there was no way that was porcelain, but in fact it is *not*
listed as plumbing in the git man page.  So I don't think there is
really a strong black-and-white category, but rather a certain set of
shades of gray, as it were.

> Is this list exactly the list of porcelain commands? Then say so ther=
e. =20
> Neither `git help diff` nor `git help ls-tree` say whether they are =20
> porcelain or plumbing commands. `git help diff` mentions git-diff-ind=
ex, =20
> which i suspect is plumbing. When I read a man page, it would be nice=
 to =20
> know whether a command (either the topic of the page or another =20
> mentioned command) is intended as porcelain or not.

My personal long-standing complaint is that there are certain man
pages like "git log" where in order to see all of the options which it
can take, the man page for git-log redirects you to a man page for
plumbing.  Great way to scare the users.  :-)


Have you taken a look at the intro-level materials such as "Everyday
Git in 20 commands or so"[1], the git tutorial[2], the official "Git's
User Manual"[3], or the "Git-SVN crash course"[4]?  Those are probably
the best place to begin --- and to basically treat the git man pages
as reference materials with a huge number of controls that you won't
use or need to use for a long time --- if ever.  It's like the 10,000
features hidden inside Microsoft Office.  The features are all
indispensable to *someone*, but everyone has a different set of the
100 features which they all *have* to have.  (And of course, the 20 or
so features that everyone really uses.  :-)

> All of this of course assumes that there is consensus and a clear =20
> distinction between what is porcelain and what is plumbing which I'm =
=20
> don't even know if there is.

I don't think so.  It's like what the judge said about pornography ---
I know it when I see it.  :-)

And note that there's nothing *wrong* with using plumbing commands.
It's just that from a pedagogical point of view, they might not
necessarily be the best place to start.

						- Ted

[1] http://www.kernel.org/pub/software/scm/git/docs/everyday.html
[2] http://www.kernel.org/pub/software/scm/git/docs/gittutorial.html
[3] http://www.kernel.org/pub/software/scm/git/docs/user-manual.html
[4] http://git.or.cz/course/svn.html

From: LordSmoke <dslice@morphometrics.org>
Subject: Re: Sharing nested subparts of large repository?
Date: Wed, 28 Mar 2012 10:52:18 -0700 (PDT)
Message-ID: <1332957138457-7414676.post@n2.nabble.com>
References: <1332693502389-7403743.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 28 19:52:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCx2w-0004D9-PM
	for gcvg-git-2@plane.gmane.org; Wed, 28 Mar 2012 19:52:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932513Ab2C1RwY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Mar 2012 13:52:24 -0400
Received: from sam.nabble.com ([216.139.236.26]:54101 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752693Ab2C1RwT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2012 13:52:19 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <dslice@morphometrics.org>)
	id 1SCx2g-0004vq-Fh
	for git@vger.kernel.org; Wed, 28 Mar 2012 10:52:18 -0700
In-Reply-To: <1332693502389-7403743.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194152>

Thanks for the helpful replies. It does seem that branches will do what I
want. Yesterday, I organized my files and created an (eventually)
open-source startup project (distinct from the development application
startup).

I created a branch "development" and "git rm"'d the (many) files I didn't
want to pass along to my developers. The trick here, I think, is you have to
do an initial commit before the rm's or else it will affect the master...or
something. Anyway, I had to reset and try a couple of times, but in the end
it worked. 

After checking out that branch, I created "public", initial commit, then
rm'd the development startup project and the other files I wouldn't want to
post to the world.

I also managed to push these branches to my remote repository. Add them to
my office repository as tracked branches, and test cloning, It works just as
I had envisioned - cloning the public branch produces the minimal structure.

I think I am two steps away from complete satisfaction. Not related to this,
I have some files that are reluctant to be updated, added, tracked, or
untracked, but that's a different issue. 

Now, though, I am wondering about merging the changes across branches. Say I
make changes on the development branch. If I merge that into the master,
will the reduced tracking be merged? - don't want that. If I merge the other
way - from, say, checkout public and merge in development? Will a bunch of
other stuff come over?

Anyway, that is where I am now and what I am looking into. Very happy with
progress, so far.

Oh, while I do everything from the command line, seeing it graphically with
gitx has really helped me conceptualize what is going on. All of this has
given me a much better understanding of what is going on in the little time
I have been able to spend on it. 

--
View this message in context: http://git.661346.n2.nabble.com/Sharing-nested-subparts-of-large-repository-tp7403743p7414676.html
Sent from the git mailing list archive at Nabble.com.

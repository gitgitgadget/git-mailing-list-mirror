From: David Kastrup <dak@gnu.org>
Subject: Re: [RFC PATCH] Re: Empty directories...
Date: Sun, 22 Jul 2007 06:28:43 +0200
Message-ID: <85abtpoydg.fsf@lola.goethe.zz>
References: <85lkdezi08.fsf@lola.goethe.zz>
	<alpine.LFD.0.999.0707180912430.27353@woody.linux-foundation.org>
	<vpq4pk1vf7q.fsf@bauges.imag.fr>
	 =?ISO-8859-1?Q?=20<alpine.LFD.0.99?= =?ISO-8859-1?Q?9.0707181004330.?= =?ISO-8859-1?Q?=04=0427?=
	=?ISO-8859-1?Q?353@woody.linux-?= =?ISO-8859-1?Q?foundation.org>?=
	<85644hxujp.fsf@lola.goethe.zz>
	<alpine.LFD.0.999.0707181444070.27353@woody.linux-foundation.org>
	<alpine.LFD.0.999.0707181557270.27353@woody.linux-foundation.org>
	<851wf2bcqy.fsf@lola.goethe.zz>
	 =?ISO-8859-1?Q?=20<alpine.LFD.0.99?= =?ISO-8859-1?Q?9.07072=0402135450?= =?ISO-8859-1?Q?.27249?=
	=?ISO-8859-1?Q?@woody.linux-fou?= =?ISO-8859-1?Q?ndation.org>?=
	<alpine.LFD.0.999.0707202154220.27249@woody.linux-foundation.org>
	<85odi69vgt.fsf@lola.goethe.zz>
	<alpine.LFD.0.999.0707210832180.27249@woody.linux-foundation.org>
	<85tzrxslms.fsf@lola.goethe.zz>
	<alpine.LFD.0.999.0707211650190.3607@woody.linux-foundation.org>
	<85644dqoig.fsf@lola.goethe.zz>
	<alpine.LFD.0.999.0707211737090.3607@woody.linux-foundation.org>
	<85r6n1p7sb.fsf@lola.goethe.zz>
	<alpine.LFD.0.999.0707211840000.3607@woody.linux-foundation.org>
	<85fy3hp3f2.fsf@lola.goethe.zz>
	<alpine.LFD.0.999.0707212040340.3607@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Jul 22 06:28:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICT3z-00025B-70
	for gcvg-git@gmane.org; Sun, 22 Jul 2007 06:28:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750963AbXGVE2s (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 00:28:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750941AbXGVE2s
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 00:28:48 -0400
Received: from mail-in-13.arcor-online.net ([151.189.21.53]:55960 "EHLO
	mail-in-13.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750866AbXGVE2r (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Jul 2007 00:28:47 -0400
Received: from mail-in-04-z2.arcor-online.net (mail-in-04-z2.arcor-online.net [151.189.8.16])
	by mail-in-13.arcor-online.net (Postfix) with ESMTP id C870C1E502E;
	Sun, 22 Jul 2007 06:28:45 +0200 (CEST)
Received: from mail-in-13.arcor-online.net (mail-in-13.arcor-online.net [151.189.21.53])
	by mail-in-04-z2.arcor-online.net (Postfix) with ESMTP id B252BABAEA;
	Sun, 22 Jul 2007 06:28:45 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-010-231.pools.arcor-ip.net [84.61.10.231])
	by mail-in-13.arcor-online.net (Postfix) with ESMTP id 7AB49225124;
	Sun, 22 Jul 2007 06:28:45 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id BA8721D1E182; Sun, 22 Jul 2007 06:28:43 +0200 (CEST)
In-Reply-To: <alpine.LFD.0.999.0707212040340.3607@woody.linux-foundation.org> (Linus Torvalds's message of "Sat\, 21 Jul 2007 20\:43\:11 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3725/Sun Jul 22 04:53:44 2007 on mail-in-13.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53217>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Sun, 22 Jul 2007, David Kastrup wrote:
>>
>> "." _is_ visible and detectable in every tree.
>
> I'm going to add you to my "clueless" filter, because it's not worth
> my time to answr you any more.

Too bad I can't do the same.

> I told you. Several times. That "." is pointless exactly because
> it's in _every_ tree, and as such is no longer "content".

"." is in every _non-empty_ directory tree.  But we are talking about
permitting _empty_ trees in the repository.  And for an empty tree in
the repository, "." may or may not be in the corresponding work
directory tree, depending on whether the directory exists or not.  So
when we are talking about a repository tree _becoming_ empty, we need
the information whether or whether not we should remove it upon
becoming empty.  _That_ is the information content of "." being or not
being considered part of the trackable material.  And the information
is no longer available at the time the repository tree becomes empty
_unless_ we already store it there when the tree is still populated.

> It's not something that the user can care about, because it has no
> meaning. There's no point in tracking it, because even if we do
> *not* track it, it's there, and we cannot do anything about it.

Ok, here we go _again_.  Test case 1:

mkdir a
touch a/b
git-add a/b
git-commit -m x
git-rm a/b
git-commit -m x

Now we want to have the directory a _removed_.

Test case 2:

mkdir a
touch a/b
git-add a
git-commit -m x
git-rm a/b
git-commit -m x

Now we want to have the directory a _retained_.

After the first commit in _both_ test cases, the only file in the
trees / and /a is a/b.  The working directory state is _identical_ at
this point, and we do identical commands afterwards.

The end result is not identical, so there must be some information
different in the repository after the first commit.  This information
_can't_ be encoded in a remaining empty tree, because both the trees /
and /a are _non_-empty yet.

So we _must_ encode the evaporate-or-not-when-empty information
_otherwise_ into the repository.  And we do that by _not_ having
/a/. in the set of tracked files in test case 1, and by _having_ it in
the set of tracked files in test case 2.

> That was the whole difference between "." and ".gitignore", and I
> explicitly pointed out that that was the difference (and the _only_
> one), and why it mattered.

You are underestimating the power of ".gitignore": while it is true
that its _physical_ presence will reliably keep git from removing the
directory, its physical presence is not _actually_ required.

It is sufficient that git _believes_ in its continuing physical
existence.  And if we tell it "it is still there" whenever it takes a
look, then git will keep the record of .gitignore in its tree, and
consequently won't remove the tree and not try deleting the directory.
However, once we explicitly tell it "remove the record of .gitignore
from the repository", it will do so, and in the course of doing so
remove the directory in the work directory together with the tree in
the repository.

>From a user interface and logical standpoint, adding or not adding "."
to the tracked content is a perfectly consistent and convenient way of
having the directory kept around or not.

>From the viewpoint of the internal data structures, I'll likely go
with tampering with (pseudo-)permissions.

> And you didn't listen. And now you claim that I don't read your
> emails. I do. They just don't make any sense.
>
> Consider this discussion ended. I simply don't care any more.

It is painfully clear that I could invest a few weeks of time in
coding better than in explaining stuff.  And I guess that's what I'll
have to do.  And afterwards it will be your job to wrack your head
about why something does all the right things for the wrong reasons
and come up with a different explanation how and why the code works.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum

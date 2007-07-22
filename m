From: David Kastrup <dak@gnu.org>
Subject: Re: [RFC PATCH] Re: Empty directories...
Date: Sun, 22 Jul 2007 04:39:45 +0200
Message-ID: <85fy3hp3f2.fsf@lola.goethe.zz>
References: <85lkdezi08.fsf@lola.goethe.zz>
	<Pine.LNX.4.64.0707180135200.14781@racer.site>
	<858x9ez1li.fsf@lola.goethe.zz>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Jul 22 04:40:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICRMu-0003iX-FD
	for gcvg-git@gmane.org; Sun, 22 Jul 2007 04:40:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756134AbXGVCjz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jul 2007 22:39:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755644AbXGVCjz
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jul 2007 22:39:55 -0400
Received: from mail-in-06.arcor-online.net ([151.189.21.46]:56888 "EHLO
	mail-in-06.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755568AbXGVCjw (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Jul 2007 22:39:52 -0400
Received: from mail-in-13-z2.arcor-online.net (mail-in-13-z2.arcor-online.net [151.189.8.30])
	by mail-in-06.arcor-online.net (Postfix) with ESMTP id 449FB31EDE9;
	Sun, 22 Jul 2007 04:39:49 +0200 (CEST)
Received: from mail-in-06.arcor-online.net (mail-in-06.arcor-online.net [151.189.21.46])
	by mail-in-13-z2.arcor-online.net (Postfix) with ESMTP id 2BFFF1B8E02;
	Sun, 22 Jul 2007 04:39:49 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-010-231.pools.arcor-ip.net [84.61.10.231])
	by mail-in-06.arcor-online.net (Postfix) with ESMTP id 0073A35E5A8;
	Sun, 22 Jul 2007 04:39:48 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id F0D441D1E182; Sun, 22 Jul 2007 04:39:45 +0200 (CEST)
In-Reply-To: <alpine.LFD.0.999.0707211840000.3607@woody.linux-foundation.org> (Linus Torvalds's message of "Sat\, 21 Jul 2007 18\:41\:27 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3724/Sun Jul 22 02:47:22 2007 on mail-in-06.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53213>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Sun, 22 Jul 2007, David Kastrup wrote:
>>  Make it have an empty reference, and it is unique.
>
> I *really* don't see the point.
>
> And you seem to have igored totally my treatise on "content" and how
> the stuff git tracks must be stuff that is visible and detectable in
> the trees.

Oh please.  Just because you refuse to read a point-to-point reply
does not mean it has not been made.

"." _is_ visible and detectable in every tree.  But that does not mean
it is automatically tracked by git unless it gets added explicitly, or
implicitly (as long as the gitignore mechanism does not kick in) by
adding a higher level directory.

If a file does not get added explicitly or implicitly, it does not end
up in the repository and git behaves like it knows nothing about it.

And that's just the way it is going to be with directories.  Nothing
more, nothing less, nothing new.

> And if I understand you correctly, you also wouldn't be backwards
> compatible.

Define backwards compatible.  Anyway, you are the repository wizard:
here are the semantics I need supported for backwards compatibility:

I need an entry type in the index and in the repository with the
following features:

a) if part of a tree, the tree is not considered empty.  Should be
   easy.
b) it has the name ".".  This is not absolutely necessary, but it
   means that the gitignore mechanism can be used for dealing with it,
   and that's intuitive and has exactly the expressive power required
   for the job.  Now the gitignore mechanism is isolated very locally
   in dir.c: whether one makes the actual representation in the
   repository based on an attribute like "filemode" rather than on a
   separate entry does not actually complicate the code all too much.
   There is, however, some level of complication since the consulted
   .gitignore file for ignoring "." must, of course, be the .gitignore
   file situated _in_ the directory.  So making "." sit _in_ the tree
   rather than _on_ the tree simplifies the code considerably.  It is
   a small amount of code, nevertheless, so it is not a major
   strategic decision.

   One conceivable implementation would be indeed similar to what the
   "filemode" thing does: let us keep open the option to track, at one
   time, permissions.  The current format has, as far as I understand,
   all zeros in the permissions field of trees (I have not checked,
   though).  Now if we stipulate that this is the kind of directory
   permissions we will in all eternity _not_ support outside of git,
   we are all set with regard to backwards compatibility: a tree with
   permissions all zero will behave as previously: it will get removed
   when it becomes empty (taking the corresponding work tree directory
   with it, if possible).  And that's it.  But a tree with nonzero
   permissions (whether they correspond to outward permissions or are
   just a placeholder) will _not_ evaporate when becoming empty.  It
   will be possible to explicitly or implicitly delete it: that will
   just set its permissions all to zero so that it has the chance to
   evaporate next time it becomes empty.

> IOW, there's a lot of "why's" at all levels.
>
> I don't see the *point*. What's the problem you're trying to solve?

rm -rf ./*
git-commit -m "all empty" -a
unzip /tmp/something-with-empty-dirs.zip
git-add .
git-commit -m "something-with-empty-dirs"
git-checkout HEAD~1
# Now I don't want empty directories and their parents lying around.
git-checkout master
# Now the state after unzip should be restored faithfully
rm -rf ./*
unzip /tmp/something-else-with-empty-dirs
git-commit -a -m "something-else"
# Now I want to have the state of something-else registered faithfully
# even if it contains top-level files and directories not present in
# something-with-empty-dirs, because supposedly . is being tracked,
# not just every file element in it.

Actually, oops.  This last criterion is not met when .'s relation to
the tree is such that it is only considered _part_ of tree.

Looks like it might be prudent to focus on the permissions-coupled
representation.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum

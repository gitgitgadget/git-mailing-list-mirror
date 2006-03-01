From: Junio C Hamano <junkio@cox.net>
Subject: What's in git.git
Date: Wed, 01 Mar 2006 04:24:14 -0800
Message-ID: <7vmzgagxox.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Wed Mar 01 13:24:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEQNb-0003AU-0h
	for gcvg-git@gmane.org; Wed, 01 Mar 2006 13:24:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030200AbWCAMYV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 1 Mar 2006 07:24:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932274AbWCAMYV
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Mar 2006 07:24:21 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:9612 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S932206AbWCAMYV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Mar 2006 07:24:21 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060301122114.IAAK26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 1 Mar 2006 07:21:14 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16972>

* The 'master' branch has these since the last announcement.

  - Cygwin related fixes (Alex Riesen) [*]
  - git-rm fixes and docs (Carl Worth)
  - gitview updates (Aneesh Kumar, Pavel Roskin)
  - git-svn updates (Eric Wong)
  - git-cvsserver (Martin Langhoff, Johannes Schindelin)
  - git-annotate (Ryan Anderson)
  - format-patch fix (Alexandre Julliard)
  - fix send-pack to a remote with insanely large number of refs [*]
  - "thin" pack git-push/git-fetch.
  - eye candies to checkout [*].
  - error() formatting fixes [*].
  - git-am empty commit prevention [*].
  - git-mailinfo now is built and installed again.
  - fix two sample hooks [*].
  - diffcore-rename and diffcore-break microfix [*].
  - svnimport enhancements (Karl Hasselstr=F6m)
  - git-fetch output tweak (Lukas Sandstr=F6m)
  - start to do more things in git wrapper (Linus)
  - combine-diff fixes (Mark Wooding) [*]
  - ls-files -i -o fix (Shawn Pearce)
  - Darwin related fix (Shawn Pearce)
  - compilation warning fixes (Timo Hirvonen, Tony Luck, Andreas Ericss=
on)

  The changes marked with [*] will appear in the next
  maintenance release; they are either first applied to 1.2.X
  maintenance branch and pulled into master, or first applied to
  master and then cherry picked to 1.2.X maintenance branch.

* The 'next' branch, in addition, has these.

  I wanted to have this out to "master", but ran out of time.
  The same set of changes are already cherry-picked and waiting
  for inclusion in the next maintenance release.

  - git-apply trailing whitespace warning (Linus and me)

  These are waiting for further progress by authors:

  - git-blame (Fredrik Kuivinen)
  - delta packer updates for tighter packs (Nicolas Pitre)

  These are here only because they are new, not because I have
  any qualms about them:

  - for_each_ref warning (Johannes Schindelin)
  - prepare to make rename/break detection independent from delta packi=
ng.
  - checkout-index --stdin (Shawn Pearce)

  These are here because they are rather important and I am
  playing it safe.

  - beginning of rev-list libification (Linus)
  - git-log without shell script (Linus and me)=20

  I am almost happy about this.  Now the author mapping format
  is the same between cvs/svn importers, would it make sense to
  unify them so that other foreign scm interface can also follow
  suit?  Usually you would not have upstreams with two different
  foreign scm to a single repository anyway, so this may not be an
  issue, though...

  - git-svnimport save author name mapping to a file (Karl Hasselstr=F6=
m)

* The 'pu' branch, in addition, has these.

  This is in preparation for Nico's delta work already in "next".

  - make rename/break detection independent from delta packing.

  These muddy the water for what is in "next", improving of
  which is more important.

  - diff-delta: cull collided hash bucket more aggressively.
  - diff-delta: allow reusing of the reference buffer index (Nicolas Pi=
tre)

  I am not sure about the command line interface of this.  Would
  it make more sense to checkout three stages in one pass?

  - checkout-index --suffix (Shawn Pearce)

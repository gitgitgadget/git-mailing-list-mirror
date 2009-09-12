From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Sep 2009, #02; Mon, 07)
Date: Fri, 11 Sep 2009 17:33:19 -0700
Message-ID: <7veiqdngs0.fsf@alter.siamese.dyndns.org>
References: <7vtyzexnhm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jan Engelhardt <jengelh@medozas.de>,
	Johan Herland <johan@herland.net>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 12 02:34:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmGZh-0006fw-QL
	for gcvg-git-2@lo.gmane.org; Sat, 12 Sep 2009 02:34:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753969AbZILAdq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Sep 2009 20:33:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753928AbZILAdq
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Sep 2009 20:33:46 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:36546 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753713AbZILAdo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Sep 2009 20:33:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7B1EF4D346;
	Fri, 11 Sep 2009 20:33:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MIHMnT013fIpgpiXAEY0fUa5LrM=; b=Z8uYK0
	17/Dyo1uHPd7idexbltdPYqSVGXMaBIy36BuBgiq41goR5Eec8rJFG1zMx1aiBNY
	jHo0I40Xw+zhBm59gLJ47zF7+9NBu4lGVcv1jo616MLWTmR5ElMRbaQyF2NImEUU
	nON668/babSPZ212HDgPYVEW8lLbXOkQ+smi0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Oz45mA7mwRH7Ts2U6De2XEcsM5ta6tNf
	R186+9GEujsO31Dc19fGacKnlZaVSp9MUsdGimFUNo0/aKiOcWBHNAVQ7NsCkEyF
	MwSu8IpALPMUIaS83a/q8GC6HkSAeozssrvRA47Ckqf8XBzxYhCOOz5e4fhNIx21
	6cnsAJlTP1k=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E862B4D341;
	Fri, 11 Sep 2009 20:33:37 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 06E5B4D340; Fri, 11 Sep 2009
 20:33:20 -0400 (EDT)
In-Reply-To: <7vtyzexnhm.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon\, 07 Sep 2009 17\:56\:53 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E9976C5A-9F33-11DE-A791-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128233>

This is an abbreviated preview of issue #03 for this month; the message
primarily covers potential 1.6.5 material and omits topics without much
urgency for the purpose of pushing 1.6.5-rc1 out.

--------------------------------------------------
[New Topics]

* jc/merge-saner-messages (2009-09-07) 1 commit
  (merged to 'next' on 2009-09-11 at 4efab98)
 + merge-recursive: give less scary messages when merge did not start

I think this should be safe for 1.6.5.

* rc/maint-http-no-head-pack-check (2009-09-09) 1 commit.
 - http.c: remove verification of remote packs

This is the response to infamous "github sometimes gives status 500
error for a HEAD request even when GET request for the same URL happily
serves the content error-free." problem.

I am hoping this is safe for 1.6.5, but will wait for a response to my
inquiry earlier.

--------------------------------------------------
[Stalled]

* jh/notes (2009-08-27) 12 commits.

The reroll was discussed on the list; unfortunately it did not quite apply
to any of my branches.  I do not think this has to be in 1.6.5, but I just
want to get us unstuck if Johan was waiting for me to apply the current
series before making his next move.

* je/send-email-no-subject (2009-08-05) 1 commit
  (merged to 'next' on 2009-08-30 at b6455c2)
 + send-email: confirm on empty mail subjects

It would be a good change for 1.6.5 when done properly, but this does not
honor --confirm=never but talks to the terminal.  Nor it honors any
existing sendemail.confirm configuration settings.

--------------------------------------------------
[Cooking]

* db/vcs-helper (2009-09-03) 16 commits
 - ...
  (merged to 'next' on 2009-09-11 at a275aa3)
 + Use a clearer style to issue commands to remote helpers
 + Make the "traditionally-supported" URLs a special case
  (merged to 'next' on 2009-08-07 at f3533ba)
 + Makefile: install hardlinks for git-remote-<scheme> supported by libcurl if possible
 + Makefile: do not link three copies of git-remote-* programs
 + Makefile: git-http-fetch does not need expat
  (merged to 'next' on 2009-08-06 at 15da79d)
 + http-fetch: Fix Makefile dependancies
 + Add transport native helper executables to .gitignore
  (merged to 'next' on 2009-08-05 at 33d491e)
 + git-http-fetch: not a builtin
 + Use an external program to implement fetching with curl
 + Add support for external programs for handling native fetches
 (this branch is used by jh/cvs-helper.)

Up to the part that eject -lcurl from the main "git" binary cleanly are
now in 'next' and is ready for 1.6.5.

* cb/maint-1.6.3-grep-relative-up (2009-09-05) 2 commits.
  (merged to 'next' on 2009-09-07 at f9b5b48)
 + grep: accept relative paths outside current working directory
 + grep: fix exit status if external_grep() punts

1.6.5 material.

* jk/unwanted-advices (2009-09-06) 2 commits
 - status: make "how to stage" messages optional
 - push: make non-fast-forward help message configurable

If I missed the v2 or later that uses 'advice.*" instead, I am sorry, and
please let me know.  At least the first one should be in 1.6.5, I think,
and probably both.

* jt/pushinsteadof (2009-09-07) 2 commits
  (merged to 'next' on 2009-09-11 at cf3eb57)
 + Add url.<base>.pushInsteadOf: URL rewriting for push only
 + Wrap rewrite globals in a struct in preparation for adding another set

Probably 1.6.5 material.

* pk/fast-import-tars (2009-09-03) 1 commit
  (merged to 'next' on 2009-09-07 at 8fbf027)
 + import-tars: Allow per-tar author and commit message.

* pk/fast-import-dirs (2009-09-03) 1 commit
  (merged to 'next' on 2009-09-07 at 836cba2)
 + Add script for importing bits-and-pieces to Git.

I have to wonder if there are standard libraries to do this sort of thing
without having to hand-roll these logic every time, but I decided not to
be picky about contrib/ material.  Both will be in 1.6.5

* jc/maint-1.6.0-blank-at-eof (2009-09-05) 10 commits.
  (merged to 'next' on 2009-09-07 at 165dc3c)

Possibly a 1.6.5 material, but it started rather late in the cycle so we
might want to cook it for a while in 'next' and do 1.6.5 without it.

* sr/gfi-options (2009-09-06) 6 commits
  (merged to 'next' on 2009-09-07 at 5f6b0ff)
 + fast-import: test the new option command
 + fast-import: add option command
 + fast-import: test the new feature command
 + fast-import: add feature command
 + fast-import: put marks reading in it's own function
 + fast-import: put option parsing code in separate functions

Perhaps 1.6.5 material but I wasn't sure.  I saw Sverre asking Shawn for
opinion but I may have missed the response.

* lt/maint-traverse-trees-fix (2009-09-06) 1 commit.
 - Prepare 'traverse_trees()' for D/F conflict lookahead

Beginning of the fix to a rather nasty longstanding issue of merging trees
with ("a" "a-b"), ("a/b" "a-b") and just ("a-b"), but my reading of it is
that it is just the first step to demonstrate one-entry lookahead and not
a full solution yet.

This is a good problem to tackle but the bug has been there from the
beginning of unpack_trees(), i.e. lacks urgency, and the full solution is
expected to be much larger.  I am tempted to say that 1.6.5 shouldn't wait
for this series.

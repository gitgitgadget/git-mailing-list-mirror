From: Junio C Hamano <gitster@pobox.com>
Subject: What's in git.git (stable)
Date: Wed, 05 Mar 2008 22:02:13 -0800
Message-ID: <7v8x0wie56.fsf@gitster.siamese.dyndns.org>
References: <7v8x27iui1.fsf@gitster.siamese.dyndns.org>
 <7vd4r24ox6.fsf@gitster.siamese.dyndns.org>
 <7vir0o44mt.fsf_-_@gitster.siamese.dyndns.org>
 <7vejb7ymep.fsf@gitster.siamese.dyndns.org>
 <7vfxvhjukt.fsf@gitster.siamese.dyndns.org>
 <7vablloqqe.fsf@gitster.siamese.dyndns.org>
 <7vod9wlfx5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 06 07:03:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JX9CE-0005E7-OA
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 07:03:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757279AbYCFGCV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Mar 2008 01:02:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752536AbYCFGCV
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Mar 2008 01:02:21 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:65085 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751908AbYCFGCT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Mar 2008 01:02:19 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id ECE713361;
	Thu,  6 Mar 2008 01:02:17 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 00D973360; Thu,  6 Mar 2008 01:02:15 -0500 (EST)
X-maint-at: 52dce39762fbec75b2d561e5dedb25b8e51f83eb
X-master-at: b9217642ef2db34e2cbeaef8d4439b07a03027cd
In-Reply-To: <7vod9wlfx5.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 02 Mar 2008 18:06:30 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76340>

I should probably do a 1.5.4.4 shortly from 'maint' to flush accumulate=
d
fixes.  There is nothing major, but send-email regression fix deserves =
to
be delibered sooner to the end users.

On the 'master', we briefly had a faulty receive-pack to cause a small
pushes to fail, but that glitch has been reverted.  Also fixed was a
git-describe not quite working when your tags are packed (e.g. after
git-gc).

----------------------------------------------------------------
* The 'maint' branch has these fixes since the last announcement.

Bj=C3=B6rn Steinbrink (1):
  receive-pack: Initialize PATH to include exec-dir.

Gerrit Pape (1):
  git-merge.sh: better handling of combined --squash,--no-ff,--no-commi=
t
    options

Jeff King (1):
  revert: actually check for a dirty index

Junio C Hamano (2):
  tests: introduce test_must_fail
  Update draft release notes for 1.5.4.4

Matthieu Moy (1):
  Fix incorrect wording in git-merge.txt.

Mike Hommey (1):
  Fix random crashes in http_cleanup()

Ping Yin (1):
  git-submodule: Fix typo 'url' which should be '$url'

Shawn O. Pearce (1):
  Fix 'git remote show' regression on empty repository in 1.5.4

----------------------------------------------------------------
* The 'master' branch has these since the last announcement
  in addition to the above.

Alex Riesen (1):
  Fix test for cleanup failure in t7300 on Windows

Junio C Hamano (8):
  Update draft release notes for 1.5.5
  git-describe: use tags found in packed-refs correctly
  describe: fix --long output
  describe: re-fix display_name()
  t6120 (describe): check --long properly
  Revert "receive-pack: use strict mode for unpacking objects"
  Revert "unpack-objects: prevent writing of inconsistent objects"
  fsck.c: fix bogus "empty tree" check

Martin Koegler (1):
  fetch-pack: check parse_commit/object results

Mike Hommey (1):
  t3407-rebase-abort.sh: Enhance existing tests, and add test for rebas=
e
    --merge

SZEDER G=C3=A1bor (2):
  bash: add git-branch options
  bash: git-branch -d and -m lists only local branches

Shawn O. Pearce (3):
  Don't allow git-describe failures to go unnoticed in t6120
  Test for packed tags in git-describe output
  Add git-describe test for "verify annotated tag names on output"

Simon Hausmann (1):
  git-p4: Fix import of changesets with file deletions


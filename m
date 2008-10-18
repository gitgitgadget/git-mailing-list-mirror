From: Junio C Hamano <gitster@pobox.com>
Subject: What's in git.git (Oct 2008, #04; Sat, 18)
Date: Sat, 18 Oct 2008 13:35:22 -0700
Message-ID: <7vtzb9abg5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 18 22:37:04 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrIXX-00063G-9L
	for gcvg-git-2@gmane.org; Sat, 18 Oct 2008 22:36:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751124AbYJRUfe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 18 Oct 2008 16:35:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751171AbYJRUfe
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Oct 2008 16:35:34 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:58083 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751073AbYJRUfd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Oct 2008 16:35:33 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id D8E688C936;
	Sat, 18 Oct 2008 16:35:29 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 8AE448C934; Sat, 18 Oct 2008 16:35:27 -0400 (EDT)
X-maint-at: f430c8e44d0548e844d817fc32be7c38b2b6856c
X-master-at: 3041b98a9d40e5eb1aae9698c7e15c85ff37f344
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 4DC5A454-9D54-11DD-A4A2-4F5276724C3F-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98569>

Hopefully what's in 'maint' today can become 1.6.0.3 soon, perhaps in m=
id
next week.

* The 'maint' branch has these fixes since the last announcement.

Bj=C3=B6rn Steinbrink (1):
  force_object_loose: Fix memory leak

Brandon Casey (4):
  remote.c: correct the check for a leading '/' in a remote name
  t4018-diff-funcname: rework negated last expression test
  t4018-diff-funcname: demonstrate end of line funcname matching flaw
  xdiff-interface.c: strip newline (and cr) from line before pattern
    matching

Dan McGee (1):
  contrib: update packinfo.pl to not use dashed commands

Daniel Barkalow (1):
  Check early that a new branch is new and valid

Jeff King (1):
  tests: shell negation portability fix

Jonas Fonseca (1):
  git-check-attr(1): add output and example sections

Junio C Hamano (3):
  Update draft release notes to 1.6.0.3
  diff(1): clarify what "T"ypechange status means
  Hopefully the final draft release notes update before 1.6.0.3

Matt McCutchen (1):
  t1301-shared-repo.sh: don't let a default ACL interfere with the test

Mikael Magnusson (1):
  Typo "does not exists" when git remote update remote.

Miklos Vajna (1):
  Add testcase to ensure merging an early part of a branch is done prop=
erly


* The 'master' branch has these since the last announcement
  in addition to the above.

Andreas Ericsson (1):
  git commit: Reformat output somewhat

Brandon Casey (1):
  t4018-diff-funcname: add objective-c xfuncname pattern to syntax test

Jeff King (3):
  reformat informational commit message
  tutorial: update output of git commit
  tests: shell negation portability fix

Junio C Hamano (2):
  Update draft release notes to 1.6.1
  Update draft release notes for 1.6.1

Miklos Vajna (1):
  Add Linux PPC support to the pre-auto-gc example hook

Pieter de Bie (1):
  builtin-commit.c: show on which branch a commit was added

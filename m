From: Junio C Hamano <gitster@pobox.com>
Subject: What's in git.git (Aug 2008, #03; Thu, 14)
Date: Thu, 14 Aug 2008 01:56:56 -0700
Message-ID: <7v1w0sdlev.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 14 10:58:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTYem-0001xS-SS
	for gcvg-git-2@gmane.org; Thu, 14 Aug 2008 10:58:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752740AbYHNI5G convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Aug 2008 04:57:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753240AbYHNI5E
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 04:57:04 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:59749 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752315AbYHNI5C convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Aug 2008 04:57:02 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8C396585A6;
	Thu, 14 Aug 2008 04:57:01 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 77C59585A5; Thu, 14 Aug 2008 04:56:59 -0400 (EDT)
X-maint-at: 21926fe885aa6579f7aa0e89fcb6a9064f8aa516
X-master-at: a0653d550524a0263d36fde6a8cf98941dd057ab
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F5A0C554-69DE-11DD-ADF8-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92337>

We will have the 1.6.0 final this weekend.  Please keep "obviously
correct" fixes flowing in.

* The 'maint' branch has these fixes since the last announcement.

Brandon Casey (1):
  t5304-prune: adjust file mtime based on system time rather than file
    mtime

=46rancis Moreau (1):
  git-bisect: fix wrong usage of read(1)

Junio C Hamano (2):
  Re-fix rev-list-options documentation
  Do not talk about "diff" in rev-list documentation.

Kevin Ballard (1):
  Fix escaping of glob special characters in pathspecs


* The 'master' branch has these since the last announcement
  in addition to the above.

Brandon Casey (1):
  test-parse-options: use appropriate cast in length_callback

Gustaf Hendeby (2):
  gitattributes: Document built in hunk header patterns
  Teach git diff about BibTeX head hunk patterns

Junio C Hamano (2):
  diff --check: do not unconditionally complain about trailing empty li=
nes
  GIT 1.6.0-rc3

Marcus Griep (3):
  Git.pm: Add faculties to allow temp files to be cached
  git-svn: Make it incrementally faster by minimizing temp files
  git-svn: Reduce temp file usage when dealing with non-links

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (1):
  Fix typo in comments of longest_ancestor_length()

Petr Baudis (1):
  Adjust for the new way of enabling the default post-update hook

Stephen R. van den Berg (1):
  git-daemon: SysV needs the signal handler reinstated.

Thomas Rast (4):
  Documentation: rev-list-options: Fix a typo
  Documentation: rev-list-options: Rewrite simplification descriptions =
for
    clarity
  rebase -i -p: handle index and workdir correctly
  rebase -i -p: fix parent rewriting

From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] GIT 1.5.4.1
Date: Sun, 10 Feb 2008 02:47:59 -0800
Message-ID: <7vodapgk9s.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-kernel@vger.kernel.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 10 11:48:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JO9k1-0001nr-3L
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 11:48:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756293AbYBJKsN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Feb 2008 05:48:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756260AbYBJKsN
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 05:48:13 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:54449 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755940AbYBJKsL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Feb 2008 05:48:11 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id A5AC61453;
	Sun, 10 Feb 2008 05:48:09 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id CE2121452;
	Sun, 10 Feb 2008 05:48:02 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73331>

The latest maintenance release GIT 1.5.4.1 is available at the
usual places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.5.4.1.tar.{gz,bz2}			(tarball)
  git-htmldocs-1.5.4.1.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.5.4.1.tar.{gz,bz2}		(preformatted docs)
  RPMS/$arch/git-*-1.5.4.1-1.$arch.rpm	(RPM)

Among a handful of documentation patches, there are a few true
bugfixes.

 * An entry in the .gitattributes file that names a pattern in a
   subdirectory of the directory it is in did not match
   correctly (e.g. pattern "b/*.c" in "a/.gitattributes" should
   match "a/b/foo.c" but it didn't).

 * "git-commit -C $tag" used to work but rewrite in C done in
   1.5.4 broke it, which this release fixes.

 * Customized color specification was parsed incorrectly when
   numeric color values are used.

----------------------------------------------------------------

Changes since v1.5.4 are as follows:

Gerrit Pape (1):
      INSTALL: git-merge no longer uses cpio

Jari Aalto (1):
      Documentation/git-stash.txt: Adjust SYNOPSIS command syntax (2)

Junio C Hamano (3):
      Update stale documentation links from the main documentation.
      Fix "git-commit -C $tag"
      gitattributes: fix relative path matching

J=C3=B6rg Sommer (2):
      git-am: fix type in its usage string
      git-remote documentation: fix synopsis to match description

Tim Stoakes (1):
      Fix typo in 'blame' documentation.

Timo Hirvonen (1):
      Fix parsing numeric color values

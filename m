From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] GIT 1.6.0.6
Date: Fri, 19 Dec 2008 22:40:41 -0800
Message-ID: <7vljub1h92.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 20 07:42:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDvXV-00018c-Fw
	for gcvg-git-2@gmane.org; Sat, 20 Dec 2008 07:42:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752219AbYLTGkx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Dec 2008 01:40:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752157AbYLTGkx
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Dec 2008 01:40:53 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:53357 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752141AbYLTGkw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Dec 2008 01:40:52 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 9B2F91AB28;
	Sat, 20 Dec 2008 01:40:49 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id B318D1AB25; Sat,
 20 Dec 2008 01:40:43 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 23A27B82-CE61-11DD-8EB0-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103623>

The latest maintenance release GIT 1.6.0.6 is available at the
usual places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.6.0.6.tar.{gz,bz2}			(source tarball)
  git-htmldocs-1.6.0.6.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.6.0.6.tar.{gz,bz2}		(preformatted docs)

The RPM binary packages for a few architectures are also provided
as courtesy.

  RPMS/$arch/git-*-1.6.0.6-1.fc9.$arch.rpm	(RPM)

Among miscellaneous fixes, this contains a local gitweb security fix.
Maintenance releases for older versions (v1.5.4.7, v1.5.5.6 and v1.5.6.6)
are also available at the same place.

----------------------------------------------------------------

Changes since v1.6.0.5 are as follows:

David Aguilar (1):
      git-mergetool: properly handle "git mergetool -- filename"

Deskin Miller (1):
      git-svn: Make following parents atomic

Jim Meyering (1):
      git-config.txt: fix a typo

Johannes Schindelin (2):
      fast-import: close pack before unlinking it
      fast-export: deal with tag objects that do not have a tagger

Junio C Hamano (6):
      work around Python warnings from AsciiDoc
      git-show: do not segfault when showing a bad tag
      pager: do not dup2 stderr if it is already redirected
      gitweb: do not run "git diff" that is Porcelain
      GIT 1.5.4.7
      fast-import: make tagger information optional

Linus Torvalds (1):
      fsck: reduce stack footprint

Markus Heidelberg (1):
      Documentation: fix typos, grammar, asciidoc syntax

Miklos Vajna (1):
      SubmittingPatches: mention the usage of real name in Signed-off-by: lines

Nicolas Pitre (1):
      make sure packs to be replaced are closed beforehand

Wu Fengguang (1):
      git-send-email: handle email address with quoted comma

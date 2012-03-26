From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git 1.7.9.5
Date: Mon, 26 Mar 2012 16:16:09 -0700
Message-ID: <7v7gy7lzra.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 27 01:16:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCJ9B-0006OR-2g
	for gcvg-git-2@plane.gmane.org; Tue, 27 Mar 2012 01:16:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757292Ab2CZXQO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Mar 2012 19:16:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51687 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753003Ab2CZXQN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2012 19:16:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D68C97205;
	Mon, 26 Mar 2012 19:16:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=C
	X5znC3h0F1MUkiKTTSR/NsNAVM=; b=m8MVAATZsogmNYzaOoNx4cGaZsfPi93+E
	Qo2ionORLLSyRlTwR1OVXPRNwdQV2sXOLmG/9SVQ7EcS1xgB0gLU/ds0LGbQHtRx
	lpP1PTBMnFEfo8v+nYeJVOE+ZK//ohkEZYZWrE8bPvtHQDuGAloEVpvS9IJA1Uv+
	O7ahE2ulcI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=qUT
	izbasKB0Vbzh6CJS6oZ1XWjlwZ3vCjKw/dofy1jUgKqkcDf1MxXD/mseGdXVEELM
	wnGOW7qhtE+W48ZdwukP0cQcIwWYrF8IBwt8kTagyY41ivRlHx2hXU6BGybjebbs
	uvqBi6E6uVJjGd4UGRmr7MuGjisC9t/LE0D0cZsE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CE2047204;
	Mon, 26 Mar 2012 19:16:11 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2FDC07202; Mon, 26 Mar 2012
 19:16:11 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: ACE2A612-7799-11E1-BA2D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193984>

The latest maintenance release Git 1.7.9.5 is now available at the
usual places.

The release tarballs are found at:

    http://code.google.com/p/git-core/downloads/list

and their SHA-1 checksums are:

33f5a5b0b6c8f8addbbec0b042731c44fd79f90c  git-1.7.9.5.tar.gz
a88baa35440033263a4f52b258f2f76cb6f87731  git-htmldocs-1.7.9.5.tar.gz
37a162c22127adc82ce9fb75aacddb6428c565da  git-manpages-1.7.9.5.tar.gz

Also the following public repositories all have a copy of the v1.7.9.5
tag and the maint branch that the tag points at:

  url = git://repo.or.cz/alt-git.git
  url = https://code.google.com/p/git-core/
  url = git://git.sourceforge.jp/gitroot/git-core/git.git
  url = git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url = https://github.com/gitster/git

Git v1.7.9.5 Release Notes
==========================

Fixes since v1.7.9.4
--------------------

 * When "git config" diagnoses an error in a configuration file and
   shows the line number for the offending line, it miscounted if the
   error was at the end of line.

 * "git fast-import" accepted "ls" command with an empty path by
   mistake.

 * Various new-ish output decoration modes of "git grep" were not
   documented in the manual's synopsis section.

 * The "remaining" subcommand to "git rerere" was not documented.

 * "gitweb" used to drop warnings in the log file when "heads" view is
   accessed in a repository whose HEAD does not point at a valid
   branch.

Also contains minor fixes and documentation updates.

----------------------------------------------------------------

Changes since v1.7.9.4 are as follows:

Jakub Narebski (1):
      gitweb: Fix actionless dispatch for non-existent objects

Jonathan Nieder (2):
      fast-import: leakfix for 'ls' of dirty trees
      fast-import: don't allow 'ls' of path with empty components

Junio C Hamano (2):
      i18n of multi-line advice messages
      Git 1.7.9.5

Kirill Smelkov (1):
      t/Makefile: Use $(sort ...) explicitly where needed

Mark Lodato (1):
      grep doc: add --break / --heading / -W to synopsis

Martin Stenberg (1):
      config: report errors at the EOL with correct line number

Nelson Benitez Leon (1):
      documentation: fix alphabetic ordered list for git-rebase man page

Phil Hord (1):
      rerere: Document 'rerere remaining'

Rodrigo Silva (MestreLion) (1):
      Documentation: improve description of GIT_EDITOR and preference order

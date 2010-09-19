From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git 1.7.3
Date: Sat, 18 Sep 2010 18:27:24 -0700
Message-ID: <7vpqway137.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 19 03:28:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ox8hO-0000Tw-OU
	for gcvg-git-2@lo.gmane.org; Sun, 19 Sep 2010 03:28:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755282Ab0ISB1g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Sep 2010 21:27:36 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:38408 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755068Ab0ISB1f (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Sep 2010 21:27:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D2388D7118;
	Sat, 18 Sep 2010 21:27:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=gC0K
	kIVRJN0vBgFQceaU7llSX0w=; b=Pxhk9SnjT/h3tDic7Ibn4PTFv/W/QpV10VNn
	yvqB/LZmiCP0kYeCG0QGoLLG/LSQ1erXbHTTLntnTR/kU+DZer43j0i4sz+UgXlC
	GRljIrRlrkNCE6uGBfPBzCRPRZz/G4/ZM9Jm4dl38B2AAhN1iyboTz02C89jPIqp
	NylmSa4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=DPn
	Qih/7QlVdvglpIMDLvcseB7QLvNJd4asE4DAXRmhwcG2JXn6zRRzC/jlXSuj5uzi
	mbfktnHDsul03K1MMs7uwxftCczoe5APso/hBAj7OYlNTdQznQBy2wEe+4BjfGfU
	zlOQuWjIkPHE8w2lrfExh+nBWqzGJd2/Ct5U3sMA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9D041D7117;
	Sat, 18 Sep 2010 21:27:30 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B2D9DD7116; Sat, 18 Sep
 2010 21:27:26 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 121DF4F4-C38D-11DF-8D65-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156481>

The latest feature release Git 1.7.3 is available at the usual
places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.7.3.tar.{gz,bz2}			(source tarball)
  git-htmldocs-1.7.3.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.7.3.tar.{gz,bz2}		(preformatted docs)

The RPM binary packages for a few architectures are found in:

  RPMS/$arch/git-*-1.7.3-1.fc11.$arch.rpm	(RPM)

Git v1.7.3 Release Notes
========================

Updates since v1.7.2
--------------------

 * git-gui, now at version 0.13.0, got various updates and a new
   maintainer, Pat Thoyts.

 * Gitweb allows its configuration to change per each request; it used to
   read the configuration once upon startup.

 * When git finds a corrupt object, it now reports the file that contains
   it.

 * "git checkout -B <it>" is a shorter way to say "git branch -f <it>"
   followed by "git checkout <it>".

 * When "git checkout" or "git merge" refuse to proceed in order to
   protect local modification to your working tree, they used to stop
   after showing just one path that might be lost.  They now show all,
   in a format that is easier to read.

 * "git clean" learned "-e" ("--exclude") option.

 * Hunk headers produced for C# files by "git diff" and friends show more
   relevant context than before.

 * diff.ignoresubmodules configuration variable can be used to squelch the
   differences in submodules reported when running commands (e.g. "diff",
   "status", etc.) at the superproject level.

 * http.useragent configuration can be used to lie who you are to your
   restrictive firewall.

 * "git rebase --strategy <s>" learned "-X" option to pass extra options
   that are understood by the chosen merge strategy.

 * "git rebase -i" learned "exec" that you can insert into the insn sheet
   to run a command between its steps.

 * "git rebase" between branches that have many binary changes that do
   not conflict should be faster.

 * "git rebase -i" peeks into rebase.autosquash configuration and acts as
   if you gave --autosquash from the command line.


Also contains various documentation updates.


Fixes since v1.7.2
------------------

All of the fixes in v1.7.2.X maintenance series are included in this
release, unless otherwise noted.

 * "git merge -s recursive" (which is the default) did not handle cases
   where a directory becomes a file (or vice versa) very well.

 * "git fetch" and friends were accidentally broken for url with "+" in
   its path, e.g. "git://git.gnome.org/gtk+".

 * "git fetch $url" (i.e. without refspecs) was broken for quite some
   time, if the current branch happen to be tracking some remote.

 * "git ls-tree dir dirgarbage", when "dir" was a directory,
   incorrectly recursed into "dir".

 * "git note remove" created unnecessary extra commit when named object
   did not have any note to begin with.

 * "git rebase" did not work well if you had diff.noprefix configured.

 * "git -c foo=bar subcmd" did not work well for subcmd that is not
   implemented as a built-in command.

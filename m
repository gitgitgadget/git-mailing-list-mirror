From: Junio C Hamano <gitster@pobox.com>
Subject: What's in git.git (stable)
Date: Sun, 11 Nov 2007 23:06:55 -0800
Message-ID: <7vy7d43ptc.fsf@gitster.siamese.dyndns.org>
References: <20071022061115.GR14735@spearce.org>
	<7vodeecyni.fsf@gitster.siamese.dyndns.org>
	<7vpryqwtt7.fsf@gitster.siamese.dyndns.org>
	<7vk5ot40w9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 12 08:07:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrTOI-0007zt-LC
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 08:07:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752484AbXKLHHF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 02:07:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752625AbXKLHHE
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 02:07:04 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:43446 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751288AbXKLHHA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 02:07:00 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 008DD2F2;
	Mon, 12 Nov 2007 02:07:21 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 5254994604;
	Mon, 12 Nov 2007 02:07:19 -0500 (EST)
X-maint-at: a91ef6e75b897a255cc17b70014a39e68dd54c7a
X-master-at: 40e2524da9f9fb2806a66a694b9aee722ea3ef0a
In-Reply-To: <7vk5ot40w9.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 08 Nov 2007 00:06:14 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64566>

* The 'maint' branch has these fixes since the last announcement.

Alex Riesen (1):
  stop t1400 hiding errors in tests

Benoit Sigoure (1):
  git-send-email: Change the prompt for the subject of the initial
      message.

Gerrit Pape (1):
  git-mailsplit: with maildirs not only process cur/, but also new/

Jonas Fonseca (1):
  instaweb: Minor cleanups and fixes for potential problems

Junio C Hamano (3):
  refresh_index_quietly(): express "optional" nature of index writing
      better
  Makefile: add missing dependency on wt-status.h
  Start preparing for 1.5.3.6

Nicolas Pitre (3):
  print warning/error/fatal messages in one shot
  git-hash-object should honor config variables
  fix index-pack with packs >4GB containing deltas on 32-bit machines

Ralf Wildenhues (2):
  Avoid a few unportable, needlessly nested "...`...".
  Fix sed string regex escaping in module_name.

Sergei Organov (1):
  SubmittingPatches: improve the 'Patch:' section of the checklist

Vincent Zanotti (1):
  gitweb: correct month in date display for atom feeds


* The 'master' branch has these since the last announcement
  in addition to the above.

Gerrit Pape (3):
  hooks--update: fix test for properly set up project description
      file
  hooks--update: decline deleting tags or branches by default, add
      config options
  contrib/hooks/post-receive-email: remove cruft, $committer is not
      used

Johannes Schindelin (4):
  parse-options: abbreviation engine fix.
  builtin-reset: do not call "ls-files --unmerged"
  builtin-reset: avoid forking "update-index --refresh"
  builtin-blame: set up the work_tree before the first file access

Johannes Sixt (1):
  upload-pack: Use finish_{command,async}() instead of waitpid().

Junio C Hamano (6):
  Style: place opening brace of a function definition at column 1
  Update draft release notes for 1.5.4
  Documentation: lost-found is now deprecated.
  Make check-docs target detect removed commands
  Documentation: remove documentation for removed tools.
  git-commit: a bit more tests

Lars Hjemli (1):
  for-each-ref: fix setup of option-parsing for --sort

Michele Ballabio (1):
  test-lib.sh: move error line after error() declaration

Nicolas Pitre (1):
  add a howto document about corrupted blob recovery

Ralf Wildenhues (1):
  git-bisect.sh: Fix sed script to work with AIX and BSD sed.

Sergei Organov (1):
  core-tutorial.txt: Fix git-show-branch example and its description

Steffen Prohaska (2):
  push: mention --verbose option in documentation
  push: teach push to pass --verbose option to transport layer

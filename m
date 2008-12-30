From: Junio C Hamano <gitster@pobox.com>
Subject: What's in git.git (Dec 2008, #04; Mon, 29)
Date: Tue, 30 Dec 2008 13:03:46 -0800
Message-ID: <7vbput1ikt.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 30 22:05:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHlm9-0005My-Hc
	for gcvg-git-2@gmane.org; Tue, 30 Dec 2008 22:05:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752123AbYL3VDv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 30 Dec 2008 16:03:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752002AbYL3VDv
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Dec 2008 16:03:51 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:44539 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751831AbYL3VDu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Dec 2008 16:03:50 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 82F2F1B674;
	Tue, 30 Dec 2008 16:03:50 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 8E3651B673; Tue,
 30 Dec 2008 16:03:48 -0500 (EST)
X-maint-at: 936b7057e8401665a2d106e8de018561db6333fe
X-master-at: c32f76f4d220e5d4d6a599d7a12a50b1e3ceceaf
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5B99BA80-D6B5-11DD-83F4-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104206>

This is the last installment of "What's in" series of the year 2008.
Enjoy a happy new year break, everybody.

* The 'maint' branch has these fixes since v1.6.1.

Adeodato Sim=C3=B3 (2):
  git-shortlog.txt: improve documentation about .mailmap files
  git-send-email.txt: move --format-patch paragraph to a proper locatio=
n

Devin Doucette (1):
  gitweb: Fix export check in git_get_projects_list

Junio C Hamano (1):
  Prepare for v1.6.1.1 maintenance release

Ren=C3=A9 Scharfe (7):
  daemon: handle freopen() failure
  daemon: cleanup: replace loop with if
  daemon: cleanup: factor out xstrdup_tolower()
  merge-file: handle freopen() failure
  pretty: factor out skip_empty_lines()
  pretty: factor out format_subject()
  pretty: support multiline subjects with format:

Shawn O. Pearce (1):
  describe: Avoid unnecessary warning when using --all

jidanni@jidanni.org (1):
  Documentation/diff-options.txt: unify options


* The 'master' branch has these since the last announcement
  in addition to the above.

Johannes Schindelin (1):
  Force t5302 to use a single thread

Junio C Hamano (2):
  Document "git-reset --merge"
  Start 1.6.2 cycle

Linus Torvalds (1):
  Add 'merge' mode to 'git reset'

Nicolas Pitre (2):
  autodetect number of CPUs by default when using threads
  pack-objects: don't use too many threads with few objects

Teemu Likonen (2):
  Fix the building of user-manual.texi and gitman.texi documents
  Fix the building of gitman.info document

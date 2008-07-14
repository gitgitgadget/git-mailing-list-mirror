From: Junio C Hamano <gitster@pobox.com>
Subject: What's in git.git (stable)
Date: Sun, 13 Jul 2008 22:33:26 -0700
Message-ID: <7vmykljahl.fsf@gitster.siamese.dyndns.org>
References: <7vtzibbjxn.fsf@gitster.siamese.dyndns.org>
 <7vwsn75pmv.fsf@gitster.siamese.dyndns.org>
 <7vy77gapkl.fsf@gitster.siamese.dyndns.org>
 <7vmynqfeab.fsf@gitster.siamese.dyndns.org>
 <7vwsmjj0js.fsf@gitster.siamese.dyndns.org>
 <7vhcdchr80.fsf@gitster.siamese.dyndns.org>
 <7vhcd0jyyp.fsf@gitster.siamese.dyndns.org>
 <7vod6wpjvr.fsf@gitster.siamese.dyndns.org>
 <7vod6nikuw.fsf@gitster.siamese.dyndns.org>
 <7viqws6zaz.fsf@gitster.siamese.dyndns.org>
 <7vfxrhwspw.fsf@gitster.siamese.dyndns.org>
 <7vwsknyz9m.fsf@gitster.siamese.dyndns.org>
 <7vlk0z9k5f.fsf@gitster.siamese.dyndns.org>
 <7vej6oipea.fsf@gitster.siamese.dyndns.org>
 <7vabh93lk6.fsf@gitster.siamese.dyndns.org>
 <7vwsk4g5py.fsf@gitster.siamese.dyndns.org>
 <7vr6a7fhwh.fsf@gitster.siamese.dyndns.org>
 <7v1w25xfd6.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 14 07:35:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIGiE-00077f-4E
	for gcvg-git-2@gmane.org; Mon, 14 Jul 2008 07:35:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752163AbYGNFdf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Jul 2008 01:33:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752114AbYGNFdf
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 01:33:35 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:62032 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752034AbYGNFde convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Jul 2008 01:33:34 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id A2DF92AFC8;
	Mon, 14 Jul 2008 01:33:33 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 48D942AFC7; Mon, 14 Jul 2008 01:33:30 -0400 (EDT)
X-maint-at: 191a8e32b38c7ff0dd884df7bd323b7a5bd4336c
X-master-at: 10ce0209b69cebc32d9bfbe78067c752952425cc
In-Reply-To: <7v1w25xfd6.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 07 Jul 2008 19:46:13 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 66581626-5166-11DD-BA83-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88376>

* The 'maint' branch is at 1.5.6.3

* The 'master' branch has these since the last announcement
  in addition to what's in 1.5.6.3

Abhijit Menon-Sen (2):
  Implement "git stash branch <newbranch> <stash>"
  Add a test for "git stash branch"

Adam Brewster (1):
  Teach git-bundle to read revision arguments from stdin like git-rev-l=
ist.

Brandon Casey (1):
  t7701-repack-unpack-unreachable.sh: check timestamp of unpacked objec=
ts

Eric Hanchrow (2):
  user-manual: typo and grammar fixes
  Documentation: fix broken "linkgit" links

Eric Raible (2):
  Documentation: tweak use case in "git stash save --keep-index"
  completion: add branch options --contains --merged --no-merged

Jeff King (2):
  Allow per-command pager config
  avoid null SHA1 in oldest reflog

Johannes Schindelin (2):
  Teach "git apply" to prepend a prefix with "--root=3D<root>"
  Allow cherry-picking root commits

Johannes Sixt (1):
  Provide fallback definitions of PRIu32 and PRIx32

Junio C Hamano (17):
  revision traversal: --children option
  rev-list --children
  builtin-blame.c: move prepare_final() into a separate function.
  builtin-blame.c: allow more than 16 parents
  git-blame --reverse
  Per-ref reflog expiry configuration
  Make default expiration period of reflog used for stash infinite
  apply --root: thinkofix.
  Refactor "tracking statistics" code used by "git checkout"
  git-status: show the remote tracking statistics
  git-branch -v: show the remote tracking statistics
  stat_tracking_info(): clear object flags used during counting
  branch -r -v: do not spit out garbage
  git-apply --directory: make --root more similar to GNU diff
  Tone down warning about GNU Interactive Tools
  Documentation: update sections on naming revisions and revision range=
s
  apply: fix copy/rename breakage

Mark Levedahl (1):
  install-doc-quick - use git --exec-path to find git-sh-setup

Mike Hommey (4):
  Catch failures from t5540-http-push
  Fix http-push test
  Skip t5540-http-push test when USE_CURL_MULTI is undefined
  Avoid apache complaining about lack of server's FQDN

Petr Baudis (1):
  Git.pm: Add remote_refs() git-ls-remote frontend

Pierre Habouzit (12):
  parse-opt: have parse_options_{start,end}.
  parse-opt: Export a non NORETURN usage dumper.
  parse-opt: create parse_options_step.
  parse-opt: do not print errors on unknown options, return -2 intead.
  parse-opt: fake short strings for callers to believe in.
  parse-opt: add PARSE_OPT_KEEP_ARGV0 parser option.
  revisions: split handle_revision_opt() from setup_revisions()
  git-blame: migrate to incremental parse-option [1/2]
  git-blame: migrate to incremental parse-option [2/2]
  git-blame: fix lapsus
  git-shortlog: migrate to parse-options partially.
  revisions: refactor handle_revision_opt into parse_revision_opt.

Ramsay Allan Jones (3):
  t9113-*.sh: provide user feedback when test skipped
  t9100-git-svn-basic.sh: Fix determination of utf-8 locale
  git-request-pull: replace call to deprecated peek-remote

Robert Shearman (1):
  git-send-email: Fix authenticating on some servers when using TLS.

SZEDER G=C3=A1bor (1):
  stash: introduce 'stash save --keep-index' option

Shawn O. Pearce (3):
  Correct pack memory leak causing git gc to try to exceed ulimit
  bash completion: Improve responsiveness of git-log completion
  bash completion: Don't offer "a.." as a completion for "a."

Stephan Beyer (3):
  git-am/git-mailsplit: correct synopsis for reading from stdin
  t3404: test two "preserve merges with -p" cases
  Make rebase--interactive use OPTIONS_SPEC

Thomas Rast (3):
  git-add--interactive: replace hunk recounting with apply --recount
  git-add--interactive: remove hunk coalescing
  git-add--interactive: manual hunk editing mode

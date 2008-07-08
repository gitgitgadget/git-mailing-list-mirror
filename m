From: Junio C Hamano <gitster@pobox.com>
Subject: What's in git.git (stable)
Date: Mon, 07 Jul 2008 19:46:13 -0700
Message-ID: <7v1w25xfd6.fsf@gitster.siamese.dyndns.org>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 08 04:47:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KG3Ei-0004mg-Tu
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 04:47:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755724AbYGHCqZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2008 22:46:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755725AbYGHCqZ
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jul 2008 22:46:25 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:35517 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755716AbYGHCqY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2008 22:46:24 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 604DE278C2;
	Mon,  7 Jul 2008 22:46:23 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 82C47278C1; Mon,  7 Jul 2008 22:46:21 -0400 (EDT)
X-maint-at: 39f319f4d51966419c0725d1145677457d6f162a
X-master-at: bed625540a0e1a4ba4da9962ed53c1d83d9bf509
In-Reply-To: <7vr6a7fhwh.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 06 Jul 2008 03:04:14 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0D5B8724-4C98-11DD-A180-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87691>

* The 'maint' branch has these fixes since 1.5.6.2.

Alex Riesen (1):
  git-clone: remove leftover debugging fprintf().

Brian Hetro (5):
  builtin-log.c: Use 'git_config_string' to get 'format.subjectprefix' and
    'format.suffix'
  convert.c: Use 'git_config_string' to get 'smudge' and 'clean'
  diff.c: Use 'git_config_string' to get 'diff.external'
  http.c: Use 'git_config_string' to clean up SSL config.
  builtin-commit.c: Use 'git_config_string' to get 'commit.template'

Christian Couder (1):
  Fix "config_error_nonbool" used with value instead of key

Gerrit Pape (1):
  git-svn.perl: workaround assertions in svn library 1.5.0

Junio C Hamano (3):
  attribute documentation: keep EXAMPLE at end
  clone -q: honor "quiet" option over native transports.
  mailinfo: feed the correct line length to decode_transfer_encoding()

Matthew Ogilvie (1):
  Documentation cvs: Clarify when a bare repository is needed

Mikael Magnusson (1):
  Fix grammar in git-rev-parse(1).

Nikolaus Schulz (1):
  Documentation: be precise about which date --pretty uses


* The 'master' branch has these since the last announcement
  in addition to the above.

Abhijit Menon-Sen (2):
  git-gui: Move on to the next filename after staging/unstaging a change
  git-gui: Don't select the wrong file if the last listed file is staged.

Daniel Barkalow (1):
  Only use GIT_CONFIG in "git config", not other programs

David Reiss (4):
  Implement normalize_absolute_path
  Fold test-absolute-path into test-path-utils
  Add support for GIT_CEILING_DIRECTORIES
  Eliminate an unnecessary chdir("..")

Dmitry Potapov (1):
  completion.bash: add 'skip' and 'run' to git-bisect

Jakub Narebski (1):
  gitweb: Describe projects_index format in more detail

Johannes Schindelin (3):
  Add another fast-import example, this time for .zip files
  git daemon: avoid calling syslog() from a signal handler
  run_command(): respect GIT_TRACE

Johannes Sixt (1):
  git-gui: Implement "Stage/Unstage Line"

Junio C Hamano (6):
  rerere: rerere_created_at() and has_resolution() abstraction
  git-rerere: detect unparsable conflicts
  rerere: remove dubious "tail_optimization"
  t4200: fix rerere test
  rerere.autoupdate
  Update draft release notes for 1.6.0

Richard Quirk (1):
  git-gui: Fix accidental staged state toggle when clicking top pixel row

From: Junio C Hamano <gitster@pobox.com>
Subject: What's in git.git (Aug 2008, #07; Wed, 27)
Date: Wed, 27 Aug 2008 20:01:38 -0700
Message-ID: <7vy72hj10t.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 28 05:02:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYXme-0003mo-FT
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 05:02:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752701AbYH1DBp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Aug 2008 23:01:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752516AbYH1DBp
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 23:01:45 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:51811 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751915AbYH1DBo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Aug 2008 23:01:44 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 630226ACB6;
	Wed, 27 Aug 2008 23:01:42 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 6D98F6ACB5; Wed, 27 Aug 2008 23:01:40 -0400 (EDT)
X-maint-at: c67b1fa349cc7b4341b32b9ef1c58a3821ce0830
X-master-at: a1184d85e8752658f02746982822f43f32316803
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A432F55A-74AD-11DD-AA4B-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94031>

Handful fixes went to 1.6.0.1 and then a few more are on 'maint'.

On the 'master' front, among other things:

 - "git cherry-pick" can reuse earlier conflict resolution.

 - "git merge" can use a custom strategy (if you write one).

 - "git-shell" was broken and then fixed.

 - "git submodule sync" is a new subcommand.

* The 'maint' branch has these fixes since the last announcement.

Alexander Gavrilov (1):
  Respect core.autocrlf in combined diff

Jeff King (1):
  Fix "git log -i --grep"

Jonathan Nieder (2):
  Documentation: clarify pager.<cmd> configuration
  Documentation: clarify pager configuration

Junio C Hamano (3):
  merge: fix numerous bugs around "trivial merge" area
  GIT 1.6.0.1
  ctype.c: protect tiny C preprocessor constants

Linus Torvalds (1):
  index-pack: be careful after fixing up the header/footer

Miklos Vajna (1):
  Makefile: enable SNPRINTF_RETURNS_BOGUS for HP-UX

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (1):
  index-pack: setup git repository

Ramsay Allan Jones (2):
  Fix a warning (on cygwin) to allow -Werror
  Suppress some bash redirection error messages

Simon Hausmann (1):
  Clean up the git-p4 documentation


* The 'master' branch has these since the last announcement
  in addition to the above.

Abhijit Menon-Sen (1):
  Make cherry-pick use rerere for conflict resolution.

Andreas F=C3=A4rber (1):
  Makefile: always provide a fallback when hardlinks fail

David Aguilar (1):
  git-submodule: add "sync" command

Gustaf Hendeby (1):
  Update .gitignore to ignore git-help

Jeff King (1):
  format-patch: use default diff format even with patch options

Junio C Hamano (7):
  builtin-add.c: restructure the code for maintainability
  builtin-add.c: optimize -A option and "git add ."
  shell: do not play duplicated definition games to shrink the executab=
le
  Build-in "git-shell"
  Fix "git-merge -s bogo" help text
  t7606: fix custom merge test
  Revert "Build-in "git-shell""

Mark Levedahl (3):
  git-submodule.sh - Remove trailing / from URL if found
  git-submodule.sh - Remove trailing / from URL if found
  git-submodule - Use "get_default_remote" from git-parse-remote

Miklos Vajna (6):
  builtin-help: make some internal functions available to other builtin=
s
  builtin-merge: allow using a custom strategy
  Add a new test for using a custom merge strategy
  Add a second testcase for handling invalid strategies in git-merge
  builtin-help: always load_command_list() in cmd_help()
  Builtin git-help.

Nicolas Pitre (1):
  discard revindex data when pack list changes

Simon Hausmann (1):
  Make it possible to abort the submission of a change to Perforce

Tommi Virtanen (1):
  Install git-shell in bindir, too

From: Junio C Hamano <gitster@pobox.com>
Subject: What's in git.git (stable)
Date: Thu, 08 Nov 2007 00:06:14 -0800
Message-ID: <7vk5ot40w9.fsf@gitster.siamese.dyndns.org>
References: <20071022061115.GR14735@spearce.org>
	<7vodeecyni.fsf@gitster.siamese.dyndns.org>
	<7vpryqwtt7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 08 09:06:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iq2PN-0005h7-7k
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 09:06:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753021AbXKHIGV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Nov 2007 03:06:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751152AbXKHIGV
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 03:06:21 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:51332 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751107AbXKHIGU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Nov 2007 03:06:20 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 6B28F2F2;
	Thu,  8 Nov 2007 03:06:41 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 2B6F692553;
	Thu,  8 Nov 2007 03:06:39 -0500 (EST)
X-maint-at: 6d0618a820a20846d60b665897fcce600f452eec
X-master-at: 53d149c54bdedd4cf490943a5478a7826c2379c9
In-Reply-To: <7vpryqwtt7.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sat, 03 Nov 2007 20:52:52 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63954>

On 'master' front:

 - git-p4 in contrib/ has updates.  As I cannot test it myself
   and did not hear any success/failure stories from the list,
   the only way to make sure is to push it out and see if
   anybody screams.

 - "git lost-found" is going to be deprecated (not removed) in
   the next feature release.

 - Unspecified clean.requireForce defaults to true; this would
   make "git clean" require "-f" by default.

 - "git send-email --suppress-from" does not CC yourself even
   when your name is on S-o-b: or Cc: lines in the body of the
   message.

----------------------------------------------------------------

* The 'maint' branch has these fixes since the last announcement.

Ask Bj=C3=B8rn Hansen (1):
  When exec() fails include the failing command in the error message

David D Kilzer (2):
  RelNotes-1.5.3.5: fix typo
  RelNotes-1.5.3.5: fix another typo

Eric Wong (2):
  git-svn: fix dcommit clobbering when committing a series of diffs
  git-svn: t9114: verify merge commit message in test

Gerrit Pape (3):
  git-diff.txt: add section "output format" describing the diff
      formats
  git-cvsimport: really convert underscores in branch names to dots
      with -u
  git-daemon: fix remote port number in log entry

Johannes Schindelin (1):
  Add Documentation/CodingGuidelines

Junio C Hamano (1):
  grep with unmerged index

Marco Costalba (1):
  Remove a couple of duplicated include

Mike Hommey (1):
  Delay pager setup in git blame


* The 'master' branch has these since the last announcement
  in addition to the above.

Benoit Sigoure (1):
  git-svn: sort the options in the --help message.

Brian Gernhardt (1):
  t3502: Disambiguate between file and rev by adding --

Chris Pettitt (2):
  git-p4: Add a helper function to parse the full git diff-tree
      output.
  git-p4: Detect changes to executable bit and include them in p4
      submit.

Daniel Barkalow (1):
  Use parseopts in builtin-push

David Symonds (1):
  Improve accuracy of check for presence of deflateBound.

Gerrit Pape (4):
  git-reset: add -q option to operate quietly
  contrib/hooks/post-receive-email: fix typo
  contrib/hooks/post-receive-email: reformat to wrap comments at 76
      chars
  contrib/hooks/post-receive-email: make subject prefix configurable

Heikki Orsila (1):
  git-clone: honor "--" to end argument parsing

J. Bruce Fields (1):
  errors: "strict subset" -> "ancestor"

Jakub Narebski (9):
  gitweb: Always set 'from_file' and 'to_file' in
      parse_difftree_raw_line
  gitweb: Add 'status_str' to parse_difftree_raw_line output
  gitweb: Remove CGI::Carp::set_programname() call from t9500 gitweb
      test
  gitweb: Easier adding/changing parameters to current URL
  gitweb: Use href(-replay=3D>1, page=3D>...) to generate pagination
      links
  gitweb: Use href(-replay=3D>1, action=3D>...) to generate alternate
      views
  gitweb: Add tests for overriding gitweb config with repo config
  gitweb: Read repo config using 'git config -z -l'
  gitweb: Use config file for repository description and URLs

Johannes Schindelin (3):
  git-reset: do not be confused if there is nothing to reset
  Split off the pretty print stuff into its own file
  Deprecate git-lost-found

Johannes Sixt (1):
  Fix an infinite loop in sq_quote_buf().

Junio C Hamano (6):
  revert/cherry-pick: work on merge commits as well
  format-patch -s: add MIME encoding header if signer's name requires
      so
  cherry-pick/revert -m: add tests
  test format-patch -s: make sure MIME content type is shown as
      needed
  clean: require -f to do damage by default
  gc: --prune prunes unreferenced objects.

Mike Hommey (5):
  Refactor working tree setup
  Use setup_work_tree() in builtin-ls-files.c
  Don't always require working tree for git-rm
  Make git-blame fail when working tree is needed and we're not in
      one
  Small code readability improvement in show_reference() in
      builtin-tag.c

Nicolas Pitre (4):
  make the pack index version configurable
  pack-objects: get rid of an ugly cast
  git-fetch: more terse fetch output
  restore fetching with thin-pack capability

Pierre Habouzit (1):
  Some better parse-options documentation.

Ralf Wildenhues (1):
  Fix minor nits in configure.ac

Shawn Bohrer (1):
  Add more tests for git-clean

Simon Sasburg (1):
  Make mailsplit and mailinfo strip whitespace from the start of the
      input

Steffen Prohaska (1):
  Fix comment in strbuf.h to use correct name strbuf_avail()

Steven Grimm (1):
  builtin-fetch: Add "-q" as a synonym for "--quiet"

Uwe Kleine-K=C3=B6nig (1):
  send-email: apply --suppress-from to S-o-b and cc-cmd

From: Junio C Hamano <gitster@pobox.com>
Subject: What's in git.git (stable)
Date: Fri, 30 May 2008 13:43:19 -0700
Message-ID: <7vod6nikuw.fsf@gitster.siamese.dyndns.org>
References: <7vtzibbjxn.fsf@gitster.siamese.dyndns.org>
 <7vwsn75pmv.fsf@gitster.siamese.dyndns.org>
 <7vy77gapkl.fsf@gitster.siamese.dyndns.org>
 <7vmynqfeab.fsf@gitster.siamese.dyndns.org>
 <7vwsmjj0js.fsf@gitster.siamese.dyndns.org>
 <7vhcdchr80.fsf@gitster.siamese.dyndns.org>
 <7vhcd0jyyp.fsf@gitster.siamese.dyndns.org>
 <7vod6wpjvr.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 30 22:44:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2BSi-0000Ca-60
	for gcvg-git-2@gmane.org; Fri, 30 May 2008 22:44:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752967AbYE3Unk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 May 2008 16:43:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753052AbYE3Unk
	(ORCPT <rfc822;git-outgoing>); Fri, 30 May 2008 16:43:40 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:55641 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754580AbYE3Und convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 May 2008 16:43:33 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 52B6A37AF;
	Fri, 30 May 2008 16:43:29 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 7EB3237AE; Fri, 30 May 2008 16:43:27 -0400 (EDT)
X-maint-at: 28bc30220f30850a10217d61f73e46d8a541e670
X-master-at: d2b3691b61d516a0ad2bf700a2a5d9113ceff0b1
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0F4FA664-2E89-11DD-9C5B-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83333>

[jc: I wrote this a few days ago but did not send it out]

* The 'master' branch has these since 1.5.6-rc0.

Christian Couder (1):
  bisect: use "$GIT_DIR/BISECT_START" to check if we are bisecting

Dmitry V. Levin (1):
  builtin-fetch.c (store_updated_refs): Honor update_local_ref() return
    value

Gerrit Pape (2):
  Documentation/git-bundle.txt: fix synopsis
  commit --interactive: properly update the index before commiting

Jeff King (1):
  clone: make sure we support the transport type

Johannes Schindelin (1):
  hg-to-git: add --verbose option

Johannes Sixt (2):
  t5700-clone-reference: Quote $U
  Revert "filter-branch: subdirectory filter needs --full-history"

Junio C Hamano (19):
  tests: do not use implicit "git diff --no-index"
  diff-files: do not play --no-index games
  "git diff": do not ignore index without --no-index
  Update draft release notes for 1.5.6
  log --graph: do not accept log --graphbogus
  log --pretty: do not accept bogus "--prettyshort"
  Release Notes for 1.5.5.2
  Documentation/git.txt: link to 1.5.5.2 documentation.
  Makefile: fix dependency on wt-status.h
  show-branch --current: do not barf on detached HEAD
  git-diff: allow  --no-index semantics a bit more
  git diff --no-index: default to page like other diff frontends
  GIT 1.5.5.3
  t5100: Avoid filename "nul"
  Git::cat_blob: allow using an empty blob to fix git-svn breakage
  fix sha1_pack_index_name()
  Manual subsection to refer to other pages is SEE ALSO
  Documentation: git-cherry uses git-patch-id
  "git checkout -- paths..." should error out when paths cannot be writ=
ten

Karl Hasselstr=C3=B6m (1):
  Add some tests for git update-ref -d

Lea Wiemann (1):
  gitweb: only display "next" links in logs if there is a next page

Michele Ballabio (1):
  Documentation: fix graph in git-rev-parse.txt

Pieter de Bie (1):
  builtin-fast-export: Only output a single parent per line

Shawn O. Pearce (5):
  git-gui: Add a --trace command line option
  git-gui: Handle workdir detection when CYGWIN=3Dnowinsymlinks
  Don't diff empty tree on branch creation in paranoid update hook
  Don't load missing ACL files in paranoid update hook
  Ignore no-op changes in paranoid update hook

Twiinz (1):
  git-gui: Vertically align textboxes with labels

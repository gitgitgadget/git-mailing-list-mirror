From: Junio C Hamano <gitster@pobox.com>
Subject: What's in git.git (stable)
Date: Mon, 02 Jun 2008 01:01:08 -0700
Message-ID: <7viqws6zaz.fsf@gitster.siamese.dyndns.org>
References: <7vtzibbjxn.fsf@gitster.siamese.dyndns.org>
 <7vwsn75pmv.fsf@gitster.siamese.dyndns.org>
 <7vy77gapkl.fsf@gitster.siamese.dyndns.org>
 <7vmynqfeab.fsf@gitster.siamese.dyndns.org>
 <7vwsmjj0js.fsf@gitster.siamese.dyndns.org>
 <7vhcdchr80.fsf@gitster.siamese.dyndns.org>
 <7vhcd0jyyp.fsf@gitster.siamese.dyndns.org>
 <7vod6wpjvr.fsf@gitster.siamese.dyndns.org>
 <7vod6nikuw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 02 10:02:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K34zr-0005Lf-UI
	for gcvg-git-2@gmane.org; Mon, 02 Jun 2008 10:02:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753885AbYFBIBV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Jun 2008 04:01:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753773AbYFBIBV
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jun 2008 04:01:21 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:34499 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752130AbYFBIBU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Jun 2008 04:01:20 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id CE1BA21D2;
	Mon,  2 Jun 2008 04:01:18 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id CC97321D1; Mon,  2 Jun 2008 04:01:16 -0400 (EDT)
X-maint-at: 28bc30220f30850a10217d61f73e46d8a541e670
X-master-at: 06f60e8edf1eb3a91e1af6f255bf46154168dd86
In-Reply-To: <7vod6nikuw.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 30 May 2008 13:43:19 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 150D4F32-307A-11DD-928F-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83500>

* The 'master' branch has these since the last announcement.  I'll tag
  -rc1 in a few days.  Hopefully we can make this cycle much shorter th=
an
  the painfully long one we had for 1.5.5.

Adam Simpkins (2):
  graph API: improve display of merge commits
  graph API: avoid printing unnecessary padding before some octopus mer=
ges

Christian Couder (1):
  Documentation: convert "glossary" and "core-tutorial" to man pages

Christian Engwer (1):
  git-svn fails in prop_walk if $self->{path} is not empty

Jakub Narebski (1):
  gitweb: Remove gitweb/test/ directory

Jamis Buck (1):
  git-reset: honor -q and do not show progress message

John J. Franey (1):
  Clarify description of <repository> argument to pull/fetch for naming
    remotes.

Junio C Hamano (4):
  checkout: make reset_clean_to_new() not die by itself
  checkout: consolidate reset_{to_new,clean_to_new}()
  unpack_trees(): allow callers to differentiate worktree errors from m=
erge
    errors
  checkout: "best effort" checkout

Karl Hasselstr=C3=B6m (1):
  Fix path duplication in git svn commit-diff

Lea Wiemann (4):
  t/test-lib.sh: resolve symlinks in working directory, for pathname
    comparisons
  Git.pm: fix documentation of hash_object
  glossary: improve a few links
  Git.pm: fix return value of config method

Linus Torvalds (2):
  Make pack creation always fsync() the result
  Remove now unnecessary 'sync()' calls

Luciano Rocha (1):
  git-init: accept --bare option

Marius Storm-Olsen (2):
  Clearify the documentation for core.ignoreStat
  Add shortcut in refresh_cache_ent() for marked entries.

Miklos Vajna (1):
  Revision walking documentation: document most important functions

Nicolas Pitre (1):
  make verify-pack a bit more useful with bad packs

Paolo Bonzini (1):
  rollback lock files on more signals than just SIGINT

Seth Falcon (1):
  Add a --dry-run option to git-svn rebase

Shawn O. Pearce (3):
  Remove unused remote_prefix member in builtin-remote
  Make "git-remote prune" delete refs according to fetch specs
  Make "git-remote rm" delete refs acccording to fetch specs

Stephan Beyer (2):
  Add test cases for git-am
  Merge t4150-am-subdir.sh and t4151-am.sh into t4150-am.sh

From: Junio C Hamano <gitster@pobox.com>
Subject: Incremental preview of "What's cooking" 1st issue of this year
Date: Tue, 03 Jan 2012 16:24:20 -0800
Message-ID: <7vlipoqpqj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 04 01:24:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RiEeo-0007YA-QG
	for gcvg-git-2@lo.gmane.org; Wed, 04 Jan 2012 01:24:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754643Ab2ADAYY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Jan 2012 19:24:24 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41723 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752755Ab2ADAYX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Jan 2012 19:24:23 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D86857564;
	Tue,  3 Jan 2012 19:24:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=rgWvmSaMJjAQBgRglPFYciHnY
	b0=; b=SUVJzfxLVqgRQ75U79XIu7brNa8kWrvoupJRbAXVLZ75ivIG0L83jGi2b
	x3+VPTMwOHLlDIn04En8IQDT4iJIvE6b25lvadJ0Bb7id7uIyMCRHxIp96H+5qA5
	+iPco5OgW1KQr6ktGwYNuLu+YiiidAOIaqDc2AhcVHOWPx9LjU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=AHfS/RTo39wD96SDEK6
	fvljEpPYbrmnhJjihcf9eYiCQM+OaCR9zIdVjM9uH8RW5jVe3KN4Vm41VAu/Qot+
	3MCxMfblIZb5myuqaTPXTI+gpj+yIrvXIPlsP3d/A1oCfCDi2BcioV0LK6oxnFiv
	R3aIVlYrIaPXI6IDv83SYzCc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D01407563;
	Tue,  3 Jan 2012 19:24:22 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 335857562; Tue,  3 Jan 2012
 19:24:22 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7308A650-366A-11E1-A2DE-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187910>

These are only notable new bits.  I'll send out the real report probabl=
y
tomorrow or the day after.

--------------------------------------------------
[New Topics]

* ss/git-svn-prompt-sans-terminal (2012-01-03) 2 commits
 - git-svn, perl/Git.pm: extend Git::prompt helper for querying users
 - perl/Git.pm: "prompt" helper to honor GIT_ASKPASS and SSH_ASKPASS

The bottom one has been replaced with a rewrite based on comments from
=C3=86var, and the top one was adjusted to it. Peff's suggestion to giv=
e
precedence to tty over SSH_ASKPASS when terminal is available may make
sense for the second one, so we may want to fix the second one further
once 1.7.9 is out. I think the bottom one is OK for 1.7.9.

Will merge the bottom one to 'next' soonish.

* pw/p4-view-updates (2012-01-03) 6 commits
  (merged to 'next' on 2012-01-03 at c3b5872)
 + git-p4: view spec documentation
 + git-p4: rewrite view handling
 + git-p4: support single file p4 client view maps
 + git-p4: sort client views by reverse View number
 + git-p4: fix test for unsupported P4 Client Views
 + git-p4: test client view handling

Will merge to 'master' by 1.7.9 unless real git-p4 users object (I am n=
ot
one of them, so I cannot really judge).

--------------------------------------------------
[Graduated to "master"]

* jv/maint-config-set (2011-12-27) 1 commit
  (merged to 'next' on 2011-12-27 at 551ac8f)
 + Fix an incorrect reference to --set-all.

* pw/p4-docs-and-tests (2011-12-27) 11 commits
  (merged to 'next' on 2011-12-28 at 8acf26e)
 + git-p4: document and test submit options
 + git-p4: test and document --use-client-spec
 + git-p4: test --keep-path
 + git-p4: test --max-changes
 + git-p4: document and test --import-local
 + git-p4: honor --changesfile option and test
 + git-p4: document and test clone --branch
 + git-p4: test cloning with two dirs, clarify doc
 + git-p4: clone does not use --git-dir
 + git-p4: introduce asciidoc documentation
 + rename git-p4 tests

--------------------------------------------------
[Cooking]

* jh/fetch-head-update (2012-01-03) 1 commit
 - write first for-merge ref to FETCH_HEAD first

Will merge to 'next'.

* jc/signed-commit (2011-11-29) 5 commits
  (merged to 'next' on 2011-12-21 at 8fcbf00)
 + gpg-interface: allow use of a custom GPG binary
 + pretty: %G[?GS] placeholders
 + test "commit -S" and "log --show-signature"
 + log: --show-signature
 + commit: teach --gpg-sign option

I am ambivalent on this one. I do not desperately need it myself, I kno=
w
the kernel folks do not, I heard some other people might.

We should to do something similar to what we do for the embedded "gpgsi=
g"
header in this series to the embedded "mergetag" header that is used to
record a merge of a signed tag when the "--show-signature" option and/o=
r
"%G[?GS]" pretty placeholders are used, so it may make sense to merge t=
his
and build such feature on top of it before 1.7.9 ships.

Opinions?

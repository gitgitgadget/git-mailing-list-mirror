From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git 1.6.5.8
Date: Wed, 20 Jan 2010 16:50:17 -0800
Message-ID: <7v3a20z3g6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 21 01:50:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXlFl-0005X8-8B
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jan 2010 01:50:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752194Ab0AUAuZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2010 19:50:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751431Ab0AUAuZ
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jan 2010 19:50:25 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:57768 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751082Ab0AUAuY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2010 19:50:24 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id ACB6092CDE;
	Wed, 20 Jan 2010 19:50:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=8j2G
	svKafhkGOlFKz0Y+Kn3dooc=; b=raA/gLclLlSfi5L3blnK+cFv9bsm9+mgLqx4
	kLvC7Kpf6J3W3FxPPRkkoN/xZba1j8BK7pXQdgfyQaMM+qfQ2ItHGqTdtmBG70Du
	J5/x/BUeOSNxunVMntZM2qEM9Z6s5YRmCI1hPuvEkj35evHGNzdGl9SXFZzq84IP
	7n6r+bU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=bhC
	S5ut43r1dq/L3aJ0iS8ZHbke+HmGvvS/T1SgfP8+xvTL89RznTFVMeXTRFvCTkq+
	e7NulrFfKE4agEii+ebVmlHWdx6BjuKuWPCHzfXSvDDcQgkuPhzPI132oYip7P0K
	ToS6Y+Y6X+A/uJR45xTQBAT0HvA7fS6r2mlW15mc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9792092CDD;
	Wed, 20 Jan 2010 19:50:20 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F3FCB92CD8; Wed, 20 Jan
 2010 19:50:18 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F35CFDD6-0626-11DF-8FA4-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137604>

An maintenance release Git 1.6.5.8 is available at the usual places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.6.5.8.tar.{gz,bz2}			(source tarball)
  git-htmldocs-1.6.5.8.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.6.5.8.tar.{gz,bz2}		(preformatted docs)

The RPM binary packages for a few architectures are found in:

  RPMS/$arch/git-*-1.6.5.8-1.fc11.$arch.rpm	(RPM)

Git v1.6.5.8 Release Notes
==========================

Fixes since v1.6.5.7
--------------------

* "git count-objects" did not handle packfiles that are bigger than 4G on
  platforms with 32-bit off_t.

* "git rebase -i" did not abort cleanly if it failed to launch the editor.

* "git blame" did not work well when commit lacked the author name.

* "git fast-import" choked when handling a tag that points at an object
  that is not a commit.

* "git reset --hard" did not work correctly when GIT_WORK_TREE environment
  variable is used to point at the root of the true work tree.

* "git grep" fed a buffer that is not NUL-terminated to underlying
  regexec().

* "git checkout -m other" while on a branch that does not have any commit
  segfaulted, instead of failing.

* "git branch -a other" should have diagnosed the command as an error.

Other minor documentation updates are also included.

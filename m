From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git 1.7.1.rc1
Date: Sat, 10 Apr 2010 21:13:56 -0700
Message-ID: <7vmxxar5h7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 11 06:14:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0oZH-0005Ge-6X
	for gcvg-git-2@lo.gmane.org; Sun, 11 Apr 2010 06:14:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750770Ab0DKEOJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Apr 2010 00:14:09 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:33430 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750709Ab0DKEOG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Apr 2010 00:14:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C7AE0A93D5;
	Sun, 11 Apr 2010 00:14:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=n07C
	f3VuTo97g3PGGR9p37Fc1BQ=; b=c6TupZfQ0ftG849Z4x5fhwCT09Aol876hQdh
	MlhpY7yJT2ArP3fhNZ0Yxn8tfq5Xj9z9PWv4eAvKFZntKLw/8Yv35OdauArKzg10
	//rYm2qWClkWm7jF9qsw8R5tjNiewAYROaKskZBcK5Uw8MfuF9x0QQiGM6kxfSc6
	VnvowC4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=mLp
	H3XwgR4yR0+bOL8UWdo/JAl2mXF+bGAviOefBW3pvIYOFNGw9vxe5Aw8+PEoxzia
	s8tLftA9XyE9q8CwtJsEWrR302EedN3uiAmbpzKqjPyZSyMYpyU4dNXh7OA7CEsa
	YbA6NHRYCZQmDhMjShI3JjD0RTYmj2ChPJ6J5roc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 92584A9396;
	Sun, 11 Apr 2010 00:14:01 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BF7A3A9395; Sun, 11 Apr
 2010 00:13:57 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A8AE1FA2-4520-11DF-92B7-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144629>

A release candidate Git 1.7.1.rc1 is available at the usual places
for testing:

  http://www.kernel.org/pub/software/scm/git/

  git-1.7.1.rc1.tar.{gz,bz2}			(source tarball)
  git-htmldocs-1.7.1.rc1.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.7.1.rc1.tar.{gz,bz2}		(preformatted docs)

The RPM binary packages for a few architectures are found in:

  testing/git-*-1.7.1.rc1-1.fc11.$arch.rpm	(RPM)

Please test 'master', report & fix regressions.  Hopefully we can do
another rc during the next week and release the final one next weekend.

----------------------------------------------------------------

Changes since v1.7.1-rc0 are as follows:

Brandon Casey (1):
      notes.h: declare bit field as unsigned to silence compiler complaints

Jeff King (4):
      fix const-correctness of write_sha1_file
      fix textconv leak in emit_rewrite_diff
      fix typos and grammar in 1.7.1 draft release notes
      docs: clarify "branch -l"

Jens Lehmann (2):
      Let check_preimage() use memset() to initialize "struct checkout"
      Teach diff --submodule and status to handle .git files in submodules

Jonathan Nieder (1):
      Teach mailinfo %< as an alternative scissors mark

Junio C Hamano (2):
      diff.c: work around pointer constness warnings
      Git 1.7.1-rc1

Mark Rada (6):
      Gitweb: add ignore and clean rules for minified files
      Gitweb: add support for minifying gitweb.css
      Gitweb: add autoconfigure support for minifiers
      instaweb: add minification awareness
      gitweb: add documentation to INSTALL regarding gitweb.js
      gitweb: update INSTALL to use shorter make target

Michael J Gruber (2):
      t3301-notes: Test the creation of reflog entries
      refs.c: Write reflogs for notes just like for branch heads

Tay Ray Chuan (2):
      branch: say "Reset to" in reflog entries for 'git branch -f' operations
      fetch/push: fix usage strings

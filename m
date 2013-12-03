From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git v1.8.4.5
Date: Tue, 03 Dec 2013 13:48:11 -0800
Message-ID: <xmqq38m9mwlr.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 03 22:52:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VnxtG-0006T8-Hz
	for gcvg-git-2@plane.gmane.org; Tue, 03 Dec 2013 22:52:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755228Ab3LCVwD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Dec 2013 16:52:03 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33945 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755041Ab3LCVvt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Dec 2013 16:51:49 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 77B7C56E9B;
	Tue,  3 Dec 2013 16:51:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=K
	eyyT2g0dHuKl755Ehnydr0H5Qk=; b=HVWnuDG3JcKu31d7VwL8NA+IvLz29v2Kh
	7t9P6PwdMw85MW+8I/MjyXY8zOxldQHAtj+39qH3H8Fxe5KR0kYwNxmewMX3J+K8
	av4k8XQTKviE3RjTjxwce19vy5EIt7kBOm7tN7G9aTUVK6JNFMcwA0nTCEmCR4CB
	DqnPZw59Rw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; q=dns; s=
	sasl; b=t9Q3CKJWFIcEXHYvzn1SLmbZODQHwiRJQK1zjfxaGYEYPDob+3qsjxa7
	+urJJZBYBmPzYS65FOHyVfrK8jtPoxDMyqAta0m5acJOJL9pTjveGSj0ucz4mn0v
	omAPtfCv+46g2SO23VyhNmrZDcPFQV1Jd1J9ZLJljPW835ayl7A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 765E656E98;
	Tue,  3 Dec 2013 16:51:47 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3505456E8F;
	Tue,  3 Dec 2013 16:51:46 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 1ACEE06C-5C65-11E3-9BFA-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238741>

A maintenance release Git v1.8.4.5 is now available at the
usual places.

The release tarballs are found at:

    http://code.google.com/p/git-core/downloads/list

and their SHA-1 checksums are:

b43c0cc46749ad62b8ac74237ceca00c8e386edb  git-1.8.4.5.tar.gz
bd66db8c9528e53d2b93e88ef8e96164e597333f  git-htmldocs-1.8.4.5.tar.gz
1ff6380e60c879a563ef89452ca461e9610e41c0  git-manpages-1.8.4.5.tar.gz

The following public repositories all have a copy of the v1.8.4.5
tag and the maint-1.8.4 branch that the tag points at:

  url = https://kernel.googlesource.com/pub/scm/git/git
  url = git://repo.or.cz/alt-git.git
  url = https://code.google.com/p/git-core/
  url = git://git.sourceforge.jp/gitroot/git-core/git.git
  url = git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url = https://github.com/gitster/git

Also, http://www.kernel.org/pub/software/scm/git/ has copies of the
release tarballs.

Git v1.8.4.5 Release Notes
==========================

Fixes since v1.8.4.4
--------------------

 * Recent update to remote-hg that attempted to make it work better
   with non ASCII pathnames fed Unicode strings to the underlying Hg
   API, which was wrong.

 * "git submodule init" copied "submodule.$name.update" settings from
   .gitmodules to .git/config without making sure if the suggested
   value was sensible.

----------------------------------------------------------------

Changes since v1.8.4.4 are as follows:

Junio C Hamano (2):
      submodule: do not copy unknown update mode from .gitmodules
      Git 1.8.4.5

Richard Hansen (1):
      remote-hg: don't decode UTF-8 paths into Unicode objects

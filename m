From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git v1.8.4.4
Date: Wed, 20 Nov 2013 14:06:48 -0800
Message-ID: <xmqqd2lu7mo7.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 20 23:07:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VjFvp-000367-Eg
	for gcvg-git-2@plane.gmane.org; Wed, 20 Nov 2013 23:07:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755170Ab3KTWGx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Nov 2013 17:06:53 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51145 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754858Ab3KTWGw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Nov 2013 17:06:52 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 71A9F5495C;
	Wed, 20 Nov 2013 17:06:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=S
	vgfZmfOBI1ADkh/SSpTj9Jw9fI=; b=XTnrh0PQteWv+WK8osMxKbr9ZYQV8zwfb
	PyhcleDpbkBbCBsRv36pT1JzxptRqxcDRJ6m60SuVH0spk4QICqDeX+tknmbm9he
	6b4/1ChW+cUM1r9Olv8A/66d/bevE3gt9zGq28RlDjH7n1J6jUYeEXNziz3wb6dq
	sBOkfjobRk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; q=dns; s=
	sasl; b=aBYP6GZpWGrC79YFZ42H0AqiuKfnEohV3lFCn/H7ZGitELr5fR4OYhRI
	Op3SC1CZQmQugTuT60UdzZE4URGNS5aKjjQG3SiHoMlFPCKyqWhA3E04qRpHgydW
	TZm65WxgTsJ1MyF4EOlmXgSwbMyVK+dtGI91av5pzsWHKwSsYJA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5F6BE5495B;
	Wed, 20 Nov 2013 17:06:51 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A983E5495A;
	Wed, 20 Nov 2013 17:06:50 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 0E892A36-5230-11E3-BE74-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238098>

The latest maintenance release Git v1.8.4.4 is now available at
the usual places.

The release tarballs are found at:

    http://code.google.com/p/git-core/downloads/list

and their SHA-1 checksums are:

1aaa1a51b599f19125e06fa6e839c9ff2e5ac941  git-1.8.4.4.tar.gz
c2ee47c2bbf8ede70eef2a1ba936a30aa0d78b2a  git-htmldocs-1.8.4.4.tar.gz
4637e22fd2fe59cf00b4a105f5104af9bfea8c2c  git-manpages-1.8.4.4.tar.gz

The following public repositories all have a copy of the v1.8.4.4
tag and the maint branch that the tag points at:

  url = https://kernel.googlesource.com/pub/scm/git/git
  url = git://repo.or.cz/alt-git.git
  url = https://code.google.com/p/git-core/
  url = git://git.sourceforge.jp/gitroot/git-core/git.git
  url = git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url = https://github.com/gitster/git

Also, http://www.kernel.org/pub/software/scm/git/ has copies of the
release tarballs.

Git v1.8.4.4 Release Notes
========================

Fixes since v1.8.4.3
--------------------

 * The fix in v1.8.4.3 to the pack transfer protocol to propagate
   the target of symbolic refs broke "git clone/git fetch" from a
   repository with too many symbolic refs. As a hotfix/workaround,
   we transfer only the information on HEAD.

----------------------------------------------------------------

Changes since v1.8.4.3 are as follows:

Junio C Hamano (2):
      Revert "upload-pack: send non-HEAD symbolic refs"
      Git 1.8.4.4

From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git 1.6.5.7
Date: Wed, 16 Dec 2009 16:29:14 -0800
Message-ID: <7vfx7aqw85.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 17 01:29:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NL4FN-00027w-3u
	for gcvg-git-2@lo.gmane.org; Thu, 17 Dec 2009 01:29:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763432AbZLQA3a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Dec 2009 19:29:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762883AbZLQA33
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Dec 2009 19:29:29 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:39058 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762939AbZLQA32 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Dec 2009 19:29:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B4F33A7834;
	Wed, 16 Dec 2009 19:29:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=vyIP
	DAhPG3vHhU5PQTlkvyN61hI=; b=WSRDJpq5BuN9BKA/Tk+zWQM/DUNXngaYY8KT
	EDSD8Wofcib7KZKObqnpPmpDnE72ww9GWzrAfrx7oF+0hv4bksFBdYPnElXR9RNC
	Wm5ZToHsmtkpsvVJnIpqjzZevkDUHm11cK6nsPLUqAMsXic79brritqS5J6dwrTq
	+kRLqlI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=Qdk
	wOv5yxD/2OuQh51rQneGIUZkHRQuvMhCDlGRh1xhQYAxePScDbZzjh4ai8UH7zAQ
	uN+ty130BUdxh6ZB007IvvCfzpjq2BkrOx/rlhlEqXZ2zRluhP1QOISs7ExKmw8y
	0aH/V4hBGr1J3XL9lpUL4uoPs8uR2D+BAmLGT+r0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 75BA6A782D;
	Wed, 16 Dec 2009 19:29:21 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id F3417A782B; Wed, 16 Dec 2009
 19:29:15 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3861B1D2-EAA3-11DE-8554-B34DBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135350>

The latest maintenance release Git 1.6.5.7 is available at the
usual places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.6.5.7.tar.{gz,bz2}			(source tarball)
  git-htmldocs-1.6.5.7.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.6.5.7.tar.{gz,bz2}		(preformatted docs)

The RPM binary packages for a few architectures are found in:

  RPMS/$arch/git-*-1.6.5.7-1.fc11.$arch.rpm	(RPM)

Nothing spectacular to see here, but as I was tagging 1.6.6-rc3 today, I
wanted to push out fixes accumulated on the maintenance branch in a tagged
release.  Everything in this release is also in 1.6.6-rc3.

----------------------------------------------------------------

Changes since v1.6.5.6 are as follows:

Jeff King (1):
      ignore unknown color configuration

Johannes Sixt (1):
      help.autocorrect: do not run a command if the command given is junk

Junio C Hamano (2):
      worktree: don't segfault with an absolute pathspec without a work tree
      Git 1.6.5.7

Nanako Shiraishi (1):
      Illustrate "filter" attribute with an example

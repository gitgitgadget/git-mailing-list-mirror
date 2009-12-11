From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git 1.6.5.6
Date: Thu, 10 Dec 2009 22:09:12 -0800
Message-ID: <7vljha59fb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 11 07:09:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NIyhP-0004b4-33
	for gcvg-git-2@lo.gmane.org; Fri, 11 Dec 2009 07:09:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756864AbZLKGJV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Dec 2009 01:09:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756169AbZLKGJV
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Dec 2009 01:09:21 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:58517 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755995AbZLKGJU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Dec 2009 01:09:20 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 876D9A6227;
	Fri, 11 Dec 2009 01:09:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=9QX/K+y7nVPmCmevsNCVPxI08
	tQ=; b=pf447DEGtKngHEFQxZYy2zf5t/aNk6U8jvMDr/IZzKgLxi8jnZm86PIBO
	aKFVQwOy1XNC30UlMNv4thsN5wMIAlxeWB682m4LHtE3MfUB1jIEaLjbKzsuz2OU
	w05wNQ/hg2gaW6nO+LuIoMF/qikbfW4YJiLZitDuH6bXLiRsic=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=c7W6ngFHrJPKV3UNqUx
	DRtKLTOjGyhzijlGflY9CS8AZCZWQfFcYCZiLGNgV1OXguxget78vkXZQl7RVCRB
	OdUiCNi6xlyQbBKbBwrLAe3DAMvLqy6qdFW2m9HOkcguTQsQ45BnRCKUmnTgrZor
	JaaS1Y2p7Gt1l5d5YFCncskE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4967FA6223;
	Fri, 11 Dec 2009 01:09:20 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9A24CA6221; Fri, 11 Dec 2009
 01:09:14 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B88F0544-E61B-11DE-8D99-B34DBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135072>

The latest maintenance release Git 1.6.5.6 is available at the
usual places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.6.5.6.tar.{gz,bz2}			(source tarball)
  git-htmldocs-1.6.5.6.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.6.5.6.tar.{gz,bz2}		(preformatted docs)

The RPM binary packages for a few architectures are found in:

  RPMS/$arch/git-*-1.6.5.6-1.fc11.$arch.rpm	(RPM)

Hopefully this will be the last update to the 1.6.5.X series before the
upcoming feature release (1.6.6).  It fixes a security issue, and users=
 of
older 1.6.5.X series are strongly recommended to update to this version=
=2E

Git v1.6.5.6 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D

=46ixes since v1.6.5.5
--------------------

 * "git add -p" had a regression since v1.6.5.3 that broke deletion of
   non-empty files.

 * "git archive -o o.zip -- Makefile" produced an archive in o.zip
   but in POSIX tar format.

 * Error message given to "git pull --rebase" when the user didn't give
   enough clue as to what branch to integrate with still talked about
   "merging with" the branch.

 * Error messages given by "git merge" when the merge resulted in a
   fast-forward still were in plumbing lingo, even though in v1.6.5
   we reworded messages in other cases.

 * The post-upload-hook run by upload-pack in response to "git fetch" h=
as
   been removed, due to security concerns (the hook first appeared in
   1.6.5).

----------------------------------------------------------------

Changes since v1.6.5.5 are as follows:

Jan Kr=C3=BCger (1):
      pull: clarify advice for the unconfigured error case

Jeff King (1):
      add-interactive: fix deletion of non-empty files

Junio C Hamano (3):
      Remove post-upload-hook
      Fix archive format with -- on the command line
      Git 1.6.5.6

Matthieu Moy (2):
      merge-recursive: make the error-message generation an extern func=
tion
      builtin-merge: show user-friendly error messages for fast-forward=
 too.

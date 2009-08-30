From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] GIT 1.6.4.2
Date: Sat, 29 Aug 2009 23:30:25 -0700
Message-ID: <7v1vmtreym.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 30 08:31:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MhdwJ-0000lP-SQ
	for gcvg-git-2@lo.gmane.org; Sun, 30 Aug 2009 08:31:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751885AbZH3Gaj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Aug 2009 02:30:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751827AbZH3Gaj
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Aug 2009 02:30:39 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:58564 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751808AbZH3Gai (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Aug 2009 02:30:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id ADEC53CCCE;
	Sun, 30 Aug 2009 02:30:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=hdfR
	o0kVHeMLrceZcGNapMgJYP8=; b=SMDEML9gV8urBypsIMBsZYpNki3akbD5QpVw
	mGU/Y+RVcAwOsDHQBoBAbjWLa/kgJM7FgDW76/pIgyukCJzmC2uwza37Yt7rDIBb
	A5bVFFpGS+UZI2vwHJZZyAv9PBbvUrem5SOPNAPh2o0ZE2xl0HcKRr3Ou7oXtjXa
	UZQS7m8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=DyN
	qnI3m4uw8J/mDIwyE1XYFsEo+xVbSEMNmvoEc1pl/BvcJH2SGQJ78XsuPS8mB5je
	OEY9BQNztixQYNGMr3vEQY09oViz68tRI+miMEmRDVRM7DCUQiAydDVTQXJAeRW+
	3OXniX+aj1ztkom5E++3vd/6xhZZaFyrgUlpZssc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7741C3CCCD;
	Sun, 30 Aug 2009 02:30:35 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B4E503CCCC; Sun, 30 Aug 2009
 02:30:27 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A00CEC90-952E-11DE-9CFA-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127394>

The latest maintenance release GIT 1.6.4.2 is available at the
usual places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.6.4.2.tar.{gz,bz2}			(source tarball)
  git-htmldocs-1.6.4.2.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.6.4.2.tar.{gz,bz2}		(preformatted docs)

The RPM binary packages for a few architectures are found in:

  RPMS/$arch/git-*-1.6.4.2-1.fc9.$arch.rpm	(RPM)

GIT v1.6.4.2 Release Notes
==========================

Fixes since v1.6.4.1
--------------------

* --date=relative output between 1 and 5 years ago rounded the number of
    years when saying X years Y months ago, instead of rounding it down.

* "git add -p" did not handle changes in executable bits correctly
  (a regression around 1.6.3).

* "git apply" did not honor GNU diff's convention to mark the creation/deletion
  event with UNIX epoch timestamp on missing side.

* "git checkout" incorrectly removed files in a directory pointed by a
  symbolic link during a branch switch that replaces a directory with
  a symbolic link.

* "git clean -d -f" happily descended into a subdirectory that is managed by a
  separate git repository.  It now requires two -f options for safety.

* "git fetch/push" over http transports had two rather grave bugs.

* "git format-patch --cover-letter" did not prepare the cover letter file
  for use with non-ASCII strings when there are the series contributors with
  non-ASCII names.

* "git pull origin branch" and "git fetch origin && git merge origin/branch"
  left different merge messages in the resulting commit.

Other minor documentation updates are included.

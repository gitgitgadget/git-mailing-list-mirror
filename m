From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git 1.7.3.1
Date: Wed, 29 Sep 2010 17:13:57 -0700
Message-ID: <7vtyl8krzu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 30 02:14:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P16mz-0004gB-TD
	for gcvg-git-2@lo.gmane.org; Thu, 30 Sep 2010 02:14:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751707Ab0I3AOK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Sep 2010 20:14:10 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:41426 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751023Ab0I3AOI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Sep 2010 20:14:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5068CDAA85;
	Wed, 29 Sep 2010 20:14:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=zlEi
	8pIsVufKMFG+iveESvXMZs4=; b=rIfR9Yn6pCF4k++ZhX2w4jVpjk3+Hh0vRegj
	iykOb36WYmC1phv/rT97mmyP6EvXTvYXzG2eI+HWQ7sSSGV6OlfYoRHWyt9QPLEE
	QElq+o85UNv3qlsevV1mOSF1b56+bDfK/BhlDfg746LQYeOKpu1NWFKHq9ZEwCRj
	FxTzNqk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=FkO
	0saHVZVP/xY4FAC9YpxHLHJ5rELm16R8ehs2A9q/jPujdpB5Yd812LpNzyGpzitP
	K0PYLUSsojSYk08VvG+nBfy5yqkVl7ftOl91v288/FMWFiVo9cGqgCoXmkyzj9Gr
	ASrg28UtyTFNLsZ1U6FmyhSHyBhdgbjyLHPLpmPA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1D68EDAA83;
	Wed, 29 Sep 2010 20:14:03 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2D0CEDAA7E; Wed, 29 Sep
 2010 20:13:59 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A191A3B8-CC27-11DF-9126-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157623>

The first maintenance release of Git 1.7.3.X series, 1.7.3.1, is
available at the usual places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.7.3.1.tar.{gz,bz2}			(source tarball)
  git-htmldocs-1.7.3.1.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.7.3.1.tar.{gz,bz2}		(preformatted docs)

The RPM binary packages for a few architectures are found in:

  RPMS/$arch/git-*-1.7.3.1-1.fc11.$arch.rpm	(RPM)

Git v1.7.3.1 Release Notes
==========================

Fixes since v1.7.3
------------------

 * "git stash show stash@{$n}" was accidentally broken in 1.7.3 ("git
   stash show" without any argument still worked, though).

 * "git stash branch $branch stash@{$n}" was accidentally broken in
   1.7.3 and started dropping the named stash even when branch creation
   failed.

And other minor fixes and documentation updates.

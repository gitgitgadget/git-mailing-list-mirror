From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git 1.7.0.3
Date: Sun, 21 Mar 2010 19:00:59 -0700
Message-ID: <7vr5nd2jz8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 22 03:01:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtWxT-0003fQ-7v
	for gcvg-git-2@lo.gmane.org; Mon, 22 Mar 2010 03:01:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753782Ab0CVCBN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Mar 2010 22:01:13 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:40980 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753716Ab0CVCBM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Mar 2010 22:01:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EA498A4EE2;
	Sun, 21 Mar 2010 22:01:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=XLkE
	CQepshgFaDZmu8fY3DRm+8k=; b=a1mPZRweQTVCnN5et56D6tqkHAYTM53cJyIL
	LK1JOqKPbGwqWyYPH6RTdNkBw+1Gji/NTIXCvvuifw0+6jd/vZO3d836e7f1YH0V
	68VwWbRJdCjC3CZwONprWSNiOcLvI14FD/KsVAJTBhdvn+JQRWBRM3nOcne//Dzd
	3v6KudY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=x4K
	YpEl3ddY+znSkgKWnxsm8KMWsNbi6fR9RaCBs0XrtjTQFs7opw6h80ZmjdxbnJYt
	smg+gESK+58l/dWRX+xuNlEKz5I2oiQKSNTE0PoBeuZqP5Hk03jquDjEFg/1RkPG
	46py7iYyfa4fdh6qTrDcTUhmm74U4Kmv27KYWt4o=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id F1832A4EDE;
	Sun, 21 Mar 2010 22:01:05 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 29BC0A4EDD; Sun, 21 Mar
 2010 22:01:01 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C69634D4-3556-11DF-AFAF-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142883>

The latest maintenance release Git 1.7.0.3 is available at the
usual places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.7.0.3.tar.{gz,bz2}			(source tarball)
  git-htmldocs-1.7.0.3.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.7.0.3.tar.{gz,bz2}		(preformatted docs)

The RPM binary packages for a few architectures are found in:

  RPMS/$arch/git-*-1.7.0.3-1.fc11.$arch.rpm	(RPM)

Git v1.7.0.3 Release Notes
==========================

Fixes since v1.7.0.2
--------------------

 * Object files are created in a more ACL friendly way in repositories
   where group permission is ACL controlled.

 * "git add -i" didn't handle a deleted path very well.

 * "git blame" padded line numbers with one extra SP when the total number
   of lines was one less than multiple of ten due to an off-by-one error.

 * "git fetch --all/--multi" used to discard information for remotes that
   are fetched earlier.

 * "git log --author=me --grep=it" tried to find commits that have "it"
   or are written by "me", instead of the ones that have "it" _and_ are
   written by "me".

 * "git log -g branch" misbehaved when there was no entries in the reflog
   for the named branch.

 * "git mailinfo" (hence "git am") incorrectly removed initial indent from
   paragraphs.

 * "git prune" and "git reflog" (hence "git gc" as well) didn't honor
   an instruction never to expire by setting gc.reflogexpire to never.

 * "git push" misbehaved when branch.<name>.merge was configured without
   matching branch.<name>.remote.

And other minor fixes and documentation updates.

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git cvsimport: new tags not imported on second cvsimport
Date: Sat, 04 Aug 2012 15:09:29 -0700
Message-ID: <7v7gte9una.fsf@alter.siamese.dyndns.org>
References: <1123570348.20120804133108@gmail.com>
 <m2lihvt2gi.fsf@linux-m68k.org> <9510482012.20120804170149@gmail.com>
 <m2pq76vecd.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ilya Basin <basinilya@gmail.com>, git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Sun Aug 05 00:10:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SxmXz-0007mJ-4E
	for gcvg-git-2@plane.gmane.org; Sun, 05 Aug 2012 00:10:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753901Ab2HDWJd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Aug 2012 18:09:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47037 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753833Ab2HDWJc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2012 18:09:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C2FD888CB;
	Sat,  4 Aug 2012 18:09:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vQCIvZcxy3iF/xw3gtrEaHPuvdc=; b=Sjrc0V
	cPwAk66E4OU7N9L/3/JXcL6x8juP+JJcA1CEFdUrd4W9jidQFSnUoqqcDYCXqyad
	DR2oHzWpn7J+aOzkpuOaBfYHbJx47HEbG3REGJfHlqTH2/+JtH1gWhnL0T1Q4czF
	+Yb9a3dG+CW1q6Swd7sMpHYfv8nPZvYai/FzU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=r7YjvBDnQWt4OORd+Lamw2jCwcDpvq7P
	GsrVQ3K1ekVBLUc97LyyHeaK3YOvD1XAZA4tS/trmxT5pgJLmxfKVihhjllyehbY
	+542wX3tKEb2/uFW0DU2aMiitBCU8pl3Zy9aMwFiniI3T0WDxIfYzl90/qmIWByu
	AzfrzvMO/r8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B100088CA;
	Sat,  4 Aug 2012 18:09:31 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2873F88C8; Sat,  4 Aug 2012
 18:09:31 -0400 (EDT)
In-Reply-To: <m2pq76vecd.fsf@igel.home> (Andreas Schwab's message of "Sat, 04
 Aug 2012 17:58:26 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 10CB653A-DE81-11E1-BC69-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202893>

Andreas Schwab <schwab@linux-m68k.org> writes:

> Reset the branch back to before the import.

Does the resulting history created by cvsimport after resetting a
branch back to an older point exactly match the history before
resetting (obviously modulo the tag that has been added since the
original import)?

I recall that cvsimport tried hard to be reproducible and it should
work, but I haven't run cvsimport myself for a long time, so...

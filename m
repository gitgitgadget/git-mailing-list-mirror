From: Junio C Hamano <gitster@pobox.com>
Subject: A possible fmt-merge-msg update?
Date: Sun, 04 Mar 2012 19:17:40 -0800
Message-ID: <7vvcmj68iz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Mar 05 04:18:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4OQv-0007hM-Md
	for gcvg-git-2@plane.gmane.org; Mon, 05 Mar 2012 04:17:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755233Ab2CEDRo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Mar 2012 22:17:44 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60687 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755004Ab2CEDRn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Mar 2012 22:17:43 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6199E689A;
	Sun,  4 Mar 2012 22:17:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=7
	Oh3Mz+tXx1wQKJDuBUVBZMOgTQ=; b=kK/XKQPA91J0yIUZ9+FNEmzjnI0UTWkNO
	AIhI4bWPNvc2y3LjKqhSBEtapzgnDinviWF7c9dQ0aJLgI5h1vH4eof8XChOOxsb
	VUm/yF1z3n2bMF3y5zQvCzDtJwOR3K4UQPOx6NWJhoUmUAY5D2qLQmrDdMM+HESD
	AbrhMEOdmc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; q=dns; s=
	sasl; b=KOaGZXU25t1yZCVVmF1Zj/H4pIaLce3aZFxo+E4bz8Q+4+s8gKgJ0sD0
	dLYEWRfxwlq54rhzb/LnGdWWjZPvCRrIzUuPm7UwNM0QDJQ6wVH/9/QdNlMKj4yW
	p393KEgcYH+5vFFlL98sfd+fIve3NcH7MR1ItVPljI/cvFeyMR4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 52CF16899;
	Sun,  4 Mar 2012 22:17:42 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C54B66898; Sun,  4 Mar 2012
 22:17:41 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C4E02ADE-6671-11E1-B103-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192191>

Subject: Re: Merge git://www.linux-watchdog.org/linux-watchdog
From: Junio C Hamano <junio@pobox.com>
Bcc: junio@pobox.com
--text follows this line--
Linus Torvalds <torvalds@linux-foundation.org> writes:

> Watchdog updates from Wim Van Sebroeck:
>
> * git://www.linux-watchdog.org/linux-watchdog:
>   watchdog: fix GETTIMEOUT ioctl in booke_wdt
>   watchdog: update maintainers git entry
>   watchdog: Fix typo in pnx4008_wdt.c
>   watchdog: Fix typo in Kconfig
>   watchdog: fix error in probe() of s3c2410_wdt (reset at booting)
>   watchdog: hpwdt: clean up set_memory_x call for 32 bit

Having observed a handful of your recent merge messages, I am wondering if
it would help to teach fmt-merge-msg to include "from Wim Van Sebroeck" in
its output by taking the committer of the MERGE_HEAD into account.

Not worth the trouble?

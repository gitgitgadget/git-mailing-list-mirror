From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 02/12] grep docs: grep accepts a <tree-ish>, not a
 <tree>
Date: Sat, 13 Mar 2010 13:59:01 -0800
Message-ID: <7v1vfn7uje.fsf@alter.siamese.dyndns.org>
References: <1268455984-19061-1-git-send-email-lodatom@gmail.com>
 <1268455984-19061-3-git-send-email-lodatom@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mark Lodato <lodatom@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 13 22:59:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NqZMc-00038W-R0
	for gcvg-git-2@lo.gmane.org; Sat, 13 Mar 2010 22:59:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756384Ab0CMV7M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Mar 2010 16:59:12 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:53078 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753718Ab0CMV7H (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Mar 2010 16:59:07 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 53619A1265;
	Sat, 13 Mar 2010 16:59:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QN1s6u+85J7ljlddQl5kDIcF+NQ=; b=jkzVmp
	IW8QXCpK4uFzUlyHH9Cr0ZgPvJtA/WQLQhB2cafv4fRVydlmoCaDXOq+ABeDR8K7
	d+izSJFxpFQ7Vy3Xv/+a0G1GTzHiAtd0gnnQv0LG4Ihte5VI7o8dXXxrecYrM6nj
	j39RvbQNxpMiGcb0FDvEgLupHBhm9iMpqLUWY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BubsSsTtC2+cR0Apl0XhZRinb4dHlPeV
	O9lucoS0JRudP/BFKX6t8GTKw41ESTIjFAascvSm0uIAo2wIvrB3PDG2+qO75euQ
	/gxYKDyvgTC5j0KRkpsU7YlwjsmvtMzuVjM+XgRTax1Oq4GQi9fU2OrqFsLOGBzE
	Ub+x1XpcnNo=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2FC9FA1264;
	Sat, 13 Mar 2010 16:59:05 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A02F4A1263; Sat, 13 Mar
 2010 16:59:02 -0500 (EST)
In-Reply-To: <1268455984-19061-3-git-send-email-lodatom@gmail.com> (Mark
 Lodato's message of "Fri\, 12 Mar 2010 23\:52\:54 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A436503E-2EEB-11DF-9122-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142112>

Mark Lodato <lodatom@gmail.com> writes:

>  Documentation/git-grep.txt |    4 ++--
>  builtin/commit-tree.c      |    2 +-

Yuck; plonk, try again.

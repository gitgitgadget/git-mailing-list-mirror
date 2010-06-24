From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] t4027,4041: Use test -s to test for an empty file
Date: Thu, 24 Jun 2010 13:55:52 -0700
Message-ID: <7vr5jwb15z.fsf@alter.siamese.dyndns.org>
References: <201006242134.54081.j6t@kdbg.org>
 <1277410231-12326-1-git-send-email-brian@gernhardtsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Jens Lehmann <Jens.Lehmann@web.de>,
	Johannes Sixt <j6t@kdbg.org>
To: Brian Gernhardt <brian@gernhardtsoftware.com>
X-From: git-owner@vger.kernel.org Thu Jun 24 22:56:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORtT1-0006TM-Nh
	for gcvg-git-2@lo.gmane.org; Thu, 24 Jun 2010 22:56:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754604Ab0FXU4G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jun 2010 16:56:06 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:32808 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753452Ab0FXU4D (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jun 2010 16:56:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7BB86BE14C;
	Thu, 24 Jun 2010 16:56:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QSHYkTQkKaRwLE3vy4Z5wYmtEW0=; b=fLZnk3
	zwIIf3xhXGFTXe608/UAkMRdDUfgJCTyZ1RBUAq1M/6G3dCl4H1FiyQYjiSSo+Us
	AOluXWetewAyQjWAFDSYUHZRWu6+zIN4o9rbolg5u1xZFzLtFdxxLV5BvymsgnU2
	tGrlXUrgSU7V2I7uaevmNjPMnjXY7dk1wPnnE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZPDCGCdmCgNkAFOY1vfbNf1vQt2Byze3
	+5x9iQdnFTVoLFgz6c5O/seuvRiMpFRjs7smT2+9G8GuSl2+rc/aEb41/R7RlUd8
	6iwVAHcRhxMAPfDON27/z1EL6RUAGgiLnDz3Scc7hThp8ajESIU57P2R3Iq2kkIS
	GZeZLQmJ3Ck=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2F490BE148;
	Thu, 24 Jun 2010 16:55:59 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4F2F1BE146; Thu, 24 Jun
 2010 16:55:54 -0400 (EDT)
In-Reply-To: <1277410231-12326-1-git-send-email-brian@gernhardtsoftware.com>
 (Brian Gernhardt's message of "Thu\, 24 Jun 2010 16\:10\:31 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E42104D6-7FD2-11DF-A860-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149649>

Thanks.  Also the leftover "test_done" should be removed and the patch
would be perfect ;-)

Will queue.  Thanks, all.

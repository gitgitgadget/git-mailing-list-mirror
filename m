From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 00/18] Extending the shelf-life of "git describe"
 output
Date: Tue, 03 Jul 2012 11:41:42 -0700
Message-ID: <7vy5n0vg9l.fsf@alter.siamese.dyndns.org>
References: <1341268449-27801-1-git-send-email-gitster@pobox.com>
 <20120703071940.GB16679@sigill.intra.peff.net>
 <7v3958wvtx.fsf@alter.siamese.dyndns.org>
 <20120703183839.GA5765@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 03 20:41:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sm82n-0001Dl-Vx
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jul 2012 20:41:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756482Ab2GCSlp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jul 2012 14:41:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56353 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756409Ab2GCSlo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2012 14:41:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 761DE9C43;
	Tue,  3 Jul 2012 14:41:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=laCo4Os+6W3jU7aXXITA01DiB4A=; b=oh7Pqu
	Wqj1vHJyMa6VR4M+LbS7TyLKUBjNUaXNXCKQQIs7f9lLQVl6GZOO9YqWO/QmWCux
	qSP1Vxe0TCxln1aIu7yB71CZ+HeIZvaq+A+q5L4G34XSZ1HKWYpaomTLXpKR5Csx
	x0gG2iq0l0hwQlgmy7Uow7yENu85JLA5Xfeug=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZEpLGCxqSrOfC3pnrdnU3NOiN2FNMauG
	9ITWY6jd2t5lJ5BtK1Hddbbzq2L/YrHudokgV+eiLbdbtAbgbyIPdbDPVeXBPZwv
	xZvsODOF/9AuQRVYhrOr8odl/q8dyGYn8l0G+Hrt3nv+fX5VJVnWKFpX3Ejvct56
	HRyUP13/TJ0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6D0F09C42;
	Tue,  3 Jul 2012 14:41:44 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E38F79C41; Tue,  3 Jul 2012
 14:41:43 -0400 (EDT)
In-Reply-To: <20120703183839.GA5765@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 3 Jul 2012 14:38:40 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BC86E1BC-C53E-11E1-957A-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200931>

Jeff King <peff@peff.net> writes:

> It looks right to me (and certainly fixes the behavior I mentioned).

OK, I have further updates on the topic; pushed out to 'pu'.

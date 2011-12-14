From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Revert "http: don't always prompt for password"
Date: Tue, 13 Dec 2011 16:33:59 -0800
Message-ID: <7v7h20t2iw.fsf@alter.siamese.dyndns.org>
References: <20111213201704.GA12072@sigill.intra.peff.net>
 <20111213202508.GA12187@sigill.intra.peff.net>
 <7vaa6wuqjt.fsf@alter.siamese.dyndns.org>
 <20111213231909.GD12432@sigill.intra.peff.net>
 <20111213232053.GE12432@sigill.intra.peff.net>
 <20111214001156.GA21940@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Naewe <stefan.naewe@gmail.com>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Eric <eric.advincula@gmail.com>, git@vger.kernel.org,
	msysgit@googlegroups.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Dec 14 01:34:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RacnR-0004VS-Bf
	for gcvg-git-2@lo.gmane.org; Wed, 14 Dec 2011 01:34:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753979Ab1LNAeE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Dec 2011 19:34:04 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50928 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753513Ab1LNAeC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Dec 2011 19:34:02 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7D9C5674B;
	Tue, 13 Dec 2011 19:34:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BWbRizEyrg7Dxl2y4pcsbV2LS8U=; b=eReVsf
	cLt/cm5iCTmzkodzIBIkTH0VXuOq+rr3LhQR6z0fmk0Iqh3SZvo7bCbIQbftV3ON
	ex8pS6MotHgM5/ZLM6ViUwyvfmfidrHspX+pM1U+Mb3BSyk3WIDxl4zYUQxv6FOh
	HccE1j3zSs5Scjfofr7cvKjTnQ7bX6M2VYpG4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jNIa2w3a/B+2T4uiljohxdHnD65SzaD0
	uQyQwZ6mH3nE0Ki/CVLEfBPwccWXxvpcSRoZpDAsYMw9gBUfT26Z3e9GtEIXX2Nf
	LW5hljRvXpG6tDV0Y31eCl2YztZ7TtYWIRxvWOvdILFQFJhiNNVD7gD52xNzJvPA
	REQ4dMng9UA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 74665674A;
	Tue, 13 Dec 2011 19:34:01 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E165B6749; Tue, 13 Dec 2011
 19:34:00 -0500 (EST)
In-Reply-To: <20111214001156.GA21940@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 13 Dec 2011 19:11:56 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 514CE3F8-25EB-11E1-BA32-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187086>

Jeff King <peff@peff.net> writes:

> ... This
> patch does a quick fix of re-enabling the "proactive auth"
> strategy only for http-push, leaving the dumb http fetch and
> smart-http as-is.

Yeah, I somehow like this better. Thanks.

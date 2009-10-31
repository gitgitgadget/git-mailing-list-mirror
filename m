From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] imap-send.c: fix compiler warnings for OpenSSL 1.0
Date: Sat, 31 Oct 2009 14:34:17 -0700
Message-ID: <7v3a4z5jty.fsf@alter.siamese.dyndns.org>
References: <1256970963-6345-1-git-send-email-vietor@vxwo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Vietor Liu <vietor@vxwo.org>
X-From: git-owner@vger.kernel.org Sat Oct 31 22:38:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N4Leb-0002NP-2z
	for gcvg-git-2@lo.gmane.org; Sat, 31 Oct 2009 22:38:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933289AbZJaVeV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Oct 2009 17:34:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933282AbZJaVeU
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Oct 2009 17:34:20 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:44117 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933273AbZJaVeU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Oct 2009 17:34:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BF4EE6E963;
	Sat, 31 Oct 2009 17:34:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=evS4fH
	P0x34CUMicrUi40KFLXmKCsOhVJb+BvNBqKwuSwywgwSbe3urfQAjOKUxJtB8ErE
	p7CqO8ziLge5ImCbNcIQBs8+tEuPn7ELr5JyIq+/OILWKs1oIAAe9uiE/ckWuQ4j
	KqPIMI0a4YQ61FSSuTY3Bzd7BrJhMiVBcmwjk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RRI4Zwuaz61LVLJQGOKO0DLn/rSCno/V
	XoBs9jmjvJs0BfMiejmLfpAgIKmsm6e0s63xtr7urxwf33zLcOi3ZzeUvVj5xMZp
	ztcV6u0oxm15+ne0/C5HJ7LamIHODmPxB2ROqX7F2zxJ4pCIZZJ2Q9s7gv9bnP1x
	9eWhHd/NtQA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9DABE6E962;
	Sat, 31 Oct 2009 17:34:22 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F37ED6E960; Sat, 31 Oct
 2009 17:34:18 -0400 (EDT)
In-Reply-To: <1256970963-6345-1-git-send-email-vietor@vxwo.org> (Vietor Liu's
 message of "Sat\, 31 Oct 2009 14\:36\:03 +0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2799F2AE-C665-11DE-997A-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131860>

Thanks.

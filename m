From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] add GIT_PATHSPEC_GLOB environment variable
Date: Wed, 19 Dec 2012 14:16:52 -0800
Message-ID: <7v38z18z6z.fsf@alter.siamese.dyndns.org>
References: <20121219203449.GA10001@sigill.intra.peff.net>
 <7vk3sd930z.fsf@alter.siamese.dyndns.org>
 <20121219210919.GA11894@sigill.intra.peff.net>
 <20121219215008.GA17908@sigill.intra.peff.net>
 <7v7god8zz0.fsf@alter.siamese.dyndns.org>
 <20121219221250.GA22823@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Dec 19 23:17:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TlRww-0004NT-4b
	for gcvg-git-2@plane.gmane.org; Wed, 19 Dec 2012 23:17:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751115Ab2LSWQ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2012 17:16:57 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49400 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750983Ab2LSWQ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2012 17:16:56 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3C6E07BCD;
	Wed, 19 Dec 2012 17:16:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bs1ErDWDQyBY1IdVZ4rLnFqpZpI=; b=hSCyUk
	MVOJSWMv48N5Aq818KgVbNdqgrmrh5KBTNq+eh3vt/jfh8Qaj6sc/3Myt85n9diO
	9x2BI5zRf+88m0CnNQsZE10sPPaVySvehUlvd07UaMRCdXYF1USySJ8CEi6s0s1d
	WWzaVUGThfOChSUci4LCk8a1gF6pdPXTQ+Hbc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ijQpmGPXbZNkBhRHdRrAHldhBNz4zMda
	aebCAL3I08xjPA1+zClFVRkDeki/mAbt3wtHV7Hkk7SgnzQ8xwi2Dr7dS5ilHtBZ
	QIEwiMEOtjpMbMi0FEPUEPdTG2blwEyaoAyJtDfHaLfXH/EZrHrZ/us5173MjOvp
	lXhe222cZv0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 29A387BCC;
	Wed, 19 Dec 2012 17:16:55 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 994B27BC8; Wed, 19 Dec 2012
 17:16:54 -0500 (EST)
In-Reply-To: <20121219221250.GA22823@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 19 Dec 2012 17:12:50 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CBB5EEF6-4A29-11E2-B7AD-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211858>

Jeff King <peff@peff.net> writes:

>> Will queue; thanks.
>
> Do we want to change the variable name and invert the logic?

That would be my preference.

I am deep into today's integration cycle, and this PATHSPEC_GLOB
version is sitting at the tip of 'pu', so today's pushout will
contain that version, though.

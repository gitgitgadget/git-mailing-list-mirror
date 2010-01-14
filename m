From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/7] Gitweb caching v4
Date: Thu, 14 Jan 2010 00:54:22 -0800
Message-ID: <7vbpgxhxs1.fsf@alter.siamese.dyndns.org>
References: <1263375282-15508-1-git-send-email-warthog9@eaglescrag.net>
 <7vmy0hhyer.fsf@alter.siamese.dyndns.org> <4B4EDA39.1020400@eaglescrag.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "J.H." <warthog9@eaglescrag.net>
X-From: git-owner@vger.kernel.org Thu Jan 14 09:54:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVLTT-00039Z-0T
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 09:54:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932143Ab0ANIyf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2010 03:54:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932120Ab0ANIyf
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jan 2010 03:54:35 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:51618 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932093Ab0ANIye (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2010 03:54:34 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 285D990C5B;
	Thu, 14 Jan 2010 03:54:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=B/+MlLI/QMXDLt50CUvBBZcl1R4=; b=akz4qX
	OVJXHLsyNdEges8L5MX+G0Fz5/sLCybK8ZTpIHtzN5lEDRUEw2Ptl2q8uQSzBpCr
	QHhfJKbbQmL8yRdT4mvaVia5aH34kL3dmMuHKrZPpoaVkb9Ybg8wBTJohLBrxgZq
	ZZ46cFNBDSfXXfLz37F3G2ulTRlqjUoCURA0k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IfK4PpQ0nCUKM3Vsu0mQKZsDKFDTfajQ
	PFvvAC1jnoXansedGx+P6lszibCJgBit7j5mThmm5jIaUV8MdhczezC93AopcES1
	6STHCdxmJ0hSodQj9qpv/GedVrJAh/OAWVFsipaGV1BZAs685vX1HYjfLsPHRxm4
	CVjfhy1uH+E=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0435690C56;
	Thu, 14 Jan 2010 03:54:29 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6280290C52; Thu, 14 Jan
 2010 03:54:24 -0500 (EST)
In-Reply-To: <4B4EDA39.1020400@eaglescrag.net> (J. H.'s message of "Thu\, 14
 Jan 2010 00\:47\:53 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6D431780-00EA-11DF-8317-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136970>

"J.H." <warthog9@eaglescrag.net> writes:

> Junio,
>
> I'd suggest using v5 vs. v4 as there was a couple of issues I discovered
> with v4 today.

Yeah, I just noticed.  I was away from the keyboard for the better part of
evening.

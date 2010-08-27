From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Add a new option 'core.askpass'.
Date: Fri, 27 Aug 2010 10:28:38 -0700
Message-ID: <7vaao8hsmx.fsf@alter.siamese.dyndns.org>
References: <201008271251.19754.k.franke@science-computing.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Frank Li <lznuaa@gmail.com>
To: Knut Franke <k.franke@science-computing.de>
X-From: git-owner@vger.kernel.org Fri Aug 27 19:29:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Op2jl-0001NU-MZ
	for gcvg-git-2@lo.gmane.org; Fri, 27 Aug 2010 19:29:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754981Ab0H0R2r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Aug 2010 13:28:47 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:64214 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754969Ab0H0R2r (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Aug 2010 13:28:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DDE81D01A1;
	Fri, 27 Aug 2010 13:28:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=XjqvD+YEiGjPUB2lJYgutjuUuQQ=; b=mFSWM++zwQ1exaI5gMNBJFF
	uFO6n8xZ1Ghq1ZtG4/INE9vtpztWghH3EOmqq2e3lAeTXi0HWo2GQ1/rcyd579uQ
	Qjjct6LRhm0Rmsb8H2vx+SLaQ51tXdcHq5Mehr6KuAH3iQ58CsBISPTsg/YwRq6C
	bQ05DcZY9WjskWLix/4E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=P8xCCBC/5AeGsnku7OPWfZIB+QwlEK8UsYathwVe5gDuSS1ch
	2yVIThVaQ1M2qF3Q2KqSvUDQPiyrxojA7pBytgJkhJhxmeEQt6+QOqcU0/VosXiK
	248uJpwl8HWck2I93xxazJgEIq3nqYU57uTwo85HcgSFp23Go6P0x2U7eg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id ACB15D019C;
	Fri, 27 Aug 2010 13:28:43 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F39CED0194; Fri, 27 Aug
 2010 13:28:39 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8A70E5A4-B200-11DF-8AB0-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154609>

Knut Franke <k.franke@science-computing.de> writes:

> From: Anselm Kruis <a.kruis@science-computing.de>
>
> Setting this option has the same effect as setting the environment variable
> 'GIT_ASKPASS'.
>
> Signed-off-by: Knut Franke <k.franke@science-computing.de>
> ---
> This is useful if you have a wrapper script around git-clone doing some site-
> specific customizations, but want users to be able to use plain git commands 
> for other operations.

I don't see ASKPASS documented anywhere in the Documentation/ in the first
place.  Perhaps we would want to fix that while we are at it.  Also this
does not feel like a "core." thing, but it may be just me.

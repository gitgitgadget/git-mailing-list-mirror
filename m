From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Documentation/remote-helpers: Fix some typos
Date: Mon, 05 Apr 2010 15:03:37 -0700
Message-ID: <7vpr2dmu9y.fsf@alter.siamese.dyndns.org>
References: <f3271551003281104h9b672abk1a8ecccd7a4f8964@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Git Mailing List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 06 00:04:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyuOm-000241-Ri
	for gcvg-git-2@lo.gmane.org; Tue, 06 Apr 2010 00:04:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756679Ab0DEWDz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Apr 2010 18:03:55 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:42619 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756450Ab0DEWDy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Apr 2010 18:03:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D9CE9A87FC;
	Mon,  5 Apr 2010 18:03:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4CNis6nqwSH9dWD5C7t8aOaSilw=; b=d+HpJL
	szl6bZLe6d+3V3cxfMaJdMtJTlBtcG/GRZ/FiGzSTRTrcbaatVHulzFCpdBTct2Y
	GXj5Hw2/Dg1OTbfKyH3qylanUSlubB7cj+3rPGQJrMJgkiLMulB8RzGmSbY9v+pz
	QAWHXhAqjBveNE6QQl66ecVTHLSablmZnmXbA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Rsl/PuKswhodiAPHMCbeOJLfXC7YzRz5
	tF7uyLCxNb746cU7GrOnjlM4Jy10VkOGboMdXg46K9OaULNCACcqeFhtu/LJ+UZA
	1iTCWw2U44lI6OtlThQYX2CyCGB2yf4KgO4eiS6LDCwLP7OvobLU1YgSiTUbZQm2
	0/7uPRyR2tI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DCB7EA87F7;
	Mon,  5 Apr 2010 18:03:46 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5912EA87F2; Mon,  5 Apr
 2010 18:03:39 -0400 (EDT)
In-Reply-To: <f3271551003281104h9b672abk1a8ecccd7a4f8964@mail.gmail.com>
 (Ramkumar Ramachandra's message of "Sun\, 28 Mar 2010 23\:34\:55 +0530")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1B8D33EE-40FF-11DF-9571-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144068>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> @@ -128,9 +131,9 @@ Supported if the helper has the "import" capability.
>  Supported if the helper has the "connect" capability.
>
>  If a fatal error occurs, the program writes the error message to
> -stderr and exits. The caller should expect that a suitable error
> -message has been printed if the child closes the connection without
> -completing a valid response for the current command.
> +stderr and exits. The caller should expect a suitable error
> +if the child closes the connection without
> +giving a valid response for the current command.

This not just fixes typo but changes what is being said, doesn't it?  The
point of the original about the "error" is that the caller does not have
to issue a redundant error message when the helper closes the connection
without reporting the status back, but that information which probably is
critical when maintaining the caller (and writing a new callee) is lost.

Other parts looked Ok to me.

Thanks.

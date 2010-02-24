From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] Use GIT_ASKPASS environment to launch thirdpart UI
 app to get password
Date: Tue, 23 Feb 2010 21:31:56 -0800
Message-ID: <7vtyt7gpwz.fsf@alter.siamese.dyndns.org>
References: <1266923463-2828-1-git-send-email-lznuaa@gmail.com>
 <20100224051307.GA3232@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Frank Li <lznuaa@gmail.com>, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 24 06:32:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nk9r5-0004Al-N4
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 06:32:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752847Ab0BXFcK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2010 00:32:10 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:57558 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752829Ab0BXFcI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2010 00:32:08 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3D28B9C65D;
	Wed, 24 Feb 2010 00:32:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HxgWoG3molz3tMygPqB3sjK2nW0=; b=xHC0EQ
	sLyvhpWhvv5MCLtpoeyLNy11YX6oS00+DobFXFbQj+AKnP9wdHb2x9PjF9kIufqG
	qZRxsYBsLGzu8T5KscgT7xLKXGA0AaRfsOLm5BmXvbln+lHwy/PE7cCKG7mdNCDC
	8kvDYOYP5+h2X6Q+JUc+0CULRKuaiZw5oh9ZE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EpWmpBaeVpNI0zS2+XzyhENX+Za8onqi
	ENOo59ovDZCiE7OVW6Lt+db+KIrjMJS+ExSLuUBNmzn/zTppJVipIr8+DM3odsY/
	NQw8HXuYc0HeWTAIFe+uMu+ViEJe7t58OGjQa0qaSQ5JqzxU72jY/B3PJ1ZAzv0/
	aslFLpMd2bk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 027079C64C;
	Wed, 24 Feb 2010 00:32:02 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1622F9C63E; Wed, 24 Feb
 2010 00:31:58 -0500 (EST)
In-Reply-To: <20100224051307.GA3232@gmail.com> (David Aguilar's message of
 "Tue\, 23 Feb 2010 21\:13\:10 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F00399CA-2105-11DF-A9D5-E038EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140899>

David Aguilar <davvid@gmail.com> writes:

> I think Junio mentioned this in passing but I'll repeat it.
>
> Many users already have SSH_ASKPASS defined.  It would be very
> nice if we supported SSH_ASKPASS as a fallback when GIT_ASKPASS
> is not provided.

Thanks; I think git-gui does something similar.

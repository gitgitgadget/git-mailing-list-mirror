From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Corrected return values in prep_for_email;
Date: Thu, 09 Dec 2010 09:38:55 -0800
Message-ID: <7v7hfihmmo.fsf@alter.siamese.dyndns.org>
References: <002501cb962c$5fa3aa40$1eeafec0$@me.uk>
 <7v1v5tqswl.fsf@alter.siamese.dyndns.org> <4CFE8E97.4020508@digium.com>
 <004301cb97ba$90772630$b1657290$@me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "'Kevin P. Fleming'" <kpfleming@digium.com>, <git@vger.kernel.org>
To: "Alan Raison" <alan@theraisons.me.uk>
X-From: git-owner@vger.kernel.org Thu Dec 09 18:39:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQkSg-0003oX-SK
	for gcvg-git-2@lo.gmane.org; Thu, 09 Dec 2010 18:39:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756143Ab0LIRjI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Dec 2010 12:39:08 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:39597 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756090Ab0LIRjH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Dec 2010 12:39:07 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DAD52369C;
	Thu,  9 Dec 2010 12:39:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=V5Rsv9fKrl0tdDAvAlilsqaSKyk=; b=d20zHs
	bbqiA8wqVXR//o1d+gJH3SMsnc+dOF+U8XgOpGc8JMHyV2Rw+21gLpGFQwWBDQN6
	0KuaSlXV7m6MZGOeGFMCP0K55h1aDY/5OxOlvFao5x8KpdiB8zJHg6LIUwZp6YQ+
	ZbyOeaIGWcWneI2AFH6MpFwBv/7q3w4rSWvaY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GG9uzZYONKxzVjPelVY3yhMWftCuU4h8
	HxuM/VAzmTpidEuU8oGYcDHS5eipDV3emkBzGaFuEICwGEsHeM7pGwmqit6v5TpW
	1vkMDGhUxSFIZvhZN8Ck02RHXwljgrmiqknPQOSw9vR5MpiwH1S8taSEkNCn7+u9
	4UYN9vQEN0U=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A6777369B;
	Thu,  9 Dec 2010 12:39:25 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 8A2E33690; Thu,  9 Dec 2010
 12:39:21 -0500 (EST)
In-Reply-To: <004301cb97ba$90772630$b1657290$@me.uk> (Alan Raison's message
 of "Thu\, 9 Dec 2010 16\:03\:05 -0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 440A6EA2-03BB-11E0-818D-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163297>

"Alan Raison" <alan@theraisons.me.uk> writes:

> Function was returning 0 for failure and 1 for success which was breaking
> the logic in the main loop.
>
> Corrected to return 0 for success, 1 for failure.  Function now also returns
> in all cases, rather than exiting.

Thanks, will apply.

> Acked-By: Kevin P. Fleming <kpfleming@digium.com>
> Signed-Off-By: Alan Raison <alan@theraisons.me.uk>

Just for reference---the order of events is that you signed-off first and
then Kevin acked the result, so the above is backwards.

Also your patch was linewrapped, but I can fix it up---no need to resend,
but please tell your MUA not to corrupt patches next time.

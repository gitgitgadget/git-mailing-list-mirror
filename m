From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RESEND/PATCH] transport-helper: improve push messages
Date: Sun, 05 May 2013 10:59:20 -0700
Message-ID: <7vip2xux3b.fsf@alter.siamese.dyndns.org>
References: <1367624519-12623-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	John Keeping <john@keeping.me.uk>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 05 19:59:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZ3Di-0002Rr-CT
	for gcvg-git-2@plane.gmane.org; Sun, 05 May 2013 19:59:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751847Ab3EER7Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 May 2013 13:59:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54676 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751613Ab3EER7X (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 May 2013 13:59:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 65E011C5EC;
	Sun,  5 May 2013 17:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WlJvN0isOcH3u7qj/BN+mIAsfCA=; b=hHHWCN
	+u6GfxFayY88W5cYcuMdDSEZjRvboIlM+V4DOhs0rQOiqGvl9wpgnjhNVlEGPmms
	5/v2dQ2+VxxKJlB3nh21Zm64eOuK0J/IFTX7apmqudiuKrHId9Y5w00peIUMd/q1
	ckEzA60TivHspPHXBzdD+TAT9dDQLje1QcL7w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rOS03x8dccYs+fpOn2JuZkXHwDc13J1Q
	LRB8o6tK8T88epe1SI2xN22zeo3L32R0Aesx2oN9+7Og2CAq5k3AsnHaUikcxJYc
	9htLLmHUV2UVEcoXJ4dCRlKbvRY0wU+KsENSNWPlP1v2yqJivzoGdouukU/y+iNt
	sE1V2RwbVsU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 59F831C5EB;
	Sun,  5 May 2013 17:59:22 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D44E11C5EA;
	Sun,  5 May 2013 17:59:21 +0000 (UTC)
In-Reply-To: <1367624519-12623-1-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Fri, 3 May 2013 18:41:59 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 83BEAF1C-B5AD-11E2-BAC8-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223411>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> I already sent this, but it has had the unfortunate luck of getting stuck with
> a bunch of irrelevant patches in 'next'.
>
> This is not only good enough for 'master', but probably even 'maint'.

Will apply for 1.8.3 (1.8.2.x may follow later).  Thanks for a
reminder.

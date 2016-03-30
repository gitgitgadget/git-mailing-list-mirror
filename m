From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 00/16] port branch.c to use ref-filter's printing options
Date: Wed, 30 Mar 2016 15:19:06 -0700
Message-ID: <xmqqpoubr4md.fsf@gitster.mtv.corp.google.com>
References: <1459330800-12525-1-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, jacob.keller@gmail.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 31 00:19:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alOSI-0006LA-VW
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 00:19:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755267AbcC3WTK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2016 18:19:10 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:57472 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753508AbcC3WTJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2016 18:19:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 29007518D6;
	Wed, 30 Mar 2016 18:19:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aDq8/bGO3iuGhaPrH5jWZAQLZ6g=; b=otXo02
	5qg6Jh2s1XKxsG6qUBmmNWqPuXowN5zJO7meuICDlRc3/Q7Wu9WSRsP48mAaF2yw
	QLwZyC/tHY7OJ1iU/KpYdOz/LF0hnwXETAiVf3W7LLz8BwZLKzKZ/92SnjB7pYgJ
	F7dL3XebAZhwhO8DsGF1wdmqavYUPE6VVHhdw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=r6mL8xU9G+TvlX6g/PhVIh5JWhSNLziL
	rEhM9vLZ8VqubMVCvkPtOaqoWuBrqdjepzY3aO/Qw2ZK1nx4wghzEReZTSQWxDwj
	tmZKl732m0WjjvacDaWTYylf9ZicdrElmZwnssiOHjny20oBKcPZnyXoozQVN+se
	AyxfnQryx9c=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 21100518D3;
	Wed, 30 Mar 2016 18:19:08 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 8CDFB518D0;
	Wed, 30 Mar 2016 18:19:07 -0400 (EDT)
In-Reply-To: <1459330800-12525-1-git-send-email-Karthik.188@gmail.com>
	(Karthik Nayak's message of "Wed, 30 Mar 2016 15:09:44 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6B6C0372-F6C5-11E5-8AC7-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290354>

Karthik Nayak <karthik.188@gmail.com> writes:

> I kinda waited before sending this, since there was lot of discussions
> happening regarding to GSOC16, didn't want to clutter the mailing list.
>
> This is part of unification of the commands 'git tag -l, git branch -l
> and git for-each-ref'. This ports over branch.c to use ref-filter's
> printing options.

Overall this was a very pleasant read (I had a few comments but
nothing that would make the whole idea of the topic invalidated).

Thanks.

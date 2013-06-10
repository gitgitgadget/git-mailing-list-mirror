From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/6] templates: Fix ASCII art in pre-rebase hook
Date: Mon, 10 Jun 2013 12:51:35 -0700
Message-ID: <7vppvtg2wo.fsf@alter.siamese.dyndns.org>
References: <1370889365-6239-1-git-send-email-richih.mailinglist@gmail.com>
	<1370889365-6239-6-git-send-email-richih.mailinglist@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Richard Hartmann <richih.mailinglist@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 10 21:51:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Um87y-0005yG-Fs
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 21:51:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750929Ab3FJTvi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jun 2013 15:51:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38444 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750792Ab3FJTvi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 15:51:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9B96C26FCB;
	Mon, 10 Jun 2013 19:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YV1I/fQAZyAD/kHtFkkFonyJU80=; b=tdUYOw
	N4+T3AoXoonp+haV3i+IgD0xWZPH75ql+N/Zapmma+mk3I9Qm7b4RVqu9sfLPKGC
	PzzPPkES5SM+eRjRGXMfcDs2y3yAOhoftDBDfD+PunmrIG5tzOJ5vat5bspuSCLb
	D4iHc1vYGohDeGl5RZDh+P71OFdIlZkK4brFE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=n+XX7AruxDoe6YW5cafBG899uWrxlbdI
	yIPxKvFIpf/bgjyQgjgZd5JnWPIUk6US7bkcnoWOEVvGLE0+HzHsOj5KYu4nxpc4
	QCOLq33VJvl++etEqG+0uG1QQeq3OHwTLkP0Tl2vQ25dXB1M6G/4bFLSd7ctb+LL
	QqnLOxQHsaA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 918C626FC6;
	Mon, 10 Jun 2013 19:51:37 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EC62B26FC4;
	Mon, 10 Jun 2013 19:51:36 +0000 (UTC)
In-Reply-To: <1370889365-6239-6-git-send-email-richih.mailinglist@gmail.com>
	(Richard Hartmann's message of "Mon, 10 Jun 2013 20:36:04 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 290BA22A-D207-11E2-A00B-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227368>

Richard Hartmann <richih.mailinglist@gmail.com> writes:

> The example assumes 8-char wide tabs and breaks for people with
> 4-char wide tabs.

Even though as far as this project is concerned, a tab stop is every
8 columns, this is for consumption by end-users who use Git, not for
people who want to improve the code in Git (which this file is part
of), so this "untabify" may make sense.

Thanks.

> Signed-off-by: Richard Hartmann <richih.mailinglist@gmail.com>
> ---
>  templates/hooks--pre-rebase.sample |   16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/templates/hooks--pre-rebase.sample b/templates/hooks--pre-rebase.sample
> index 053f111..b74cd1d 100755
> --- a/templates/hooks--pre-rebase.sample
> +++ b/templates/hooks--pre-rebase.sample
> @@ -132,14 +132,14 @@ With this workflow, you would want to know:
>  
>  Let's look at this example:
>  
> -		   o---o---o---o---o---o---o---o---o---o "next"
> -		  /       /           /           /
> -		 /   a---a---b A     /           /
> -		/   /               /           /
> -	       /   /   c---c---c---c B         /
> -	      /   /   /             \         /
> -	     /   /   /   b---b C     \       /
> -	    /   /   /   /             \     /
> +                   o---o---o---o---o---o---o---o---o---o "next"
> +                  /       /           /           /
> +                 /   a---a---b A     /           /
> +                /   /               /           /
> +               /   /   c---c---c---c B         /
> +              /   /   /             \         /
> +             /   /   /   b---b C     \       /
> +            /   /   /   /             \     /
>      ---o---o---o---o---o---o---o---o---o---o---o "master"

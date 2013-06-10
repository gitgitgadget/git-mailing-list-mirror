From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/6] template: Fix comment indentation in pre-rebase hook
Date: Mon, 10 Jun 2013 12:52:42 -0700
Message-ID: <7vli6hg2ut.fsf@alter.siamese.dyndns.org>
References: <1370889365-6239-1-git-send-email-richih.mailinglist@gmail.com>
	<1370889365-6239-7-git-send-email-richih.mailinglist@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Richard Hartmann <richih.mailinglist@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 10 21:52:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Um899-0006nz-SA
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 21:52:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752095Ab3FJTwr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jun 2013 15:52:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54137 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751997Ab3FJTwp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 15:52:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C04BF2705B;
	Mon, 10 Jun 2013 19:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=y4UKAlcYKzn11ss/e+W2sWIQyNo=; b=ox8mfQ
	0HHQFm3bFMy8KN/gvLaoDFOK/DArtbD4xFe5m8Jd0KSdHf851YK9Wtloks6kJ8+T
	TlFODQbYGpuyWoTp4WiqJJKQtZP8nNsHp9fP4DWt9nHO7tRHfr3jsa/VveyCYRC9
	49A4N8mDuagq4L+uAqdPjfiop3aw8D7LQ2gsQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KSBGsbqMBloo9X3YvHqSYF3UR7hpM3ov
	iECOEm7T7xjy66+yNurAs7M7oj79jtgNoAlzFrGa3u2sucDsYDYSM4a/t3TaoqqW
	vfYCQJz49GK6GP+6KQprL9zTsZzKwmz/X0+rmSLloU9Ao68yTePrwu17DxsnzOXZ
	+eggpk8P3h0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B2E8F2705A;
	Mon, 10 Jun 2013 19:52:44 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 16E6327057;
	Mon, 10 Jun 2013 19:52:44 +0000 (UTC)
In-Reply-To: <1370889365-6239-7-git-send-email-richih.mailinglist@gmail.com>
	(Richard Hartmann's message of "Mon, 10 Jun 2013 20:36:05 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 510E4688-D207-11E2-9500-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227369>

Richard Hartmann <richih.mailinglist@gmail.com> writes:

> The other hooks use two whitespace for indentation instead of tabs
> to signify code in the example/echo output.
> Follow the same layout in templates/hooks--pre-rebase.sample
>
> Signed-off-by: Richard Hartmann <richih.mailinglist@gmail.com>
> ---
>  templates/hooks--pre-rebase.sample |   10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/templates/hooks--pre-rebase.sample b/templates/hooks--pre-rebase.sample
> index b74cd1d..43426e0 100755
> --- a/templates/hooks--pre-rebase.sample
> +++ b/templates/hooks--pre-rebase.sample
> @@ -157,13 +157,13 @@ B to be deleted.
>  
>  To compute (1):
>  
> -	git rev-list ^master ^topic next
> -	git rev-list ^master        next
> +  git rev-list ^master ^topic next
> +  git rev-list ^master        next
>  
> -	if these match, topic has not merged in next at all.
> +  if these match, topic has not merged in next at all.
>  
>  To compute (2):
>  
> -	git rev-list master..topic
> +  git rev-list master..topic
>  
> -	if this is empty, it is fully merged to "master".
> +  if this is empty, it is fully merged to "master".

I think offsetting the actual commands to the right is correct, but
"if these match" and "if this is empty" should be flushed to left as
this patch shows.

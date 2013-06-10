From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/6] templates: Reformat pre-commit hook's message
Date: Mon, 10 Jun 2013 12:47:27 -0700
Message-ID: <7vtxl5g33k.fsf@alter.siamese.dyndns.org>
References: <1370889365-6239-1-git-send-email-richih.mailinglist@gmail.com>
	<1370889365-6239-3-git-send-email-richih.mailinglist@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Richard Hartmann <richih.mailinglist@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 10 21:47:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Um83z-0003Gy-6G
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 21:47:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751344Ab3FJTrb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jun 2013 15:47:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40149 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750792Ab3FJTra (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 15:47:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C868F26C65;
	Mon, 10 Jun 2013 19:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hrBK6akqFRj5SeWMrZBV43A6ddI=; b=cBL6zl
	5a9tLfvShl7VlkpUSjM73CqAFU+3Gy9o1KwkDsf80yvfZepPRgdBIbff4CrMf98O
	DQELk1O0pCZWM2dA758ifC94+Douk+qHSzTPmJnlgshkcC+/HtDoXs2gZPL2zO1Q
	rCgIvS/TypgfDqfRwMoevgY8G2T96vv3cs6w4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZJ9nonMCkVM7BBJpTKTk3tkudwNCe+0Q
	eYLo2QJotLDXh3gFJD9wmSabmSTcW+/KnjHzPPn2SfO+Uick7paUd4FadXS0BF3Y
	FSgOFACSJpFCVoZvWBAg7h6BBp4VEVnc4NahJoXt9RrTaJ6btFQtNbAtmj8dmDBF
	/AMeqM65QoU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B0FA226C64;
	Mon, 10 Jun 2013 19:47:29 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D294926C5B;
	Mon, 10 Jun 2013 19:47:28 +0000 (UTC)
In-Reply-To: <1370889365-6239-3-git-send-email-richih.mailinglist@gmail.com>
	(Richard Hartmann's message of "Mon, 10 Jun 2013 20:36:01 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 952B6BE4-D206-11E2-B98E-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227367>

Richard Hartmann <richih.mailinglist@gmail.com> writes:

> Now that the there's only one echo being spawned, the message can span
> the full 80 chars.
>
> Signed-off-by: Richard Hartmann <richih.mailinglist@gmail.com>
> ---
>  templates/hooks--pre-commit.sample |    6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/templates/hooks--pre-commit.sample b/templates/hooks--pre-commit.sample
> index 126ae13..7676c6e 100755
> --- a/templates/hooks--pre-commit.sample
> +++ b/templates/hooks--pre-commit.sample
> @@ -33,13 +33,11 @@ if [ "$allownonascii" != "true" ] &&
>  then
>  	echo 'Error: Attempt to add a non-ascii file name.
>  
> -This can cause problems if you want to work
> -with people on other platforms.
> +This can cause problems if you want to work with people on other platforms.
>  
>  To be portable it is advisable to rename the file.
>  
> -If you know what you are doing you can disable this
> -check using:
> +If you know what you are doing you can disable this check using:
>  
>    git config hooks.allownonascii true
>  '

OK.  Occupying 75-col feels like it is pushing a bit, but the result
does look more readable.

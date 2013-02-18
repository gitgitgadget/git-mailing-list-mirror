From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 3/9] user-manual: Give 'git push -f' as an alternative
 to +master
Date: Sun, 17 Feb 2013 18:24:51 -0800
Message-ID: <7v1ucee4uk.fsf@alter.siamese.dyndns.org>
References: <20130217170606.GA3432@odin.tremily.us>
 <cover.1361146398.git.wking@tremily.us>
 <dadeb91c29bf6758cbe463b569146991d9eb455a.1361146398.git.wking@tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Mon Feb 18 03:25:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7GPy-0005B9-6w
	for gcvg-git-2@plane.gmane.org; Mon, 18 Feb 2013 03:25:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757461Ab3BRCY6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2013 21:24:58 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33221 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755687Ab3BRCY6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2013 21:24:58 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 93499B238;
	Sun, 17 Feb 2013 21:24:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AdWhQg8+QfvwafZlNZCH4CmPO4g=; b=BbOB/Z
	L5L1n8JP92xyXdaG74mAq5WJE2vttHNVVX1r23IOCMpqaA1uh06XvSi+KgCWOiK7
	9VUHEYjE/+yxlRBwr34PwE8lmUAkonUwEpGcvWnz8uznzoltU3/71ZXByDPMSW8I
	AC4sIGMTFjNsAaB12OPJV9NfCksOFpK9qIPnA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=f7T9MlKIZdQUvp8rB7cOXg7wGImhjlE7
	4Fiv1F69Qx2YfcvWFHWlCppo5d9EBB6AO0b9tH+OYsNHKuprzXkXi9LK6GZ+FzRE
	lznCUyckk0tS3e9/r+/nOadqBGwdfOanZ4FjHJCvr9ALJpRc16CF97hbwCSBaO8S
	nChJcCF6mOE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 885BDB237;
	Sun, 17 Feb 2013 21:24:57 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 02C90B235; Sun, 17 Feb 2013
 21:24:56 -0500 (EST)
In-Reply-To: <dadeb91c29bf6758cbe463b569146991d9eb455a.1361146398.git.wking@tremily.us>
 (W. Trevor King's message of "Sun, 17 Feb 2013 19:15:55 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6316AD2C-7972-11E2-82AC-ACA62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216430>

"W. Trevor King" <wking@tremily.us> writes:

> From: "W. Trevor King" <wking@tremily.us>
>
> This mirrors existing language in the description of 'git fetch'.
>
> Signed-off-by: W. Trevor King <wking@tremily.us>
> ---

This looks like a good 'maint' material that can be applied straight
away there in preparation for 1.8.1.4 to me; reviewers watching from
the sideline, please stop me if you see issues.

>  Documentation/user-manual.txt | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
> index dbffd0a..ba06b7e 100644
> --- a/Documentation/user-manual.txt
> +++ b/Documentation/user-manual.txt
> @@ -2051,6 +2051,13 @@ branch name with a plus sign:
>  $ git push ssh://yourserver.com/~you/proj.git +master
>  -------------------------------------------------
>  
> +Note the addition of the `+` sign.  Alternatively, you can use the
> +`-f` flag to force the remote update, as in:
> +
> +-------------------------------------------------
> +$ git push -f ssh://yourserver.com/~you/proj.git master
> +-------------------------------------------------
> +
>  Normally whenever a branch head in a public repository is modified, it
>  is modified to point to a descendant of the commit that it pointed to
>  before.  By forcing a push in this situation, you break that convention.

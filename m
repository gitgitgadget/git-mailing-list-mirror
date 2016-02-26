From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/6] Documentation/git-worktree: spell --detach correctly
Date: Fri, 26 Feb 2016 09:52:56 -0800
Message-ID: <xmqq1t7zl5on.fsf@gitster.mtv.corp.google.com>
References: <cover.1456504190.git.git@drmicha.warpmail.net>
	<f0c859d9736058736a58d8c9898c9b5417a63b8c.1456504190.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Feb 26 18:53:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZMZd-0006Mk-GO
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 18:53:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030323AbcBZRxA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2016 12:53:00 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:51460 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1030317AbcBZRw7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2016 12:52:59 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 24FEB44CC5;
	Fri, 26 Feb 2016 12:52:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GonJwSECFcAoNk3HKcxZ0JyRX7A=; b=FLEEDf
	WGPmW3rgRHHNdFy4ksVhk4PKZc+0biWo2/4xEbXIyMRjVy8/6SHZKJSoQxxGKyxf
	OS/1WGTwiWY9MkM3LCUjs6ydK3j5R9SCP7TsBFtlmCDUsRq0cXYV25Vlrano32Aq
	X/9K1JQUEivT11BvvM4UYw9VeHO42TdzKiEsQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Y1kOeSOx6UVxUZx+3asb2kXr9UhTOJ4o
	l4U7K5zQsJJF8U1lkS9LLHRqSgEr0pfNDir1JuTAepyRqAFtXf1vnq0ynn6v2GJf
	899ozk+P8/TjTthHFWXEtfi87yG3L2W5xu6zvsIK1QbJozhHnlpG0GdZBjNSHfDm
	D49Feun/+HA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1C7E644CC4;
	Fri, 26 Feb 2016 12:52:58 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 8D8DA44CC1;
	Fri, 26 Feb 2016 12:52:57 -0500 (EST)
In-Reply-To: <f0c859d9736058736a58d8c9898c9b5417a63b8c.1456504190.git.git@drmicha.warpmail.net>
	(Michael J. Gruber's message of "Fri, 26 Feb 2016 17:39:41 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C4EE0DBA-DCB1-11E5-AB58-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287599>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
>  Documentation/git-worktree.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
> index 62c76c1..51a2ea0 100644
> --- a/Documentation/git-worktree.txt
> +++ b/Documentation/git-worktree.txt
> @@ -50,7 +50,7 @@ Create `<path>` and checkout `<branch>` into it. The new working directory
>  is linked to the current repository, sharing everything except working
>  directory specific files such as HEAD, index, etc.
>  +
> -If `<branch>` is omitted and neither `-b` nor `-B` nor `--detached` used,
> +If `<branch>` is omitted and neither `-b` nor `-B` nor `--detach` used,

That is correct, but I wonder if there is an " is" missing there...?

>  then, as a convenience, a new branch based at HEAD is created automatically,
>  as if `-b $(basename <path>)` was specified.

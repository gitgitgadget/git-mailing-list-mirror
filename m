From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/7] Documentation: git-init: typographical fixes
Date: Tue, 05 Aug 2014 15:06:00 -0700
Message-ID: <xmqqr40uoalz.fsf@gitster.dls.corp.google.com>
References: <1407002817-29221-1-git-send-email-linusarver@gmail.com>
	<1407002817-29221-2-git-send-email-linusarver@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Steven Drake <sdrake@xnet.co.nz>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Johan Herland <johan@herland.net>,
	Nanako Shiraishi <nanako3@lavabit.com>
To: Linus Arver <linusarver@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 06 00:06:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XEms5-0005Wm-0H
	for gcvg-git-2@plane.gmane.org; Wed, 06 Aug 2014 00:06:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753632AbaHEWGM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Aug 2014 18:06:12 -0400
Received: from smtp.pobox.com ([208.72.237.35]:60760 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752854AbaHEWGL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Aug 2014 18:06:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3DEF12EBE6;
	Tue,  5 Aug 2014 18:06:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xB9DT7g/aGCqJ9Fvn046IGAi20k=; b=bxpsze
	WexpA5NHbmKQt06gv+tv4PLdkmYV06lFRr85oYeqi8HHgzexm3NT/Nb7RhOABG1o
	gJaNKhndFolRBIHqME98Lp0iTdrOtZFMIUVyj3ISObAGl8678OJPaoD0HTrMdo+v
	jtfkQCXpFQe6TA6SotNCHe5WfCYLItClClozY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GE5nIakNX3qJNVV/37AegYtJWW9YEplH
	QWzRp12EjVv1+6Wi3McV07pBHxKuYZ26RxVzemF6M9iecfZRGNmxBq1go7IkreR4
	Pu57sRFi8F3xcpcQShdfMglltox2HnwC8SSGaa/0U6WT/djcMzV1RYKJMn9JD56n
	xrzLKPFfYPM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 33CD72EBE5;
	Tue,  5 Aug 2014 18:06:09 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 7B18C2EBD7;
	Tue,  5 Aug 2014 18:06:02 -0400 (EDT)
In-Reply-To: <1407002817-29221-2-git-send-email-linusarver@gmail.com> (Linus
	Arver's message of "Sat, 2 Aug 2014 11:06:51 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B064D6A2-1CEC-11E4-8FE0-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254832>

Linus Arver <linusarver@gmail.com> writes:

> Signed-off-by: Linus Arver <linusarver@gmail.com>
> ---
>  Documentation/git-init.txt | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
> index afd721e..5ed5859 100644
> --- a/Documentation/git-init.txt
> +++ b/Documentation/git-init.txt
> @@ -43,7 +43,7 @@ OPTIONS
>  -q::
>  --quiet::
>  
> -Only print error and warning messages, all other output will be suppressed.
> +Only print error and warning messages; all other output will be suppressed.

OK.

>  --bare::
>  
> @@ -97,7 +97,7 @@ is given:
>     create a repo that is readable and writable to the current user and group,
>     but inaccessible to others.
>  
> -By default, the configuration flag receive.denyNonFastForwards is enabled
> +By default, the configuration flag 'receive.denyNonFastForwards' is enabled
>  in shared repositories, so that you cannot force a non fast-forwarding push
>  into it.

If you are going to quote something that the user should literally
use, it is probably better to use `backticks` so that the quoted
contents will be typeset in monospaced typewriter-font.

> @@ -113,7 +113,7 @@ TEMPLATE DIRECTORY
>  The template directory contains files and directories that will be copied to
>  the `$GIT_DIR` after it is created.
>  
> -The template directory used will (in order):
> +The template directory used will be (in order):
>  
>   - The argument given with the `--template` option.

OK.

Thanks.

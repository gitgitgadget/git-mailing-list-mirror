From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] completion: Add --word-diff-regex= to diff
Date: Wed, 20 Jan 2016 16:18:44 -0800
Message-ID: <xmqqy4bj23a3.fsf@gitster.mtv.corp.google.com>
References: <569FC542.2060504@virtuell-zuhause.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	John Keeping <john@keeping.me.uk>,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
To: Thomas Braun <thomas.braun@virtuell-zuhause.de>
X-From: git-owner@vger.kernel.org Thu Jan 21 01:18:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aM2xf-0001zP-QT
	for gcvg-git-2@plane.gmane.org; Thu, 21 Jan 2016 01:18:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752068AbcAUASs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2016 19:18:48 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:50217 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751182AbcAUASq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2016 19:18:46 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 684203EFEE;
	Wed, 20 Jan 2016 19:18:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OZIuo5peKQgwjrEUdaHfyATQ8+4=; b=R97ssk
	S9UAfZhygKr1nmW1JpgG4eIBt2kyGlDymKta5wlzoVuF42ff7NQVU4FmPrDZ96w0
	y0BZdLLUe4c0W7XEtwWM29C3TM3x1Yxho1yHwKdrxCkU/1HH7sUDWNAe1/H6mVp6
	/oJ0f+3khEy3D48So8Pv/spPZ3TeYll7C3nkQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BcibDee2DZt/7tNlc3twaglpUBopMjxo
	0MEmrIjWUir5Lu6E+6l2RVU3jGcJuUf6pEjP7RLyCVIwuQf1hkrpciAq3yKEAg+s
	dM0RzHK5J1/FSqDWLTIew6hO6YAEtCOQM724ZhJClp6Hw//psSBBWFQ7IUSswcCR
	o2LJq2Xwe0c=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5C4E73EFEC;
	Wed, 20 Jan 2016 19:18:46 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id AFB603EFEB;
	Wed, 20 Jan 2016 19:18:45 -0500 (EST)
In-Reply-To: <569FC542.2060504@virtuell-zuhause.de> (Thomas Braun's message of
	"Wed, 20 Jan 2016 18:34:58 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 89030944-BFD4-11E5-95F3-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284491>

Thomas Braun <thomas.braun@virtuell-zuhause.de> writes:

> Signed-off-by: Thomas Braun <thomas.braun@virtuell-zuhause.de>
> ---
>  contrib/completion/git-completion.bash | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/contrib/completion/git-completion.bash
> b/contrib/completion/git-completion.bash
> index ab4da7f..d2a08dd 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1169,7 +1169,7 @@ __git_diff_common_options="--stat --numstat
> --shortstat --summary
>  			--no-prefix --src-prefix= --dst-prefix=
>  			--inter-hunk-context=
>  			--patience --histogram --minimal
> -			--raw --word-diff
> +			--raw --word-diff --word-diff-regex=
>  			--dirstat --dirstat= --dirstat-by-file
>  			--dirstat-by-file= --cumulative
>  			--diff-algorithm=

Thanks; the patch was word-wrapped, but I fixed it up and managed to
apply.

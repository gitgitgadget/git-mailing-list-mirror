From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Improve the description of GIT_PS1_SHOWUPSTREAM
Date: Mon, 24 Sep 2012 11:49:35 -0700
Message-ID: <7v7grjz268.fsf@alter.siamese.dyndns.org>
References: <1348508486-63176-1-git-send-email-jonathan@leto.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Jonathan \"Duke\" Leto" <jonathan@leto.net>
X-From: git-owner@vger.kernel.org Mon Sep 24 20:50:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGDjD-00017q-UG
	for gcvg-git-2@plane.gmane.org; Mon, 24 Sep 2012 20:50:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757756Ab2IXStm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2012 14:49:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49781 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757747Ab2IXStl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2012 14:49:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E38CC9EBB;
	Mon, 24 Sep 2012 14:49:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=W3OvaVJhcinH8UXQLIGGXP0zScc=; b=niv/mf
	7XTVArEJ9g6pw8J+2EHchIKWb/qEwVXNCH+kNgoZPQD8LspOc2Z9iDNqmGX5rPtF
	66gXPjrZtRKBzuVFAdV8v0hgZIYhs688CPqXgEk17mYRA1cgZ0G0e9DJlVnEq5Rz
	APrGnk/tFQoK9Vv//3r1E661iQPOYb3ZXbUXY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=d/Csby38GaAxtrNyxbyaxZo4LmbKKF42
	m1eRULLgLDtR8887VVqTvy1X8Gwn0HI+pSzHbH6RMPemuoyb6c448cFH2zqpsedi
	yn1nyFHpDBykBMc2JlPe/GjCib6HgbklW3+nhdzkf6u0mSs+Qoc2GAPMvRAd0zEj
	bJNnSgLjyCc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C50079EBA;
	Mon, 24 Sep 2012 14:49:40 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2761F9EB4; Mon, 24 Sep 2012
 14:49:37 -0400 (EDT)
In-Reply-To: <1348508486-63176-1-git-send-email-jonathan@leto.net> (Jonathan
 Leto's message of "Mon, 24 Sep 2012 10:41:26 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 96E0CC22-0678-11E2-9275-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206311>

"Jonathan \"Duke\" Leto" <jonathan@leto.net> writes:

> From: "Jonathan \"Duke\" Leto" <jonathan@leto.net>
>
> Describe what '=' means in the output of __git_ps1 when using
> GIT_PS1_SHOWUPSTREAM, which was not previously described.
>
> Signed-off-by: Jonathan "Duke" Leto <jonathan@leto.net>
> ---

Makes sense; will directly apply to 'maint'.

>  contrib/completion/git-prompt.sh | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
> index 29b1ec9..bf20491 100644
> --- a/contrib/completion/git-prompt.sh
> +++ b/contrib/completion/git-prompt.sh
> @@ -34,9 +34,10 @@
>  #
>  # If you would like to see the difference between HEAD and its upstream,
>  # set GIT_PS1_SHOWUPSTREAM="auto".  A "<" indicates you are behind, ">"
> -# indicates you are ahead, and "<>" indicates you have diverged.  You
> -# can further control behaviour by setting GIT_PS1_SHOWUPSTREAM to a
> -# space-separated list of values:
> +# indicates you are ahead, "<>" indicates you have diverged and "="
> +# indicates that there is no difference. You can further control
> +# behaviour by setting GIT_PS1_SHOWUPSTREAM to a space-separated list
> +# of values:
>  #
>  #     verbose       show number of commits ahead/behind (+/-) upstream
>  #     legacy        don't use the '--count' option available in recent

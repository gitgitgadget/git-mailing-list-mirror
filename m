From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/5] README.md: don't call git stupid in the title
Date: Tue, 23 Feb 2016 11:13:04 -0800
Message-ID: <xmqqegc31br3.fsf@gitster.mtv.corp.google.com>
References: <1456249229-30454-1-git-send-email-Matthieu.Moy@imag.fr>
	<1456249229-30454-5-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, emma.westby@gmail.com
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Tue Feb 23 20:13:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYIOc-0006oJ-9j
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 20:13:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754163AbcBWTNI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2016 14:13:08 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:61296 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752254AbcBWTNH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2016 14:13:07 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 057EF44D6B;
	Tue, 23 Feb 2016 14:13:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WdN+L31NWO8WjY3qmweALYAcneI=; b=uTWS9D
	F3YtAWW7KERRFDHAqks2/BQalYy/EbPrrc/3AiJVFAEmQ3sl3SbhkADy98L0v/Ds
	BlsddQBulV+01ERzgYMCi8addRO0D1WJXzFBElUK5yeNoKv9DxiJMSLSs3DNMeWp
	aUxoz/Gdlb0YTDW5NgLwfveVPgUl3/XXtiUrM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Xu31xxBC6MQwvPjjuxULXgF5VkU/vWWM
	3xz1TxF8KA89CHqONP0J4NsgtmONyXMmwSF6izUSWi5CcRpgX5BVjB92jY8QhA0y
	+7rK6R+/8TPyhQ/54PsFxgWvcTmlNps/C+RbjOo0iFGqDNr/r81AXr/LCC/nAZo7
	9CD9HcsRCA8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id F1EC844D6A;
	Tue, 23 Feb 2016 14:13:05 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6E7C744D69;
	Tue, 23 Feb 2016 14:13:05 -0500 (EST)
In-Reply-To: <1456249229-30454-5-git-send-email-Matthieu.Moy@imag.fr>
	(Matthieu Moy's message of "Tue, 23 Feb 2016 18:40:28 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7767BC64-DA61-11E5-B622-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287103>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> "the stupid content tracker" was true in the early days of Git, but
> hardly applicable these days. "fast, scalable, distributed" describes
> Git more accuralety.
>
> Also, "stupid" can be seen as offensive by some people. Let's not use it
> in the very first words of the README.
>
> The new formulation is taken from the description of the Debian package.
>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---

This self-derogatory reference shouldn't offend those who didn't
help write it.

Having said that, I agree with the spirit of 4/5 and 5/5; but it is
sad that this line is not resurrected by 5/5 in some way.

>  README.md | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/README.md b/README.md
> index 1625352..c11c3e2 100644
> --- a/README.md
> +++ b/README.md
> @@ -1,4 +1,4 @@
> -# Git - the stupid content tracker
> +# Git - fast, scalable, distributed revision control system
>  
>  "git" can mean anything, depending on your mood.

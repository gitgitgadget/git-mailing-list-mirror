From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Ignore gitk-wish buildproduct
Date: Wed, 23 Jan 2013 11:58:57 -0800
Message-ID: <7vip6nhdry.fsf@alter.siamese.dyndns.org>
References: <1358967340-3642-1-git-send-email-hjemli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>, Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Wed Jan 23 20:59:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ty6Tm-000558-Dr
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jan 2013 20:59:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751718Ab3AWT7F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2013 14:59:05 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59404 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751273Ab3AWT7E (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2013 14:59:04 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9018DC29B;
	Wed, 23 Jan 2013 14:59:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vOXkoy5H3k33DgEwfGkpksG+jcI=; b=yD53YE
	/m34d5e+4P4pLMY8k7XOHJurc9FZ40B7KpL6WLebkidr2BhYNYqBdDruNTmNmCMt
	6uMc0gB5IQzYNT5d3+Jx9nkD6CDluu8D6rXRk2nXHYiXs+aCe39owWgSTlPbFcnD
	FyQWRqlOcnTh9low0AUfyGObbzzxUa/nkDlWw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=f3DcecPVM73cB0lkLX1TNPT4K03/c9Yz
	iXHoWKUp65OC5Uq5NQ/gayqGLo85BaVEh/K4T7VHG1UXVhIWo9tJttz76QvCaRIZ
	XwiN4e8G8rsLKaslm6mXudtNyQ51pu1X11mI2AK732tYKs7rDKmSExzNPD9Pjf+U
	412JL1Z0DyA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 804E9C29A;
	Wed, 23 Jan 2013 14:59:00 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E78C5C298; Wed, 23 Jan 2013
 14:58:59 -0500 (EST)
In-Reply-To: <1358967340-3642-1-git-send-email-hjemli@gmail.com> (Lars
 Hjemli's message of "Wed, 23 Jan 2013 19:55:40 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 54137E16-6597-11E2-8BE7-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214350>

Lars Hjemli <hjemli@gmail.com> writes:

> After running `make` on latest master, gitk-git/gitk-wish shows up as
> untracked. This fixes it.
>
> Signed-off-by: Lars Hjemli <hjemli@gmail.com>

The removal was very much deliberate [*1*]; Christian was going to
send a corresponding updates to gitk maintainer [*2*, *3*] but I
guess we haven't sync'ed up yet.

Paul, I'll resend another copy of [*3*] to you as a follow-up;
please apply, thanks.


[References]

*1* http://thread.gmane.org/gmane.comp.version-control.git/211773
*2* http://thread.gmane.org/gmane.comp.version-control.git/211641/focus=211751
*3* http://thread.gmane.org/gmane.comp.version-control.git/213067

>
> ---
>  .gitignore | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/.gitignore b/.gitignore
> index aa258a6..63d4904 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -171,6 +171,7 @@
>  /git-whatchanged
>  /git-write-tree
>  /git-core-*/?*
> +/gitk-git/gitk-wish
>  /gitweb/GITWEB-BUILD-OPTIONS
>  /gitweb/gitweb.cgi
>  /gitweb/static/gitweb.js

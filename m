From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] check-ignore doc: fix broken link to ls-files page
Date: Sun, 30 Jun 2013 12:34:08 -0700
Message-ID: <7v8v1rjsun.fsf@alter.siamese.dyndns.org>
References: <1372593928-403-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 30 21:34:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UtNO3-0001Ws-BQ
	for gcvg-git-2@plane.gmane.org; Sun, 30 Jun 2013 21:34:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752302Ab3F3TeL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Jun 2013 15:34:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51901 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752291Ab3F3TeL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Jun 2013 15:34:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 420502C08C;
	Sun, 30 Jun 2013 19:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xl/Azwm2w8r2RYfKDvOB2FZvk8U=; b=S6Vlrw
	Uopp4fNXCneECMJLzJJzGKEJ2gA7sPa88iYqbK+EhPOmvKE4RxS/e47D8453LOpM
	HX6fZ5Ro1Jv6xulE/8BYVKoSK99rXdk1sAS5ocXl0a+Q5KJMMxZsDX7XDuhsyke/
	Rg913tJZQ9T9QS5pSuFsPDDZaGzP/ALKdmyyE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uQ8gsDdfVSHyvGNGpBTZVqir2ig6Vp3e
	sfIJ6uqbJ2WUlCSCRkNpv9eIOx33/7/sAAh4m4NMjkVwAJyBrSiduOHsGTMLNlJD
	4eQGCw6STeB2rg4F0C/CGiNl12ngfNOy/LGRDElIFTolcVCSR4nhtetURQoQJdAN
	XhgfAPvjEHw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 391A52C08B;
	Sun, 30 Jun 2013 19:34:10 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B18FC2C08A;
	Sun, 30 Jun 2013 19:34:09 +0000 (UTC)
In-Reply-To: <1372593928-403-1-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Sun, 30 Jun 2013 17:35:28 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 091A7652-E1BC-11E2-A881-E636B1368C5F-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229286>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---

Thanks, good eyes.

I wonder if we can come up with an automated and reliable way to add
to check-docs target of the main Makefile to catch this kind of thing.

>  Documentation/git-check-ignore.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/git-check-ignore.txt b/Documentation/git-check-ignore.txt
> index 8e1f7ab..d2df487 100644
> --- a/Documentation/git-check-ignore.txt
> +++ b/Documentation/git-check-ignore.txt
> @@ -102,7 +102,7 @@ SEE ALSO
>  --------
>  linkgit:gitignore[5]
>  linkgit:gitconfig[5]
> -linkgit:git-ls-files[5]
> +linkgit:git-ls-files[1]
>  
>  GIT
>  ---

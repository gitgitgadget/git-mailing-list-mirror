From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 10/16] ls-remote doc: rewrite <repository> paragraph
Date: Fri, 21 Jun 2013 15:39:53 -0700
Message-ID: <7vfvwbjdfq.fsf@alter.siamese.dyndns.org>
References: <1371813160-4200-1-git-send-email-artagnon@gmail.com>
	<1371813160-4200-11-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 22 00:40:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uq9zs-0005F5-4w
	for gcvg-git-2@plane.gmane.org; Sat, 22 Jun 2013 00:40:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423670Ab3FUWj4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jun 2013 18:39:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42753 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423636Ab3FUWjz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jun 2013 18:39:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5BD212AFB1;
	Fri, 21 Jun 2013 22:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WRsWic82KRLSbWi3qA9mYZXaBPg=; b=bDHV1N
	UdDzdVDvdMPZh3u51mv3yILt/LVNRZjrPqpClb+vGJ8HnplvrO3Z8Q3EjmhRal/4
	UGrp1XWYGywsNS/MZQxK2JN5T6bq76rOdHimPfqFBK3Cl/e5tP0GjTrixcitIkzC
	4LMVCfD0SUwfm4pDQvbObZkExKhCwA7K+ZBf0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=O0eJSOfpr9fJT+VswcJOQm41RpyahUft
	9+Iu2Cz/taLb4qluRRnL5SN+iU0Bq7JJ9Cl85VBfJhY/o0CZbzwZkW1aqTA6J9+Y
	38UXTUUTKL9pVXvDGkFb1wEfVPobxMQtewvMUeGrHkPpg/CimxXhqcpqK4JdhK/F
	O5tBTGEGSBo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 531472AFB0;
	Fri, 21 Jun 2013 22:39:55 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BE6EF2AFAF;
	Fri, 21 Jun 2013 22:39:54 +0000 (UTC)
In-Reply-To: <1371813160-4200-11-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Fri, 21 Jun 2013 16:42:34 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7E5A758E-DAC3-11E2-AA2B-80EC6777888E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228668>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Replace the <repository> paragraph containing specific references to
> $GIT_DIR/branches and "." with a generic urls-or-remotes paragraph
> referencing the relevant sections in the git-fetch(1) manpage.
>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  Documentation/git-ls-remote.txt | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/git-ls-remote.txt b/Documentation/git-ls-remote.txt
> index a24b8b6..0715892 100644
> --- a/Documentation/git-ls-remote.txt
> +++ b/Documentation/git-ls-remote.txt
> @@ -48,9 +48,9 @@ OPTIONS
>  	exit without talking to the remote.
>  
>  <repository>::
> -	Location of the repository.  The shorthand defined in
> -	$GIT_DIR/branches/ can be used. Use "." (dot) to list references in
> -	the local repository.
> +	The "remote" repository to query.  This parameter can be
> +	either a URL or the name of a remote (see the GIT URLS and
> +	REMOTES sections of linkgit:git-fetch[1]).

Looks OK.  "." was written before "for-each-ref" and "branch --list"
have become the standard way to list your local refs and branches,
and I would agree that the description outlived its usefulness.

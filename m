From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/6] reset: trivial style cleanup
Date: Fri, 30 Aug 2013 20:49:52 -0700
Message-ID: <xmqq7gf2wmcf.fsf@gitster.dls.corp.google.com>
References: <1377899810-1818-1-git-send-email-felipe.contreras@gmail.com>
	<1377899810-1818-5-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 31 05:50:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFcCF-0001Si-1g
	for gcvg-git-2@plane.gmane.org; Sat, 31 Aug 2013 05:49:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754787Ab3HaDtz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Aug 2013 23:49:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39253 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753585Ab3HaDty (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Aug 2013 23:49:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 81EDD33AEC;
	Sat, 31 Aug 2013 03:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oU75t5RYG8T2vkHt6hMk6ye2MsM=; b=UfEtZA
	ohs9o3bys5ZsrMU73oj9wFt7JFl3UEZQ5w/OTUmsCoXM0fgoOu7ZBzIB7G2AadwX
	RkpbboyFKiSWvawt5GkxbpNh8TYRAHC8B/k8H6t6nttMCXkifRuclJmHYCH1B1gl
	2bzjwONWXw5Z9waWJxQl1hre7g8rNUUfboC0Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=R3+07n6nQ1cQ+Ur+yfjEWsit2vlZDimP
	KPsmu348t0CrmvNqP2zPh1fHeJ556YJ9fMrDAeYcXC1VlA86AB8DPBfy8zHeuCkr
	esA6nqvp9fHmS8rUgOLShpSTtIA1u4CSkWYZjnVFIRhrIFP+q0ZLvuQOHy3GLRNp
	Yx/FS6vV39w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6DFE933AEB;
	Sat, 31 Aug 2013 03:49:54 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BD98733AEA;
	Sat, 31 Aug 2013 03:49:53 +0000 (UTC)
In-Reply-To: <1377899810-1818-5-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Fri, 30 Aug 2013 16:56:48 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 65231670-11F0-11E3-A51F-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233497>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  builtin/reset.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/reset.c b/builtin/reset.c
> index 225e3f1..7e65934 100644
> --- a/builtin/reset.c
> +++ b/builtin/reset.c
> @@ -323,7 +323,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
>  		die_if_unmerged_cache(reset_type);
>  
>  	if (reset_type != SOFT) {
> -		struct lock_file *lock = xcalloc(1, sizeof(struct lock_file));
> +		struct lock_file *lock = xcalloc(1, sizeof(*lock));

Good.  Thanks.

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/git: add missing info about --git-dir
 command-line option
Date: Wed, 12 Dec 2012 11:35:38 -0800
Message-ID: <7vmwxj3vxx.fsf@alter.siamese.dyndns.org>
References: <50C8B92F.8020408@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Manlio Perillo <manlio.perillo@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 12 20:36:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tis63-0007Go-Bo
	for gcvg-git-2@plane.gmane.org; Wed, 12 Dec 2012 20:35:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754565Ab2LLTfm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2012 14:35:42 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39175 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754381Ab2LLTfl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2012 14:35:41 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1EB78AB2E;
	Wed, 12 Dec 2012 14:35:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WW7lxLOjLdOkg/VXQonrNd2u0ng=; b=VNA4vv
	rYVq16uvqszOEUEVOEukKq5dkcvFgO4JRZUNMn0RvqR0tngyVatRvMTwzfsk1Q7z
	dZ+2SPFcLtRdLwSmO7ETgouYD1tUMY0tHFplPfn42lsRllpH5rUkxX4fgb1tSLg0
	c+mcxdvJZ941K5L/oMk/AfjBk5AJS85dJXAkE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BQw61fEoSfZ1hjI+6jcoNyyIAt5JDbNf
	9fyeKa1Snj24hYwkz+Dy+q8FXfeWkJfwiKqkP3VsVvHlXObFf6nR23q2N4uIx+0C
	CpzPc5FFt16oM4K31WAHXcesIlO8hLeMBrHvn2fj0AhXGCa31LTs8Qj3MjnM6gfp
	ff/696ngGuQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0B26FAB2D;
	Wed, 12 Dec 2012 14:35:41 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6868EAB2A; Wed, 12 Dec 2012
 14:35:40 -0500 (EST)
In-Reply-To: <50C8B92F.8020408@gmail.com> (Manlio Perillo's message of "Wed,
 12 Dec 2012 18:04:47 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1C8C0F3C-4493-11E2-8BB4-995F2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211386>

Manlio Perillo <manlio.perillo@gmail.com> writes:

> The Documentation/git.txt file, in the GIT_DIR environment variable
> section, did not mentioned that this value can also be set using the
> --git-dir command line option.
> ---

s/mentioned/mention/; Also it may help to say

	Unlike other environment variables (e.g. GIT_WORK_TREE,
	GIT_NAMESPACE),

somewhere in the description.

Please sign-off your patch (see Documentation/SubmittingPatches).

Thanks.

>  Documentation/git.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/git.txt b/Documentation/git.txt
> index e643683..60db292 100644
> --- a/Documentation/git.txt
> +++ b/Documentation/git.txt
> @@ -650,6 +650,7 @@ git so take care if using Cogito etc.
>  	If the 'GIT_DIR' environment variable is set then it
>  	specifies a path to use instead of the default `.git`
>  	for the base of the repository.
> +	The '--git-dir' command-line option also sets this value.
>   'GIT_WORK_TREE'::
>  	Set the path to the working tree.  The value will not be

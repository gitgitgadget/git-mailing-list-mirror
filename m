From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Documentation/diff-options: reword description of
 --submodule option
Date: Wed, 14 Mar 2012 12:09:21 -0700
Message-ID: <7vzkbjov8e.fsf@alter.siamese.dyndns.org>
References: <1331744455-624-1-git-send-email-tim.henigan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Tim Henigan <tim.henigan@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 14 20:09:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7tZj-00066E-Bf
	for gcvg-git-2@plane.gmane.org; Wed, 14 Mar 2012 20:09:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761130Ab2CNTJ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Mar 2012 15:09:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50159 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760907Ab2CNTJY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2012 15:09:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8E2C76576;
	Wed, 14 Mar 2012 15:09:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=H7K5oFqfzrA+w07nmDaUAq7yW3E=; b=OOmOD5
	jQfVOXDGpDjcDez4Q9qL3Y6w2+xVDAG18bcBEjvZbwozBblEs4tNCj7Pq8uxiRfJ
	pJmEFOYJmFM4ERhH+Yc2vhvTApYuvONvakzDLshp5TWtSU5LGZyuv8yv3lBrSZlU
	MYyyBe5xhJ3lKW39LUbDgAkGskasdTvk5NEhY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aEBUybypmfCwbjiJh6kTwUXN8uf6oAVg
	vYEYwzR2nIXsR8G8V7rdkTXJmw6QYzlOKFvhgqc9zO6B18Qa4Bl/ZtEtEmUFhx/9
	A0sAJv38Ri3mRFwwJX0/CzcHuEtK0Yu+uEbmtV0QYtF/ax0OamKzhNVheIprTlH+
	KuYvYD7lDTM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 841886575;
	Wed, 14 Mar 2012 15:09:23 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 11D446567; Wed, 14 Mar 2012
 15:09:22 -0400 (EDT)
In-Reply-To: <1331744455-624-1-git-send-email-tim.henigan@gmail.com> (Tim
 Henigan's message of "Wed, 14 Mar 2012 13:00:55 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 35996CC4-6E09-11E1-ADF9-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193149>

Tim Henigan <tim.henigan@gmail.com> writes:

> The previous description was confusing.  This rewrite makes it easier
> to understand.
>
> Signed-off-by: Tim Henigan <tim.henigan@gmail.com>
> ---
>
> Changes in v2:
>   - v1 was a series of two patches. The first was a simple typo fix
>     (s/Chose/Choose/). v2 eliminates the first commit as it is no longer
>     needed.
>   - Changed wording again based on direction from Junio Hamano.
>   - Removed explanation of formats from the commit message. The diff
>     now adequately explains how they work.

Thanks for a credit, but I rarely if ever give "direction". I just mumble
my observations, and the readers realize improvements for themselves ;-)

I'll squash the "submodule summary" (as opposed to "submodule --summary")
fix Jens mentioned in the other thread and apply.

Thanks.

>  Documentation/diff-options.txt |   11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
> index 7d4566f..6aa0907 100644
> --- a/Documentation/diff-options.txt
> +++ b/Documentation/diff-options.txt
> @@ -165,11 +165,12 @@ any of those replacements occurred.
>  	of the `--diff-filter` option on what the status letters mean.
>  
>  --submodule[=<format>]::
> -	Chose the output format for submodule differences. <format> can be one of
> -	'short' and 'log'. 'short' just shows pairs of commit names, this format
> -	is used when this option is not given. 'log' is the default value for this
> -	option and lists the commits in that commit range like the 'summary'
> -	option of linkgit:git-submodule[1] does.
> +	Specify how differences in submodules are shown.  When `--submodule`
> +	or `--submodule=log` is given, the 'log' format is used.  This format lists
> +	the commits in the range like linkgit:git-submodule[1] `--summary` does.
> +	Omitting the `--submodule` option or specifying `--submodule=short`,
> +	uses the 'short' format. This format just shows the names of the commits
> +	at the beginning and end of the range.
>  
>  --color[=<when>]::
>  	Show colored diff.

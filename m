From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] gitignore.txt: fix documentation of "**" patterns
Date: Thu, 07 Nov 2013 10:50:41 -0800
Message-ID: <xmqqeh6s59mm.fsf@gitster.dls.corp.google.com>
References: <527BC00D.8000501@gmail.com> <527BC037.2000106@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Duy Nguyen <pclouds@gmail.com>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 07 19:51:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VeUfY-0003qj-6v
	for gcvg-git-2@plane.gmane.org; Thu, 07 Nov 2013 19:51:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751083Ab3KGSur (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Nov 2013 13:50:47 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34544 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750939Ab3KGSuq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Nov 2013 13:50:46 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 16C804E478;
	Thu,  7 Nov 2013 13:50:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RdLPYrgzrPLMV3TnEF3vVWkvy7w=; b=yJiMgj
	OlxDuLKRjYCrhiM0+vxnhUFd/EceGGBUGt9nuiYXZL5GFg/ivJ8O26/cwrxRZCAy
	0N1C+0yyj9YX/9C9bZaTmUq/ptSLCwr/4yBb6ELkjPWzLHAeHvdp7/ughxOdlc92
	6lqRXXum0aByd8zAthukeuqAz4sh0U49z0q+w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oTNrprV0CTytEe9VUxEdCeBruDhoQ6HP
	K9WI6EhaY6r1qzncJXCLh0qIKvnXXN80Nc/wqPcbAQkb/2FYGk4HO4HL9qqDhnTC
	LFanvQYnSD6MlwmjjsXCubHqbgmS/+78EcESIjGbY5y4da+G0sJq7jh7UV/fQoBc
	K2yOUe4+yn8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 083104E477;
	Thu,  7 Nov 2013 13:50:46 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5906E4E475;
	Thu,  7 Nov 2013 13:50:45 -0500 (EST)
In-Reply-To: <527BC037.2000106@gmail.com> (Karsten Blees's message of "Thu, 07
	Nov 2013 17:30:47 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 827B9DA0-47DD-11E3-9E2A-1FFB7F2839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237422>

Karsten Blees <karsten.blees@gmail.com> writes:

> "**" means bold in ASCIIDOC, so we need to escape it.
>
> Signed-off-by: Karsten Blees <blees@dcon.de>
> ---
>  Documentation/gitignore.txt | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
> index 54e334e..f971960 100644
> --- a/Documentation/gitignore.txt
> +++ b/Documentation/gitignore.txt
> @@ -113,12 +113,12 @@ full pathname may have special meaning:
>  
>   - A leading "`**`" followed by a slash means match in all
>     directories. For example, "`**/foo`" matches file or directory
> -   "`foo`" anywhere, the same as pattern "`foo`". "**/foo/bar"
> +   "`foo`" anywhere, the same as pattern "`foo`". "`**/foo/bar`"
>     matches file or directory "`bar`" anywhere that is directly
>     under directory "`foo`".
>  
> - - A trailing "/**" matches everything inside. For example,
> -   "abc/**" matches all files inside directory "abc", relative
> + - A trailing "`/**`" matches everything inside. For example,
> +   "`abc/**`" matches all files inside directory "`abc`", relative
>     to the location of the `.gitignore` file, with infinite depth.

All, including the quoting of `abc` that does not have anything to
do with the double-asterisk, look good; thanks.

>  
>   - A slash followed by two consecutive asterisks then a slash

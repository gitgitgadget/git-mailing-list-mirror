From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 05/11] Fix some typos and improve wording
Date: Tue, 27 Aug 2013 12:07:59 -0700
Message-ID: <xmqqk3j7c5ps.fsf@gitster.dls.corp.google.com>
References: <1403569571.34349.1377625974290.JavaMail.ngmail@webmail19.arcor-online.net>
	<70864071.34489.1377626361141.JavaMail.ngmail@webmail19.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, martinvonz@gmail.com, jrnieder@gmail.com,
	wking@tremily.us, philipoakley@iee.org
To: Thomas Ackermann <th.acker@arcor.de>
X-From: git-owner@vger.kernel.org Tue Aug 27 21:08:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEOca-0000bW-U4
	for gcvg-git-2@plane.gmane.org; Tue, 27 Aug 2013 21:08:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752788Ab3H0TIE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Aug 2013 15:08:04 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39583 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752602Ab3H0TID (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Aug 2013 15:08:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8C1E63CA8A;
	Tue, 27 Aug 2013 19:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JRhDteul88HSbB7r/NeGBQOD2z4=; b=GUU8g6
	Tzh93YtOscF1LK41dm9TQ1UlPFGFDsrdifXLAwaz0WlVJYkF+pww6oWIiLdSDxMd
	HYgF5F6aFXtmSBQGu4gI4zSrXaWKK/wnrmlSqULi8FI75MwieZXVbZxSZOGAotda
	7aZL2KV5MG4f8fhBU18kC8/9EWK4pJDNNdgs0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AlRjSXl/YMLbrVTweBx+VrhOEzesH6uZ
	zBstvmBIpgDEJO4XqTkeNf7DKqbKLjbfadv5/bvj6Tf7XDaLUShYc3RI7RaE7ur1
	k9wnfwrr28mGaR7G7GReEWz1MH6popWaV/nToCF57O9NDRVG/X1uLCrY7F/uc1c1
	o9zwa5VClDQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7F6D43CA89;
	Tue, 27 Aug 2013 19:08:02 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9966E3CA85;
	Tue, 27 Aug 2013 19:08:01 +0000 (UTC)
In-Reply-To: <70864071.34489.1377626361141.JavaMail.ngmail@webmail19.arcor-online.net>
	(Thomas Ackermann's message of "Tue, 27 Aug 2013 19:59:21 +0200
	(CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: FE71BD24-0F4B-11E3-97A8-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233137>

Thomas Ackermann <th.acker@arcor.de> writes:

> Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
> ---
>  Documentation/user-manual.txt | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
> index 6241a43..465d9cb 100644
> --- a/Documentation/user-manual.txt
> +++ b/Documentation/user-manual.txt
> @@ -219,7 +219,7 @@ of development leading to that point.
>  
>  The best way to see how this works is using the linkgit:gitk[1]
>  command; running gitk now on a Git repository and looking for merge
> -commits will help understand how the Git organizes history.
> +commits will help understand how Git organizes history.
>  
>  In the following, we say that commit X is "reachable" from commit Y
>  if commit X is an ancestor of commit Y.  Equivalently, you could say
> @@ -793,7 +793,7 @@ e05db0fd4f31dde7005f075a84f96b360d05984b
>  -------------------------------------------------
>  
>  Or you could recall that the `...` operator selects all commits
> -contained reachable from either one reference or the other but not
> +reachable from either one reference or the other but not
>  both; so
>  
>  -------------------------------------------------
> @@ -820,7 +820,7 @@ You could just visually inspect the commits since e05db0fd:
>  $ gitk e05db0fd..
>  -------------------------------------------------
>  
> -Or you can use linkgit:git-name-rev[1], which will give the commit a
> +or you can use linkgit:git-name-rev[1], which will give the commit a

I think I agree with Jonathan that this reads better with "Or", not
"or".

Other than that looks good to me.  Thanks.

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Grammar fixes to "merge" and "patch-id" docs
Date: Wed, 25 Mar 2009 11:33:52 -0700
Message-ID: <7vocvp310v.fsf@gitster.siamese.dyndns.org>
References: <1238005422-7647-1-git-send-email-win@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Wed Mar 25 19:35:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmXwm-0007tr-DE
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 19:35:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753592AbZCYSeC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 14:34:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752327AbZCYSeB
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 14:34:01 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40736 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751313AbZCYSeA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2009 14:34:00 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6C120A5E5A;
	Wed, 25 Mar 2009 14:33:57 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 2A65AA5E56; Wed,
 25 Mar 2009 14:33:53 -0400 (EDT)
In-Reply-To: <1238005422-7647-1-git-send-email-win@wincent.com> (Wincent
 Colaiuta's message of "Wed, 25 Mar 2009 19:23:42 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8067AC02-196B-11DE-8A79-32B0EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114641>

Wincent Colaiuta <win@wincent.com> writes:

>  If you tried a merge which resulted in a complex conflicts and
> -would want to start over, you can recover with 'git-reset'.
> +want to start over, you can recover with 'git-reset'.

Reads Ok to me either way...

> diff --git a/Documentation/merge-strategies.txt b/Documentation/merge-strategies.txt
> index 1276f85..ee7f754 100644
> --- a/Documentation/merge-strategies.txt
> +++ b/Documentation/merge-strategies.txt
> @@ -3,15 +3,15 @@ MERGE STRATEGIES
>  
>  resolve::
>  	This can only resolve two heads (i.e. the current branch
> -	and another branch you pulled from) using 3-way merge
> +	and another branch you pulled from) using a 3-way merge
>  	algorithm.  It tries to carefully detect criss-cross

Hmph, would that be an 'a' or 'the'?

>  recursive::
> -	This can only resolve two heads using 3-way merge
> -	algorithm.  When there are more than one common
> -	ancestors that can be used for 3-way merge, it creates a
> +	This can only resolve two heads using a 3-way merge
> +	algorithm.  When there is more than one common
> +	ancestor that can be used for 3-way merge, it creates a

Do you need an article before the latter "3-way merge", perhaps "the"?

> @@ -22,11 +22,11 @@ recursive::
>  	pulling or merging one branch.
>  
>  octopus::
> -	This resolves more than two-head case, but refuses to do
> -	complex merge that needs manual resolution.  It is
> +	This resolves the more than two-heads case, but refuses to do
> +	a complex merge that needs manual resolution.  It is

Perhaps "resolves cases with more than two heads" is easier to read?

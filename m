From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Doc: 'replace' merge and non-merge commits
Date: Mon, 09 Sep 2013 08:17:50 -0700
Message-ID: <xmqqwqmp1u7y.fsf@gitster.dls.corp.google.com>
References: <xmqqob86g8v4.fsf@gitster.dls.corp.google.com>
	<1378642244-3572-1-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GitList <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@inf.ethz.ch>, Johannes Sixt <j6t@kdbg.org>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Tue Sep 10 00:55:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJAMS-0004YB-3p
	for gcvg-git-2@plane.gmane.org; Tue, 10 Sep 2013 00:55:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755989Ab3IIWzE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Sep 2013 18:55:04 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54572 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755836Ab3IIWzC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Sep 2013 18:55:02 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4A935402FE;
	Mon,  9 Sep 2013 22:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=dqOltjPNqmaDQa3vC4HBm32sGxo=; b=EEZvZWA7Vh+5Px5WOAfq
	dBsaGIOFQdk65ZPdlgz8Ax1agyV67ZC9QwxAOVhYosxP3Z9Gjb+fTuqz26erldxC
	oVheSHtJJJIsF66yVFEJiYVLJXu/NqZrALPbqSvbRoEEKkZqGIz+A9T/Wk0OfGN9
	5idwgeUWIvPvZSZwJl83rsQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=STuK510Tisn12D5tiwnFm1Kubje7CEuEINHW6b9RBtaqzo
	0yFh/ebUvmr5zpunres/oqQYOM+eUDZnEJtK3+vGe57DQkHxgRZkSL0s2qfkUP/K
	c7XmKxdvWE6blQg1E4KT2pgWTX+6YvnVkg/wB5DVYCbRisr0/fXWLUQA3LgV8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 47BF2402F6;
	Mon,  9 Sep 2013 22:55:01 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 827D3402EC;
	Mon,  9 Sep 2013 22:54:59 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: DAADA1DA-19A2-11E3-B0EB-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234392>

Philip Oakley <philipoakley@iee.org> writes:

> Merges are often treated as special case objects so tell users that
> they are not special here.
>
> Signed-off-by: Philip Oakley <philipoakley@iee.org>
> ---
>
> This updates my in-line patch given in [PATCH v3 07/11]
> Documentation/replace: tell that -f option bypasses the type check
> ($gmane/233997 05 September 2013 23:20) and Junio's comments
> ($gmane/234001 06 September 2013 00:13) 
>
> Applies on top of pu and Christian Couder's series.

Thanks, looks good.

>
> Philip
>
> ---
>  Documentation/git-replace.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/git-replace.txt b/Documentation/git-replace.txt
> index 414000e..f373ab4 100644
> --- a/Documentation/git-replace.txt
> +++ b/Documentation/git-replace.txt
> @@ -26,6 +26,7 @@ This restriction can be bypassed using `-f`.
>  Unless `-f` is given, the 'replace' reference must not yet exist.
>  
>  There is no other restriction on the replaced and replacement objects.
> +Merge commits can be replaced by non-merge commits and vice versa.
>  
>  Replacement references will be used by default by all Git commands
>  except those doing reachability traversal (prune, pack transfer and

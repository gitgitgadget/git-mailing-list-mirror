From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/git-rebase: clarify -s option
Date: Fri, 12 Nov 2010 17:59:58 -0800
Message-ID: <7vtyjmdlup.fsf@alter.siamese.dyndns.org>
References: <1289588269-6920-1-git-send-email-martin.von.zweigbergk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jrnieder@gmail.com
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 13 03:00:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PH5Pg-0007c3-Us
	for gcvg-git-2@lo.gmane.org; Sat, 13 Nov 2010 03:00:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753290Ab0KMCAM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Nov 2010 21:00:12 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:61958 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753665Ab0KMCAL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Nov 2010 21:00:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E57693596;
	Fri, 12 Nov 2010 21:00:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KmDIUwgMbhSZW2KT5rJw4Q7CkHU=; b=VRERTA
	PfToYAGWfTL+ShdAkkYQQo0ngubPXzED8GTs3Rs7WWwQv5byanPjMTi1MU6HWS90
	Lw8zi5vQlB8Vx0fTs9dtcMfDcfjdKWlyAZ5PAb+vkMvHsI2jVSbfq1hu21TVoGDP
	ePgH1KI314Vz97PvKHesytURZFpKf6XMksIHU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=x/Ks7mjQNur4XiBTVp5GifIhfCy72ptf
	NAmU5zOoGXICEXI6Q7GMRIz7PK1yRdVu3qeu3C5todG9VGSZUcRSqQjB2kJTrqIq
	Y7nKn/NAEe7357g5uGzbTsmxO5oaFBGJwsWV4dmH+QP2FjVbMwPllpNn4HUXCPBA
	CGcIvlEWwoM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B7A843591;
	Fri, 12 Nov 2010 21:00:12 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 15168356E; Fri, 12 Nov 2010
 21:00:06 -0500 (EST)
In-Reply-To: <1289588269-6920-1-git-send-email-martin.von.zweigbergk@gmail.com> (Martin
 von Zweigbergk's message of "Fri\, 12 Nov 2010 19\:57\:49 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C0569DB6-EEC9-11DF-B560-B53272ABC92C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161380>

Martin von Zweigbergk <martin.von.zweigbergk@gmail.com> writes:

> Clarify that it is '-s' itself that implies '--merge'. Currently it may
> seem like '--merge' is implied "If there is no `-s` option".
>
> Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
> ---
>  Documentation/git-rebase.txt |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index 30e5c0e..f3753a8 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -244,9 +244,9 @@ other words, the sides are swapped.
>  
>  -s <strategy>::
>  --strategy=<strategy>::
> -	Use the given merge strategy.
> +	Use the given merge strategy.  This implies --merge.
>  	If there is no `-s` option 'git merge-recursive' is used
> -	instead.  This implies --merge.
> +	instead.

The first change is absolutely right---thanks for starting this.  However,
"if there is no `-s`..." describes the default when `--merge` alone is
given, so these last two lines may need to move elsewhere, no?

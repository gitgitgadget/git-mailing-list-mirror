From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/6] CodingGuidelines: mention whitespace preferences for
 shell scripts
Date: Mon, 29 Nov 2010 16:30:17 -0800
Message-ID: <7vy68by7om.fsf@alter.siamese.dyndns.org>
References: <1291042075-19983-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1291042075-19983-2-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 30 01:30:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNE78-0000su-EX
	for gcvg-git-2@lo.gmane.org; Tue, 30 Nov 2010 01:30:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755187Ab0K3Aa3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Nov 2010 19:30:29 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:41881 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754391Ab0K3Aa2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Nov 2010 19:30:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CC95038D8;
	Mon, 29 Nov 2010 19:30:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ayjQnnr0uAauS+MykEi86VpYINc=; b=gXKYxr
	rdsRYRTnr7xtNzsMTE2pJkyw1NGLNCGnZJIh1f46TdOyi46uu4KDDXgvLKtvvMv8
	+dEegQwgIMlQ+6PToXnFKLiFLRUFsQMMbmUY/O2p8pOKI4x97t8TmuPzBVZFw0jR
	s6uVjVwEWtO2FZ86xe3UwpaZThr61RBFtlJhA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=udC5dBQQwgW1LO7+6k1nBw2epQXWtLeE
	iMADX8byAMVAdZs2v/kawtilyvmWBPP7btIi3toumjM+wioFGhoIQAQF4Jl7anNK
	NH2855YUA7AQkQkiWT5MI4AiEx0tag/VX2ZbqGKn8yJXydVL2Pzi/8LeonIionnI
	PtdefJTZgq4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id ABA0338D7;
	Mon, 29 Nov 2010 19:30:41 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id A06AC38D6; Mon, 29 Nov 2010
 19:30:38 -0500 (EST)
In-Reply-To: <1291042075-19983-2-git-send-email-giuseppe.bilotta@gmail.com>
 (Giuseppe Bilotta's message of "Mon\, 29 Nov 2010 15\:47\:50 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0FF62C18-FC19-11DF-B812-CDEAE6EC64FC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162454>

Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:

> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
> ---
>  Documentation/CodingGuidelines |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
>
> diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
> index 5aa2d34..7ecce51 100644
> --- a/Documentation/CodingGuidelines
> +++ b/Documentation/CodingGuidelines
> @@ -31,6 +31,12 @@ But if you must have a list of rules, here they are.
>  
>  For shell scripts specifically (not exhaustive):
>  
> + - We use tabs for indentation.

Ok.

> + - The choices in case ... esac statement are not indented with respect
> +   to the the case and esac lines. The body of the choices however _is_
> +   indented (by one tab).
> +

Nit; "choices" are called "case arms".

I don't think there is any need to emphasize your surprise that case body
is indented with "however _is_", which implies "against common sense or
normal convention" or somesuch.  The thing is, there is no single _right_
convention, and we want people to folow the one just picked---we should
just describe what it is without being emotional nor emphatic.

Thanks.

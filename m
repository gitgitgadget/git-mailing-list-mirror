From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] sha1_name.c: update comment to mention :/foo syntax
Date: Tue, 21 Sep 2010 11:02:31 -0700
Message-ID: <7v62xzug94.fsf@alter.siamese.dyndns.org>
References: <7ab60e32582447ad792602ff405dcee464ef1414.1284830388.git.kirr@landau.phys.spbu.ru> <1285016477-22222-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Tue Sep 21 20:02:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oy7Ay-0000iY-IV
	for gcvg-git-2@lo.gmane.org; Tue, 21 Sep 2010 20:02:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755643Ab0IUSCi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Sep 2010 14:02:38 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:52328 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754149Ab0IUSCi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Sep 2010 14:02:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C4ECCD7E92;
	Tue, 21 Sep 2010 14:02:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=exevTgGULMTrRI/ZqXXu1dyJYrY=; b=VzgIGu
	XN98Ha5Xu4Rogv0UwcrYbI0TgB0GyDp0a7+D3hTDNezmnir89wiC7yWnZaXFg7b2
	Huc9icwQq+nbRueTN/7P1hEA7Ooisb75TEfecFkvBi489xvTATKDHxEmWeSR1ReD
	pJ3ri3Rziuqyi+z/+dpcuC0iDs80+nH4LURpU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yM+IwCsfTxW6hQnHRqSVXm4PYEPiJPQA
	N3A/AVZv01cmoWNF571jhrhVS+DZTjExUIztCV/+kVk27mBeMC4ZRKGYarYxn1fP
	7y3WR1UNsWJ9C5YWq4hRz/FC+8vKOEVIpHnLC9Fra84Geh9//F4XHEZDN2LLJR5I
	PnUOAFTdFQs=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 98E17D7E8F;
	Tue, 21 Sep 2010 14:02:35 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6E39BD7E89; Tue, 21 Sep
 2010 14:02:32 -0400 (EDT)
In-Reply-To: <1285016477-22222-1-git-send-email-Matthieu.Moy@imag.fr>
 (Matthieu Moy's message of "Mon\, 20 Sep 2010 23\:01\:17 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 69DE4A8A-C5AA-11DF-AA5A-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156737>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
> Noticed while reviewing the patch serie about textconv and symlinks.
> If we have comments, better have them up-to-date ;-).
>
>  sha1_name.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/sha1_name.c b/sha1_name.c
> index 7b7e617..d7ab72a 100644
> --- a/sha1_name.c
> +++ b/sha1_name.c
> @@ -1062,6 +1062,7 @@ int get_sha1_with_context_1(const char *name, unsigned char *sha1,
>  	/* sha1:path --> object name of path in ent sha1
>  	 * :path -> object name of path in index
>  	 * :[0-3]:path -> object name of path in index at stage
> +	 * :/foo -> last commit whose subject starts with foo

Documenting what hasn't been is a good thing, but is it really up-to-date?

Isn't it "a randomly chosen recent commit whose subject contains regexp
foo" these days?

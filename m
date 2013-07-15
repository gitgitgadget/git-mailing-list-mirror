From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/5] Documentation/git-show.txt: include common diff options, like git-log.txt
Date: Mon, 15 Jul 2013 07:54:18 -0700
Message-ID: <7va9lneuw5.fsf@alter.siamese.dyndns.org>
References: <vpqa9lof2e4.fsf@anie.imag.fr>
	<1373893639-13413-1-git-send-email-Matthieu.Moy@imag.fr>
	<1373893639-13413-4-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, stefanbeller@googlemail.com
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Jul 15 16:54:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UykAU-0007EF-ON
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jul 2013 16:54:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932097Ab3GOOyW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jul 2013 10:54:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63793 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932133Ab3GOOyV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jul 2013 10:54:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A336C3045F;
	Mon, 15 Jul 2013 14:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=41W9z3WEejeRw9IrPXwDkUWK1W4=; b=dxTIlN
	a+tFHoUD72NlcXqM8JxM5+WWK+YpQCoXFd+3A2PdXeb+RNIQ/k2/ArSYUZkqoyzr
	YOEfmSsWScvM8RDtbhSnB33DDHuGISHz5vou7taS9DS1sH6z7PkrMOdsBxE9CGl/
	SWTw7+6CMGNQt3Oc/D05GTyDimTS9/uB7T1Bs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=j5O2GVwsRUeTYVjR7eNC5R4oAZhBJDp4
	XB+zhJjAlS718jJUQJ7bS7PxFZnoXhKMObXKbZY1MOlag7eJgSODJjDDKB2qFrXx
	oSxV+xKtL/JQ96+8rj8/7SOeJsIbquZVJ4a6bsXgBTu7kQZOOqCzMD/PVbdo904m
	K9yloXn9uTc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 983953045D;
	Mon, 15 Jul 2013 14:54:20 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E7D1F30458;
	Mon, 15 Jul 2013 14:54:19 +0000 (UTC)
In-Reply-To: <1373893639-13413-4-git-send-email-Matthieu.Moy@imag.fr>
	(Matthieu Moy's message of "Mon, 15 Jul 2013 15:07:17 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6DCFE8F4-ED5E-11E2-BFB7-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230473>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
>  Documentation/git-show.txt | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/Documentation/git-show.txt b/Documentation/git-show.txt
> index ae4edcc..4e617e6 100644
> --- a/Documentation/git-show.txt
> +++ b/Documentation/git-show.txt
> @@ -45,6 +45,15 @@ include::pretty-options.txt[]
>  include::pretty-formats.txt[]
>  
>  
> +COMMON DIFF OPTIONS
> +-------------------
> +
> +:git-log: 1
> +include::diff-options.txt[]
> +
> +include::diff-generate-patch.txt[]
> +
> +
>  EXAMPLES
>  --------

This is a good start; the output should match what you would get for
git-log(1) with the above.

But we would need to say, unlike "log" whose default is not to show
any patch, "show" that works on a commit defaults to "--cc"
somewhere.

Other than that the whole series looks sensible to me.  Thanks.

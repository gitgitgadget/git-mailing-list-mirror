From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Documentation: fix git-prune example usage
Date: Thu, 18 Jul 2013 10:55:27 -0700
Message-ID: <7vr4ev3g8g.fsf@alter.siamese.dyndns.org>
References: <19D1767A-4C36-4A89-A9BB-9FED33289CD9@JonathonMah.com>
	<E676323F-CEDD-4072-B4FF-737143354401@JonathonMah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Jonathon Mah <me@JonathonMah.com>
X-From: git-owner@vger.kernel.org Thu Jul 18 19:55:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzsQR-0001es-1o
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jul 2013 19:55:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759303Ab3GRRzb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jul 2013 13:55:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52083 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759072Ab3GRRza (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jul 2013 13:55:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D029C31321;
	Thu, 18 Jul 2013 17:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BxYzJjR9cNSu4i+F/rejen8WWdo=; b=mq84bF
	NqHdVIiENnmf140qNOdRqOs6CQEOeHJPQYywgO+H8hrmnjtEZ44AYrL/oVfW96Va
	PlRSDd2/lSTHama/BX9BVGLVkLJ5f1x5lKZ3sVOFgPe6y8hcQ9nY4kRRivBpOboz
	SlChjm6Ca5xc/ueAryh07ODi0WhJpcm6WtJmE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AZp5f20LLAZYUOjx2NNgNJFw4DX0lOAu
	PLYmB7jrI5BvvOlJVfPIQB2GBfuQTVfwff3CxRJa1oEDFvWMKKGd0dywWLS6LSUh
	F/eQXN7X4omZuG3nrT+Mtp/LYBLjVGWofZe6swpw/L27Q817d4pnAZUefKQt6HEB
	GkcxLdrtYis=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C785231320;
	Thu, 18 Jul 2013 17:55:29 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2A94A3131F;
	Thu, 18 Jul 2013 17:55:29 +0000 (UTC)
In-Reply-To: <E676323F-CEDD-4072-B4FF-737143354401@JonathonMah.com> (Jonathon
	Mah's message of "Thu, 18 Jul 2013 00:12:35 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3B9D2168-EFD3-11E2-99A8-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230717>

Jonathon Mah <me@JonathonMah.com> writes:

> ---
>  Documentation/git-prune.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks.  Can we have your sign-off?

>
> diff --git a/Documentation/git-prune.txt b/Documentation/git-prune.txt
> index 80d01b0..bf82410 100644
> --- a/Documentation/git-prune.txt
> +++ b/Documentation/git-prune.txt
> @@ -59,7 +59,7 @@ borrows from your repository via its
>  `.git/objects/info/alternates`:
>  
>  ------------
> -$ git prune $(cd ../another && $(git rev-parse --all))
> +$ git prune $(cd ../another && git rev-parse --all)
>  ------------
>  
>  Notes

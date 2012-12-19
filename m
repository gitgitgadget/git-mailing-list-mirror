From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Remove duplicate entry in ./Documentation/Makefile
Date: Wed, 19 Dec 2012 10:22:23 -0800
Message-ID: <7vd2y5aom8.fsf@alter.siamese.dyndns.org>
References: <1674037566.22743.1355940925216.JavaMail.ngmail@webmail07.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thomas Ackermann <th.acker@arcor.de>
X-From: git-owner@vger.kernel.org Wed Dec 19 19:22:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TlOI0-0005Ck-C4
	for gcvg-git-2@plane.gmane.org; Wed, 19 Dec 2012 19:22:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752206Ab2LSSW1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2012 13:22:27 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52111 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751303Ab2LSSW0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2012 13:22:26 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6ABAFAE8F;
	Wed, 19 Dec 2012 13:22:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IaGLRjEmX2xv3JrDVsuJ5Yx26QA=; b=u0baEg
	XsZG1KV9eUbYsMXBQHZ/ntj6AkoA6zMdpzADEDS99c3Tb1gs9TJ9R0tn0CCgTzsq
	4gJofw1Comm/KxTRttd+dOkrmCyuJU1oDbqnJlaD3wcBP1Z5wrP4+6bf/qso/qRr
	/JktXrxKe3a9NMkLUrDbHHMYPZu0Z4ytGIilk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UATpcWF0FdpGHI/rrdUqehK8s3GRnU09
	XnLq/Q89Kj0Gf+7HHfqBzL4ElGyYDgn0tYAUkgTd0iNfnA3WRrinwbyM5SJWaxK/
	oNpwxdy6wnZicJdny4bGdHuO5hN6lDz2Bu3seMRI4VhLUL2cdMECJBcCKOWpDxlq
	9WpRKlezrCU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5643BAE8D;
	Wed, 19 Dec 2012 13:22:25 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B19DDAE82; Wed, 19 Dec 2012
 13:22:24 -0500 (EST)
In-Reply-To: <1674037566.22743.1355940925216.JavaMail.ngmail@webmail07.arcor-online.net>
 (Thomas Ackermann's message of "Wed, 19 Dec 2012 19:15:25 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 09658548-4A09-11E2-9172-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211839>

Thomas Ackermann <th.acker@arcor.de> writes:

> Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
> ---
>  Documentation/Makefile | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index 3615504..7df75d0 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -31,7 +31,6 @@ SP_ARTICLES += howto/separating-topic-branches
>  SP_ARTICLES += howto/revert-a-faulty-merge
>  SP_ARTICLES += howto/recover-corrupted-blob-object
>  SP_ARTICLES += howto/rebuild-from-update-hook
> -SP_ARTICLES += howto/rebuild-from-update-hook

Heh, good eyes.  How did you spot it?

If not by eyeballing but with some mechanical process, did you spot
any others?

>  SP_ARTICLES += howto/rebase-from-internal-branch
>  SP_ARTICLES += howto/maintain-git
>  API_DOCS = $(patsubst %.txt,%,$(filter-out technical/api-index-skel.txt technical/api-index.txt, $(wildcard technical/api-*.txt)))

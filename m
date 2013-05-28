From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] remote-helpers: rename tests
Date: Tue, 28 May 2013 13:05:48 -0700
Message-ID: <7vmwrezx7n.fsf@alter.siamese.dyndns.org>
References: <1369449507-18269-1-git-send-email-felipe.contreras@gmail.com>
	<1369449507-18269-3-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	David Aguilar <davvid@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 28 22:05:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhQ9b-0007CH-VL
	for gcvg-git-2@plane.gmane.org; Tue, 28 May 2013 22:05:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755332Ab3E1UFv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 May 2013 16:05:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54552 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755033Ab3E1UFv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 May 2013 16:05:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 40BA2225CC;
	Tue, 28 May 2013 20:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=+GlSa1LQYLttjlY6g18Kr2qEb5c=; b=hOkWguQa1FAtxQ/+QzCQ
	+NLzyjEWgivj5mqJAQ3psNV+gj5otTPskuRERttHkjuu7S9N9XSqGY7/UFL1Rasj
	GTlTpI8Z7edi7KcW+4fiZyOvTEqzZ1svPF7qj7CFLaNLuw5u/RkigBTPX/shdTIC
	2EbWej41sS/jlVvQexWQTSw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=LiA2piFDmhuNI8fclTg/f58MUTVnKWIQoltzS0UpGpkn2W
	JTlovpFuRYiBht87mrBRCfGf32d9l8eMuPzkH54kqIWK5OfNh3KgaZa+Dnw9PSaM
	+3XSzrszrdpTCYZeo6uc8/xr/jE/2NlIJuETFqEcS3syVZ4B6vTkUWFcpE2Nk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 31E52225CA;
	Tue, 28 May 2013 20:05:50 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8DA5E225C6;
	Tue, 28 May 2013 20:05:49 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FDDF34F2-C7D1-11E2-86B9-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225683>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> The .t extension is more standard for sharness tests.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---

Is that "sharness" test the sh script testsuite forked from our
testsuite?

I do not see how it makes sense to copy how they deviate from us
back to our codebase, especially if we plan to eventually move some
of these tests out of contrib/ area, but even without such a plan in
the future.



>  contrib/remote-helpers/Makefile                                | 2 +-
>  contrib/remote-helpers/{test-bzr.sh => test-bzr.t}             | 0
>  contrib/remote-helpers/{test-hg-bidi.sh => test-hg-bidi.t}     | 0
>  contrib/remote-helpers/{test-hg-hg-git.sh => test-hg-hg-git.t} | 0
>  contrib/remote-helpers/{test-hg.sh => test-hg.t}               | 0
>  5 files changed, 1 insertion(+), 1 deletion(-)
>  rename contrib/remote-helpers/{test-bzr.sh => test-bzr.t} (100%)
>  rename contrib/remote-helpers/{test-hg-bidi.sh => test-hg-bidi.t} (100%)
>  rename contrib/remote-helpers/{test-hg-hg-git.sh => test-hg-hg-git.t} (100%)
>  rename contrib/remote-helpers/{test-hg.sh => test-hg.t} (100%)
>
> diff --git a/contrib/remote-helpers/Makefile b/contrib/remote-helpers/Makefile
> index d9b3515..2c91ec6 100644
> --- a/contrib/remote-helpers/Makefile
> +++ b/contrib/remote-helpers/Makefile
> @@ -1,4 +1,4 @@
> -TESTS := $(wildcard test*.sh)
> +TESTS := $(wildcard test-*.t)
>  SCRIPTS := $(wildcard git-remote-*.py)
>  
>  export T := $(addprefix $(CURDIR)/,$(TESTS))
> diff --git a/contrib/remote-helpers/test-bzr.sh b/contrib/remote-helpers/test-bzr.t
> similarity index 100%
> rename from contrib/remote-helpers/test-bzr.sh
> rename to contrib/remote-helpers/test-bzr.t
> diff --git a/contrib/remote-helpers/test-hg-bidi.sh b/contrib/remote-helpers/test-hg-bidi.t
> similarity index 100%
> rename from contrib/remote-helpers/test-hg-bidi.sh
> rename to contrib/remote-helpers/test-hg-bidi.t
> diff --git a/contrib/remote-helpers/test-hg-hg-git.sh b/contrib/remote-helpers/test-hg-hg-git.t
> similarity index 100%
> rename from contrib/remote-helpers/test-hg-hg-git.sh
> rename to contrib/remote-helpers/test-hg-hg-git.t
> diff --git a/contrib/remote-helpers/test-hg.sh b/contrib/remote-helpers/test-hg.t
> similarity index 100%
> rename from contrib/remote-helpers/test-hg.sh
> rename to contrib/remote-helpers/test-hg.t

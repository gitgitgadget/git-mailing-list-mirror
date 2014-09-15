From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Makefile: fix some typos in the preamble
Date: Mon, 15 Sep 2014 11:58:14 -0700
Message-ID: <xmqqd2aw7ltl.fsf@gitster.dls.corp.google.com>
References: <CAD+ArX07pvmFKaCzy+dTcbga56U=fCgpPN-T3+QSudfFSVr=bQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ian Liu Rodrigues <ian.liu88@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 15 20:58:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTbTh-0005Nh-8m
	for gcvg-git-2@plane.gmane.org; Mon, 15 Sep 2014 20:58:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754139AbaIOS6R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2014 14:58:17 -0400
Received: from smtp.pobox.com ([208.72.237.35]:50903 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753478AbaIOS6R (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2014 14:58:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 70CFC39D1C;
	Mon, 15 Sep 2014 14:58:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=net6/hT3v9IHxysZGFV/3gGjLYg=; b=rqxWm4
	lMMjDSEXd7Voszq0tTSCSYRblQONGT58CC2BMZEEuqL78u2RAIwWMEsKgf2zqpyK
	kxTvHYEnQ9z/r60xbQU293cz2g46xS3rVeCze0GUVdkijhqxXpLl1I2Vt4Yp41zH
	so5/GBMpo5JiLSEooOgwOqqpo2DlfjKMQ4CKY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KTn+06Uk4rLbMfismA9XpTCLI5Es3Cyj
	dGKWaWQ2FWkO4lVtvYoYvNKuN1PhdJNkFqarQL5wSdPAbNuycBsiY2H16IJA1qpS
	enrY8ShKZnQlhJjFlv7A0cCUf6LXi5t3KAmC2GzEx7IL63G0qPmsIA4P6kJf0FzM
	fRkYX2MxyYw=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 652E239D1B;
	Mon, 15 Sep 2014 14:58:16 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id DFD0539D1A;
	Mon, 15 Sep 2014 14:58:15 -0400 (EDT)
In-Reply-To: <CAD+ArX07pvmFKaCzy+dTcbga56U=fCgpPN-T3+QSudfFSVr=bQ@mail.gmail.com>
	(Ian Liu Rodrigues's message of "Sat, 13 Sep 2014 11:20:22 -0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 3FEA67BE-3D0A-11E4-AD36-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257067>

Ian Liu Rodrigues <ian.liu88@gmail.com> writes:

> Signed-off-by: Ian Liu Rodrigues <ian.liu88@gmail.com>
> ---
>  Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 9f984a9..496af55 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -14,11 +14,11 @@ all::
>  # Define INLINE to a suitable substitute (such as '__inline' or '') if git
>  # fails to compile with errors about undefined inline functions or similar.
>  #
> -# Define SNPRINTF_RETURNS_BOGUS if your are on a system which snprintf()
> +# Define SNPRINTF_RETURNS_BOGUS if you are on a system which snprintf()
>  # or vsnprintf() return -1 instead of number of characters which would

The change is correct but I wonder if "which snprintf()" should be
"whose snprintf()".

>  # have been written to the final string if enough space had been available.
>  #
> -# Define FREAD_READS_DIRECTORIES if your are on a system which succeeds
> +# Define FREAD_READS_DIRECTORIES if you are on a system which succeeds
>  # when attempting to read from an fopen'ed directory.
>  #
>  # Define NO_OPENSSL environment variable if you do not have OpenSSL.

Thanks.

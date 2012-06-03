From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] api-credentials.txt: add "see also" section
Date: Sun, 03 Jun 2012 15:28:27 -0700
Message-ID: <7vsjecvxmc.fsf@alter.siamese.dyndns.org>
References: <1338739804-32167-1-git-send-email-Matthieu.Moy@imag.fr>
 <1338739804-32167-4-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Jun 04 00:28:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbJHl-0004I3-NK
	for gcvg-git-2@plane.gmane.org; Mon, 04 Jun 2012 00:28:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754966Ab2FCW2a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Jun 2012 18:28:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51713 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754905Ab2FCW23 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jun 2012 18:28:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 15DDC85D4;
	Sun,  3 Jun 2012 18:28:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=V/cWzxXCaeSXCgHBpJUxMbY7UGk=; b=Kv9HoB
	Rs8FGTQUJZ807IqJqe/MkM8Qn4kFGphExex60i9clKCtov/UImjj+9tJTnoO/YC0
	YM5XsJyhXp9UZ07nO7ksUn1LgRpCK1DD+wZ/OsiZpVumiv1k4M28Ele1stH+L/+b
	tTErrn2qwSGhSox2DFuP6wneBKh4vP8/6oId0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TfQnov2/vSfkFid96pURZ7WxJPGUTYyr
	vbsgL60kEAU4M/vn7jhzR1iN7bX691EHmdARyiq8mdsaJpPtFXiBSJwUoanP2cHk
	DCn7te23bRSNW3tOtPtIMIXSqFMtsB6G5YI/gEwP061bH7lp2vxvkTCvkBoYa21n
	5mUGiRGUbmM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0DED785D3;
	Sun,  3 Jun 2012 18:28:29 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4FEDA85D2; Sun,  3 Jun 2012
 18:28:28 -0400 (EDT)
In-Reply-To: <1338739804-32167-4-git-send-email-Matthieu.Moy@imag.fr>
 (Matthieu Moy's message of "Sun, 3 Jun 2012 18:10:04 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 70FC5036-ADCB-11E1-90CD-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199110>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> diff --git a/Documentation/technical/api-credentials.txt b/Documentation/technical/api-credentials.txt
> index 4561469..ac6be31 100644
> --- a/Documentation/technical/api-credentials.txt
> +++ b/Documentation/technical/api-credentials.txt
> @@ -288,3 +288,10 @@ request.
>  If a helper receives any other operation, it should silently ignore the
>  request. This leaves room for future operations to be added (older
>  helpers will just ignore the new requests).
> +
> +See also
> +--------
> +
> +linkgit:../gitcredentials[7]
> +
> +linkgit:../git-config[5] (See configuration variables `credential.*`)

Thanks.  All looked good.

This is the first one that refers to "../something" with "linkgit:";
do they format sensibly?

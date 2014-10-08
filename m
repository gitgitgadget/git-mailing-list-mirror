From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: fix misrender of pretty-formats in Asciidoctor
Date: Wed, 08 Oct 2014 13:53:42 -0700
Message-ID: <xmqqbnpm8eqx.fsf@gitster.dls.corp.google.com>
References: <CAMsgyKadiE-HOH_oLK=Fc0UQXnEuUTMHmz3=9zRiMvU0fr4KvA@mail.gmail.com>
	<1412801170-60741-1-git-send-email-sandals@crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Derek Moore <derek.p.moore@gmail.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Wed Oct 08 22:54:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XbyFS-0006TT-7G
	for gcvg-git-2@plane.gmane.org; Wed, 08 Oct 2014 22:54:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755018AbaJHUyJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Oct 2014 16:54:09 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:60697 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753783AbaJHUyI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Oct 2014 16:54:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5915C144BD;
	Wed,  8 Oct 2014 16:54:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Rav7c5EtdbD7BL8RO6Rs97kN3Hk=; b=tCBnbU
	fA5DePeZyBRNkEzYiHsK5xnw8XTpThUYu8koKMSaER+jbtTfMetXKEjYOufKOgOz
	9eqoaPd6g7demdKlAamaDoz8KWVJYk+YR4Bs4XU4Mh79UR37HfBwATlqJH/Uq4e5
	KlVGjgXSgzao4vJs/ZvczwEgPdmgxJWtpNF2E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=W7ju9pyJCHqpij1WEBnYI8neraFM9bqk
	m62ekjVA8j+iEuFVXUY091KEgs/ZM+ZVLpqh1h+XEim0avxU8jWKYiu0qJi0NYWi
	f1rUm27Chi1rLYJMhCu+7uzrFDommcB3EVHZE25UJHd00jJxxZ90QbE1hHJZL4hL
	xpavLoNla+Q=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4B3FD144BC;
	Wed,  8 Oct 2014 16:54:06 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EBB5E1449D;
	Wed,  8 Oct 2014 16:53:43 -0400 (EDT)
In-Reply-To: <1412801170-60741-1-git-send-email-sandals@crustytoothpaste.net>
	(brian m. carlson's message of "Wed, 8 Oct 2014 20:46:10 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 30DB8048-4F2D-11E4-98CC-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> Neither the AsciiDoc nor the Asciidoctor documentation specify whether
> the same number of delimiter characters must be used to end a block as
> to begin it, although both sets of documentation show exactly matching
> pairs.  AsciiDoc allows mismatches, but AsciiDoctor apparently does not.
> Adjust the pretty formats documentation to use matching pairs to prevent
> a misrendering where the remainder of the document was rendered as a
> listing block.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---

Thanks, well spotted, well described and well done ;-)

Will queue.

>  Documentation/pretty-formats.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
> index eecc39d..dcf7429 100644
> --- a/Documentation/pretty-formats.txt
> +++ b/Documentation/pretty-formats.txt
> @@ -95,7 +95,7 @@ would show something like this:
>  The author of fe6e0ee was Junio C Hamano, 23 hours ago
>  The title was >>t4119: test autocomputing -p<n> for traditional diff input.<<
>  
> ---------
> +-------
>  +
>  The placeholders are:

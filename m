From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: correct typo in example
Date: Thu, 12 May 2016 14:52:01 -0700
Message-ID: <xmqq7fezc5by.fsf@gitster.mtv.corp.google.com>
References: <20160512213001.30822-1-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu May 12 23:52:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0yWi-0005M3-Ds
	for gcvg-git-2@plane.gmane.org; Thu, 12 May 2016 23:52:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751167AbcELVwH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2016 17:52:07 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58243 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751111AbcELVwG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2016 17:52:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E62FE1B02E;
	Thu, 12 May 2016 17:52:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IDeRzHZn9ztzvLeDb6Cn5B5MVsI=; b=p+DonN
	4NXlErQDSoNc0ziGxEifDMKmajJykY2/xl5I41oHw9lHGMIX5vI2TKvaAIEnPgTn
	IC0F5U+fTdJZnZkTs/HnMo2ZFqGWoKVyxJ8AqzXR34j5keoCTk+9tQvhaPD+8pvp
	zoVnWfMAsgBJG2vDfBQJgfvTKP7pVuq3kJ3s4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=w6oAL4q38IcdF8zwTCyjZ/KXsW3OBEGF
	5BTQNfgtPMIA8SsZgzS+/dwfNUtLO05+1HnteQIBlXgTcTSk7f6Qa5/ahwkN0HcR
	a1mzukyeq03+YXv71jfBxYpdL9PYT82UeqKZysI6qAWFQ3qKiYd/xccsNxgkHyv3
	1ZZRpoEofEE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id DD7BE1B02D;
	Thu, 12 May 2016 17:52:03 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 521521B02C;
	Thu, 12 May 2016 17:52:03 -0400 (EDT)
In-Reply-To: <20160512213001.30822-1-sbeller@google.com> (Stefan Beller's
	message of "Thu, 12 May 2016 14:30:01 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C30FFD4E-188B-11E6-ABE6-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294484>

Stefan Beller <sbeller@google.com> writes:

> The example want's to explain how 'To see how attributes "crlf" and
> "indent" are set for different paths.'
>
> Spell the selected attribute correctly.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  Documentation/technical/api-gitattributes.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/technical/api-gitattributes.txt b/Documentation/technical/api-gitattributes.txt
> index 2602668..0d7e98c 100644
> --- a/Documentation/technical/api-gitattributes.txt
> +++ b/Documentation/technical/api-gitattributes.txt
> @@ -74,7 +74,7 @@ static void setup_check(void)
>  	if (check[0].attr)
>  		return; /* already done */
>  	check[0].attr = git_attr("crlf");
> -	check[1].attr = git_attr("ident");
> +	check[1].attr = git_attr("indent");
>  }
>  ------------

Technically the text and code after this patch is more "correct".

Back when I wrote the original, 530e741c (Start preparing the API
documents., 2007-11-24), however, I did mean to use "ident", iow,
the introductory text has typo, and the code sample is correct.
There wasn't any "indent" attribute that is natively recognised by
Git back then for git_attr("indent") would have made sense, either.

So perhaps update the introductory text instead?

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: fix header markup
Date: Thu, 22 Oct 2015 09:36:05 -0700
Message-ID: <xmqq37x2uah6.fsf@gitster.mtv.corp.google.com>
References: <1445518740-18221-1-git-send-email-xfq.free@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Xue Fuqiao <xfq.free@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 22 18:36:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZpIqc-0008Tq-PU
	for gcvg-git-2@plane.gmane.org; Thu, 22 Oct 2015 18:36:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753821AbbJVQgJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Oct 2015 12:36:09 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:55974 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751178AbbJVQgI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Oct 2015 12:36:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A020523020;
	Thu, 22 Oct 2015 12:36:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=a72BTskZ/bp7Z53KESM7s1BqdJY=; b=ZFNsf6
	jWO14xtQeOhhoxf5e0JcM5BOkcWXoDJ+OAUwmw15f6BhWudNFRvhJEf6GqNf2r8k
	pJjKNzcs03x7erEWKGK+fmqT/xMgK6B0xLXFIlbGy0LJL7DwyOjEzuwSPCm2ZUy8
	YpPumHxt6FNTK/NV2m5n+sLqlnopGl0SGdnsc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Pc5N/DaZqy2+tLl9L6JFrkzNTFa2wnFx
	wPsB0vPX1Jwhqq8uQ7lGrsGU4sV4NaXjzRJwvojZ/2JehUFKo1vWdo0luYR1l4gI
	HkAKd1aj9vHLFpbRUXzM9kcLlu4MCSduWVWLEDr/TGIeZ4BSOhpG8aEJAF0MmnmS
	T9boelEbI2g=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 985252301F;
	Thu, 22 Oct 2015 12:36:07 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 144902301E;
	Thu, 22 Oct 2015 12:36:07 -0400 (EDT)
In-Reply-To: <1445518740-18221-1-git-send-email-xfq.free@gmail.com> (Xue
	Fuqiao's message of "Thu, 22 Oct 2015 20:59:00 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: FE663422-78DA-11E5-BC65-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280062>

Xue Fuqiao <xfq.free@gmail.com> writes:

> Asciidoctor is stricter than AsciiDoc when deciding if underlining
> is a section title or the start of preformatted text.  Make the
> length of the underlining match the text to ensure that it renders
> correctly in all implementations.
>
> Signed-off-by: Xue Fuqiao <xfq.free@gmail.com>
> ---

Looks obviously correct.  Will queue.

Thanks.

> Currently, "Fixing a mistake by rewriting history" is surrounded by a
> pair of <p> tags instead of a pair of <h3> tags in
> https://git-scm.com/docs/user-manual.html.  This patch will (hopefully)
> fix that.
>
>  Documentation/user-manual.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
> index 1b7987e..764a270 100644
> --- a/Documentation/user-manual.txt
> +++ b/Documentation/user-manual.txt
> @@ -1491,7 +1491,7 @@ resolving a merge>>.
>  
>  [[fixing-a-mistake-by-rewriting-history]]
>  Fixing a mistake by rewriting history
> -~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  
>  If the problematic commit is the most recent commit, and you have not
>  yet made that commit public, then you may just

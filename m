From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Dec 2015, #02; Fri, 4)
Date: Fri, 04 Dec 2015 16:21:36 -0800
Message-ID: <xmqqvb8doicv.fsf@gitster.mtv.corp.google.com>
References: <xmqqa8pprej5.fsf@gitster.mtv.corp.google.com>
	<20151204232436.GB15064@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Dec 05 01:21:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a50bf-0000dI-O6
	for gcvg-git-2@plane.gmane.org; Sat, 05 Dec 2015 01:21:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753553AbbLEAVj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2015 19:21:39 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:50268 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752623AbbLEAVj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2015 19:21:39 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 63DE831FF3;
	Fri,  4 Dec 2015 19:21:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/RHc4NWTF1mX4+BqHjGlwQhMjJ0=; b=C1b/g2
	4/qZzBMwvcD8GywjgcbFu7wDCodgHo2cTi97NdJHM9ruvyihY1rcb8I0ZF3xmj/8
	EplxobfZy5N10Rj6oCIvB5ewq6o9Yk656II5cSQ+XFMaTbxSzTZFZl6rWcKoffoZ
	O+ESW9llbxadcKPiNJAuT54Ti5DLq0arx06OY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BSEIrbWB5PrujWPy7uNNJfMP6J1i5qGQ
	6rICJLC1ZO34IJOuv+95YC82PpdG7k9NtLaMuLf06jVEZ5D5xQvvjG0hZjER0aTH
	cI9kyKgjmHJ1FRh4yupW6YIROsyKwKBBhZhrxf19YVAOZC7PSYROuESpb74riNCP
	6Mmnh/efA/k=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5A6A231FF2;
	Fri,  4 Dec 2015 19:21:38 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D280F31FEF;
	Fri,  4 Dec 2015 19:21:37 -0500 (EST)
In-Reply-To: <20151204232436.GB15064@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 4 Dec 2015 18:24:36 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 26339EE0-9AE6-11E5-AB51-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282023>

Jeff King <peff@peff.net> writes:

> You may want to update this in the whats-cooking template. :)

X-<.  This is a bit tricky in that most of the time I want to retain
the customization I made to the top-portion, and this part does not
go through a three-way merge as it probably should.

>
> diff --git a/whats-cooking.txt b/whats-cooking.txt
> index 43394b7..04f6208 100644
> --- a/whats-cooking.txt
> +++ b/whats-cooking.txt
> @@ -25,7 +25,11 @@ and all topic branches at:
>  
>      https://github.com/peff/git/
>  
> -But note that I will _not_ be pushing to kernel.org.
> +You can find the changes described here in the integration branches
> +of the repositories listed at
> +
> +    http://git-blame.blogspot.com/p/git-public-repositories.html
> +

Thanks, but the patch is not quite right, as I won't be pushing to
peff/git ;-)

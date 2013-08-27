From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/11] Call it "Git User Manual" and remove reference to very old Git version
Date: Tue, 27 Aug 2013 12:04:04 -0700
Message-ID: <xmqqsixvc5wb.fsf@gitster.dls.corp.google.com>
References: <1403569571.34349.1377625974290.JavaMail.ngmail@webmail19.arcor-online.net>
	<1972849803.34382.1377626115372.JavaMail.ngmail@webmail19.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, martinvonz@gmail.com, jrnieder@gmail.com,
	wking@tremily.us, philipoakley@iee.org
To: Thomas Ackermann <th.acker@arcor.de>
X-From: git-owner@vger.kernel.org Tue Aug 27 21:04:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEOYq-00063r-C5
	for gcvg-git-2@plane.gmane.org; Tue, 27 Aug 2013 21:04:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753599Ab3H0TEM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Aug 2013 15:04:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64625 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752573Ab3H0TEL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Aug 2013 15:04:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 838343C805;
	Tue, 27 Aug 2013 19:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pNAUOSzECYeis8ofYxguenkH2eA=; b=TV+q5b
	luGHqT1w/6i56ZPPyFL65jpsJG+N9PAJoK5yKNeMcbMoGF/QgZFRrKlGKcA8Nnsu
	IwazYq9FZJMGZ8tcP+li5wQoJSbj01OKaPaIhyFxxXuW3dZXIpYNpYUt+xbwcf1G
	zbme63+5ivG4xSvzWmvRIN6dAnB7Re82u75Lo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=o6icjc1bywFs4tasDRG0kAZGo5HFiJdl
	0nt7Y0XQRkKMP+Y013qmO/9BBMhtvrCr6S6Qy5hkP0QIXEzWdYbt7dgnY3j8KDvI
	63KH6rGy3GPheBJfGoqX/y3GAz5HTNygKVl/PemjUVE3nLc8Mq6JGYr4BxXtPu9B
	plfJR8Aeslc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 25E023C804;
	Tue, 27 Aug 2013 19:04:10 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7F9343C7FD;
	Tue, 27 Aug 2013 19:04:08 +0000 (UTC)
In-Reply-To: <1972849803.34382.1377626115372.JavaMail.ngmail@webmail19.arcor-online.net>
	(Thomas Ackermann's message of "Tue, 27 Aug 2013 19:55:15 +0200
	(CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 737660BC-0F4B-11E3-81B6-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233135>

Thomas Ackermann <th.acker@arcor.de> writes:

> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
> Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
> ---

I tend to agree with Jonathan that this should be "User's Manual".

I've tentatively queued uncontroversial bits from v1 series already
on 'pu', by the way, and I do not think I have time to queue rerolls
of any topic today, so please expect a longer turn-around time than
usual.

>  Documentation/user-manual.txt | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
> index fe723e4..103ec9a 100644
> --- a/Documentation/user-manual.txt
> +++ b/Documentation/user-manual.txt
> @@ -1,6 +1,5 @@
> -Git User's Manual (for version 1.5.3 or newer)
> -______________________________________________
> -
> +Git User Manual
> +_______________
>  
>  Git is a fast distributed revision control system.

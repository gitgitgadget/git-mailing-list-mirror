From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 0/5] git-reset documentation changes
Date: Fri, 16 Jul 2010 14:00:07 -0700
Message-ID: <7v39vjrvl4.fsf@alter.siamese.dyndns.org>
References: <cover.1279273256.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Jul 16 23:00:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZs1B-0006xT-QR
	for gcvg-git-2@lo.gmane.org; Fri, 16 Jul 2010 23:00:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759297Ab0GPVAS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jul 2010 17:00:18 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:60148 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759191Ab0GPVAR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jul 2010 17:00:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EF199C5968;
	Fri, 16 Jul 2010 17:00:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rSrSoDY5nyn5AR72hXTcv94TP1k=; b=vaR7Hz
	oOleeueLle4miFwHIAg/2AJ4pDjjNuxHmaXl5FVDvIh9oWy9okTQTdZK4KhFcuQ9
	FNw5MJZO8VNXkd5Y52Bh4eM+Dne+En2ugOvcy8q0FKccXRAlAkwThJY9/FiazTXr
	jWuwy6i+PrEWqsC1GPuQgZqFJQZvmXBiZWMlo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Mh5+ry62Yh8u7brQUv1Lp0+aqcdOydc+
	khAT7vqiHtbN31ujD1XSCOpp5I7IEEgiqupVkCvYtJfVaHTPK5tROoA2hScsbwxG
	pLDLTfp5CtPqGhWpGUqbaxOM8PEhMYcgLlVnGs8N0f5qConwhUVuxpZbSHwMjCrv
	qe01R4SUosU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 97C98C5963;
	Fri, 16 Jul 2010 17:00:13 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 25074C5959; Fri, 16 Jul
 2010 17:00:09 -0400 (EDT)
In-Reply-To: <cover.1279273256.git.trast@student.ethz.ch> (Thomas Rast's
 message of "Fri\, 16 Jul 2010 11\:44\:37 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2095BECE-911D-11DF-AA78-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151171>

Thomas Rast <trast@student.ethz.ch> writes:

> I wrote this on the bus travelling to France, and haven't got around
> to sending it out since then.
>
> The main goal was the first patch, which redoes the 'description'
> section in the style pioneered by b831ded (Documentation/checkout:
> clarify description, 2010-06-01) in git-checkout(1).
>
> The rest are just various ideas that I'm tossing around.  I also would
> like to shorten the 'examples' section significantly if anyone sees a
> way to do that without a huge loss of explanations.  I think the
> chances that users consult the current version aren't exactly great
> because of its length.

Except for one small nit or two I mentioned in a separate message, I like
the overall direction of this series.

Thanks.

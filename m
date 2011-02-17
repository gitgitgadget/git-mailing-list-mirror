From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] Dont use the same variable for different things
Date: Wed, 16 Feb 2011 17:44:05 -0800
Message-ID: <7v62sjfna2.fsf@alter.siamese.dyndns.org>
References: <1297550311-17723-1-git-send-email-vvavrychuk@gmail.com>
 <1297550311-17723-4-git-send-email-vvavrychuk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Vasyl' Vavrychuk <vvavrychuk@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 17 02:44:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ppsuz-0004y9-Bn
	for gcvg-git-2@lo.gmane.org; Thu, 17 Feb 2011 02:44:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755920Ab1BQBoO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Feb 2011 20:44:14 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:63718 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751520Ab1BQBoN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Feb 2011 20:44:13 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9ED2D410F;
	Wed, 16 Feb 2011 20:45:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=Y5c49RlTDavYrF1N2dc3/xXZcfw=; b=FQREUuDgfzZh+f1FzCqQH7/
	iQuFFshTpQHuVrKNoX5rIbE1RSzSqiYfCQWamzhYOzqshZ8oB5Ke+FUZM1iUoeFR
	y3iGA3QOa8mEU7fiCKG2bTB+EUTB8jxi88eQIde+ta+ENOEEAcWvY63qbwvkQont
	/wjHtsZsICeUn4cozrd4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=UHhqOJ2pZyKb6/9+BHy5NiOr6CnLmB0ejg/RLj91tfHMTG9vv
	cy7+2ci4xmuE15TAs9n5y8cvGKrvbfaM3nyFN9IKLuU20hy6QznZloOdI1lLf7qV
	DDnvvHrXA8m6Uj5NVCfuVTn8K4u+ppf9ItwfNe9IYD+xG4gQ9hNy833gHA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 76387410D;
	Wed, 16 Feb 2011 20:45:17 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 56FC2410A; Wed, 16 Feb 2011
 20:45:13 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 925DC470-3A37-11E0-8E51-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167028>

Vasyl' Vavrychuk <vvavrychuk@gmail.com> writes:

> Subject: Re: [PATCH 3/4] Dont use the same variable for different things

	Subject: builtin/fetch.c: do not use ... different things

But more important question is why?

What benefit are we getting by almost doubling the stack footprint of this
function?  What problem are you fixing?

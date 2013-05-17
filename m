From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] for-each-ref: introduce color format
Date: Fri, 17 May 2013 10:20:39 -0700
Message-ID: <7vsj1lzfo8.fsf@alter.siamese.dyndns.org>
References: <1368802552-16024-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 17 19:20:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdOKk-0004jq-Gq
	for gcvg-git-2@plane.gmane.org; Fri, 17 May 2013 19:20:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756381Ab3EQRUm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 May 2013 13:20:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64411 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756305Ab3EQRUm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 May 2013 13:20:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A28091FCC7;
	Fri, 17 May 2013 17:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MDx1nb0l0a5I8iuw/fXZC6de/pY=; b=aOlFq5
	2mH3wp7juVNXFDXuFxii3oGiD3WwDazVJ43S1NuahxDiHAynZJSSbn7ou25L7fvV
	bwrs1AeydLX7p4P5vOaLeQKSjE2x8B88UqyQ4a/tR6AQsnbRapcRp1XQCbz1P9/O
	IO+h3LpjFWbkcieOr93yYQ03tJBnUKHlk34us=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=x083qiAwjdDHEJN4f3ksGCvYDm95g3rU
	eceg5z+uG2SLiPSogw9abebEUQbIJZVsdVgx0Gu0DCIQwlcysSVhwd4l8406rHrO
	8o9udCuGXeUe6YmOitts8ydMfZiGJsudlIweWbucwSJ9aBEkDbQvKDIa9KldhcGy
	IOC7TQTKAT8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 95FB91FCC6;
	Fri, 17 May 2013 17:20:41 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 108B81FCC3;
	Fri, 17 May 2013 17:20:40 +0000 (UTC)
In-Reply-To: <1368802552-16024-1-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Fri, 17 May 2013 20:25:52 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 19654F82-BF16-11E2-BB99-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224714>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

>  I just have one major doubt: in the above output, how do I align all
>  the upstream branches to the same column?  How can I achieve it with
>  pretty-formats?  Something like %*d?  But * is already taken to mean
>  deref in for-each-ref's --format.

Doesn't Duy's more recent work on the pretty-format front introduce
alignment operators?

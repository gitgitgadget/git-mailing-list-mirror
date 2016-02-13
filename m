From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/3] git-config.txt: describe '--includes' default behavior
Date: Sat, 13 Feb 2016 13:00:22 -0800
Message-ID: <xmqqpow0s4ux.fsf@gitster.mtv.corp.google.com>
References: <1455373456-64691-1-git-send-email-larsxschneider@gmail.com>
	<1455373456-64691-2-git-send-email-larsxschneider@gmail.com>
	<20160213171704.GF30144@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: larsxschneider@gmail.com, git@vger.kernel.org,
	sschuberth@gmail.com, ramsay@ramsayjones.plus.com,
	sunshine@sunshineco.com, hvoigt@hvoigt.net, sbeller@google.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Feb 13 22:00:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aUhIu-0007Du-6s
	for gcvg-git-2@plane.gmane.org; Sat, 13 Feb 2016 22:00:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751335AbcBMVAZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Feb 2016 16:00:25 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:53466 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751229AbcBMVAY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Feb 2016 16:00:24 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BDFA642B18;
	Sat, 13 Feb 2016 16:00:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nhyvSNZH3kZ1TM4FjVZEbmffIlc=; b=A1xdZB
	pUF0v3iCOmpv74ZvzF/wiOIOxX03F/9ei3JO7gJr45/dvYRvNem5dtCjPNe+F4Oq
	FPz0QaRxW4Bg7MmzSZOWwy3nVC8LRZCUQZZTq/jHT2S9XRmxQk36tfF4ZCGMeqtM
	JbYDHp9xKjOSBW3tcMSCEVWTeQGG521kbtyXY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=f0KkFq0r7UvQso7eKYY+hlHDZJGqD5cy
	cAE1wEsa/POcbSJ3Vu5dq3zMll55BdW+pRgGnVCyAYiylwWy8nopoNNRYcV3m/1b
	zLDQn2jVGq9uLy+nq3WPdeVy0x0TBhK/e4rc+rA/qFZOIRNfYj82PQeAUztTozWd
	ixfXBblNlbg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A990842B16;
	Sat, 13 Feb 2016 16:00:23 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 268A042B13;
	Sat, 13 Feb 2016 16:00:23 -0500 (EST)
In-Reply-To: <20160213171704.GF30144@sigill.intra.peff.net> (Jeff King's
	message of "Sat, 13 Feb 2016 12:17:04 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: CC7D2D94-D294-11E5-93C3-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286127>

Jeff King <peff@peff.net> writes:

> ... I did not realize then that my patch from:
>
>   http://article.gmane.org/gmane.comp.version-control.git/262641
>
> was never picked up (but of course I've been carrying it in my tree for
> a year).

Hmm, I do not see how it happened, either.  It is not like I was
offline (I can see I was involved in other threads from the same
timeframe).  Perhaps it was lost in the noise.

Thanks for following up.

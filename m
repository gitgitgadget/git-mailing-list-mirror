From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PREVIEW v3 9/9] strbuf: retire strbuf_getline() for now
Date: Wed, 13 Jan 2016 19:09:15 -0800
Message-ID: <xmqqd1t4luw4.fsf@gitster.mtv.corp.google.com>
References: <1450303398-25900-1-git-send-email-gitster@pobox.com>
	<1452740590-16827-1-git-send-email-gitster@pobox.com>
	<1452740590-16827-11-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 14 04:09:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJYHq-0002QN-Kq
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jan 2016 04:09:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750866AbcANDJT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 22:09:19 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:60360 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750768AbcANDJS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 22:09:18 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 640953C51A;
	Wed, 13 Jan 2016 22:09:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HrxOPoNxjSd6jdfH9pxSVYDjyaU=; b=ggWrwZ
	DlNO3laUeg5JbkWBWspoi+hCvbjzGFpXEPFlBA/bqUsAd5rgDgfOBxN0EIn6/djF
	ei1U+hWclMP7qtVgTJSFHOvs9v+oqnRr3+wfcJ1muqL0SoOOrUkVdp7chfk6vSaE
	mnwF+PvBdnvBd51Yl3o8NiDzm+FDpmdyBB7Dg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kpKIoWmMquk9FsNNSBUhpnMJbReu6vL2
	uM1fHybMt0h0+8F+4IzQyaQcAsY9604h4fZ76DUrbVXz1kvmr9IRkHT3ExM/VOrN
	jEzY33wsOtGXz/HS09pbSr9xXy6NvP0YLXLnUniHzdSy5Br7ewXu8RkaL/6GKq8I
	6I+XexX3/mI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 59B393C519;
	Wed, 13 Jan 2016 22:09:17 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D20123C518;
	Wed, 13 Jan 2016 22:09:16 -0500 (EST)
In-Reply-To: <1452740590-16827-11-git-send-email-gitster@pobox.com> (Junio
	C. Hamano's message of "Wed, 13 Jan 2016 19:03:10 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 325B6BF8-BA6C-11E5-9089-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284012>

Junio C Hamano <gitster@pobox.com> writes:

> Now there is no direct caller to strbuf_getline(), so demote it
> to file-scope static private to strbuf.c implementation and rename
> it to strbuf_getdelim().
>
> Eventually, we may want to make this short and clean name a synonym
> to strbuf_getline_crlf(), but not now.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

This is not part of the series but sent out by mistake.

    strbuf: give strbuf_getline() to the "most text friendly" variant

    Message-ID: <1452740590-16827-10-git-send-email-gitster@pobox.com>
    Xref: news.gmane.org gmane.comp.version-control.git:284008

is the correct 9/9.

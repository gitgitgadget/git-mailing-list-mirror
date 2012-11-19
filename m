From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/6] completion: test consolidations
Date: Mon, 19 Nov 2012 12:34:48 -0800
Message-ID: <7v6251xrfb.fsf@alter.siamese.dyndns.org>
References: <1353235917-13059-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Mon Nov 19 21:35:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TaY3e-0008In-A7
	for gcvg-git-2@plane.gmane.org; Mon, 19 Nov 2012 21:35:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754541Ab2KSUev (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2012 15:34:51 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34635 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753042Ab2KSUeu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2012 15:34:50 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 722A1A6CA;
	Mon, 19 Nov 2012 15:34:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/HZ406tHe4pamZ2VGEl7+bTd9pI=; b=X55Gex
	XrR8Dharqamk1SgoJ/3bH+w575GK/Vzk+FR4ARrxKK+KV16zcyoUjfwGMyqYlJSC
	KHw1oJ9XkGNwr94DUqma01Fs/9yaIrfxVM4INOJm/48HltoS4YGLQIFcUPudgdxo
	aYKIw7NB9YEtV7yT6Cws/vFfYih1P03mie6Sw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Tb+79q5xCKK3oG8Es5z3xgRevEW3x/hG
	Eh2hSEVP4o2G0IC8z/akM/TZ4BLoWMi9+vZ2/XaScotjI5eiTRgnpT/wb6rlTkE+
	9bX34omCqRmnZbORNtp1Lo1COEcbU386Zby67yfcMS11cJL943yyw9Pg/GJFPfr/
	q+UtZcIeTCw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5F452A6C9;
	Mon, 19 Nov 2012 15:34:50 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D0BDBA6C6; Mon, 19 Nov 2012
 15:34:49 -0500 (EST)
In-Reply-To: <1353235917-13059-1-git-send-email-felipe.contreras@gmail.com>
 (Felipe Contreras's message of "Sun, 18 Nov 2012 11:51:51 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 90AB63BC-3288-11E2-9D4B-54832E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210052>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> These started from a discussion with SZEDER, but then I realized there were
> many improvements possible.

Thanks; I'd loop him in and wait for his acks/reviews.

>
> Changes since v2:
>
>  * Updated comments and commit messages
>
> Changes since v1:
>
>  * A lot more cleanups
>
> Felipe Contreras (6):
>   completion: add comment for test_completion()
>   completion: standardize final space marker in tests
>   completion: simplify tests using test_completion_long()
>   completion: consolidate test_completion*() tests
>   completion: refactor __gitcomp related tests
>   completion: simplify __gitcomp() test helper
>
>  t/t9902-completion.sh | 133 +++++++++++++++++++-------------------------------
>  1 file changed, 51 insertions(+), 82 deletions(-)

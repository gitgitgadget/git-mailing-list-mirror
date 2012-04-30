From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/5] Large file support for git-archive
Date: Mon, 30 Apr 2012 12:15:27 -0700
Message-ID: <7vehr5f2uo.fsf@alter.siamese.dyndns.org>
References: <1335761837-12482-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 30 21:15:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SOw4M-0000WI-Q6
	for gcvg-git-2@plane.gmane.org; Mon, 30 Apr 2012 21:15:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756556Ab2D3TPa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Apr 2012 15:15:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41440 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756505Ab2D3TP3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2012 15:15:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 45AF27464;
	Mon, 30 Apr 2012 15:15:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2e0DiSoGC++Kjq2afIYTGq5KeP4=; b=M84k4/
	wIUmji5qqqKI0EKC1DJAfeWapV1xwOmE92dIWrrt8Jq08dqQBZ9nfLp2I+6X+jE2
	HfLVKlDUw20YYhcaz3sHeVn49XMs8IzyTX4j1RpYInz9h7XymYn6tPeXjVClpv04
	6CakvAQ3PhOgIzJEtfsXA3vC5R0Wy8EWTuxZg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ejr4OU5bMbgGOpVqGeKiX4UCF7K1+/rz
	UsfA+f3Bag+kRH1YlKrwM+/rVVeDQzrHksRZsYluh+N9aNsOSzQ1b2MamjCQw8wc
	h2QlsMZ/FOUwRi5GjzJ2MGyeYTByLRaXvZ4y23EGInH/bjuztSQxojYa0P/jf/T1
	nBZ4S0urkfc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3C4047463;
	Mon, 30 Apr 2012 15:15:29 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C69E27462; Mon, 30 Apr 2012
 15:15:28 -0400 (EDT)
In-Reply-To: <1335761837-12482-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Mon, 30 Apr
 2012 11:57:12 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D9034E02-92F8-11E1-96E8-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196596>

Overall this was a very pleasant read.  Thanks.  Will queue.

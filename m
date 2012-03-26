From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] grep: add more information to hunk separators
Date: Mon, 26 Mar 2012 11:05:28 -0700
Message-ID: <7vk427p79z.fsf@alter.siamese.dyndns.org>
References: <1332729705-9283-1-git-send-email-lodatom@gmail.com>
 <7vr4wgq6zm.fsf@alter.siamese.dyndns.org> <4F70966B.4050107@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mark Lodato <lodatom@gmail.com>, git@vger.kernel.org
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Mon Mar 26 20:05:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCEIU-0005O4-16
	for gcvg-git-2@plane.gmane.org; Mon, 26 Mar 2012 20:05:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933219Ab2CZSFc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Mar 2012 14:05:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34661 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933211Ab2CZSFc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Mar 2012 14:05:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B2D437369;
	Mon, 26 Mar 2012 14:05:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=oLijuC3tVJ7E
	5z14Rm9+uJxBZ9k=; b=tAzHcxbL5K+PuM2t7Ii6nnnc3bpuhFuDSzC3nlIZsmoT
	fp9JqQmeKRHefgN8p5Zeb1DWLawjDg6BXyWZ5qPwiEiiz2///IMJFv6FKNhLwsmX
	JsF6i/b+Bj/YqWT2G8EUs3BpdOdXtCIFIrCS8XbRxwWbNGS62eiz0i9+RgPIXis=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=RpAsvn
	FLy8aPSMI+DepWTyPXhdPN178FzyqbvF0H1JbDpWBiAZSiutyaPr143WhaJUA4h4
	srzBU+4NZKsFt67tbgFvYAz43P+nj5RSovvfUU9+tt2g1/OoC8YEFu4aJsQCi954
	eNxcmXhFgc4sb9pSc60E8cafbn6t67HAv6K7A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A93F97368;
	Mon, 26 Mar 2012 14:05:31 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 91E817365; Mon, 26 Mar 2012
 14:05:30 -0400 (EDT)
In-Reply-To: <4F70966B.4050107@lsrfire.ath.cx> (=?utf-8?Q?=22Ren=C3=A9?=
 Scharfe"'s message of "Mon, 26 Mar 2012 18:16:43 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 46394338-776E-11E1-912B-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193943>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> Human readers can differentiate between contents and heading by color=
;
> separators are cyan by default.

OK.

> A separate frontend would probably have to implement match
> highlighting again.  That's not too hard, but a bit sad.

Yeah, but at the same time, a separate front-end could do a lot more th=
an
just grep.  Letting the user pick a function name from the current outp=
ut
and run grep again, letting the user highlight the line range and run
blame (or "Linus's ultimate content tracking tool"), etc.

> ...  But I think the idea to deduplicate the meta-information and giv=
e
> found content more screen real estate is a good one in general.

Yeah, I found the "sound of one hand clapping" in your other message
somewhat intriguing ;-).

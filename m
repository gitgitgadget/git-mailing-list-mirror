From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Obey p4 views when using client spec
Date: Mon, 14 Feb 2011 10:33:49 -0800
Message-ID: <7v7hd2tqia.fsf@alter.siamese.dyndns.org>
References: <4D55D56C.6050207@vmware.com>
 <20110212215133.GA21494@mew.padd.com>
 <AANLkTinVp3EYFX3Ow2G8dO6Zn5BEWxuYjwO8vW2yOjcF@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pete Wyckoff <pw@padd.com>, Ian Wienand <ianw@vmware.com>,
	git@vger.kernel.org
To: Tor Arvid Lund <torarvid@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 14 19:34:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pp3Fe-0001jh-9J
	for gcvg-git-2@lo.gmane.org; Mon, 14 Feb 2011 19:34:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751423Ab1BNSeD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Feb 2011 13:34:03 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:59871 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751395Ab1BNSeB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Feb 2011 13:34:01 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 691153AE6;
	Mon, 14 Feb 2011 13:35:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+SiOJuHIb9BoCp6aoV4CnnRpGLU=; b=pQKD6E
	cyFbiZsDhVXbwmmI4s9pGXrNvJVTu2LaQ521Rc6kbVvAx/PVT2AQcCxI+2IqybxL
	YIjdKvVZDVDetPMZl1tuYsIGzKri+GDK0H4qPHpM5NkNn8SKW9+Du7sA5A5+HJeZ
	92F9AkswqTdp9EUEAbU6PtovaRvMUOpYqdLlI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=trZCEGSzx+6KgHHMm5tR7jP5mwhVrn2k
	qHFjHpMZuoSDHLwksUm8Pq3DtBaLjfLvrE0gapdHMJB4nUnDOOiAFWHF3bWjnmqV
	UtPQh22tq5hLsaqO3x++Sm/WznMCo2IR+V3H18RBs3Qb8th67hFqY2dbArdUh1/c
	/Ysd0UcvAyc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1E0273AE3;
	Mon, 14 Feb 2011 13:35:01 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 8498F3ADF; Mon, 14 Feb 2011
 13:34:55 -0500 (EST)
In-Reply-To: <AANLkTinVp3EYFX3Ow2G8dO6Zn5BEWxuYjwO8vW2yOjcF@mail.gmail.com>
 (Tor Arvid Lund's message of "Mon\, 14 Feb 2011 10\:16\:10 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 21B89BCA-3869-11E0-B428-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166746>

Tor Arvid Lund <torarvid@gmail.com> writes:

>>> ...
>>> p4 can do various other reordering that this change doesn't support,
>>> but we should detect it and at least fail nicely.
>>>
>>> Signed-off-by: Ian Wienand <ianw@vmware.com>
>>
>> Nice, thanks for making the changes.
>>
>> Acked-by: Pete Wyckoff <pw@padd.com>
>
> Good work, Ian! Thanks.
>
> Acked-by: Tor Arvid Lund <torarvid@gmail.com>

Will apply; thanks.

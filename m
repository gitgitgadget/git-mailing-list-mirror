From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t5551: do not use unportable sed '\+'
Date: Mon, 13 May 2013 09:30:32 -0700
Message-ID: <7vtxm6n8pj.fsf@alter.siamese.dyndns.org>
References: <201305111525.53130.tboegi@web.de>
	<7vwqr5wdqm.fsf@alter.siamese.dyndns.org>
	<7vobchwbax.fsf@alter.siamese.dyndns.org> <518EA351.8000603@web.de>
	<7v8v3lwa5p.fsf@alter.siamese.dyndns.org> <518EAB7C.3010508@web.de>
	<7vsj1svqi7.fsf@alter.siamese.dyndns.org>
	<7vr4hbu818.fsf_-_@alter.siamese.dyndns.org> <51910418.2070904@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon May 13 18:30:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ubve7-0003we-Mg
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 18:30:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751816Ab3EMQah convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 May 2013 12:30:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34431 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751572Ab3EMQag convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 May 2013 12:30:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0DD551EE9F;
	Mon, 13 May 2013 16:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=MrOFumcYgY8D
	7um/YTmg88pQfLU=; b=ikYUbGWXG4LwD30dyxTkhf4Caq9Xqnqpn2sMftOViCBI
	pvJ/RN61JdKGCDY47UzRp1KjViBuliWZTYKKDvT9tJYqOpQbAve7Nzupr/SKRuk8
	i98STd6hk+Z0XgWZZf1grX5olNPbmu/5zSChxJ52IpCKmof1mkKf0hJ51ukWEnk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=wNA7DV
	A1YoVWlNJTRqR+YB48JP/slqO5ZOs9zTrpjOHMyUhzgEz8EmGIRaA9JrSFy9w7vd
	PVqvNpZI2e4uvzZke7DXX6lGs8AANp8XOhEWrQrFTYrbwa2KT1UScSuonnUIy9aH
	hdytd4SCA1SzfNnyn/dJedtBAfgv3btQPkyR8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 045D11EE9E;
	Mon, 13 May 2013 16:30:35 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7E3F41EE98;
	Mon, 13 May 2013 16:30:34 +0000 (UTC)
In-Reply-To: <51910418.2070904@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Mon, 13 May 2013 17:17:44 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6FB2C24A-BBEA-11E2-8893-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224179>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> On 2013-05-13 00.50, Junio C Hamano wrote:
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> ---
>>  t/t5551-http-fetch.sh | 8 ++++++--
>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>=20
> Thanks, works like a charm, tested on Mac OS.
> /torsten

Thanks; I take it that you reverted the "sed fix" part and saw the
updated "clone" check fail with the platform "sed"?

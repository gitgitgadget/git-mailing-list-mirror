From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-fetch-pack uses URLs like git-fetch
Date: Mon, 11 Nov 2013 12:17:14 -0800
Message-ID: <xmqq8uwulmlx.fsf@gitster.dls.corp.google.com>
References: <201311081854.06201.tboegi@web.de>
	<xmqqk3gen888.fsf@gitster.dls.corp.google.com>
	<52813651.7000701@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Nov 11 21:17:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VfxvO-0000ht-Bo
	for gcvg-git-2@plane.gmane.org; Mon, 11 Nov 2013 21:17:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752485Ab3KKUR0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Nov 2013 15:17:26 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62931 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752641Ab3KKURZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Nov 2013 15:17:25 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7FF755142F;
	Mon, 11 Nov 2013 15:17:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=t1uQ1wtlL1q7
	rVciYPhrtS6CUiY=; b=K64VvYs7wfpvBehR9PunqXWUKDQ5wTKFG+9280owNsAe
	g3xzAXMY/LxGWN3aqK7/6cNevsNpKvLHlzz6U2X0HMh2leBeEKnNsUJy5D6fup6C
	AaxMY353SaFLekvmOTuXpdhCEL4aL7KTmeC37q4hDeDFXTyyUDtdNWTLAYwBgFA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=KVvuZq
	V9ZAp4xexEFExclF0qPW6QV0b8y6oXhT1FZhmDmm9k+F/X+vP0PgxefKrR2XkQfP
	H7HErz9GzoInonxFsVOEn6XbNfAzS3eKFSQi86kqPtnwx0VKZipG/BTp6eK7WDro
	SQuwGKCup7lYyYskgRxGTSuv3G7qYgE71FzfI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6ED8C5142E;
	Mon, 11 Nov 2013 15:17:22 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A36095142B;
	Mon, 11 Nov 2013 15:17:21 -0500 (EST)
In-Reply-To: <52813651.7000701@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Mon, 11 Nov 2013 20:56:01 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 455FBC2E-4B0E-11E3-8763-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237643>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> On 2013-11-11 18.44, Junio C Hamano wrote:
>> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>>=20
>>> "git fetch-pack" allows [<host>:]<directory> to point out the sourc=
e
>>> repository.
>>> Use the term <repository>, which is already used in "git fetch" or =
"git pull"
>>> to describe URLs supported by Git.
>>=20
>> Sign-off?

> If the patch makes sense otherwise, are you willing to squeeze this i=
n:
>
> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>

Will do; thanks.

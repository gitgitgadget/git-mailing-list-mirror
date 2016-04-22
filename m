From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Apr 2016, #06; Thu, 21)
Date: Fri, 22 Apr 2016 10:23:54 -0700
Message-ID: <xmqqzislpnf9.fsf@gitster.mtv.corp.google.com>
References: <xmqqy486r4co.fsf@gitster.mtv.corp.google.com>
	<5719B035.6070103@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Fri Apr 22 19:24:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ateoH-0004MS-Nx
	for gcvg-git-2@plane.gmane.org; Fri, 22 Apr 2016 19:24:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932302AbcDVRX6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Apr 2016 13:23:58 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57315 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932280AbcDVRX6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Apr 2016 13:23:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id AAD3212A4C;
	Fri, 22 Apr 2016 13:23:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=RQVa2cc6WoRE
	fASv0AApAz4BMBU=; b=pTzX2z0x3Rs247xw2UzaDRa62ltPQRcNF31Vp1S9NrbA
	PZQDstjiqqHE69TKvv+2jRvz6W2Jbc0bFZ0xX63P0uOahwILdQiBHTdCQAXPG6cY
	zWmfFrVrvhvYl533Pr1bhM7nfVdneDJsH+VnrbHXfo6+Ip3kVaB+xWaGuOxPc4A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=f3iFIa
	y3RdqpAJn0F6uhxhvWfYrJrLKVw/vupZzI28FsLx06Jhs8mHNBvsjYnql/Ug0eJH
	yxWjd1CqlNDRotO8w+jujQw3BSduiqI8yKOx4yESfHHI2UoYd30gWfDVWZUVKinX
	opN1Ouu08vSdeQ0QpGetc6T7aOwx1i4S08cAE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A2F6612A4B;
	Fri, 22 Apr 2016 13:23:56 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E32BF12A4A;
	Fri, 22 Apr 2016 13:23:55 -0400 (EDT)
In-Reply-To: <5719B035.6070103@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Fri, 22 Apr 2016 07:01:41 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: FDF548A2-08AE-11E6-9CAC-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292232>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> * tb/convert-eol-autocrlf (2016-04-19) 4 commits
>  - convert.c: ident + core.autocrlf didn't work
>  - t0027: test cases for combined attributes
>  - convert: allow core.autocrlf=3Dinput and core.eol=3Dcrlf
>  - t0027: avoid false "unchanged" due to lstat() matching after a cha=
nge
>
>  Setting core.autocrlf to 'input' and core.eol to 'crlf' used to be
>  rejected, but because the code gives precedence to core.autcrlf,
>  there is no need to, hence we no longer reject the combination.
>
>  Will merge to 'next'.
> I know that I asked for an early merge of 4/4, but there is a new ver=
sion
> with a fix for the leaking filter coming out this evening, european t=
ime.
> Please hold it.

I'll drop what has been queued and wait for a reroll.

Thanks.

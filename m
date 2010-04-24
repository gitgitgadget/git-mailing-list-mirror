From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Recent documentation patches, and an RFC on terminology
Date: Sat, 24 Apr 2010 00:23:13 -0700
Message-ID: <7vd3xpqppa.fsf@alter.siamese.dyndns.org>
References: <20100423215448.1EF5B479E92@snark.thyrsus.com>
 <20100423221433.GB29661@atjola.homenet> <20100423222956.GB21224@thyrsus.com>
 <alpine.LFD.2.00.1004231920580.7232@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Raymond <esr@thyrsus.com>,
	=?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	Eric Raymond <esr@snark.thyrsus.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Sat Apr 24 09:23:37 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5ZiC-0008FH-IA
	for gcvg-git-2@lo.gmane.org; Sat, 24 Apr 2010 09:23:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752760Ab0DXHXa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 Apr 2010 03:23:30 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:42939 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752567Ab0DXHX3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Apr 2010 03:23:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D39AAD828;
	Sat, 24 Apr 2010 03:23:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=J13AmN1QSSVqsVGuG+euZTwr7
	c0=; b=jL50mPIHGXaGdiixQf7o6SI+xu5w3o1QsmUlN6c2bl+gpp04INC2fHfSr
	uTEIpsT2kZp6rdkrs0pJ+2xb41JuNCFxy49/2l2UX7/yO447KXWi/Eim1fwrKxRX
	gl6LMNwDFzSvxksDrs2dcpVxdTZoNtrdCbMvzNq4Y0x74vyFiU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=pRYZZYjUiHJUXIVcYqt
	b9g/LVlBjOi73oAfr7xTJwbNYrqnM2j2SIpSkcEbeLqS2NpWkRk7qJ2W9s53PEhP
	zsN1YA4R1U1n+IIp6QTo/z2OcmsLga2DW4QZyYQ2GYjYWuksyfWhGOGi+kTORO4/
	APu3LIrxLz5qqflHcjY+awCk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 51F79AD824;
	Sat, 24 Apr 2010 03:23:20 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 776B4AD81D; Sat, 24 Apr
 2010 03:23:14 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 42632920-4F72-11DF-A865-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145658>

Nicolas Pitre <nico@fluxnic.net> writes:

> On Fri, 23 Apr 2010, Eric Raymond wrote:
>
>> Bj=C3=B6rn Steinbrink <B.Steinbrink@gmx.de>:
>> >                   (your other mail didn't make it to me yet, so I
>> > couldn't quickly look up how you differentiate between the "stagin=
g
>> > area" and the index).
>>=20
>> *Groan*...is the Great Galactic Ghoul randomly eating my patch submi=
ssions
>> again? I'll check the archives...
>>=20
>> Basically, I changed the docs to use "staging area" when talking abo=
ut=20
>> workflow and "index" only when describing implementation.
>
> If so that should be a good thing.

Do you mean that Ghoul did a good thing to eat such a change?

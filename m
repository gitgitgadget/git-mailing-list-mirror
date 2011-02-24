From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Feb 2011, #05; Wed, 23)
Date: Wed, 23 Feb 2011 17:59:50 -0800
Message-ID: <7v4o7u42g9.fsf@alter.siamese.dyndns.org>
References: <7v1v2y5o3p.fsf@alter.siamese.dyndns.org>
 <AANLkTinUtqJJHNyS9CxrC=VnS87v=GH=pOw9yr4r=pii@mail.gmail.com>
 <7vk4gq45bo.fsf@alter.siamese.dyndns.org>
 <AANLkTik6-AFN1T7GYz6z4ad=pPCZG4Z5LWung0qYwe2X@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 24 03:00:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsQV2-0007A7-1H
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 03:00:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753534Ab1BXCAE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Feb 2011 21:00:04 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:39050 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753160Ab1BXCAD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Feb 2011 21:00:03 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 78472338A;
	Wed, 23 Feb 2011 21:01:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=iPnXaW/bYPW3
	WWrUlzbl9RAF9mc=; b=QmH8cdoBSAgrDANyFVMl/dxFFkQZiEZkSUuIzWCXfDZx
	Sqhl9O/tN4nZQVyCM7bnQrLhrXPAqi27KlnVpkDqBw2kEvVt0gbTj12ggftavJAS
	pnl2qdh3U0YEjc+6X/bIcDDf18eOszD3qcR5ydy0SXhXCQciFEoSK/XcqYYHTt4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=mu8bho
	QZPseYju/a/sfmrBEOk8NGiN5bCPQq2uNqRvMNH16PBZwS0LG9EOxDiikmywMj7k
	T95YB8w3ZaozxAxjA/noY/8B+0KIgTCv3y409U46qeA+kZuvvzTjLx0XsNDoYD/f
	MeDuCPZ0Smuiwu2eRBcKtngpoDFq/eeNLuxF4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 473C93387;
	Wed, 23 Feb 2011 21:01:10 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 268873385; Wed, 23 Feb 2011
 21:01:05 -0500 (EST)
In-Reply-To: <AANLkTik6-AFN1T7GYz6z4ad=pPCZG4Z5LWung0qYwe2X@mail.gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu\, 24 Feb
 2011 02\:37\:36 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F32E968A-3FB9-11E0-BD2E-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167766>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Right, once we're confident (which at least I am) that the first few
> patches really are no-op's I think it would be easier for everyone to
> merge them down sooner than later.

We three are pretty much on the same page, then.

Two minor points are what to do with the "#" prefix in "# POISON #" and
namespace contamination, but other than these I don't think there is
anything controversial.


>>> =C2=A0 =C2=A0 Warning: you are leaving 1 commit behind that are not=
 connected to
>>> =C2=A0 =C2=A0 any of your branches:
>>>
>>> For the singular this should be "1 commit behind which is not
>>> corrected to any of your branches".
>>
>> Heh, thanks. =C2=A0I would think "s/ that are /, /" would fix it rat=
her
>> nicely.
>
> s/corrected/connected/ also :)

That typo appears only in _your_ version, not mine ;-).

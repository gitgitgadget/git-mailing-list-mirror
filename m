From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t0008: avoid brace expansion
Date: Wed, 09 Jan 2013 16:18:39 -0800
Message-ID: <7vsj693n6o.fsf@alter.siamese.dyndns.org>
References: <50EC8025.8000707@lsrfire.ath.cx>
 <7vr4lvcstt.fsf@alter.siamese.dyndns.org> <50EC8BE7.2010508@lsrfire.ath.cx>
 <7vboczcq5a.fsf@alter.siamese.dyndns.org> <50EE01F8.1070109@lsrfire.ath.cx>
 <CAOkDyE_EuuV04KxkkLuHMV+VbDWsDMN1q3YShLtKaimaXH40Sg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	git discussion list <git@vger.kernel.org>
To: Adam Spiers <git@adamspiers.org>
X-From: git-owner@vger.kernel.org Thu Jan 10 01:19:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tt5rK-0001iX-In
	for gcvg-git-2@plane.gmane.org; Thu, 10 Jan 2013 01:19:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932351Ab3AJASm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Jan 2013 19:18:42 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40936 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932206Ab3AJASm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Jan 2013 19:18:42 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C290DA6CF;
	Wed,  9 Jan 2013 19:18:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=PxJUp0Mp8DZf
	uPKWzIiPPwZB6i0=; b=nAxcn4r9yCiS/PakeuJBRe6+jsAGmnpMy2vhr1B5WyhF
	KqOkah4hN1wyfM5jTnHwVs8sKyeatCMyx3iKNsMHXENx6BnLlMJhD4OThZ/dkZ05
	j/3oqcfpo/G1hWK3Ss9qHIq7ZXeOP6XYGnuPGTg660tcwe3XA59QM+2ZjUG9p3s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=KsvtTN
	XJ+2x4Vi44s64jS8fuybOwFq6+xRianifd/03Fxm4k+2/Y6oqlNXJwlPdeS5WYMt
	XTVTUWUEGftJYD6fkNpzr5BkZIj6ERVjFcn4PUVrYkfnXqb0Y/pZuCz1IXzPslzg
	sXcEhR7KD02kt17iNdMMOKqD4DVRPSseaZqtk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B6DA2A6CE;
	Wed,  9 Jan 2013 19:18:41 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 312B0A6CB; Wed,  9 Jan 2013
 19:18:41 -0500 (EST)
In-Reply-To: <CAOkDyE_EuuV04KxkkLuHMV+VbDWsDMN1q3YShLtKaimaXH40Sg@mail.gmail.com> (Adam
 Spiers's message of "Wed, 9 Jan 2013 23:56:27 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 497179D6-5ABB-11E2-B15E-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213114>

Adam Spiers <git@adamspiers.org> writes:

> On Wed, Jan 9, 2013 at 11:49 PM, Ren=C3=A9 Scharfe
> <rene.scharfe@lsrfire.ath.cx> wrote:
>> Brace expansion is not required by POSIX and not supported by dash n=
or
>> NetBSD's sh.  Explicitly list all combinations instead.
>
> Good catch, thanks!

Yeah; thanks.

It would also be nice to avoid touch while we are at it, by the way.

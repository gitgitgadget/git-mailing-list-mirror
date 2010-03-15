From: Junio C Hamano <gitster@pobox.com>
Subject: Re: FEATURE REQUEST: Comment assignment on branches
Date: Mon, 15 Mar 2010 14:32:02 -0700
Message-ID: <7v3a01jmp9.fsf@alter.siamese.dyndns.org>
References: <be8f531d1003150133n3ea64109u7d573dbd533ffa48@mail.gmail.com>
 <4B9EA22E.1010103@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Maxim Treskin <zerthurd@gmail.com>, git@vger.kernel.org
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Mon Mar 15 22:32:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrHtd-00041U-5J
	for gcvg-git-2@lo.gmane.org; Mon, 15 Mar 2010 22:32:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933157Ab0COVcP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Mar 2010 17:32:15 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:54204 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757172Ab0COVcN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Mar 2010 17:32:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 96101A21AC;
	Mon, 15 Mar 2010 17:32:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=vMI6K9fEsZ/S
	rMP5F8Y1R1B8BKY=; b=XuSVnMkYz5GbnWqqTfPwfjXiW7GdVZZtBgEvLLHvxvN+
	5OcUJGLSqnCrSES6oC3SgZGqDv9osUI4btxRak12JvtS3BUKXaycDdLqn2C+qQMo
	c2RB5duMsQlUY9EpFk3mfb5pAKC/JryMB+JG+jpp+IjHsCEF+dIiqU8Nxi9XeQI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=RffJyE
	KDdsYiX5HRadIOReH2wBunncWDaSlX0sCcNjHxETKQ6qpp2DtKXFiArTnooqLioA
	7Sx37nyhpdttx/G6dOMzyL13GP43E713OMD1pEtu9no98yeLTGJpa6co/WZAP+78
	fxmrBiyPXZNYSkWYB6DLCsWD3slRJWOa/EhwE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4F911A21A6;
	Mon, 15 Mar 2010 17:32:09 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B8E8CA219D; Mon, 15 Mar
 2010 17:32:03 -0400 (EDT)
In-Reply-To: <4B9EA22E.1010103@lsrfire.ath.cx> (=?utf-8?Q?=22Ren=C3=A9?=
 Scharfe"'s message of "Mon\, 15 Mar 2010 22\:10\:06 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 35DC03D2-307A-11DF-8720-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142255>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> Am 15.03.2010 09:33, schrieb Maxim Treskin:
>> Hello
>>=20
>> Is it possible to add comments assignment to branches?
>> Something like:
>>=20
>> $ git branch --comment=3D"New branch with implementation of some fea=
tures" br14
>>=20
>> $ git branch
>>   br14
>> * master
>>=20
>> $ git branch --comments
>>   br14           (New branch with implementation of some features)
>> * master
>>=20
>> and when configuration variable branch.comments =3D=3D true, this be=
havior
>> is default.
>
> Hmm.  You could name your branch
> "br14/new-branch-with-implementation-of-some-features" instead of
> "br14".  With command line completion you would only have to hit two
> extra keys (slash tab) and could enjoy a meaningful branch name every=
where.

Another thing to worry about is how "--comments" and "-v" would interac=
t
with each other.

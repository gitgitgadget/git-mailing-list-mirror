From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] i18n: po for zh_cn
Date: Wed, 01 Feb 2012 15:45:08 -0800
Message-ID: <7vr4ye15kr.fsf@alter.siamese.dyndns.org>
References: <1328111436-58925-1-git-send-email-worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 02 00:45:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rsjrb-0003Dd-Av
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 00:45:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753137Ab2BAXpN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Feb 2012 18:45:13 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53612 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753019Ab2BAXpL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Feb 2012 18:45:11 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6013D73A9;
	Wed,  1 Feb 2012 18:45:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=8ALJ6bA0OspH
	YM0ko1UJtmwrBzI=; b=DXXSfFTQtrlFzjtZ6L7m89uPWWzjKY2RKQ1LRB3HWE27
	bjnobxvgMYefdisIeo0BvB5eqtjsw5nLT76INqKJA6pCgs9IFEeBTlhambR/+heT
	UV6Gagoy2oJEDYAdQ1QJp+kFFtZmMbVsM4qu6t0btGFviPjl+vavF3OxzZ7W8vk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=aj/N2p
	ypLeOjORJOp5KizXY2iv96g9HGGFRQX0xFzi7To+63OMlEgcnJT3zNbIOqwYacZq
	+KBii7OxEQPSoEQer/HoADoYPIXDF1GJBuXOkueRuWdnFwpw+u9MJh0tzvpOoDoF
	aoGHg3thtYPeY+YfXyEq2AoYIJt4sVJOmeL4w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5716673A8;
	Wed,  1 Feb 2012 18:45:10 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BC4A373A7; Wed,  1 Feb 2012
 18:45:09 -0500 (EST)
In-Reply-To: <1328111436-58925-1-git-send-email-worldhello.net@gmail.com>
 (Jiang Xin's message of "Wed, 1 Feb 2012 23:50:36 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C6D9C8BA-4D2E-11E1-B609-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189557>

Jiang Xin <worldhello.net@gmail.com> writes:

> Git can speak Chinese now.
>
> Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
> ---
>  po/zh_cn.po | 3568 +++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++++
>  1 =E4=B8=AA=E6=96=87=E4=BB=B6=E8=A2=AB=E4=BF=AE=E6=94=B9, 3568 =E5=A4=
=84=E6=B7=BB=E5=8A=A0(+), 0 =E5=A4=84=E5=88=A0=E9=99=A4(-)
>  create mode 100644 po/zh_cn.po

I do not mind Chinese in the patch text (i.e. below), but I would have
preferred the above not to be in Chinese, which I do not read---I can
guess what =E6=96=87=E4=BB=B6, =E6=B7=BB=E5=8A=A0 and =E5=88=A0=E9=99=A4=
 are, and I can also guess that =E4=B8=AA and =E5=A4=84
are units of counting, but nevertheless...

I haven't decided what to do with this, though.  If we are going to get
tons of l10n patches[*1*], it may make sense to have a separate clone o=
f
git.git, with possibly a maintainer other than myself, forked at v1.7.9
and updates _only_ files in po/ hierarchy.

Let me think about how to manage the l10n patches a bit.

Thanks for a patch.

[Footnote]

*1* Ah, another thing, shouldn't the title be labelled as l10n instead =
of
i18n?

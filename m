From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Update l10n guide
Date: Fri, 02 Mar 2012 08:59:11 -0800
Message-ID: <7vfwdrey74.fsf@alter.siamese.dyndns.org>
References: <CANYiYbGS_cFTHT1Pkafi9dmzedqezTq8k1tPkYur0b2St_c43Q@mail.gmail.com>
 <7v1upew6d0.fsf@alter.siamese.dyndns.org>
 <7vfwduujxw.fsf_-_@alter.siamese.dyndns.org>
 <CANYiYbE5rcnD_VGJyL2CjS-R5E0pyNSd5TetvH849W6wC5JiAA@mail.gmail.com>
 <7vk434q4eg.fsf@alter.siamese.dyndns.org>
 <CANYiYbE7bxz5=h9gaKf6+N6k5cn6mEKnuf_7KPFAnDrC31UL_w@mail.gmail.com>
 <4F50A55E.8040705@viscovery.net>
 <CANYiYbG-Gp0cELF7_CxT1veRod+ookBaucfjCpWZjK1kTC0sAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Git List <git@vger.kernel.org>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 02 17:59:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3VpQ-00074l-Nh
	for gcvg-git-2@plane.gmane.org; Fri, 02 Mar 2012 17:59:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758926Ab2CBQ7P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Mar 2012 11:59:15 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43177 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755932Ab2CBQ7O (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2012 11:59:14 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D05BE6DBE;
	Fri,  2 Mar 2012 11:59:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pPqtjOTen5tsBQFfOr220XfZQjE=; b=P96FJp
	sAUX9EXyBMc8+m/NJyjPVBiY5ZMxS+7Cy4O0BeepYTl4ZUSbRAaKxUmXgesuk9SE
	Khb0+NUvPoJAzW8c9H55bZ63ibN6ot7hHt4KLYWI7Ro9ABfs3Qm6pWJ72VvxlPju
	0dANLM0mkfM84hsRN/EHpMb9CwxUSLpEXTpKs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wqksQ6D8LXV5Yr+bUdRAtmnY3dqRglXn
	ygIoVvKRPb+RoMz7BYXfYbq7rc3IHH7TglS7v6482PQ3SFvGXRCsnFhiVzrAm8zm
	Aj4y9hY6A9GJ7JvBGPKS2TzcKhmsqcMM6QqCUh4rmjYAKA3bXGfnO81+u2tFElTR
	2UKvhsQ6bTs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C77156DBD;
	Fri,  2 Mar 2012 11:59:13 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4A3286DBC; Fri,  2 Mar 2012
 11:59:13 -0500 (EST)
In-Reply-To: <CANYiYbG-Gp0cELF7_CxT1veRod+ookBaucfjCpWZjK1kTC0sAQ@mail.gmail.com> (Jiang
 Xin's message of "Fri, 2 Mar 2012 20:18:36 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 09A8628E-6489-11E1-96F7-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192050>

Jiang Xin <worldhello.net@gmail.com> writes:

> I know there are two config variables. i18n.commitEncoding will insert
> a "encoding XX" line to the commit object, while i18n.logOutputEncoding
> will set the default output encoding. But this implementation seems like
> a workaround.
>
> * Tree objects do not have such implementation, so multibyte characters
>    can not be used as filenames.

Even outside i18n/l10n context, projects that want to be usable by wide
population avoid filesystem-unsafe characters, which are not limited to
just multi-byte. Even though Git started on Linux, we do not have a file
whose name contains '\' or HT, which would have made it impossible to
check out on DOS.

It's just "common sense" or "common courtesy".

In any case, I do not expect we would need to have po/國語.po in git-l10n
repository, so this is a non issue in the context of this discussion
thread.

> * Commit object without "encoding" instruction will be used as it is. So
>   people under the same non-utf8 locale may not notice that they
>   have not set the proper i18n.commitEncoding, until one day they
>   need accross platform development.

That is why we have l10n coordinator who can vet such mistakes crawling
into our system, isn't it?

> I think save commit object, tree object, packed-refs in UTF-8 is
> a better implementation.

It is one of the better conventions to encourage.

It is entirely a different matter to forbid a closed local user community
from adopting GB, Big5, EUC or whatever character encoding as the encoding
of their choice, and using it throughout their project for pathnames, blob
payloads and log messages.

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5] diff: move TRANSLATORS comments so they're picked up
Date: Mon, 30 Apr 2012 10:30:24 -0700
Message-ID: <7v8vhdgma7.fsf@alter.siamese.dyndns.org>
References: <1335799995-7667-1-git-send-email-avarab@gmail.com>
 <1335799995-7667-2-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 30 19:30:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SOuQi-0000pl-Uc
	for gcvg-git-2@plane.gmane.org; Mon, 30 Apr 2012 19:30:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756493Ab2D3Ra2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Apr 2012 13:30:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61560 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756438Ab2D3Ra1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Apr 2012 13:30:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DF76F7AC8;
	Mon, 30 Apr 2012 13:30:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=PInbio6GXK9e
	Inr5LPUAJ3Gi31M=; b=tGChqzUBo7xOPc5ijH/3e4/eG16UDT2+t2uWrFinBEFC
	ML7MDdqyhwvXiYKqvJAhdj5eykc//hsbJQXRY9mHi0NMjuwRS2CHFN8Y+u5nuXSP
	gRG+WKITJYh6jMjSVouCIYiYZkFkoMfQOCwbJrXEYd0L2Cr+diDehIJt/NvkQ7o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=l/Ch8F
	RM//ldGr/6UrCRnn+DXsv9HxqKxb+tvRFBa3svjLIYFp7/XkAslRV/w4gGC/zvXS
	gQXyQWeZ22P9y88CqzIxZY99CH7MJvjnPDP0MMwdJVJJgtaVWNoBFKMca+PZGwoh
	faPIWKuRXBGLZ2ZRux4+Jy0s0197Lyysk6svA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D73E17AC4;
	Mon, 30 Apr 2012 13:30:26 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5E8D07AC3; Mon, 30 Apr 2012
 13:30:26 -0400 (EDT)
In-Reply-To: <1335799995-7667-2-git-send-email-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 30 Apr
 2012 15:33:10 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2C794C94-92EA-11E1-AC09-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196581>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> These TRANSLATORS comments weren't actually picked up by xgettext, th=
e
> comment needs to be right before the Q_() function call, evidently it
> isn't picked up if that call is wrapped in another function call.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.c=
om>

The patch makes sense as an advice to people who update sources where t=
o
place the "TRANSLATORS:" comment, but I am unsure about what this
particular one says. Are we assuming that translators do not know what =
the
sentence they are translating refers to?

>  		strbuf_addf(&sb,
> +			    /*
> +			     * TRANSLATORS: "+" in (+) is a line addition marker;
> +			     * do not translate it.
> +			     */
>  			    Q_(", %d insertion(+)", ", %d insertions(+)",
>  			       insertions),

What I am getting at is that this may be simply being unnecessarily noi=
sy
by trying to be helpful, and I am not sure if you are drawing the line =
at
the right level.  For example, "insertion" has many meanings and in the
context of this sentence it means lines added to the old material---sho=
uld
we mention that here, and tell translators to use the word that conveys
that particular meaning?

=46or this particular one, I'd be happier if the TRANSLATORS comment to=
ld
them to check if "diffstat" (which we borrowed this from) has a l10n of
this message for the language they are translating to, and make sure th=
ey
use the same format here.

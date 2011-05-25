From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] sh-18n: quell "unused variable" warning
Date: Wed, 25 May 2011 09:35:37 -0700
Message-ID: <7vy61u4u1y.fsf@alter.siamese.dyndns.org>
References: <62c2e1619edcb37c0411f29a34b6bc10e3899a97.1306317312.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed May 25 18:36:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPH48-00035v-Km
	for gcvg-git-2@lo.gmane.org; Wed, 25 May 2011 18:36:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932773Ab1EYQf4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 May 2011 12:35:56 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:37138 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932293Ab1EYQfr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 May 2011 12:35:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1055A52F8;
	Wed, 25 May 2011 12:37:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=r2MfQu96WusV
	DGKJyIgXR1TMfI8=; b=lwTdYrsjiiTGrkq9rg0wnF8Mgk0NIsHvYxxpi5Q+lj73
	4uK/f2258Wmd5quW5ia/BTJ/s/ikhzz3nS08D25JyX8+JSZ4BxJ35VcWIPKH/KKM
	l/MlMPQmy5icaiyVnNU5hqAnvkDiFqg6Q3DjI/yJQwhf1AIR9qyC3wDZw+jXwTE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=N4OyA4
	90ee+k8mzb+sxWb5uYr+SviENZ/hiMVoEgOkNJwsS4jGAFZPFJEm19jnFgYEX8UF
	Pz85hsVbjRL08qnPXvgoamTFybPDYLyGmpwtIl86mWrVz8Ehw9HbqJo27rtOcRjp
	wxdCJzq7CDIVVeW4zmQM918CrqcIVyjwtSn44=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CB9C652F6;
	Wed, 25 May 2011 12:37:50 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id AEE6952F2; Wed, 25 May 2011
 12:37:46 -0400 (EDT)
In-Reply-To: <62c2e1619edcb37c0411f29a34b6bc10e3899a97.1306317312.git.git@drmicha.warpmail.net> (Michael J. Gruber's message of "Wed, 25 May 2011 11:55:43 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 54B33A80-86ED-11E0-8ABA-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174426>

Michael J Gruber <git@drmicha.warpmail.net> writes:

>     CC sh-i18n--envsubst.o
> sh-i18n--envsubst.c: In Funktion =C2=BBmain=C2=AB:
> sh-i18n--envsubst.c:71:22: Warnung: Variable =C2=BBshow_variables=C2=AB=
 gesetzt,
> aber nicht verwendet [-Wunused-but-set-variable]
>
> show_variables is indeed unused. Comment it out rather than remove it=
 so
> that the relation with upstream remains clear.
>
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
> Why is it that even with LANG=3DC exported, gcc gives localized warni=
ngs?

Because you probably do not have LC_ALL=3DC?

In any case, thanks.

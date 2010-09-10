From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/5] gettext docs: add "Marking strings for translation"
 section in po/README
Date: Fri, 10 Sep 2010 15:26:33 -0700
Message-ID: <7vmxrpgrqe.fsf@alter.siamese.dyndns.org>
References: <AANLkTikdHZFmXAdABvS9hPXtbXNJU5NdCOrw5_KP73bX@mail.gmail.com>
 <1284147353-18000-3-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 11 00:26:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OuC3X-0003ys-Tp
	for gcvg-git-2@lo.gmane.org; Sat, 11 Sep 2010 00:26:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753176Ab0IJW0m convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Sep 2010 18:26:42 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:33874 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751991Ab0IJW0l convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Sep 2010 18:26:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 55C4ED5E19;
	Fri, 10 Sep 2010 18:26:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=u/IRk+KvR0Sb
	h8xVxx7PXMc/D90=; b=uvdmiw3z/Emh6ktCrJqUI9Cnfp8KPphtlpIfFnmvyOrV
	TvTFCpP0f8alUX/gqgiBhWkFNBxAQIJ24Pjae52aXvqQ2xXT3Sc8rAhEM+V3+Sda
	usTC8xQZEIA/i/7Ap5z1FhuY4FME4Fx4zuyxnF/MQ4jMS+g1CPsXM92Ho/Tqb0E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=XXuMrg
	Dv7riYNbobBJ9x0LQtrQi6AfzdKJkZqbeSHgNWE6SEjLGXrOUuqlSUhu2sgqsS/m
	ANz2A01D5Dor0SoBDOs3J+Sw6/BTFyte51J+8iC7u8LGkIjxUYQ9L/Yyg+br2wMS
	iI8Y12cbXYmHlSEiDrpd2RScgYF70mKekm1UI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 323ADD5E16;
	Fri, 10 Sep 2010 18:26:38 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8FC1CD5E15; Fri, 10 Sep
 2010 18:26:35 -0400 (EDT)
In-Reply-To: <1284147353-18000-3-git-send-email-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri\, 10 Sep
 2010 19\:35\:50 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7A407B1A-BD2A-11DF-B5C9-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155974>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> + - Don't mark everything for translation, only strings which will be
> +   read by humans (the porcelain interface) should be translated.
> +
> +   The output from Git's plumbing utilities will primarily be read b=
y
> +   programs and would break scripts under non-C locales. These strin=
gs
> +   should not be translated.

Hmm, I had to re-read the above twice and then mentally annotate "would
break ... _if translated_" to make sense of the advice.  Perhaps other
people are much less dense than me?

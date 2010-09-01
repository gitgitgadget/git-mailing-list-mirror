From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Why isn't builtin.h used by all builtin/*.c files?
Date: Wed, 01 Sep 2010 10:31:45 -0700
Message-ID: <7vvd6p5q0u.fsf@alter.siamese.dyndns.org>
References: <AANLkTinHtvHt0q=dK9KHtCX6JzymB5dx1NuaAZN_uu2R@mail.gmail.com>
 <4C7E69A5.4070008@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 01 19:32:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqrAO-0003Bq-5m
	for gcvg-git-2@lo.gmane.org; Wed, 01 Sep 2010 19:32:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754432Ab0IARb7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Sep 2010 13:31:59 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:63466 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754051Ab0IARb6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Sep 2010 13:31:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DD666D2432;
	Wed,  1 Sep 2010 13:31:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=PqrngJtexZOm
	Oe6ov4k2mC5a+rQ=; b=P2MWxFsmkJiVSo+hbj0ww75+Fx8A5ULeY9YRurlVjxZi
	lITGZZFmCbiLfJUG1tQnyYe20mcGwid9L+JbrJLiP48OJoH4+pQH74b1cU9MgRy+
	L/Cwc+TYJrK/pNqTZt9UbO47wicgcEE/U6WEBy15YkXEI6cFLGYFm29ETGy4bok=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=QsgAEn
	G3cjZBmDiVmhyUdNEun1DgagEXfBCsecthoqJj2DaJm9LeCjkxB87vTwRaEBhaHK
	Cyi32hU+lqhHuE+EgGllRmQBWc981LYUQTxn0szpmFr8Hb+gNKWMuoM/Ag3ob8s5
	W2pSB5o1YCwXASipWmF9j0v8OMkFIWxmRpzec=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 97EBAD2431;
	Wed,  1 Sep 2010 13:31:51 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C428CD242E; Wed,  1 Sep
 2010 13:31:46 -0400 (EDT)
In-Reply-To: <4C7E69A5.4070008@gmail.com> (Stephen Boyd's message of "Wed\,
 01 Sep 2010 07\:56\:37 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CE832062-B5EE-11DF-816E-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155064>

Stephen Boyd <bebarino@gmail.com> writes:

>  On 09/01/2010 07:17 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote=
:
>> I'm working on gettextizing the 'mainporcelain common' commands now,
>> and I ran into this:
>>
> [snip]
>>
>> Anyway, I'll convert these to builtin.h where appropriate as part of
>> the series unless someone can find a good reason not to.
>
> Sparse warns about this too. "Prototype not found, should it be stati=
c?"
> for a few cmd_*'s. So sounds good to me.

Sounds good to me, too.

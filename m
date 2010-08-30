From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 00/17] Begin gettextizing Git
Date: Mon, 30 Aug 2010 14:42:36 -0700
Message-ID: <7v39tveq0j.fsf@alter.siamese.dyndns.org>
References: <1283203703-26923-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Marcin Cieslak <saper@saper.info>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 30 23:42:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqC82-0007v6-Iz
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 23:42:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754294Ab0H3Vmw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Aug 2010 17:42:52 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:45865 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753346Ab0H3Vmw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Aug 2010 17:42:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CF521D2F35;
	Mon, 30 Aug 2010 17:42:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=13q89dN8yMCn
	tD8eKcKlEmnixy0=; b=yFoqM6H7yCc98y3NVpryzX+Se2bbk416uA2X9sdhAOYx
	HusjqLQdk78fWVcz0m0NQXBqvD7ULc5wUEufZkWzaARwtPCewOMzRGwkdUUjBwyl
	Utb98zYohB1+TPDMzf9mFK4Hp8hLBfFKmAkIcZk0qSkQ5q7RqiNvHWr/w/7Mt9I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Ah4uTq
	ujmJBdRD8xr4lb1+Elz8EsfvqNCd5GRREdFDCdct2qcA9PYczixg4JjQ85CYqJVL
	Y/2RYqBuEnD97TZUyHKyIerTua6AmPLbubOs2IETUKrHeitpNtObS6w0iIkuhWot
	J3W7ZfBepZPQq+QjnLAA9mac8Lfew9+2htMAI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 793B9D2F33;
	Mon, 30 Aug 2010 17:42:44 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 734D5D2F32; Mon, 30 Aug
 2010 17:42:38 -0400 (EDT)
In-Reply-To: <1283203703-26923-1-git-send-email-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon\, 30 Aug
 2010 21\:28\:06 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 85E5E9AE-B47F-11DF-AE6B-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154867>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Now that Git has the infrastructure for translation in next I'm going
> to start submitting patches to make the main porcelain translatable.
>
> This series starts that work, and fixes and also fixes up some of the
> infrastructure (like the bug discussed in "Odd encoding issue with
> UTF-8 + gettext yields ? on non-ASCII"), and adds tests to make sure
> it's all working.
>
> With it applied git-init is the one and only utility of the porcelain
> that's translatable. The series includes a translation of it into
> Icelandic and Polish.
>
> I think it's ready to be applied. I tested it on Solaris, FreeBSD and
> Debian. But there's almost definitely something I'm missing in a
> series this big, so it's an RFC.

Thanks; will queue them.

I however strongly suspect that we would be better off first kicking th=
e
earlier parts of i18n topic out of 'next' back to 'pu', as I am hoping
that we can declare feature freeze for 1.7.3 by the end of this week at
the latest, and you can never tell if we got the "infrastructure" right
without playing with a real "user of the infrastructure" like this 17
patch series, which means that the part of i18n topic that is already i=
n
'next' cannot be part of 1.7.3 --- it is way premature.

It was somewhat unfortunate and sad that your "test" series depended on=
 a
few patches from the i18n series, which means it is now taken hostage t=
o
the latter.  I'd rather want to have the "test" series in the 1.7.3, an=
d
we need to think about a way to untangle the two topics.

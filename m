From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jun 2010, #02; Wed, 16)
Date: Thu, 17 Jun 2010 16:37:52 -0700
Message-ID: <7vmxut1b8v.fsf@alter.siamese.dyndns.org>
References: <7viq5ict4p.fsf@alter.siamese.dyndns.org>
 <7vocf939vu.fsf@alter.siamese.dyndns.org>
 <0d059f457e2edc87093de2e0ea3c911a@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Andrew Sayers <andrew-git@pileofstuff.org>,
	Axel Bonnet <axel.bonnet@ensimag.imag.fr>,
	Brian Downing <bdowning@lavos.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	Finn Arne Gangstad <finnag@pvv.org>,
	Ian Ward Comfort <icomfort@stanford.edu>,
	Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Johan Herland <johan@herland.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	"Philippe Bruhat \(BooK\)" <book@cpan.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Simo Melenius <simo.melenius@iki.fi>,
	Stephen Boyd <bebarino@gmail.com>,
	Thomas Rast <tr
To: clement.poulain@ensimag.imag.fr
X-From: git-owner@vger.kernel.org Fri Jun 18 01:38:56 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OPOfg-000089-3X
	for gcvg-git-2@lo.gmane.org; Fri, 18 Jun 2010 01:38:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756554Ab0FQXiu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Jun 2010 19:38:50 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:42930 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752976Ab0FQXit convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Jun 2010 19:38:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0A5A6BC799;
	Thu, 17 Jun 2010 19:38:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=ZCi7qNM50gJS
	2KIDLvarBKe3ClU=; b=p3G3r1TVUm758RdCTLX6WbOTL7UtcBYLAWDJ1mbEnrWV
	8PjeB9OYyKvpr3sOq6b68ktUkmza78by6A8xgdGO5xYX6kdK4Np6f776ymeRxWE5
	J0tgFcwHvkoN7ot+SqgVVj6cWcYgw5Ofjw9oKt7aO/mpp6xCpNIAzNCHdSGd2xM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=F17Wpt
	RJgwugkFNelJUZn0uHDlovDpXciT1mwvXV/uIxx0G+W8TB3W0uClV8ib4a/l3JKC
	NNxWgDX0fHq85RU+1DSK3jL0lDVqB68k2lcZheSGZrND3YBS79Nz1CsDqfRLgLc+
	N5pD1VnO1vqYktZaW0zBfTy6ZVGNmH+1egXUs=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 68E61BC795;
	Thu, 17 Jun 2010 19:38:21 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6E52CBC790; Thu, 17 Jun
 2010 19:37:54 -0400 (EDT)
In-Reply-To: <0d059f457e2edc87093de2e0ea3c911a@ensimag.fr> (=?utf-8?Q?=22C?=
 =?utf-8?Q?l=C3=A9ment?= Poulain"'s message of "Thu\, 17 Jun 2010 21\:05\:59
 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6A1031BC-7A69-11DF-9DA8-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149333>

Cl=C3=A9ment Poulain <clement.poulain@ensimag.imag.fr> writes:

> A fix was proposed here:
> http://mid.gmane.org/1276610328-28532-1-git-send-email-axel.bonnet@en=
simag.imag.fr

This one changes textconv_object() to take a pointer to ulong*; a calle=
r
is changed to cast a long* down to that pointer (in fill_origin_blob);
that is shifting one type-punned pointer problem to another one, so I d=
o
not think it is an improvement.

> http://mid.gmane.org/1276617028-5265-1-git-send-email-clement.poulain=
@ensimag.imag.fr

=2E.. and this depends on that.

The solution should be along the lines of what Jeff outlined in=20

    Message-ID: <20100615110710.GA1682@sigill.intra.peff.net>

i.e.

    The only portable way in C to convert between types is by assignmen=
t. So
    you have to do:

      unsigned long foo;
      textconv_object(read_from, null_sha1, &buf.buf, &foo);
      buf.len =3D foo;

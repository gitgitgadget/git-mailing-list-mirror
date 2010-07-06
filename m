From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Make author and committer available to pre-commit hook
Date: Mon, 05 Jul 2010 20:04:39 -0700
Message-ID: <7vocel5n08.fsf@alter.siamese.dyndns.org>
References: <AANLkTinpCDRf_Yhuj2-tdZwmvHk8yna1Xjdtbrmx35CB@mail.gmail.com>
 <20100705114619.GA21146@sigill.intra.peff.net>
 <AANLkTinlGBt3nBa7Ge5ytjisTeDu3As4wCkF8M1iz5JV@mail.gmail.com>
 <AANLkTim-TXX4uVyUN9loOI276wnKp22m4F7g5c-js61U@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Gisle Aas <gisle@aas.no>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 06 05:04:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OVySt-00085j-0w
	for gcvg-git-2@lo.gmane.org; Tue, 06 Jul 2010 05:04:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756518Ab0GFDEv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Jul 2010 23:04:51 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:65169 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755645Ab0GFDEu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Jul 2010 23:04:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CD5A6C2E4B;
	Mon,  5 Jul 2010 23:04:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=tW9ApEIz1e13
	m8wI8OWRZCt9l2M=; b=VNPm7g8dgPa6z8iGCdifAwaOfxdlZ9TVDnuw2I7YGQjE
	fPxogMMBjVpVsUBCWvPK0AC7I2/oYjfk0xAVAJzdJP2b0xrABTbLTAOni7H73Sgv
	pxJrEIYGDoyyIRff5U1D8MLLhys2b5tZ8/+1KacAJXV3rgmPyYgBcQzvLJXdE40=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=DgcxMS
	YQmIayXbPHdDVfixEDAHd4RNSrK60soPuG7JxU7Kv7h0rf/wKrB2PhggX62UYTLm
	Xj2X6EfdastaPRTgVWFPGyl5KNBA7ktvoYOHtJyoAICxOQPfet+RyHSVRFJFhMmD
	lUL3vJa86q0sMPYbjlLqkEl/VSDK6e5xevff0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7C190C2E47;
	Mon,  5 Jul 2010 23:04:45 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9276DC2E46; Mon,  5 Jul
 2010 23:04:40 -0400 (EDT)
In-Reply-To: <AANLkTim-TXX4uVyUN9loOI276wnKp22m4F7g5c-js61U@mail.gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon\, 5 Jul
 2010 21\:31\:13 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3AFC7462-88AB-11DF-B16A-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150318>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Hi, just a note that patches submitted for inclusion in Git should
> have [PATCH] in the subject, be submitted inline and you should CC
> Junio.

Thanks.  Please add "... after a list concensus that it is a good chang=
e
is reached" at the end.

I wonder if we should also make author/committer dates available via th=
e
same mechanism.

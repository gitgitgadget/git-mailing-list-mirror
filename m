From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Do not install shell libraries executable
Date: Sun, 31 Jan 2010 13:08:43 -0800
Message-ID: <7veil6c78k.fsf@alter.siamese.dyndns.org>
References: <20100129102518.GA5875@coredump.intra.peff.net>
 <20100129103723.GC6025@coredump.intra.peff.net>
 <20100129145025.GA22703@progeny.tock>
 <7vhbq2g3a9.fsf@alter.siamese.dyndns.org>
 <20100131083459.GA18561@progeny.tock>
 <7vy6jecb0y.fsf@alter.siamese.dyndns.org>
 <20100131200028.GA4045@progeny.tock>
 <7vockaca5w.fsf@alter.siamese.dyndns.org>
 <20100131210052.GA4435@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	David Aguilar <davvid@gmail.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 31 22:09:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nbh2r-0008Lh-WA
	for gcvg-git-2@lo.gmane.org; Sun, 31 Jan 2010 22:09:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754492Ab0AaVJD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 31 Jan 2010 16:09:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754490Ab0AaVJB
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Jan 2010 16:09:01 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:46330 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754484Ab0AaVI6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 31 Jan 2010 16:08:58 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 394B6960A3;
	Sun, 31 Jan 2010 16:08:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=2MYX5pLvwPZI
	tf9DRpjKZvESuGU=; b=dBnaiF7/sWoQXPldxnSL4HjHLtofpo/jaqC622aS3g9j
	R0dQ6pqgnsQ9KX7jHZSj1wWlN3DAQOMuVU47tzot4wuYKZUPpgdLAS/dT5f5f6yf
	IpmHAV9FZO2HNNV6UDYH1N9hVNbotoB32IFdW7NBrjjGD0U0yM+E8r6GxtQkSRo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=GVs0WP
	8QGfkKznTyToZfj0TXW/tBFsw5j6SBYrQG3+KMZ7hpVEjjk+tG/4n6KGfUmPJnp+
	ps0fePnMtcSKaKlAeik3MhBT+KKyz/tV0ykLPjTtj5Ns4Oje3F6YF4h4sBQmQKhj
	i164zku2wi1uBX8xWLkmW/zyANZBcZ9lpK76s=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D50B49609F;
	Sun, 31 Jan 2010 16:08:50 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EC67B96096; Sun, 31 Jan
 2010 16:08:44 -0500 (EST)
In-Reply-To: <20100131210052.GA4435@progeny.tock> (Jonathan Nieder's message
 of "Sun\, 31 Jan 2010 15\:00\:52 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D4997B70-0EAC-11DF-8D3C-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138561>

Jonathan Nieder <jrnieder@gmail.com> writes:

> I wrote that patch late at night, and unfortunately, I cannot justify=
 it
> to myself now.  With Jeff=E2=80=99s change applied, there is no obvio=
us breakage
> that it fixes.  If a problem comes up again, I will let you know.

Thanks for a thorough write-up.  Really appreciated.

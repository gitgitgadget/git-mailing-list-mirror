From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5 v2] t7607: use test-lib functions and check
 MERGE_HEAD
Date: Wed, 13 Oct 2010 14:33:14 -0700
Message-ID: <7vhbgpkcbp.fsf@alter.siamese.dyndns.org>
References: <7v4oepaup7.fsf@alter.siamese.dyndns.org>
 <1286632380-7002-2-git-send-email-drizzd@aon.at>
 <20101010063527.GC23100@burratino> <20101010083543.GA12186@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Wed Oct 13 23:33:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P68x6-0006w1-IF
	for gcvg-git-2@lo.gmane.org; Wed, 13 Oct 2010 23:33:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753158Ab0JMVd0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Oct 2010 17:33:26 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:48455 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751675Ab0JMVd0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Oct 2010 17:33:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8FAF5DE7CD;
	Wed, 13 Oct 2010 17:33:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6Hxp6GyoD0CfxRc2C0gEfVzfFas=; b=pucuCh
	BQ5MlrO8F78KdfRD6Cz1wyigoYKvLkIBhBV/cCuiBY8u8oCAYlWPbj/je2sw/i+e
	mV9OhlMqnGBUQTnEujdks7JLL5W9zUQeee76fvfDKeamBR4VJ/DI1TMfJ7lnApC0
	a9hp+P7fCHOLNwKlrOf74xqo6By9XMxQDKiDM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uNsDqN5vsPjJNOt0avISXGo9Mu7l6VXR
	KCNEVaXCEcLOqsR/ZjPg+oGKy+UOFRXb2RMteYL2eFPeRWUJ13MEVG4hDSbMKjBt
	f0XQMnaSo8FSJ1NE79es8AMkas8K8h2o0kRdPZUaxE/oblOjJhdbPQ+SFF5gWjtC
	81NTU5VShX4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 511CBDE7CA;
	Wed, 13 Oct 2010 17:33:20 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7ABD9DE7C8; Wed, 13 Oct
 2010 17:33:16 -0400 (EDT)
In-Reply-To: <20101010083543.GA12186@localhost> (Clemens Buchacher's message
 of "Sun\, 10 Oct 2010 10\:35\:43 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7FCE27AC-D711-11DF-B6FD-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158980>

Clemens Buchacher <drizzd@aon.at> writes:

> --ew6BAiZeqk4r7MaW
> Content-Type: text/plain; charset=us-ascii
> Content-Disposition: inline
> Content-Transfer-Encoding: quoted-printable

Please don't do this...

>
> --ew6BAiZeqk4r7MaW
> Content-Type: application/pgp-signature; name="signature.asc"
> Content-Description: Digital signature
> Content-Disposition: inline
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.10 (GNU/Linux)
>
> iQEcBAEBAgAGBQJMsXrfAAoJELKdZexG8uqM/BwH/Ai2w+DFW4L9D1SivLoxDL8/
> Z3YDRrx5oJa35ZhbBwInGJx7xwXG3Pn/mx0avGwoRwQe9cRufp6AO5hHUq3U1LNv
> ZaP4RdlScMqeuKUu8mrbjJs4kumL/sjZ59MRnBZzX1Ovdq/GbKhJqidYTvmHQc6e
> 0sngXx9Jf1WlS7m1sDztYPRJ3z2lF0js+BNHLIVOi6CgSbBJYdQzeLrvO/BVX9V0
> P2F0bGZLWTqqOSLMav5jcYFAgIv8mRqxjre+1IviFuGTuu5hX7yTx++qAiV8CK0f
> Fpe0HNQlYahbytd9qlOoqsbV5fuXkOoFqYHKmT6461u31QHaYPyBwsSWgjkF9IE=
> =3pEL
> -----END PGP SIGNATURE-----

Nor this.

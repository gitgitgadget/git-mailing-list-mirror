From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 10/10] merge-recursive: add a label for ancestor
Date: Mon, 15 Mar 2010 01:29:28 -0700
Message-ID: <7vr5nm0yzb.fsf@alter.siamese.dyndns.org>
References: <20100305215253.364.63583.reportbug@localhost>
 <20100305221950.GB5083@progeny.tock> <20100315074748.GA28827@progeny.tock>
 <20100315080703.GJ8824@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Stefan Monnier <monnier@iro.umontreal.ca>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 15 09:29:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nr5gF-0005Du-Vo
	for gcvg-git-2@lo.gmane.org; Mon, 15 Mar 2010 09:29:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756252Ab0COI3i convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Mar 2010 04:29:38 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:59278 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752337Ab0COI3h convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Mar 2010 04:29:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D02C0A1F5B;
	Mon, 15 Mar 2010 04:29:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=DyxPe1RCnp7+
	KNyxDQReO71X7zk=; b=KlFY4G1stFxmMoIO3qzSAP6/STPor0yWj7471uy17Hrv
	2V1hIRbteWL0fc+otp22AmwtjXAi//z2aXAYBEjcEvQSSzzB+b1ETsFZTCujXojm
	g15tOCLo+D33axiczozGI8ACjSVwZSRt43mDGedzNIjt+SIYZjW2OpNS9ypbbEI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=BwSeRI
	h6eMtEcBEfRcCLRjtTqhzWwFwXiI8tM0RUic0XTjfbWt8xIP4yv7tRpXSDQ7Dx/I
	luLmr4JvzCnN3ii6L8JNzpIxBZkinz13wCVKCPHKvHFcfACu271EXIRGR5OJm7CD
	0zP28ClMSTgssrY2TmX2cpint+JnTKyF17pA4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 98DB8A1F5A;
	Mon, 15 Mar 2010 04:29:33 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 05D88A1F58; Mon, 15 Mar
 2010 04:29:29 -0400 (EDT)
In-Reply-To: <20100315080703.GJ8824@progeny.tock> (Jonathan Nieder's message
 of "Mon\, 15 Mar 2010 03\:07\:04 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E2209BE4-300C-11DF-B259-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142190>

Jonathan Nieder <jrnieder@gmail.com> writes:

> I would be interested to know which merge tool chokes on |||||||. ;)
> As it is, since I haven=E2=80=99t experienced the mechanical misbehav=
ior, I
> am targetting humans.

Even if there weren't any broken tools, I think targetting humans is a
good thing to do, as long as we don't break ourselves (including old
rerere database).

> That=E2=80=99s the end of the series.  Thanks for reading.

Thanks for writing.  I think this is generally a good thing to have,
and from my cursory look I didn't see anything glaringly wrong except f=
or
the one I already commented on the first patch.

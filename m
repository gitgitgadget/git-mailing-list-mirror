From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/3] parse-options: disallow --no-no-sth
Date: Wed, 29 Feb 2012 11:02:57 -0800
Message-ID: <7vd38xtqce.fsf@alter.siamese.dyndns.org>
References: <4F49317A.3080809@lsrfire.ath.cx>
 <4F49332E.7070003@lsrfire.ath.cx> <7vy5rpcgrk.fsf@alter.siamese.dyndns.org>
 <87d390smpa.fsf@thomas.inf.ethz.ch> <7v8vjob3ff.fsf@alter.siamese.dyndns.org>
 <4F4BC3B3.7080000@lsrfire.ath.cx> <7vzkc457g3.fsf@alter.siamese.dyndns.org>
 <4F4D3545.6060704@lsrfire.ath.cx> <7vlinmy80x.fsf@alter.siamese.dyndns.org>
 <4F4E6912.7060204@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org,
	Bert Wesarg <bert.wesarg@googlemail.com>,
	Geoffrey Irving <irving@naml.us>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pierre Habouzit <madcoder@debian.org>,
	Jeff King <peff@peff.net>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Wed Feb 29 20:03:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2onr-0003xJ-6I
	for gcvg-git-2@plane.gmane.org; Wed, 29 Feb 2012 20:03:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966118Ab2B2TDA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Feb 2012 14:03:00 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39930 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964992Ab2B2TC7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Feb 2012 14:02:59 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4FCD56989;
	Wed, 29 Feb 2012 14:02:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=IyX4R9uH8yKH
	c82fjvOPv/euTkI=; b=Fp22tQ0nIATTPk9bI0JuTzylhbe9OT7KlznxLba8j+NI
	vx95LT3RgIIr2USWRM07tdTSc0FTBdl3skpl+hz4Zl45yBz8Unh0Tui1c09uWnLH
	MmwWDCtzQgL7SXkMjycNARFa4sVAdAMbQVVXRSZwSO/j00gpo245PIOEtmbMIk4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=sezST4
	OG0sC3YS/mDWOc9tuJS3JPG9PutkzfHU6k9mT6ORovLyOjc3cc3q0KxYm/pyP9j9
	0Lb/AodwuTxPsxb5ExZpH+TuSqwPhS0vKwo82es13pFnXcwrnOh4sqsPTwKWpJW0
	a++eOEqIPk+M85DqA/t/m/mtct6n4h2pAts/Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 449356988;
	Wed, 29 Feb 2012 14:02:59 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AE7816985; Wed, 29 Feb 2012
 14:02:58 -0500 (EST)
In-Reply-To: <4F4E6912.7060204@lsrfire.ath.cx> (=?utf-8?Q?=22Ren=C3=A9?=
 Scharfe"'s message of "Wed, 29 Feb 2012 19:06:10 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FEBFB0C0-6307-11E1-96DF-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191843>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> Please drop this extra patch if I misunderstood you, in order to keep
> backward compatibility.

I do not think it makes practical difference between accepting silently=
 or
forbidding, so let's stop at 3/3 and keep --no-no-sth working.

Thanks.

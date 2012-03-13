From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git push default behaviour?
Date: Tue, 13 Mar 2012 05:34:22 -0700
Message-ID: <7vlin4llwx.fsf@alter.siamese.dyndns.org>
References: <CAFsnPqp1+jX3ZY0LZ1QDmvA=2_ebApPBttwFjr36OuTX2_MHug@mail.gmail.com>
 <87k42vs8pi.fsf@thomas.inf.ethz.ch>
 <CAFsnPqopZEZeeuFzK4ZoUjGnfpiv5oMs=xV5XBSgSyGLXOwgqA@mail.gmail.com>
 <1331202483.21444.11.camel@beez.lab.cmartin.tk>
 <CAFsnPqpnH2CTki8zz6Mpz=qrdxF_aTA92cPrn1L9MQZVMoxdeg@mail.gmail.com>
 <1331203321.21444.13.camel@beez.lab.cmartin.tk>
 <4F58C977.8000400@xiplink.com> <vpq62efjeqd.fsf@bauges.imag.fr>
 <CAHkcotiOGaOdDvibpoiEgys3PnSPfSw0mT3DeEOix+FuboULiA@mail.gmail.com>
 <vpqfwdjas0m.fsf@bauges.imag.fr>
 <20120309033826.GA6164@sigill.intra.peff.net>
 <7vsjhi9wku.fsf@alter.siamese.dyndns.org> <vpqobs65gfc.fsf@bauges.imag.fr>
 <7vwr6u6qrn.fsf@alter.siamese.dyndns.org> <vpqmx7mcgdz.fsf@bauges.imag.fr>
 <7vk42pu6io.fsf@alter.siamese.dyndns.org> <vpqwr6o3k9s.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Dmitry Potapov <dpotapov@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	Jeremy Morton <jeremy@configit.com>,
	Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Mar 13 13:34:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7Qvu-0006gF-Lm
	for gcvg-git-2@plane.gmane.org; Tue, 13 Mar 2012 13:34:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752044Ab2CMMe0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Mar 2012 08:34:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55315 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752003Ab2CMMeZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2012 08:34:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5657F41A5;
	Tue, 13 Mar 2012 08:34:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5Vlj6+LuMavTIN8PYs7AIecnM18=; b=U+8jAH
	ivbbg6ujYvs+6LdQkIBSCcnRs7C2xQPVbKYi9h0PeAETsb/NrOQt8iwdXg4al5Ya
	S0JvfY1Jb18ENY1vMJoMRai+mhta+qDIlF58iCYxqa2QGjRX6Pd8E4X5kY/TAKjP
	fixNhqYGOQrgQBZpGVSAi7nS6MZMp2B6kRoLg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=owgIQsGSfUN0N9d0Na8wptltgt88Llr2
	rbDuws/zblrbsFkgarzFEa/UtrLOSlcFDP1EqHq+yXYrSm0beu+OnDJQ3qd9tg8n
	ji9adJ8gBkGi5xF+W25Otrk/awQyfO9jK22MN6H1s09f7y6WuMyZbKNuBXvFSt2d
	ycegftKXG4A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4BFA041A4;
	Tue, 13 Mar 2012 08:34:24 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C0CE241A3; Tue, 13 Mar 2012
 08:34:23 -0400 (EDT)
In-Reply-To: <vpqwr6o3k9s.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Tue, 13 Mar 2012 10:47:11 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DD54F49E-6D08-11E1-8437-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193012>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

>> Sounds OK from a cursory read, except for a few minor details.
>>
>> Thanks.  Nitpicks follow.
>
> I'm taking them all. Here's the result:

I'd hold onto this version for a few days before I paste it in my
blog or send it to k-list in order to give others a chance to
improve the text further, but this looks good (obviously) to me.

Thanks for getting the ball rolling.

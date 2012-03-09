From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git push default behaviour?
Date: Fri, 09 Mar 2012 08:23:18 -0800
Message-ID: <7vk42t7ngp.fsf@alter.siamese.dyndns.org>
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
 <7vwr6u6qrn.fsf@alter.siamese.dyndns.org>
 <m3ipidzuxp.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>, Dmitry Potapov <dpotapov@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Carlos Martin Nieto <cmn@elego.de>,
	Jeremy Morton <jeremy@configit.com>,
	Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 09 17:23:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S62bG-0005dn-1A
	for gcvg-git-2@plane.gmane.org; Fri, 09 Mar 2012 17:23:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932361Ab2CIQXV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Mar 2012 11:23:21 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46733 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932200Ab2CIQXV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Mar 2012 11:23:21 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BE8E556B8;
	Fri,  9 Mar 2012 11:23:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7kltMDEfv3ZsuWc832KfnCtxVSM=; b=rRGMas
	mTo4lYfanG6sDlkFD9E74Np9BW1iDqlI5nvQ4pxC7qm5AocPiYVk+qQCyRNyuOOJ
	c5mgWY0QPqP0cKsasjXKlROR6m04BWGd0Xl9xM1cVTHDmAcu67pVu9/+uJ/Jumy1
	Pdgn1Ynbmc5I1nLiKaxOaYK3MAaPDOLWJc1XI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=V0VtPxXBt3vi3zhUaEdIjZrCNI7Hbwz4
	2lfaIWEHzZ5Seca6eU5eTr06h1qAJrrwBVQCpwvPTvQgN9CBNlcvHrPgDKSpUG9U
	4kKSHEbFQo2vd0iT0TXGk/AJokarNcAgwCzk5WIW2CcNqIaHJ9hTUnQiTWYJQGvR
	CUKBGoZQ/JA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B366656B7;
	Fri,  9 Mar 2012 11:23:20 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2868556B5; Fri,  9 Mar 2012
 11:23:20 -0500 (EST)
In-Reply-To: <m3ipidzuxp.fsf@localhost.localdomain> (Jakub Narebski's message
 of "Fri, 09 Mar 2012 06:56:34 -0800 (PST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2F31A8A0-6A04-11E1-9002-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192725>

Jakub Narebski <jnareb@gmail.com> writes:

> There are other places where we can send such message beside git
> mailing list and LKML: There is Junio's "Git Blame" blog, there is Git
> page on Google+; we can ask for such annoncement to be posted also
> on GitHub Blog...

And you are saying who will do all of the above?

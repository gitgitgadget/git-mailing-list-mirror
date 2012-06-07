From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t1304: improve setfacl prerequisite setup
Date: Thu, 07 Jun 2012 09:16:05 -0700
Message-ID: <7vlijzjdx6.fsf@alter.siamese.dyndns.org>
References: <vpqk3zlhorc.fsf@bauges.imag.fr>
 <20120605140449.GA15640@sigill.intra.peff.net>
 <20120605141039.GB15640@sigill.intra.peff.net>
 <20120605142813.GA17238@sigill.intra.peff.net>
 <20120605150550.GA19843@sigill.intra.peff.net>
 <7vpq9dpvnp.fsf@alter.siamese.dyndns.org>
 <20120605164439.GA2694@sigill.intra.peff.net>
 <7v62b5pt2s.fsf@alter.siamese.dyndns.org>
 <20120606132824.GA2597@sigill.intra.peff.net>
 <7vvcj4ml6a.fsf@alter.siamese.dyndns.org>
 <20120607090200.GA6087@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Stefan Beller <stefanbeller@googlemail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 07 18:16:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ScfNe-0006so-Pp
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jun 2012 18:16:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752777Ab2FGQQK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jun 2012 12:16:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53325 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751517Ab2FGQQJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2012 12:16:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 240A97BDE;
	Thu,  7 Jun 2012 12:16:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IdRIwQ/b3dAyVmMWOAhYVi5MHUI=; b=BcM+JB
	J4+7qvvaBb+VQAlP5w0W87ZO2F1d05+pQ/sNFniCl6brvy+cl9MtgRaW6Cets9Vg
	oJRJ57Ha/lrmp90WT3dAY/s9GjXoBsjzeNUYBPaJu8r8dj9dW4CZRgxyzqhH6zCQ
	rlj2r0bNEhQz0/rhx4SzHOds0sgqCx0yXFVEA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ewl05R3YUbvJU8yRKs1mAaAsACbEsLeM
	SCItbqy47XhjZk0urbbdJukD6C7Unsetg9Wrgdn16oks3dmp+dPBAMg1b/lTMt6z
	8s4Dm3yCikuOuf2/pYtlevoVV/4dosc1Valv0fopVLtCgdwjlwmhgE4Ej+Y9/TlE
	jLt+IQn6QCk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1B6857BDD;
	Thu,  7 Jun 2012 12:16:07 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AF53D7BDC; Thu,  7 Jun 2012
 12:16:06 -0400 (EDT)
In-Reply-To: <20120607090200.GA6087@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 7 Jun 2012 05:02:00 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 16006B88-B0BC-11E1-B882-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199413>

Jeff King <peff@peff.net> writes:

> I intentionally did not anchor it because the tests themselves did not,
> and I worried that that there was some subtle portability issue there
> (especially because of the magic "let there be two colons" part of the
> pattern).

OK, fair enough (the "two colons" one I think was for Solaris).

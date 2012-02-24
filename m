From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG?] bulk checkin does not respect filters
Date: Fri, 24 Feb 2012 10:48:21 -0800
Message-ID: <7vd394130q.fsf@alter.siamese.dyndns.org>
References: <20120224030244.GA15742@sigill.intra.peff.net>
 <7vvcmw2a3m.fsf@alter.siamese.dyndns.org>
 <7vr4xk28z0.fsf@alter.siamese.dyndns.org>
 <20120224075425.GA18688@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 24 19:48:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S10Bx-0005Tn-Td
	for gcvg-git-2@plane.gmane.org; Fri, 24 Feb 2012 19:48:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754719Ab2BXSsY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Feb 2012 13:48:24 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55546 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752714Ab2BXSsY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Feb 2012 13:48:24 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2F431715B;
	Fri, 24 Feb 2012 13:48:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iZr+mXKW3mslqGVawxGuiInPXyk=; b=PYyAlr
	1/mBsl+6NI9Skhp4f11ZFgQJMNGrRHwrW9KltlSNLr5SmlvOrSpGsYx7UCuJ35Oq
	+lDuz3PQ7n3enFijz9sH1H0LES00soNnWRonSKDgr7gFYcgimSBkgV0xg4XVPKdH
	h22iS13RmbwGqF8KCTJLpXsj/vDKJEk7XDTxE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aU+2Vnv+K6wYS7qLpS9/RBhGvipnN0+o
	PqM6GwefO0NxM/Orl92ClbiIxGUCPv1AqI3NX1jj0mnw7zBvUEBBEmnQp0XVfIq2
	On0opJ0ZV1gxAtwBnqg/mILSf3UKek6aaBjGPEe8sVRRnTuZlBfjcGzCBgtitIps
	jpLuCBsp/vc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 270B0715A;
	Fri, 24 Feb 2012 13:48:23 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B1DB07158; Fri, 24 Feb 2012
 13:48:22 -0500 (EST)
In-Reply-To: <20120224075425.GA18688@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 24 Feb 2012 02:54:25 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2086F05E-5F18-11E1-93B6-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191444>

Jeff King <peff@peff.net> writes:

> Isn't write_entry the _other_ side of things. I.e., checking out, not
> checking in?

Ah, of course.

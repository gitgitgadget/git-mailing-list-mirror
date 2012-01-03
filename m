From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Stashing individual files
Date: Tue, 03 Jan 2012 12:45:36 -0800
Message-ID: <7v39bwtszz.fsf@alter.siamese.dyndns.org>
References: <CAJ6vYjduoBNrRcvcvQbX_yY-3-Qm5ZbXOM0WQpWRwC1H1OCqaA@mail.gmail.com>
 <20120103190612.GC20926@sigill.intra.peff.net>
 <7vfwfwtup7.fsf@alter.siamese.dyndns.org>
 <20120103201323.GA4340@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Leong <walkraft@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 03 21:45:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RiBF2-00019j-FB
	for gcvg-git-2@lo.gmane.org; Tue, 03 Jan 2012 21:45:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755237Ab2ACUpl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jan 2012 15:45:41 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56057 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754643Ab2ACUpj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jan 2012 15:45:39 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 97BEB6BB9;
	Tue,  3 Jan 2012 15:45:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ouKZWFEnkcfmt78GaFrxU+2cDCM=; b=tIpyp2
	F7QvqDp8TOc4shV3yUzvaTpRI9BBJ2+rts/n+pEzTWYx4plTKSOA9wQ3q2zPUJT7
	vuylxmUdG2qxzRxbN/UNfW7OghUqYYtrtSTWJR3k+V/Xn89Bak/pVXRDtzPtgMsS
	XOTebXgHu4C+d051Ucbo9fILZa/kkiEHHsa7I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=P499tqCzP/EUGoyjsa3r9SI7FaEczDbg
	oaxOwsE/GoLYyA6HcrHfxHAl4V8GhoPJXPhfRRqUvl8X4z8puLYYdJJju6A3C9oJ
	rS4Kg+FpdR3n+R1TzFHJNzYOkX6bsCQs3J00zp3h4qnOppxmawCtMuCUqVwhJ1g5
	mqn7keXjxYY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8CB9F6BB8;
	Tue,  3 Jan 2012 15:45:38 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 215706BB7; Tue,  3 Jan 2012
 15:45:38 -0500 (EST)
In-Reply-To: <20120103201323.GA4340@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 3 Jan 2012 15:13:23 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E47A01D6-364B-11E1-A111-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187895>

Jeff King <peff@peff.net> writes:

> We already have partial stashing like this via "git stash -p".  This is
> just a shorthand for "say yes to all of the changes in foo.c, and no to
> everything else". So I don't see it as particularly new or dangerous.

Ok.

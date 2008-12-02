From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Managing websites with git
Date: Tue, 02 Dec 2008 11:07:54 -0800
Message-ID: <7vd4gapf91.fsf@gitster.siamese.dyndns.org>
References: <fe5a74300811300830x850d81csc5cf1f9b367bac11@mail.gmail.com>
 <20081130170722.GJ6572@eratosthenes.sbcglobal.net>
 <20081130172717.GA7047@coredump.intra.peff.net>
 <87k5ajflp0.fsf@sparse.dyndns.org>
 <20081202011154.GA6390@coredump.intra.peff.net>
 <87vdu2po5l.fsf@sparse.dyndns.org>
 <20081202165507.GA15826@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jason Riedy <jason@acm.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 02 20:09:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7ack-0007x5-05
	for gcvg-git-2@gmane.org; Tue, 02 Dec 2008 20:09:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754004AbYLBTII (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2008 14:08:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752507AbYLBTIH
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Dec 2008 14:08:07 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:62406 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752435AbYLBTIG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2008 14:08:06 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 0614717F18;
	Tue,  2 Dec 2008 14:08:02 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id A361A17F11; Tue, 
 2 Dec 2008 14:07:56 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8A666B00-C0A4-11DD-B9B8-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102168>

Jeff King <peff@peff.net> writes:

> On Tue, Dec 02, 2008 at 10:55:34AM -0500, Jason Riedy wrote:
>
>> Ah, ok, thanks!  Issuing a warning makes sense.  I'm not sure if
>> denying such a push by default does...
> ...
> It shouldn't make you change how you work. At most, it will break an
> existing setup until you set receive.denycurrentbranch to false (again,
> if and when the default value changes). You can prepare for any such
> change now by pre-emptively setting the config value.

True.

But "pre-emptively" is a bit misleading.  Please realize that the warning
is not about "this is a risky thing to do, you've been warned", but is
about "the behaviour to allow this may change in the future; if you rely
on it please set this config before that happens".  We may end up not
flipping the default for a long time, but setting the config also has the
side effect of squelching the warning, so it never hurts to set it now.

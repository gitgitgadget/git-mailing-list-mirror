From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git notes: notes
Date: Wed, 20 Jan 2010 14:33:48 -0800
Message-ID: <7vpr54z9rn.fsf@alter.siamese.dyndns.org>
References: <20100120050343.GA12860@gnu.kitenet.net>
 <201001201148.11701.johan@herland.net>
 <20100120182438.GB31507@gnu.kitenet.net>
 <7vhbqg376b.fsf@alter.siamese.dyndns.org>
 <20100120195626.GA6641@gnu.kitenet.net>
 <7vska01qrt.fsf@alter.siamese.dyndns.org>
 <4B576F5C.2050102@drmicha.warpmail.net>
 <7veilk1o3s.fsf@alter.siamese.dyndns.org>
 <7v3a201lpz.fsf@alter.siamese.dyndns.org>
 <20100120222548.GD15936@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Joey Hess <joey@kitenet.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 20 23:34:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXj7v-0001Dy-DZ
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jan 2010 23:34:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754573Ab0ATWeL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2010 17:34:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754043Ab0ATWeK
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jan 2010 17:34:10 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:40505 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753361Ab0ATWeE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2010 17:34:04 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6C78E92146;
	Wed, 20 Jan 2010 17:34:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gXjGxQ13F3fLUCELJkQBWUdEqYo=; b=B8+H+W
	AFjQ05OaOSRCCs7lxIKOG0NBysT0s4AObrItfPvrjrbNCeKrjEhiNeuaorMO+0Je
	/FIKa+rDkE7QkcpqwNq1QoBfTStD8H/1pM/k+/a8U/YaLPSs+x0S8uCeRBKB85JK
	Px6X1DJqp0QoTQ9Ii+5d34ujKcaUp570IU0Yw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WvVSvtp3bUMvISGlU69PKYWoeimWV/jg
	e3nS5baWARuOdVRVnrS4diw+cDPzxufE2UNtA9nIZcOnLFTfLZteknTUOgvHezLV
	ywhANOK+DmPKNOu9sBltpH6k+MhZMm6u1ftbjT/OuwRT63vPd90lzIMH0UR6UxR1
	xB+g9/I9GFQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EF7B592145;
	Wed, 20 Jan 2010 17:33:56 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C90AE92128; Wed, 20 Jan
 2010 17:33:49 -0500 (EST)
In-Reply-To: <20100120222548.GD15936@coredump.intra.peff.net> (Jeff King's
 message of "Wed\, 20 Jan 2010 17\:25\:48 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E588E9D0-0613-11DF-AA37-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137595>

Jeff King <peff@peff.net> writes:

> No tests or docs, of course. :) You can squash the --pretty=raw test
> from my patch, but you will need to exercise --show-notes and
> --no-show-notes, too, as well as checking other formats and things like
> format-patch. So probably writing your own tests will make it easier to
> more thoroughly check each case.

Thanks, but Ugh.

Didn't I say elsewhere that I am too busy to become a janitor for
everybody's itch, especially for topics that are merely "Meh" to me?

If there is no volunteer, I might be forced to do something about it, but
no promises, and I am reasonably certain that not much will happen at my
end for coming 48 hours, as I am cutting 1.6.6.1 (and perhaps 1.6.5.8) and
looking at other topics in 'next' that deserve to go to 1.7.0-rc0.

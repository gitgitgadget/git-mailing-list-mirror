From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Give the hunk comment its own color
Date: Wed, 18 Nov 2009 13:56:34 -0800
Message-ID: <7vaayjebu5.fsf@alter.siamese.dyndns.org>
References: <1258543836-799-1-git-send-email-bert.wesarg@googlemail.com>
 <20091118142320.GA1220@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bert Wesarg <bert.wesarg@googlemail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 18 22:57:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAsWH-0003t7-5k
	for gcvg-git-2@lo.gmane.org; Wed, 18 Nov 2009 22:56:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755851AbZKRV4i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Nov 2009 16:56:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753631AbZKRV4i
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Nov 2009 16:56:38 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:53620 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751644AbZKRV4h (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Nov 2009 16:56:37 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B777B81721;
	Wed, 18 Nov 2009 16:56:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nN0iu5igH6fRMWCSFPwhQ6CC2VM=; b=Kj0Jjc
	3kzEDBkkR2CNsHOEG3hd+HbPeHZt70L+Kam523LxNP9t7EIi8/EDJVLR6Eu29KP0
	FJq6ZyK9v/eFwgnylmfWmr2eVWjp5tTCLEVzZM1GQd76xJXnIjV0Tw0WScCYvZhM
	9dtvx4K2nKPYm+2BeR2l2TmaoTzbkeB0n1It4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XPZgqtNcu7x20BhLaGy9ACrjXCPQBJ/D
	xwCBahpPe2rUeFeuBJKc7EEzYWe6Y3+2JTuTK4m4OpoGL6Wz0kkeI0gZG9GeDXgl
	H9VANHoA3KlKiedg7L+Y8BjpndQ44BOpihTIGHdZqUfg13L7elXAMr5GjaVwoGg7
	RlEUXU0LXSE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8C7CD81720;
	Wed, 18 Nov 2009 16:56:39 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D53658171F; Wed, 18 Nov
 2009 16:56:35 -0500 (EST)
In-Reply-To: <20091118142320.GA1220@coredump.intra.peff.net> (Jeff King's
 message of "Wed\, 18 Nov 2009 09\:23\:21 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3FE8908C-D48D-11DE-A1F2-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133201>

Jeff King <peff@peff.net> writes:

> PS I almost complained about your default of "magenta" as the same as
> the meta color before I remembered that magenta meta is a personal
> setting I use.

On black-on-white terminals, cyan tends to be less visible, and I think
that is the whole point of painting the hunk header @@ .. @@ in that
color--- make it less distracting). 

But the function name on the line is not something that should be made
less visible---if that part of the line were a meaningless cruft, we
wouldn't have configurable funcname patterns after all.

I would suggest "normal" as the neutral default.  After all, the purpose
of the funcname in the hunk header is to give context to people who read
patches.

> I'm not sure what is the best way to arrive at a default color for
> something like this. Arguing about it really is almost the definition of
> bikeshedding.  Maybe next year's git survey should contain a special
> section on colors, and majority should rule.  :)

Sorry, but this is no democracy ;-)

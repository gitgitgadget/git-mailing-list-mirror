From: Junio C Hamano <gitster@pobox.com>
Subject: Re: GSoC idea: allow "git rebase --interactive" todo lines to take options
Date: Tue, 11 Mar 2014 12:31:00 -0700
Message-ID: <xmqqy50gpm6j.fsf@gitster.dls.corp.google.com>
References: <530DA00E.4090402@alum.mit.edu>
	<20140226105249.GE25711@sigill.intra.peff.net>
	<CANUGeEY2qE2LPq=-bhaKrKrv+uJUaPRqAeW_X1sFyZH-_PRVeA@mail.gmail.com>
	<20140228125241.GA23448@sigill.intra.peff.net>
	<53109748.3090507@alum.mit.edu>
	<20140311013749.GA12033@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Brandon McCaig <bamccaig@gmail.com>,
	git discussion list <git@vger.kernel.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 11 20:31:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNSOi-00052H-KO
	for gcvg-git-2@plane.gmane.org; Tue, 11 Mar 2014 20:31:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755190AbaCKTbG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2014 15:31:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35503 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755120AbaCKTbE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2014 15:31:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DBB0D74C22;
	Tue, 11 Mar 2014 15:31:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/SbmB4eU3l4SdnPUq6LekNbAQyE=; b=XWPW3Q
	R0008W09nRxSskEyWarAS6/H14OpGqHwmflA27Cq16fePGsgDntQ3Rrunp1Q12Ys
	CcRu39RIrP14PXmcYil8SKDxaQwPOQ9ZK7oGO7N0m+ahk+YQDV1FyuYe2uUOgU7b
	T9ZBbKuz3gTLN4UlHsjLteSw3xOxoqKe+YI2M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=O2556DUjMJqFWk/NLH4xyNwUY6JnDoSl
	M/os6VU1/aO+bA0rgfy6ed7em9OXEp5M2mtZTTw4GGKBw8FoZE3N3r7kiHmGXBmz
	4ys1PWGW5wCnnBumZWbiYfrNK6eyB4zpZIurYpYimqTJqTAt//xPctUA+u3mll31
	/dvQYc4YxxE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C728A74C21;
	Tue, 11 Mar 2014 15:31:03 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 08BA874C1E;
	Tue, 11 Mar 2014 15:31:02 -0400 (EDT)
In-Reply-To: <20140311013749.GA12033@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 10 Mar 2014 21:37:49 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: AEC095A0-A953-11E3-9EAD-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243882>

Jeff King <peff@peff.net> writes:

> I'd say keep it at this point. I think there _are_ some good ideas here,
> and part of a project is figuring out what is good. And part of the role
> of the mentor is applying some taste.

Amen to that.  I hope we have enough mentor-candidates with good
taste, though ;-)

> There are probably students who would be a good fit, and students
> who would not. That is true for just about every project, of
> course, but I think this one is just a little trickier than some.

Perhaps.

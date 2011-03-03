From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] commit notes workflow
Date: Wed, 02 Mar 2011 19:50:14 -0800
Message-ID: <7v39n4ammh.fsf@alter.siamese.dyndns.org>
References: <20110225133056.GA1026@sigill.intra.peff.net>
 <201102251658.22678.johan@herland.net>
 <20110301215907.GA23945@sigill.intra.peff.net>
 <201103020121.54690.johan@herland.net>
 <AANLkTino7fGnLutJ3cAxcvx8O-JbcDPJDrYHznjoN-TC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 03 04:50:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuzYf-00028v-Ar
	for gcvg-git-2@lo.gmane.org; Thu, 03 Mar 2011 04:50:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932106Ab1CCDu2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Mar 2011 22:50:28 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:54143 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751174Ab1CCDu2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Mar 2011 22:50:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 788D24F5E;
	Wed,  2 Mar 2011 22:51:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ywMIxIxHJzXNODtAGUgY/I21asU=; b=PFW77p
	gD//UD0TM1jHOHt2WPLifLDKT5yNrXDYOTHCtlge9n+WTRrt96A1JEFyvs6XKZWN
	Y/U2XuF3lOV9w3jVaoMp15jboraoZdYhTelXmWrJ9r7vtRseTsqP1wU3tz8R02BZ
	NvuxgakWYGa81YXQKRadwdtcpoSGuECwnQVHk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=u3NXHkAkYG/jMYuBMi5K+bbgBNsoQRTC
	s2dPBuFXJQAa5fVY9LMEc8yE27EMlfCAJi21nDFAA2YsPAfFPdadUPLtZpH4TzAg
	3qmhalo2K0v6HHw61OqXF/pUwWYfroyU1Iu5f/ynNlGpqQANTaPpuI04h734EKTd
	76sAGCZkYJA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 379F04F51;
	Wed,  2 Mar 2011 22:51:43 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E59474F4E; Wed,  2 Mar 2011
 22:51:37 -0500 (EST)
In-Reply-To: <AANLkTino7fGnLutJ3cAxcvx8O-JbcDPJDrYHznjoN-TC@mail.gmail.com>
 (Sverre Rabbelier's message of "Thu\, 3 Mar 2011 02\:57\:22 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8D9CAF56-4549-11E0-80C8-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168371>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> Can someone explain why -v does not output it's data prefixed by a
> '#'? If someone really wanted to include it in their commit message
> they can column-select-delete it, and if they don't, it just gets
> deleted by the cleanup code?

Good question.  There was no reason other than "that is just a historical
accident".

The intention has always been "allow people to review the change for the
last time while writing a log message"; there was never a feature request
to allow the diff to be included---it would always have been an unwelcome
accident it that ever happened.

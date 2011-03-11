From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Add Author and Documentation sections to
 git-for-each-ref.txt
Date: Fri, 11 Mar 2011 00:09:34 -0800
Message-ID: <7vwrk6yt6p.fsf@alter.siamese.dyndns.org>
References: <1299590170-30799-1-git-send-email-alcosholik@gmail.com>
 <1299590170-30799-3-git-send-email-alcosholik@gmail.com>
 <4D773570.4010803@drmicha.warpmail.net>
 <7voc5k9hfy.fsf@alter.siamese.dyndns.org>
 <20110310223732.GE15828@sigill.intra.peff.net>
 <7v4o7a3748.fsf@alter.siamese.dyndns.org>
 <20110311062041.GA20048@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Alexei Sholik <alcosholik@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 11 09:09:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxxQ1-0003JW-LR
	for gcvg-git-2@lo.gmane.org; Fri, 11 Mar 2011 09:09:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752258Ab1CKIJs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Mar 2011 03:09:48 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:52231 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751122Ab1CKIJr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Mar 2011 03:09:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1B1B828D2;
	Fri, 11 Mar 2011 03:11:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/3xP/WkHC9jT4vkGenlgfn1WR+c=; b=FLnWfI
	gofkt4babYrcrOqT0USWWwMfC7GeohCLrpgke5D7Jg/cMOCy4ZBE5vaBtNLkCMVS
	iR/8mA+sL5mZbgJG4fAXDpi2W2y+aCCwHJoGq4cUZLNDGr9Hqh2WKsIqbm1rRwHS
	cFrNL1x0kXzbdnr8J2ElYUuG+dY8tnF8ODhUo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yTJXsZrI/dscB524NFygrb28DQj4GUp9
	DNXd9H9XEgQIhxHV4BPfQiMSkLOboKrAfBqNHWHMeL6FJ9RBI5B6TR/07mxZPiVu
	b1vBLjHtd0gw5RpYz+6+CenJSUuOzgHVa7Mult+1PvT+2C/JT+h3+OtWmdN6TChe
	0JwcTQ+gw8k=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CD1C728D1;
	Fri, 11 Mar 2011 03:11:10 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 7699328CF; Fri, 11 Mar 2011
 03:11:05 -0500 (EST)
In-Reply-To: <20110311062041.GA20048@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 11 Mar 2011 01:20:41 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1FE93F14-4BB7-11E0-B250-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168889>

Jeff King <peff@peff.net> writes:

> On Thu, Mar 10, 2011 at 03:09:43PM -0800, Junio C Hamano wrote:
>
>> > Yeah, I would just as soon drop Author and Documented-by fields in all
>> > manpages. We could replace them with a single "Credits" in git(1). It
>> > can either mention nobody, very few people (like Linus as the originator
>> > and Junio as the long-time maintainer), or the top N (for N < 20 or so)
>> > people in shortlog. And then mention that you can run shortlog yourself.
>> 
>> Sounds sensible.
>
> If you want to see what the full patch would look like, you can fetch it
> from:
>
>   git://github.com/peff/git.git jk/doc-credits
>
> The patch itself is rather large, so I didn't want to post it.

Thanks; will immediately queue to 'pu' for wider dissemination.  I think
the changes are all sensible. The credits are there in the shortlog, and
the contributors' names are displayed at one of the more prominent git
related sites, namely http://git-scm.com/about/, to honor them, so I don't
think keeping already stale information on each and every manpage is
warranted.

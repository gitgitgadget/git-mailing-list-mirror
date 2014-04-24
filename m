From: David Kastrup <dak@gnu.org>
Subject: Re: Harmful LESS flags
Date: Thu, 24 Apr 2014 23:48:30 +0200
Message-ID: <87lhuu9z69.fsf@fencepost.gnu.org>
References: <4dc69237123e8962b2b2b901692ea78e.id@mailtor>
	<87lhuvb9kr.fsf@fencepost.gnu.org>
	<xmqqha5iv9eb.fsf@gitster.dls.corp.google.com>
	<87tx9ia5zq.fsf@fencepost.gnu.org>
	<xmqq8uquv84u.fsf@gitster.dls.corp.google.com>
	<20140424213529.GB7815@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, d9ba@mailtor.net,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 25 00:09:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdRpy-0006KU-Vq
	for gcvg-git-2@plane.gmane.org; Fri, 25 Apr 2014 00:09:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758081AbaDXWJk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Apr 2014 18:09:40 -0400
Received: from fencepost.gnu.org ([208.118.235.10]:55183 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758073AbaDXWJh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Apr 2014 18:09:37 -0400
Received: from localhost ([127.0.0.1]:54224 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WdRpo-0000YI-EK; Thu, 24 Apr 2014 18:09:36 -0400
Received: by lola (Postfix, from userid 1000)
	id 1520AE0989; Thu, 24 Apr 2014 23:48:30 +0200 (CEST)
In-Reply-To: <20140424213529.GB7815@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 24 Apr 2014 17:35:29 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247014>

Jeff King <peff@peff.net> writes:

> On Thu, Apr 24, 2014 at 12:29:21PM -0700, Junio C Hamano wrote:
>
>> David Kastrup <dak@gnu.org> writes:
>> 
>> > Junio C Hamano <gitster@pobox.com> writes:
>> >
>> >> Traditionally, because the tool grew in a context of being used in a
>> >> project whose participants are at least not malicious, always having
>> >> to be on the lookout for fear of middle-of-line tabs hiding bad
>> >> contents near the right edges of lines has never been an issue.
>> >
>> > My beef is not with "hiding bad contents" but with "hiding contents".
>> > It makes the output useless for seeing what is actually happening as
>> > soon as the option starts having an effect.
>> 
>> My suspicion is that one of the reasons why S was chosen to be in
>> the default was to mildly discourage people from busting the usual
>> line-length limit, but I am not Linus ;-)
>
> I would think it's the opposite. Long lines look _horrible_ without
> "-S", as they get wrapped at awkward points. Using "-S" means that long
> lines don't bug you, unless you really want to scroll over and see the
> content.

I prefer horrible over useless.

> I really think the right solution here is to teach less to make it more
> obvious that there is something worth scrolling over to. Here's a very
> rough patch for less, if you want to see what I'm thinking of.

Still useless.  I'm not actually interested in a more prominent "I could
be useful" indicator.

-- 
David Kastrup

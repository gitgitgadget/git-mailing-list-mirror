From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Remove the suggestion to use parsecvs, which is
 currently broken.
Date: Mon, 07 Jan 2013 11:21:41 -0800
Message-ID: <7vehhwiyt6.fsf@alter.siamese.dyndns.org>
References: <20121228162025.8565E4413A@snark.thyrsus.com>
 <20121228230149.GA3575@book-mint> <20121229044200.GA16086@thyrsus.com>
 <20130106163420.GA3378@book-mint>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Eric S. Raymond" <esr@thyrsus.com>, git@vger.kernel.org
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Mon Jan 07 20:22:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TsIHI-0000zB-OR
	for gcvg-git-2@plane.gmane.org; Mon, 07 Jan 2013 20:22:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755292Ab3AGTVq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jan 2013 14:21:46 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50282 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755074Ab3AGTVo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jan 2013 14:21:44 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8663AB4A2;
	Mon,  7 Jan 2013 14:21:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1X8W5aVzklIt/24xxSQdys8MzRw=; b=ewOV1D
	byKRyXSKWxKiv3k8PSt5PoHJ1ixFSRce9mhGDhzbBQGrXhmXw2u+2cN5BbD9cbUY
	WowiPGY2/S47+7v6u0h0P7U17cIq/8oKg41jF2ulNjXBDU7zdMQbEL9FVeKH/y8k
	s7aUUAp8lQz02iTytwrLwprDDPnJYnKfmTm68=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FhYDRR5fuBuGk31ObG9iaGbqOFT3PIbe
	sK/2mrdMymKa9mhwND1T+YR5SWsaa3FRl+iN9vXPdJNXejGIbkXOxjEReAukNmmB
	cKEAy2V1lTKDEnKGuP1ry6JgAy34cYMnM9EtLOeT8KI8s4zVzb8r2B/tVThVPne+
	grCXhtu9gLg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 76D35B4A1;
	Mon,  7 Jan 2013 14:21:43 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D2634B49F; Mon,  7 Jan 2013
 14:21:42 -0500 (EST)
In-Reply-To: <20130106163420.GA3378@book-mint> (Heiko Voigt's message of
 "Sun, 6 Jan 2013 17:34:20 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 780F1CB6-58FF-11E2-ACF3-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212915>

Heiko Voigt <hvoigt@hvoigt.net> writes:

> Hi,
>
> On Fri, Dec 28, 2012 at 11:42:00PM -0500, Eric S. Raymond wrote:
>> Heiko Voigt <hvoigt@hvoigt.net>:
>> > Maybe you could add that information to the parsecvs compile
>> > instructions? I think just because it takes some effort to compile does
>> > not justify to remove this useful pointer here. When I was converting a
>> > legacy cvs repository this pointer would have helped me a lot.
>> 
>> I'm parsecvs's maintainer now.  It's not in good shape; there is at
>> least one other known showstopper besides the build issue.  I would
>> strongly prefer to direct peoples' attention away from it until I
>> have time to fix it and cut a release.  This is not a distant 
>> prospect - two or three weeks out, maybe.
>
> So for this short amount of time you want to change gits documentation?
> Is this hint causing you trouble? Are there many people asking for
> support because of that?
>
> Even if it takes some effort to get parsecvs running I would like to
> keep the hint to a good and proven cvs importer.

I do not mind changing the documentation, but now I re-read the
change, I tend to agree that dropping the last (un)maintained
version of parsecvs may be detrimental.  Most people will not
download parsecvs from keith's page, but first will try the one
shipped with their distros, and the recent maintainer change for
that tool would not have any impact to these users.

But at the same time, by the time this change reaches these users
who may benefit by the mention of parsecvs via the distro route, the
situation may be different, so I do not think it is such a big deal.
In the longer term, if parsecvs is revived either by Eric or
somebody else, we will add the mention back to the documentation,
probably with an updated URL.

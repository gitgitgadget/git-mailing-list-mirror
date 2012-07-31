From: Michael G Schwern <schwern@pobox.com>
Subject: Re: Fix git-svn for SVN 1.7
Date: Tue, 31 Jul 2012 16:24:10 -0700
Message-ID: <5018691A.9050904@pobox.com>
References: <1343468872-72133-1-git-send-email-schwern@pobox.com>
 <20120730203844.GA23892@dcvr.yhbt.net>
 <7v1ujsl8ut.fsf@alter.siamese.dyndns.org> <5017AB63.6080909@pobox.com>
 <20120731200108.GA14462@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	robbat2@gentoo.org, bwalton@artsci.utoronto.ca, jrnieder@gmail.com
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Aug 01 01:24:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SwLnW-0002wu-2y
	for gcvg-git-2@plane.gmane.org; Wed, 01 Aug 2012 01:24:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756164Ab2GaXYN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Jul 2012 19:24:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34724 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754999Ab2GaXYM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jul 2012 19:24:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 00AD49397;
	Tue, 31 Jul 2012 19:24:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=message-id
	:date:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; s=sasl; bh=8GOlOosVhGVG
	/czHBBwE9wEWa+Q=; b=N5dbWHofW48fL7Jq9LjVaz6cnEt/BzhVDm5oph0/gK8C
	pWX67Snmpfkpp8goxuqi75BAvkJlgROgcQWj2c9TAr8H3rkqWr2Gspji4iS7Cr0r
	AEUlSjSnp9IdYlFpmPxQyEUqsHrol2AKTuXLCcMbf+2On/2igxw5yJqoJZGm5Uw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=message-id:date
	:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=s5kkEd
	OeRRYCm0S89iZjr5aZ6BCdGgQUlN2nf1Jbqr7Lsi3uZCybNwukxLL50VrH3wR7jC
	Fgy4oWIA4QzUCpQ/wZlxaP6QDbsfkQQITuKT2QsAYj8aO/SukkMkTn+CE/k/83w0
	lODvC1owA/dyKm9aCXIwArY4PYFhwvsUwNRp4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E08439396;
	Tue, 31 Jul 2012 19:24:11 -0400 (EDT)
Received: from [192.168.0.71] (unknown [168.103.236.213]) (using TLSv1 with
 cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested)
 by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BFD2D9391; Tue, 31 Jul
 2012 19:24:10 -0400 (EDT)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:14.0)
 Gecko/20120713 Thunderbird/14.0
In-Reply-To: <20120731200108.GA14462@dcvr.yhbt.net>
X-Enigmail-Version: 1.4.3
X-Pobox-Relay-ID: D5A3E350-DB66-11E1-B8F7-01B42E706CDE-02258300!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202695>

On 2012.7.31 1:01 PM, Eric Wong wrote:
> Michael G Schwern <schwern@pobox.com> wrote:
>> It just doesn't matter.
>>
>> Why are we arguing over which solution will be 4% better two years from now,
>> or if my commits are formatted perfectly, when tremendous amounts of basic
>> work to be done improving git-svn?  The code is undocumented, lacking unit
>> tests, difficult to understand and riddled with bugs.
> 
> Yes it does matter.
> 
> git-svn has the problems it has because it traditionally had lower
> review standards than the rest of git.  So yes, we're being more careful
> nowadays about the long-term ramifications of changes.

Yes, review does matter.  And so far we've been arguing over whether reviewing
objects-with-overloading or objects-without-overloading would be better.  And
we can argue about that forever.

That's the part that doesn't matter.  People matter.

I think we can all agree that either solution is a vast improvement along
multiple axes, including review.  So what really matters is making sure one of
them gets done.  Once either of them is done, we can see how it works out in
practice instead of arguing theoretical futures.  Once either of them is done,
it's much easier to switch to the other.

What I'm trying to say is I have much less interest in doing it without the
overloading.  It's not interesting to me.  It's no fun.  No fun means no
patch.  No patch means no improvement.  No improvement is the worst of all
possible options.

I had a lot of enthusiasm for this project when I came in.  I like refactoring
Perl code.  I like git.  That's all but sunk at how painful and slow and
nit-picking the process has been.  We've barely talked about the content of
the patches I've submitted, it's all process.  This is no fun.

We're all volunteers here and we're all getting something personal out of
this.  Some form of personal enjoyment.  I'm not getting that, so I'm unlikely
to stick around.


-- 
Defender of Lexical Encapsulation

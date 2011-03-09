From: Adam Monsen <haircut@gmail.com>
Subject: Re: [PATCH v4] Documentation fix: git log -p does not imply -c.
Date: Wed, 09 Mar 2011 13:25:15 -0800
Message-ID: <4D77F03B.4050605@gmail.com>
References: <7vsjuyzckd.fsf@alter.siamese.dyndns.org> <1299545378-22036-1-git-send-email-haircut@gmail.com> <7vmxl5e6ur.fsf@alter.siamese.dyndns.org> <4D7695A9.8070403@gmail.com> <7vtyfdaz4k.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 09 22:25:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxQss-0004pn-Nf
	for gcvg-git-2@lo.gmane.org; Wed, 09 Mar 2011 22:25:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752884Ab1CIVZZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2011 16:25:25 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:48588 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752318Ab1CIVZY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2011 16:25:24 -0500
Received: by qwd7 with SMTP id 7so739725qwd.19
        for <git@vger.kernel.org>; Wed, 09 Mar 2011 13:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=LixN/Gam4CYHrLw7LKHZeLvpUKyZCVJv/Ss5SYjltvk=;
        b=xc/x8YdUnVXJ+Bm+645dXpZ8jmqDfKEBVC5UV7bMmy+efulmiBfQMhKFwg/OSHehzR
         8eVc6rY0KybG0CfYQnjWuvxQ+t+UihyWGVVPDki42kNkFzZjnMaXqr2zzF/sNBhkHhFW
         BNdDwSFkGDnoYEgRMg47yGn0FH4aydksz6HNw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        b=BaGgpcMRlN4LfGWXg3qwZLrBhf0j5Q47tTWxjhfIxVkieP0YVFzEi5pPSbD1CneHm4
         3fI9RVOF9/CEEnOrEq6+r+oRKBDy5FkEay+IBQSGimIO7t70ZLz1U4sROlkucI/r03RS
         /ng3eUSpBKCXebLqwM3fi0Tc0oUmAB0Yx32JY=
Received: by 10.229.16.83 with SMTP id n19mr5557643qca.235.1299705923032;
        Wed, 09 Mar 2011 13:25:23 -0800 (PST)
Received: from [192.168.13.8] (c-67-183-136-182.hsd1.wa.comcast.net [67.183.136.182])
        by mx.google.com with ESMTPS id s10sm1728135qco.35.2011.03.09.13.25.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 09 Mar 2011 13:25:22 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.9.2.15) Gecko/20110303 Lightning/1.0b2 Thunderbird/3.1.9
In-Reply-To: <7vtyfdaz4k.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168762>

Junio C Hamano wrote:
>> - Read previous commit messages. Emulate the best ones.
> 
> I thought you were trying to teach new people how to gauge the "goodness"
> with this list.  How would they know which ones are "best"? ;-)

Heh, glad you asked. I was being intentionally vague. The list just
provides some ideas. "Best" is an ideal. It's subjective. I don't want
people to just do what I say, I want to inspire them to do something better.

Maybe:

  Read previous commit messages. Strive to make yours better.

Again, we're talking about commit messages, not raising children or
anything. But commit messages help others, so why not try to make them the
"best" they can be?

> I try to give this list to new contributors early in their initiation
> process (ideally before their patches hit the codebase).  That is probably
> why many of the existing commits you saw in "git log" more or less
> conformed to the recommendation.

Cool. That's well-written and helpful.

>> - Be verbose!
> 
> Please don't.  We want sufficiently detailed description, but we don't
> want verbosity.

:) fair enough. I wrote this because, in the Mifos community, I struggle
getting people to write enough of *anything* in commit messages. Good to
know that's not a problem in git land.

> How about this as a not-too-verbose compromise?

I like it. Some specific comments below.

> -		- includes motivation for the change, and contrasts
> -		  its implementation with previous behaviour
> +	  . explains the problem the change tries to solve, iow, what
> +	    is wrong with the current code without the change.

Good, but spell out "in other words". I had to look up that acronym.

> +	  . justifies the way the change solves the problem, iow, why
> +	    the result with the change is better.

Ditto.

> +	  . alternate solutions considered but discarded, if any.

Prepend with "mentions" or something.

> +	- try to make sure your explanation can be understood without
> +	  external resources. Instead of giving a URL to a mailing list
> +	  archive, summarize the relevant points of the discussion.

+1, but I prefer both the summary *and* the link.

So maybe:

  Instead of providing only a URL to a mailing list archive, summarize
  the relevant points of the discussion.

> -Describe the technical detail of the change(s).
> +Give an explanation for the change(s) that is detailed enough so
> +that people can judge if it is good thing to do, without reading
> +the actual patch text to determine how well the code does what
> +the explanation promises to do.

+1!

I noticed a few grammar errors in the doc, too. I'll reply with
another patch.

Sorry if this continued work on the SubmittingPatches
documentation is getting annoying. It's been useful for me to learn
how things are done around here. And it's important that the
document be well written, so people actually use it. I just thought
we might as well improve it a little more since we've already started.

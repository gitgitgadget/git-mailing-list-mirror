From: Christopher Tiwald <christiwald@gmail.com>
Subject: Re: [PATCH] push: Provide situational hints for non-fast-forward
 errors
Date: Fri, 16 Mar 2012 13:20:13 -0400
Message-ID: <20120316172013.GA8119@gmail.com>
References: <20120313232256.GA49626@democracyinaction.org>
 <vpqipi7zh3n.fsf@bauges.imag.fr>
 <7vty1rqek5.fsf@alter.siamese.dyndns.org>
 <7vlin1gl9l.fsf@alter.siamese.dyndns.org>
 <20120316091019.GB22273@ecki>
 <7v3998kb0x.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Clemens Buchacher <drizzd@aon.at>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org, peff@peff.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 16 18:20:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8apF-0002LX-SR
	for gcvg-git-2@plane.gmane.org; Fri, 16 Mar 2012 18:20:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750994Ab2CPRUU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Mar 2012 13:20:20 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:47807 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750802Ab2CPRUT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2012 13:20:19 -0400
Received: by gghe5 with SMTP id e5so4419445ggh.19
        for <git@vger.kernel.org>; Fri, 16 Mar 2012 10:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=s7Vj1Q1XLWaAGmVvQPj+AK99Gcc3FYCXQIdBaqsgFT0=;
        b=M5pUBwIJOVxhGqd27+hall4N4z8FqQ4T2BXrSvBpsopietpbdMUl8KImJNN55Re8dQ
         xrza3HdTpold4uOfjHvMdnpnzNHn5fAMv4xKakITduVSCNGyJ2LeN9cgmKwhnXOhYRNu
         ojeh1AeBHeGtlfMCHmr67qjoqW58y7cr23TuSS3YdD6bZg5OmYWyYLbdvhDYrTZCTcPY
         JY5t+FylwzV4NdnxcG2FMtMO9jmPIWK3EmfaXmIYME9Fgw7/HRAfBuOPlykyq8S9TeHM
         mHDUPNMRqY4WHfzlhmfqIS+Aa4xa5fdevOtByEWe7KJWeGK722YmPyHU/69/p6+U/Oxk
         gKEQ==
Received: by 10.224.116.6 with SMTP id k6mr4748626qaq.91.1331918418753;
        Fri, 16 Mar 2012 10:20:18 -0700 (PDT)
Received: from gmail.com ([216.55.38.246])
        by mx.google.com with ESMTPS id ha3sm10126390qab.13.2012.03.16.10.20.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 16 Mar 2012 10:20:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7v3998kb0x.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193278>

On Fri, Mar 16, 2012 at 05:03:58AM -0700, Junio C Hamano wrote:
> > We should not give advise_use_upstream if the user specified git push
> > --all. The advice_checkout_pull_push would make more sense in that case.
> 
> Yeah, "default_matching_used" variable should be looked at somewhere
> around that, but I *think* the approach Christpher and Peff took (and I
> agree with them) is to help solving the immediate problem the user has and
> can address.

Yeah, this was how I interpretted Peff's original suggestion. It seemed
like a nice compromise between advice that was inapplicable and advice
that was too complex ("There are 3 different non-ff errors in your push.
Here are the four resolution processes required to fix them...").

Thanks for the additional patching. The language / logic changes make
sense. One quick, slightly-off-topic question: I'd like
to take another crack at the patch's commit message, to implement
some of your language suggestions and clean it up further. Is it
reasonable for me to wait a few days for additional comments or
updates, squash together these fixups into a single v2 patch (assuming
one patch is a logical unit for it), then resubmit?

Just wanted to clarify the workflow,

--
Christopher Tiwald

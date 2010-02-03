From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: Fix signal handler
Date: Wed, 03 Feb 2010 11:20:30 +0100
Message-ID: <4B694DEE.5030207@web.de>
References: <4B684F5F.7020409@web.de> <20100202205849.GA14385@sigill.intra.peff.net> <4B689CC5.3000400@web.de> <20100202223208.GB18781@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 03 11:20:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NccLi-0007ek-PB
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 11:20:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932422Ab0BCKUh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2010 05:20:37 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:45481 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932276Ab0BCKUh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2010 05:20:37 -0500
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate01.web.de (Postfix) with ESMTP id 9542B14601AAA;
	Wed,  3 Feb 2010 11:20:35 +0100 (CET)
Received: from [78.54.162.123] (helo=[192.168.1.202])
	by smtp06.web.de with asmtp (WEB.DE 4.110 #314)
	id 1NccLb-0001xb-00; Wed, 03 Feb 2010 11:20:35 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.1.5) Gecko/20091130 SUSE/3.0.0-1.1.1 Thunderbird/3.0
In-Reply-To: <20100202223208.GB18781@sigill.intra.peff.net>
X-Sender: Markus.Elfring@web.de
X-Provags-ID: V01U2FsdGVkX1+wSOstKuCcL/GFdSvFWF9w7di3rS4wil+u8PeQ
	mpaoOffb4xl8zU/MR4oZt66h5CFRNQ7YIoRgtrk//DuYApzgzD
	8USv4U3LzNfE07+XYrtQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138825>


> I don't think anyone here is much interested in whether there is any
> sort of guarantee on a particular construct working.

That is a pity. - I would expect that professional software development
will build on working specifications instead of potentially undefined
behaviour.


> So to answer your question, I honestly don't know. The code may well
> be broken on common platforms and it is simply a race condition that
> has never come up. But I do know that it has not been a common source
> of bug reports, which makes me not want to spend time investigating
> it when nobody has demonstrated its incorrectness beyond mentioning
> a standards document.
>   

Thanks for your clarification.

I find that programming errors in this area might be hard to identify
from the outside because resulting race conditions and deadlocks fall
into the symptom category of heisenbugs, don't they?
How many software developers do deal with the nasty design details for
signal handler implementations correctly?

Regards,
Markus

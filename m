From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: Completion of error handling
Date: Thu, 18 Feb 2010 16:11:03 +0100
Message-ID: <4B7D5887.6050502@web.de>
References: <4B68249F.6070004@web.de> <alpine.LFD.2.00.1002021324290.1681@xanadu.home> <4B740153.4010600@web.de> <4B7A79F0.1070100@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@fluxnic.net>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Thu Feb 18 16:11:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ni82A-000170-I4
	for gcvg-git-2@lo.gmane.org; Thu, 18 Feb 2010 16:11:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758286Ab0BRPLM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2010 10:11:12 -0500
Received: from fmmailgate02.web.de ([217.72.192.227]:58932 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758252Ab0BRPLL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2010 10:11:11 -0500
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate02.web.de (Postfix) with ESMTP id B411614EA9AF2;
	Thu, 18 Feb 2010 16:11:09 +0100 (CET)
Received: from [78.49.129.221] (helo=[192.168.1.202])
	by smtp08.web.de with asmtp (WEB.DE 4.110 #314)
	id 1Ni821-0005Db-00; Thu, 18 Feb 2010 16:11:09 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.1.5) Gecko/20091130 SUSE/3.0.0-1.1.1 Thunderbird/3.0
In-Reply-To: <4B7A79F0.1070100@op5.se>
X-Sender: Markus.Elfring@web.de
X-Provags-ID: V01U2FsdGVkX1++LjxqQgH5Fgtgh8c66C1AJe1hjrdmX8DQL7LC
	27HwN7ZhDMVSRtIxWpoGw9KIj1fMUFUqFzSdyc8uFtgapqKbCV
	33/KeaU39bvQVhDWucGg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140345>


> That's an awful lot of text to read that's hardly relevant for a C
> program. Most of it regards newbie stuff about how to handle reporting
> an error when you can't use a C++ exception.
>   

I would like to quote a bit which shows the underlying issues with the
used programming language.
"...
Exceptional events occur. But, since they are exceptional, they occur
very rarely. This is exactly the problem with them. In programming
courses you learn to always handle any possible event. But, in practice,
most programmers just ignore them. If you look at this problem in
detail, you see that these events are not ignored where they actually
occur, but at some higher level.
..."


>
> You keep on claiming that but haven't proven it in any way.

I do not want to prove this so far because return value ignorance might
be a common and well-known (bad) coding practice.
https://www.securecoding.cert.org/confluence/display/seccode/EXP12-C.+Do+not+ignore+values+returned+by+functions


>
> Git is written in C, not C++. Using aspectc++ would mean requiring
> the use of a C++ compiler, which git doesn't require today.

It would be nice if C++ exceptions could be used here because they can
not be ignored by default. I guess that the tool "AspectC++" will also
work with C constructs. Do you find the tool "AspeCt-oriented C
compiler" more appealing?


> Now please stop trolling and find one of these bugs you keep talking
> about but never showing.

I would not say never. - Exceptional situations are usually expected to
appear seldom.


> We've made it painfully clear to you that we're interested in realworld
> problems rather than potential ones, so all this "use this model for
> development" just reeks of concept evangelism.

The efforts for complete error code checking can be reduced by a mixture
of function, class and advice libraries.


> No real engineer likes that, which is why you're facing
> such massive opposition on this list.
>   

It takes a bit more time to become comfortable with evolving software
technologies.

Regards,
Markus

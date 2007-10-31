From: Andreas Ericsson <ae@op5.se>
Subject: Re: remote#branch
Date: Wed, 31 Oct 2007 10:03:16 +0100
Message-ID: <472844D4.8050306@op5.se>
References: <20071030053732.GA16963@hermes.priv> <fg8h9l$b4n$1@ger.gmane.org> <20071031013856.GA23274@coredump.intra.peff.net> <200710310249.17233.jnareb@gmail.com> <20071031015708.GA24403@coredump.intra.peff.net> <47282A0D.9010400@op5.se> <20071031083506.GA23316@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>,
	git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Wed Oct 31 10:03:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1In9UC-0000AW-Hc
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 10:03:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753643AbXJaJD0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2007 05:03:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753611AbXJaJD0
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Oct 2007 05:03:26 -0400
Received: from mail.op5.se ([193.201.96.20]:56292 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753404AbXJaJDZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2007 05:03:25 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 96B04173065F;
	Wed, 31 Oct 2007 10:03:21 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gM+YrVyWR4ER; Wed, 31 Oct 2007 10:03:19 +0100 (CET)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id CA7EA1730593;
	Wed, 31 Oct 2007 10:03:17 +0100 (CET)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <20071031083506.GA23316@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Mike Hommey wrote:
> On Wed, Oct 31, 2007 at 08:09:01AM +0100, Andreas Ericsson <ae@op5.se> wrote:
>> Jeff King wrote:
>>> On Wed, Oct 31, 2007 at 02:49:16AM +0100, Jakub Narebski wrote:
>>>
>>>>> ...which is a quoting mechanism, and it's not even one commonly used in
>>>>> emails (i.e., people have written "parse a URL from this text" scripts
>>>>> for RFC-encoded URLs, but _not_ for shell quoting).
>>>> I don't think RFC-encoding is quoting mechanism used in emails, either.
>>> That's funny, because I have hundreds of mails where that is the case,
>>> and none where people used shell-quoting.  Most URLs don't _need_ any
>>> encoding, so we don't notice either way. But are you honestly telling me
>>> that if you needed to communicate a URL with a space via email, you
>>> would write:
>>>
>>>  'http://foo.tld/url with a space'
>>>
>>> rather than:
>>>
>>>  http://foo.tld/url+with+a+space
>>>
>>> ?
>>>
>> I think 99% of all URL's communicated via email are copy-pasted from a
>> webbrowsers location bar. I believe most git urls (or grls, or whatever
>> you wanna call them) communicated via email are copy-pasted from ones
>> config, or written out manually.
> 
> Or copied from gitweb.
> 

Perhaps, but I've never seen that done. Partly because you can't be sure
the HTTP url is the same as the git address (perhaps people are used to
this from CVS and the likes), and partly because you'd, for most cases,
want to use git:// or ssh transport instead of http.

It might be nifty to have gitweb print some git-valid locator for a repo
though, or even a full copy-pastable "git clone git://host/path/to/repo.git"
command-line thingie. I'll look into it when I have leisure.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

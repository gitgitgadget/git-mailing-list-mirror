From: Eric Raible <raible@nextest.com>
Subject: Re: RFH: unexpected reflog behavior with --since=
Date: Thu, 10 Nov 2011 00:20:19 -0800
Message-ID: <4EBB8943.4060801@nextest.com>
References: <4EB9C7D1.30201@nextest.com> <20111109220128.GA31535@sigill.intra.peff.net> <20111109222032.GB31535@sigill.intra.peff.net> <4EBB8596.6040507@nextest.com> <20111110080851.GA28342@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 10 09:20:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ROPs2-000054-TD
	for gcvg-git-2@lo.gmane.org; Thu, 10 Nov 2011 09:20:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757456Ab1KJIUW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Nov 2011 03:20:22 -0500
Received: from exchange.domain1.nextest.com ([12.96.234.114]:48243 "EHLO
	exchange.DOMAIN1.nextest.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752360Ab1KJIUW (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Nov 2011 03:20:22 -0500
Received: from [131.101.151.102] (131.101.151.102) by
 Exchange.DOMAIN1.nextest.com (131.101.21.39) with Microsoft SMTP Server (TLS)
 id 8.2.176.0; Thu, 10 Nov 2011 00:20:20 -0800
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:7.0.1) Gecko/20110929 Thunderbird/7.0.1
In-Reply-To: <20111110080851.GA28342@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185216>

On 11/10/2011 12:08 AM, Jeff King wrote:
>>>   git log -g --format='%ct %H' |
>>>   awk '{ print $2 if $1 < SOME_TIMESTAMP }'
>>
>> And then the sha would have to be fed back into git to be useful, eh?
> 
> It's just illustrative. You could replace "%H" with the actual
> information you're interested in.

Of course, my thinko.

> The only point would be to leave "--since" to act on the commit
> timestamps, so that you don't have to resort to the external grepping I
> mentioned above. However, I'm not convinced anybody even cares about
> that use case.
> 
> I think the behavior you want is much more sensible.

Me too!

>> Is this something you'd be willing to turn into a real patch?
>> I'm certainly not qualified.
> 
> Yes. We're in release freeze now, so I didn't even bother with sending
> it to Junio. But also, I'd like to gather more opinions on whether the
> design is the right thing (hopefully the implementation is Obviously
> Correct. :) ).

I think it's hard to argue that the current behavior (as illustrated with
my original example) makes sense.  Or that your patch is overly complicated.
But giving people time to chime in it definitely TRTTD.

- Eric

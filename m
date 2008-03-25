From: =?UTF-8?B?RGlyayBTw7xzc2Vyb3R0?= <newsletter@dirk.my1.cc>
Subject: Re: [PATCH] Documentation: git-tag '-m' implies '-a'
Date: Tue, 25 Mar 2008 18:13:24 +0100
Message-ID: <47E932B4.5060700@dirk.my1.cc>
References: <47E7BDB2.3030304@dirk.my1.cc> <20080324194308.GE14002@coredump.intra.peff.net> <7v1w5zvqbw.fsf@gitster.siamese.dyndns.org> <20080325013842.GB15607@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 25 18:15:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JeCjA-0007u0-Ez
	for gcvg-git-2@gmane.org; Tue, 25 Mar 2008 18:14:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755070AbYCYRN3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2008 13:13:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755707AbYCYRN3
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Mar 2008 13:13:29 -0400
Received: from smtprelay10.ispgateway.de ([80.67.29.24]:60305 "EHLO
	smtprelay10.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755959AbYCYRN2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2008 13:13:28 -0400
Received: from [84.176.126.117] (helo=[192.168.2.100])
	by smtprelay10.ispgateway.de with esmtpa (Exim 4.68)
	(envelope-from <newsletter@dirk.my1.cc>)
	id 1JeCiD-0005IC-N0; Tue, 25 Mar 2008 18:13:25 +0100
User-Agent: Thunderbird 2.0.0.12 (Windows/20080213)
In-Reply-To: <20080325013842.GB15607@coredump.intra.peff.net>
X-Df-Sender: 757646
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78198>

Jeff, thanks for the advice and the corrections, I'll act on it.
It was my first submission and I'm handicapped in the way that I'm
using Windows. So I just pasted the patch into my Thunderbird window.

The git-send-email program doesn't work properly with Windows.
Either the sendmail program isn't present (no shit sherlock ;-))
or the Net/SMTP.pm module isn't found. I'm currently writing
a wrapper to bypass that. When I manage to figure the problem,
I'll post a patch.

git-send-email for Windows doesn't accept the authorization
switches (--smtp-user, --smtp-pass) (despite the docs), so I've
either to patch it or use a wrapper that adds them.

Dirk


Jeff King schrieb:
> On Mon, Mar 24, 2008 at 01:07:15PM -0700, Junio C Hamano wrote:
>
>   
>> Thanks for tidying up.  It makes my life easier.
>>     
>
> No problem.
>
>   
>>>   - at least cc Junio on patch submissions to make sure he sees it
>>>   - sign off your patch (either with commit -s or format-patch -s).
>>>       
>> Heh, and you did not sign it off when you forwarded? ;-)
>>     
>
> Heh. Believe it or not, that actually did occur to me. However, I'm not
> really sure what it means to do that. As you have made clear in the
> past, the signoff is _not_ "this looks good to me, please apply" but
> rather "I am signing the Certificate of Origin."
>
> And while I can only assume that everything in such an obvious patch is
> kosher, it is _not_ true that:
>
>   - I created or have the right to submit it under an open source
>     license (DCO, part a)
>   - The contribution was provided to me by somebody else who certified
>     the above (DCO, part c)
>
> I'm not clear on what part (b) of the DCO means. Is it making a
> judgement that says "even though I have no license on this, it is
> clearly a derivative work of git, which is GPL'd, and therefore it is
> GPL'd"?
>
> -Peff
>
>   

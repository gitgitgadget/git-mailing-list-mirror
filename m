From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Improving git branch
Date: Thu, 18 Dec 2014 11:05:12 +0100
Message-ID: <5492A6D8.8060509@drmicha.warpmail.net>
References: <CAHQ6N+qBUcBcG8RC6Co+k_GmJDXCynmyfZmvTjz4bQyH1wG3DA@mail.gmail.com>	<549168DD.1080906@drmicha.warpmail.net> <xmqqvbla80bm.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: John Tapsell <johnflux@gmail.com>, Git List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 18 11:05:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y1XxU-0004rp-VK
	for gcvg-git-2@plane.gmane.org; Thu, 18 Dec 2014 11:05:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751178AbaLRKFQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2014 05:05:16 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:39890 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750986AbaLRKFO (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Dec 2014 05:05:14 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by mailout.nyi.internal (Postfix) with ESMTP id F3C9920A8A
	for <git@vger.kernel.org>; Thu, 18 Dec 2014 05:05:13 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute2.internal (MEProxy); Thu, 18 Dec 2014 05:05:13 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:date:from
	:mime-version:to:cc:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=glUgaFgfFnJTOcYI03j2zO
	eQxiI=; b=TnkEEgydNe26Q9erfFsGup+JtN3IlPkkHHh2n3bKlrDIebH+I4pvQW
	0vJTVMcjvovICCauv17X29tSBAlP/I30Rf/6jKJBUjU1AkQ2UaIebB8zZ2KXoohK
	U4uQYu1HGyF0wJUX6LgjYP3jxemnisGjXgCi+0mypC8NzQWZUAj5k=
X-Sasl-enc: mjtg0p5Dl6in3EfBDbdAPqr1kFW+UO8thJaJ9jZjlzrj 1418897113
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 4006C680188;
	Thu, 18 Dec 2014 05:05:13 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
In-Reply-To: <xmqqvbla80bm.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261520>

Junio C Hamano schrieb am 17.12.2014 um 21:53:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> Rather than extending "git branch" any further[*], I suggest a bolder
>> strategy:
>>
>> - unify/merge for-each-ref and pretty formats (and code) as far as possible
>> - leverage that for the list modes of branch and tag
>>
>> That would allow everyone to get their favourite listing, just like for
>> logs. Otherwise it would be very difficult to agree on *the* proper
>> format for an extended branch or tag list.
>>
>> Michael
>>
>>
>> [*] I know I'm a sinner, too.
> 
> Actually this is not a "bolder" strategy, but the unification has
> been discussed and agreed to be the longer-term direction for quite
> a while, I think.  Didn't Peff have this in his "things to do when
> absolutely bored" box?
> 

If "waiting for Peff to be bored" is not a bold strategy then I don't
know what would be one ;)

Seriously, I didn't feel bold enough to claim that this is agreed upon
but I am more than happy that it is!

If I can squeeze out some more git time from my other obligations I'll
try and help.

Michael

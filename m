From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH] Documentation: enhanced "git for CVS users" doc about shared repositories
Date: Wed, 7 Nov 2007 09:07:58 +0100
Message-ID: <277490E5-2B9A-4BA7-9DD7-C1CEE698B348@zib.de>
References: <472F99F8.4010904@gmail.com>	<7v8x5cmern.fsf@gitster.siamese.dyndns.org>	<4730E056.7080809@gmail.com> <7vd4unez2l.fsf@gitster.siamese.dyndns.org> <47310ACF.4030103@gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Francesco Pretto <ceztkoml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 07 09:07:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpfwX-0006fV-KT
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 09:07:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756573AbXKGIHH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 03:07:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756557AbXKGIHH
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 03:07:07 -0500
Received: from mailer.zib.de ([130.73.108.11]:33022 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756525AbXKGIHF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 03:07:05 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id lA786fMn008371;
	Wed, 7 Nov 2007 09:06:41 +0100 (CET)
Received: from [192.168.178.21] (brln-4db1a8b8.pool.einsundeins.de [77.177.168.184])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id lA786d9R028458
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Wed, 7 Nov 2007 09:06:40 +0100 (MET)
In-Reply-To: <47310ACF.4030103@gmail.com>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63783>

On Nov 7, 2007, at 1:46 AM, Francesco Pretto wrote:

> Junio C Hamano ha scritto:
>>
>> Honestly speaking, I am not too thrilled about making the
>> cvs-migration document much longer than what it currently is.
>>

Maybe the description of setting up a shared repository should
go to the user-manual and cvs-migration should refer to the
user-manual, instead of the other way round. I don't like the
idea that the user-manual is referring to a CVS specific guide.
The user manual should be as self-contained as possible.


> Honestly speaking, you've spent too much time in looking for every  
> possible
> objections against these simple additions. At least it should be  
> less than the
> time I've spent in measuring every single word of this patch,  
> hoping you could
> consider them for inclusion. You gave me lot of attentions (I am  
> grateful of this,
> really) so I should probably be surprised of the cleanliness of git  
> code, of the
> rigor of the code style, of the clarity of the documentation. But  
> unfortunately,
> I am not. I simply tried to make this document more useful and  
> helpful for a
> wider audience of people that could ever consider of using git in  
> their life.
> And yes, I decided to so because I had trouble myself during  
> initial configurations.
> What's the problem if a document called "git for CVS users" is more  
> explicated?
> What's the problem if it contains as many as possible informations  
> to set up
> git in a viable way and, hopefully, to learn something on how it  
> does work?
>
> I'm sad. Not only because you refused a documentation patch, but  
> because i could
> have sent a "Bug: Documentation Sucks!" to the ml and i would have  
> obtained the
> same thing: nothing.

Don't be unfair. Junio made clear that the documentation
should not be cluttered with an introduction to Unix commands.
But at least two points (git-shell, git-init.txt) would be
accepted if you sent an cleaned-up patch.

I have no good idea how to reconcile your idea of giving more
guidance to Unix commands with the idea of having a concise
document that assumes a reader with decent Unix knowledge

Maybe you could just add some references to the distribution
specific information, or just refer to the man pages.

Maybe you could move the introductory comments to a FAQ-like
appendix. It could give brief hints on
"How to set up a user account?",
"How to setup a world-writable directory?"
I'm a bit reluctant to this because we'd need to maintain such
information. But I suspect that some users would find them
helpful.

One last comment: discussing patches is how the world works on
the git mailing list. It happend to me, too, that patches were
rejected after a brief or after a lengthy discussion. So, yes,
finally sometimes there is no change. But often the discussions
reveal a better way of achieving the original goal. Nonetheless,
it can be frustrating to the original author.

Thanks for you effort of improving the documentation.

	Steffen

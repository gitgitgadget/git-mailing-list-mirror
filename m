From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 1/4] Documentation: Add filter.<driver>.* to config
Date: Thu, 07 Apr 2011 13:57:31 +0200
Message-ID: <4D9DA6AB.40100@drmicha.warpmail.net>
References: <1301654600-8901-1-git-send-email-artagnon@gmail.com> <1302083854-2448-1-git-send-email-artagnon@gmail.com> <1302083854-2448-2-git-send-email-artagnon@gmail.com> <4D9C4E0F.8050302@drmicha.warpmail.net> <20110406124235.GA5881@kytes> <7vpqozjpcl.fsf@alter.siamese.dyndns.org> <20110406180950.GA667@kytes>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 07 11:57:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7lyC-0008DD-Ff
	for gcvg-git-2@lo.gmane.org; Thu, 07 Apr 2011 11:57:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754049Ab1DGJ5i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2011 05:57:38 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:49075 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752631Ab1DGJ5h (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Apr 2011 05:57:37 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 4BF50209AD;
	Thu,  7 Apr 2011 05:57:37 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute3.internal (MEProxy); Thu, 07 Apr 2011 05:57:37 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=oHPXcohj3qmmWh+Df6WjjfR4Ptc=; b=Pk2tpUSuwc3sUHVw5lx3Y0Z6RaEF0k22527EcXpm/uhXHt4mu2AQEyUCqjROm90wjcj/zz6IvF3uJci22RGDbL4s6vnz2Gmq/di6AJZgfUYxkGvG3EPdLbSm7S3hilkz9cGa9BMNZ+9/Qk8UyRF0F4F52pVOWiJB5T/dzmBpGX0=
X-Sasl-enc: wmXOt1SwilK1s9sgg2hDNwVmpyuz1FHvHMVAK2u8yqUT 1302170255
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 70159441943;
	Thu,  7 Apr 2011 05:57:35 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <20110406180950.GA667@kytes>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171051>

Ramkumar Ramachandra venit, vidit, dixit 06.04.2011 20:09:
> Hi Junio,
> 
> Junio C Hamano writes:
>> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>>> I'm very sorry to have caused so much pain.  Yes, I can imagine how
>>> terrible it must be to review several iterations of a simple
>>> documentation patch.  Thank you for being so patient with me so far- I
>>> understand if you don't want to do this anymore.
>>>
>>> I do spend time proofreading patches before sending them out, but I'm
>>> clearly not very good at it.  In future, I'll either try rewriting
>>> entire paragraphs or simply refrain from writing documentation patches.
>>
>> I do not think that is the lesson you should learn from this exchange.  A
>> major part of Michael's complaint (which I think was justified) was that
>> he even made a suggestion that is ready to be cut-and-pasted, but your
>> reroll does not use the suggested phrasing _without_ explaining why it
>> doesn't.
>>
>> It is not limited to "documentation patches".  If you get a "how about
>> doing it this way---isn't it cleaner?" suggestion to your code patch, you
>> at least owe either "yeah, that looks better---thanks, I've used it in
>> this reroll" or "no, because...; I've used the original" to the person who
>> tried to help you, no?
> 
> I completely agree -- all of Michael's suggestions were excellent, and
> I'd definitely owe him an explanation for not using something.  In
> this particular case, it was an honest mistake though- I meant to
> include Michael's version, but I'd rolled out the wrong commit after
> rebasing.

Ram, all is well (explained) now, and please don't give up on
documentation patches. You see, it happened to me again and again that I
submitted something, and someone took over the initiative or the idea
and submitted something under his name. And that is completely OK (after
all I had signed off on my patch, it's part of the O in OSS) but
"deprives" the original submitter of the "reward" of having the commit
count incremented. And that is what I wanted to spare you by not
submitting my own version.

Cheers,
Michael

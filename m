From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] git-pull.sh: Fix call to git-merge for new command  
 format
Date: Thu, 03 Dec 2009 09:10:53 +0100
Message-ID: <4B17728D.4070606@drmicha.warpmail.net>
References: <1259707451-20661-1-git-send-email-vonbrand@inf.utfsm.cl> <7vmy22qmgp.fsf@alter.siamese.dyndns.org> <4B163B49.4070606@drmicha.warpmail.net> <7vws15jpe7.fsf@alter.siamese.dyndns.org> <4B16A410.5090802@drmicha.warpmail.net> <7viqcpgtbf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 03 09:12:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NG6nO-0000Kp-2d
	for gcvg-git-2@lo.gmane.org; Thu, 03 Dec 2009 09:12:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751816AbZLCIMA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Dec 2009 03:12:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751696AbZLCIMA
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Dec 2009 03:12:00 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:35255 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751590AbZLCIL7 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Dec 2009 03:11:59 -0500
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id C0A68C5329;
	Thu,  3 Dec 2009 03:12:05 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Thu, 03 Dec 2009 03:12:05 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=aNRuNA78NfX3cPfL8bea8x7mIHk=; b=lbSJx71MXsWHuhEBsnjU88Z4vem1oklnB2aiC3VlV1HTZwXWMaH/tRubk6fx3FET5FzB6flWOy20KbLy9H2yzdM68MX8er8Fy8PbkhPeesizcPhjb5aMxZ3v7Rg1p6fdCYYYkeJ7dfxc/NyW6qPYZKAw8wf9yQy6uBWKXj3M1bo=
X-Sasl-enc: 4zHoboguGy1xOPAMibNik9h9f2NvwJMipHLrgtTBSM9g 1259827925
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 1BF982B215;
	Thu,  3 Dec 2009 03:12:04 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.6pre) Gecko/20091127 Lightning/1.0b1pre Shredder/3.0.1pre
In-Reply-To: <7viqcpgtbf.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134440>

Junio C Hamano venit, vidit, dixit 02.12.2009 18:49:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>>> Yes.  Anything that sets GIT_EXEC_PATH correctly can use git-foo form.
>>
>> I know they can. That was in the part you snipped ;)
> 
> You asked about the presense of "a policy", and you got an answer.

I guess that was a language issue (on both sides) then, since "can"
could be "is able to" as well as "is allowed to", and I read your answer
in the former sense; the latter makes it a policy.

>> The questions is: Should they? Should we avoid mixing both forms in one
>> script?
> 
> Should we avoid it?  Yes but not very enthusiastically.  We should make
> sure that new invocations anybody adds use dashless form, but I would
> recommend against a "let's remove use of dashed form" patch _unless_ you
> find a time when the project is really quiet and there is nothing else
> going on.

OK, that's all I wanted to know. Thanks.

Michael

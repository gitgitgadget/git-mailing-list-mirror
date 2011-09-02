From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Rebase & Trailing Whitespace
Date: Fri, 02 Sep 2011 09:32:58 +0200
Message-ID: <4E6086AA.40806@drmicha.warpmail.net>
References: <CAE1pOi0rY4kRR4rvEdFhzzTgfhUczHMX=H5_9+o5aHnv4vTadw@mail.gmail.com> <20110901023127.GB31838@sigill.intra.peff.net> <29267EE41F9343E68AAAE2C33AA40E1A@PhilipOakley> <20110901212618.GB16308@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Philip Oakley <philipoakley@iee.org>,
	Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	Git Users <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Sep 02 09:33:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QzOFR-0004hr-0d
	for gcvg-git-2@lo.gmane.org; Fri, 02 Sep 2011 09:33:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756190Ab1IBHdD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Sep 2011 03:33:03 -0400
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:56661 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753928Ab1IBHdB (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Sep 2011 03:33:01 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 886A620A35;
	Fri,  2 Sep 2011 03:33:00 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute1.internal (MEProxy); Fri, 02 Sep 2011 03:33:00 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=4la+pMpPaqyjezPeNkEe2W
	JRH64=; b=tT0xzWXiXPCQJy/dUKjmJaRuyrfe2GPM7OmwdBz0cMBoAqlMtNWGOF
	fOIZynXxV8FmlRxZvYkplLbNyipKeHqYcuQwVLpoDps5R+305ra2o5kJLQxkRXn8
	KmK1gjMoxta3NvAPhZnD01034AVP/J0xCVNTbNYHl89QlxOT394Io=
X-Sasl-enc: xFkJb4MKHqRxYiuUSoPaYgyYy/m5SvTl5fccAYPPbSnn 1314948780
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id C948EB21A91;
	Fri,  2 Sep 2011 03:32:59 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:6.0) Gecko/20110816 Thunderbird/6.0
In-Reply-To: <20110901212618.GB16308@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180601>

Jeff King venit, vidit, dixit 01.09.2011 23:26:
> On Thu, Sep 01, 2011 at 10:00:38PM +0100, Philip Oakley wrote:
> 
>>> [1] If you don't remember the empty tree sha1, you can always derive it
>>>   with:
>>>
>>>       git hash-object -t tree /dev/null
>>>
>>
>> I've added this tip to the
>> https://git.wiki.kernel.org/index.php/Aliases page
> 
> Thanks. By itself, I think many readers would ask "why would I want the
> empty tree, so I threw in a few examples of use on the wiki, too.

Ugh. I mean: Thanks for the wiki entries, they're nice, but have you
checked git.git for whitespace errors? Time for another war on
whitespace? Many false positives, of course, but also true positives.

Michael

From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: tracking branch for a rebase
Date: Mon, 07 Sep 2009 11:53:30 +0200
Message-ID: <4AA4D81A.1030203@drmicha.warpmail.net>
References: <20090904135414.GA3728@honk.padd.com> <4AA124DD.1030208@drmicha.warpmail.net> <20090904181846.GC19093@coredump.intra.peff.net> <20090904185949.GA21583@atjola.homenet> <20090905061250.GA29863@coredump.intra.peff.net> <20090905140127.GA29037@atjola.homenet> <20090905142841.GB15631@coredump.intra.peff.net> <7vfxaz9wfi.fsf@alter.siamese.dyndns.org> <20090907084324.GB17997@coredump.intra.peff.net> <alpine.DEB.1.00.0909071126040.8306@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
	Pete Wyckoff <pw@padd.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Sep 07 11:53:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mkav2-0006iZ-B6
	for gcvg-git-2@lo.gmane.org; Mon, 07 Sep 2009 11:53:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752539AbZIGJxm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Sep 2009 05:53:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752386AbZIGJxm
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Sep 2009 05:53:42 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:35691 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752008AbZIGJxm (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Sep 2009 05:53:42 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id F2265632BD;
	Mon,  7 Sep 2009 05:53:42 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Mon, 07 Sep 2009 05:53:43 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=3ayM66O6F4HQVbPHDG51b596OCw=; b=Ocxj/zv+tJB8hKJK+TXS2HBVCwfkmAQB3ZIrq5BGE78Yp6z1mQLr6FUmr3R1alxVZyTrGxV0sOIoBJK+c681Qh2mAIy8RB4tjo2OZUq4OMOT9L55z8ftkDp58qB+4NhvaH9IrLp5H/YTUcJUxBZ1nhn0SuYbkHYwgFsvmJkWsQA=
X-Sasl-enc: rnsgFrEQt6Vpe+qkiFVBf8XHMQdVlGt2XqMf6RiITgYe 1252317222
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id B5F8B6108C;
	Mon,  7 Sep 2009 05:53:41 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.4pre) Gecko/20090902 Lightning/1.0pre Shredder/3.0b4pre
In-Reply-To: <alpine.DEB.1.00.0909071126040.8306@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127917>

Johannes Schindelin venit, vidit, dixit 07.09.2009 11:29:
> Hi,
> 
> On Mon, 7 Sep 2009, Jeff King wrote:
> 
>> On Sun, Sep 06, 2009 at 10:05:21PM -0700, Junio C Hamano wrote:
>>
>>> 	ref@{number}	-- nth reflog entry
>>>         ref@{time}	-- ref back then
>>> 	@{-number}	-- nth branch switching
>>>
>>> So perhaps ref@{upstream}, or any string that is not a number and cannot
>>> be time, can trigger the magic operation on the ref with ref@{magic}
>>> syntax?
>>
>> I think using @{} is a reasonable extension format.
> 
> Sorry to enter this thread that late, but I did not realize that it 
> touches my %<branch> work.
> 
> Your proposal leads to something like "master@{upstream}@{2.days.ago}", 
> which looks ugly.  And it is much more to type.
> 
> I still think that it is not too-much asked for to require the 
> "refs/heads/" prefix if somebody starts her branch names with "%".
> 
> Or did I miss something (as I do not have time to read long mails these 
> days, I tend to read only the short, to-the-point ones; I allowed myself 
> to only skim over the rest of your mail)?

Solution needs to be:
- practical (short, clear)
- not too brutal (on existing users of legal "exotic" refnames)
- extensible (for later uses)

Michael
152 chars for Dscho :)

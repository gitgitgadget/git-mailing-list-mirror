From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: How to git checkout a orgin(unstage) version file in another
 directoy?
Date: Fri, 18 Feb 2011 08:41:50 +0100
Message-ID: <4D5E22BE.301@drmicha.warpmail.net>
References: <loom.20110217T074533-358@post.gmane.org> <4D5CDBAD.4050700@drmicha.warpmail.net> <7vpqqqcxzf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Chunlin Zhang <zhangchunlin@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 18 08:45:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqL1d-000128-DF
	for gcvg-git-2@lo.gmane.org; Fri, 18 Feb 2011 08:45:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755999Ab1BRHpE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Feb 2011 02:45:04 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:39610 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755853Ab1BRHpC (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Feb 2011 02:45:02 -0500
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id B020B20BAE;
	Fri, 18 Feb 2011 02:45:00 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Fri, 18 Feb 2011 02:45:00 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=wjVOQq5WQjiSqInYZjtsveFk350=; b=BH6wM0SOCDfZLkKjizkdIjNqLLC09Dki8SrTIbe565XdbBbZOuapYk5jOzKQz9maCJyvmBhCrbgM5HnG8KLtXh0OxaPcREGyBQj9twocZ8u36yeKuiTw28Pl9OdCDjYBpf2LOOhCIEl2V4wYy7Pa1SmqjHLHU7mkTLuxNgdOU/w=
X-Sasl-enc: WKltI6HAGdvRFxW5bymY5XbPP23O9iFJB/RP20XjHESf 1298015100
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 1CE6B449F80;
	Fri, 18 Feb 2011 02:44:59 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.7
In-Reply-To: <7vpqqqcxzf.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167182>

Junio C Hamano venit, vidit, dixit 17.02.2011 19:33:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> I'm not sure what you mean by "origin" version, but if you mean the
>> version from the current revision (before making and staging changes),
>> you would check out from HEAD instead of from the index:
>>
>> git --work-tree=. --git-dir="/media/linux/t/kernel/.git" checkout HEAD
>> -- README
> 
> Wouldn't that still affect the index in /media/linux/t/kernel/.git/index,
> making /media/linux/t/kernel/README and the index entry out-of-sync?

Yes. I guess you overlooked the two posts where Chunlin and I realised
that I took his request for "checkout" too giterally.

Michael

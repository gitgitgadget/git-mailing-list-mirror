From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 0/3] rev-list and friends: --min-parents, --max-parents
Date: Mon, 21 Mar 2011 08:42:15 +0100
Message-ID: <4D870157.2070309@drmicha.warpmail.net>
References: <20110318085616.GA16703@sigill.intra.peff.net> <cover.1300459016.git.git@drmicha.warpmail.net> <20110318194113.GA2215@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 21 08:42:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1Zks-0000o5-6R
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 08:42:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752553Ab1CUHmR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2011 03:42:17 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:44569 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751722Ab1CUHmP (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Mar 2011 03:42:15 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 5BA14209AF;
	Mon, 21 Mar 2011 03:42:15 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Mon, 21 Mar 2011 03:42:15 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=Mes/BvOet4xFyTpL992GtQwACGk=; b=oHKl5vWqJmAFf4Wt8bmC+9vmVW8C8GS4wwbsZukBqNlAEKpgnuJZA6o7degh9C45r5Cq9RwiHrKzJXVmtvqlrbMya61PpqRzx7tC6lr4SsR23DQwVXBGnjOHzPXtM5p9K451s/MmiBbkA4jQ465FuYKUjo5vK2CY9YIUi4WkroA=
X-Sasl-enc: AmgCZ49E4t7zqT2EhEWFW6icox6Z17DtYJCyT3Kuu/K5 1300693335
Received: from localhost.localdomain (p548593A3.dip0.t-ipconnect.de [84.133.147.163])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 893784409E6;
	Mon, 21 Mar 2011 03:42:14 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <20110318194113.GA2215@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169556>

Jeff King venit, vidit, dixit 18.03.2011 20:41:
> On Fri, Mar 18, 2011 at 03:50:22PM +0100, Michael J Gruber wrote:
> 
>> As opposed to the RFD it replaces, this is a real patch series with
>> documentation and tests, and it even comes with boiler plate. It should
>> make all of Jeff's and Junio's dreams come true (as far as revision
>> limiting by parent number goes).
>>
>> 1/3 introduces the new options (and has a proper commit message)
>> 2/3 I noted along the way and could be applied earlier
>> 3/3 depends on 1 and 2 and is the candy (doc, tests, completion)
> 
> I didn't see it mentioned anywhere, but I assume this applies on
> mg/rev-list-one-side-only (b1b4755). It has conflicts when applied on
> master.
> 
> (I know you probably know that, but it is for the benefit of other
> reviewers).

Well, yes, but that's in next already (and probably in master by the
time this is taking shape). If I had it based on something earlier it
would have applied cleanly but failed to compile which is fine for
something meant to go to maint but a nuisance for pu material.

Michael

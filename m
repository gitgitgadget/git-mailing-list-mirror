From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [Support] Branch pointer does not move
Date: Mon, 14 Mar 2011 16:48:22 +0100
Message-ID: <4D7E38C6.4010804@drmicha.warpmail.net>
References: <op.vsb4lif0bl4hj1@metalltrottel.fritz.box> <AANLkTik5MGyw_6vnT8055Yap3Ca1pDQYpJ_RXiZQbwA4@mail.gmail.com> <op.vsb95dilbl4hj1@metalltrottel.fritz.box> <AANLkTimW+01wriSjvEVEyQ8SE5RPxhGv_o2Rus9kw6ZQ@mail.gmail.com> <op.vscae5mbbl4hj1@metalltrottel.fritz.box>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
To: Franz Liedke <franz@develophp.org>
X-From: git-owner@vger.kernel.org Mon Mar 14 16:52:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzA3w-0000DX-5u
	for gcvg-git-2@lo.gmane.org; Mon, 14 Mar 2011 16:52:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755501Ab1CNPvz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Mar 2011 11:51:55 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:37406 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752892Ab1CNPvy (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Mar 2011 11:51:54 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id D7B0120B93;
	Mon, 14 Mar 2011 11:51:53 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Mon, 14 Mar 2011 11:51:53 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=u4zGsPTyZ88JVU/0JAQIO1ucei8=; b=lVbHHjIxpaf077jCPRIJN1IjFHAF/WmKk4gkbazj5I882yR65gm7AP8ivfOYLtyEwqSojtXiqQBAtpa9+0Qp+ETlxRR4JT4LTVgdSuCbl29oZGzVD1nT/sAiK7aZ9NAQZMFkFcO1yn5hmv1WLPF8HrB0YwNAyWSex47L9ywwWB4=
X-Sasl-enc: qTDpYPAQVJFR9QGieFYDii2x3qgIAHXG4Tx7XTQczV60 1300117913
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 3CD66441DE8;
	Mon, 14 Mar 2011 11:51:53 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <op.vscae5mbbl4hj1@metalltrottel.fritz.box>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168995>

Franz Liedke venit, vidit, dixit 14.03.2011 16:24:
> Oops, sorry I didn't make that clear. The branch pointer is still  
> displayed next to the old commit in SmartGit, the GUI I normally use.
> 
> On Mon, 14 Mar 2011 16:19:39 +0100, Sverre Rabbelier  
> <srabbelier@gmail.com> wrote:
> 
>> Heya,
>>
>> On Mon, Mar 14, 2011 at 16:18, Franz Liedke <franz@develophp.org> wrote:
>>> "git status" and "git branch" both tell me I'm on my feature branch.
>>
>> And that one _is_ updating?
>>
>>> .git/packed-refs and .git/info/refs are both not updated.
>>
>> That's fine, don't worry about those.
>>

So, taking a step back - when you "make a commit", do you mean using git
or using smartgit? Have you been mixing git command line and smartgit
actions (while smartgit was running)?

Michael

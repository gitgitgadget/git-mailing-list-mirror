From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git cherry improvements suggestions
Date: Wed, 23 Mar 2011 14:33:48 +0100
Message-ID: <4D89F6BC.2040902@drmicha.warpmail.net>
References: <AANLkTimk0bkOGVy2W+XddHRuf-1xw+d0RwzPhnk40vi8@mail.gmail.com>	<4D89CF8E.4070100@drmicha.warpmail.net> <AANLkTinXh_Y9ft5Pd5SxOEXvKNm3HLmsiut8WrvFZrdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 23 14:37:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2OFf-0000Qf-DR
	for gcvg-git-2@lo.gmane.org; Wed, 23 Mar 2011 14:37:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932528Ab1CWNhY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2011 09:37:24 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:58728 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755619Ab1CWNhW (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Mar 2011 09:37:22 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 3083620A0D;
	Wed, 23 Mar 2011 09:37:22 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Wed, 23 Mar 2011 09:37:22 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=qA/ieVLSbxBBaR0V36v6klkesb8=; b=LiPM0vWqkHDyEGqHe4pfUdlPFsjsqkl6qEX1WiS/WC/fazOBg3MesxN/jFM+nULnWe9B6Vo9zVn65JFrew9Gpo0ZaeThLshosvQvFzVZuKeWlA30EqT9zDIa7DwxRLc8KStVB9y/refV47Oh2mw1EU/nLwezj0qAXS9TYZxzKK8=
X-Sasl-enc: b3a2dksj8/0twcrIr06pf0BYHK0VxYo8BAvz/p3D2/1N 1300887441
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 9FA13440B98;
	Wed, 23 Mar 2011 09:37:21 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <AANLkTinXh_Y9ft5Pd5SxOEXvKNm3HLmsiut8WrvFZrdQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169829>

Piotr Krukowiecki venit, vidit, dixit 23.03.2011 14:23:
> On Wed, Mar 23, 2011 at 11:46 AM, Michael J Gruber
> <git@drmicha.warpmail.net> wrote:
...
>> You will be a happy user of "git log --cherry A...B" instead of "git
>> cherry A B". It gives you all the log option (e.g. p for diff) that you
>> like and uses "=" rather than "-". It's currently in next and will be in
>> the next release.
> 
> I've tried it and indeed I'm happy! :)
> The "git log --cherry-mark --left-right A...B" is what I needed!
> 
> Just some stats:
> 
>    git log --cherry-mark --left-right --oneline --date-order branch...trunk
> 
> lists 1004 commits, takes about 20s and memory peaks to about 670MB
> twice during the run (I'm on linux with AMD Phenom II X4 945)
> 
> With limit it prints X last commits (the limiting seems to take place after all
> work, on the output list only).
> 
> branch..trunk is 551 commits, the other way is 453 commits.
> 710 commits are found to be "=", 98 "<", 196 ">".
> 
> Note, I'm not saying it's too slow, or that it's working incorrectly, I'm just
> giving real-life stats if anyone was interested.
> I suspect such checks won't be done frequently.

You don't need to say it's slow - I've said so already :(

http://permalink.gmane.org/gmane.comp.version-control.git/169725

But I hope we can remove some bottle-necks.

> So thanks for the great improvement!

You're welcome :)

Michael

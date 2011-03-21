From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: The way to make work with git a bit more easier.
Date: Mon, 21 Mar 2011 13:33:30 +0100
Message-ID: <4D87459A.1040307@drmicha.warpmail.net>
References: <AANLkTimrYGXQ_wWrj-Sr3UB9YbddW613oebddUoLat7b@mail.gmail.com> <AANLkTik3_tE6DdCQkS5ssqB9OBBNSvj5KO3WK=0Vj4YG@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Alexey Homyakov <alexey.homyakov@gmail.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 21 13:33:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1eIt-0000Gc-Kn
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 13:33:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752825Ab1CUMdc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2011 08:33:32 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:53608 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752686Ab1CUMdb (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Mar 2011 08:33:31 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 7DBFA207F7;
	Mon, 21 Mar 2011 08:33:30 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Mon, 21 Mar 2011 08:33:30 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=giy2+FjIEo4ivuwUlgYp0zTR/K0=; b=q9nk/a5thkxjhAfkcLkGQPAq2ViNeZChwmjUuj6kTx29cPXAbbVliIupYfWoCLazCkOQ+eZ0UDNDfwpVvbsBlAPO1yAdBqUDMfDDjfQQr8awYg8sPjRivH9nWBjWgo6lUxq+XEtpA0RMfv5Eg8laQ6amOUKjuwNqnoyrIAoaqPM=
X-Sasl-enc: 4oCGmzUnWPHEjnZ0NtRrNJ3V/GPV8eKEONRet22qkKlo 1300710810
Received: from localhost.localdomain (p548593A3.dip0.t-ipconnect.de [84.133.147.163])
	by mail.messagingengine.com (Postfix) with ESMTPSA id B5595445328;
	Mon, 21 Mar 2011 08:33:29 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <AANLkTik3_tE6DdCQkS5ssqB9OBBNSvj5KO3WK=0Vj4YG@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169590>

Nguyen Thai Ngoc Duy venit, vidit, dixit 19.03.2011 13:30:
> 2011/3/19 Alexey Homyakov <alexey.homyakov@gmail.com>:
>> Hi, guys, i'm enjoy to work with git, but think it's possibly to make
>> one of the operation more easier.
>> What do you mean about mark a parts of files which don't need to be
>> tracked by git once instead using interactive adding each time?
>> For example using statement in comments like this:
>>
>> ................
>> tracked part
>> ...............
>> //@git off
>> ...............
>> untracked part
>> ...............
>> //@git on
>> ................
>> track again
>> ................
> 
> That's interesting, provided that this is only enabled by command
> argument (i.e. never activated by default). Another option is to make
> "git add -p" only show chunks that match a pattern.

This can be done using a "clean" filter already. For example, for
tracking my global git configuration, I use

[filter "dotgitk"]
        clean = fgrep -v geometry

and specify

.gitk   filter=dotgitk

for the attributes.

Cheers,
Michael

From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: gitk won't show notes?
Date: Tue, 07 Apr 2015 16:13:19 +0200
Message-ID: <5523E5FF.8060101@drmicha.warpmail.net>
References: <551D99B9.7040200@ubuntu.com> <5523DE66.8060904@drmicha.warpmail.net> <5523E479.2010701@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Phillip Susi <psusi@ubuntu.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 07 16:13:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YfUG7-0007rk-JQ
	for gcvg-git-2@plane.gmane.org; Tue, 07 Apr 2015 16:13:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755526AbbDGONj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2015 10:13:39 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:34106 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755496AbbDGONV (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Apr 2015 10:13:21 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id E7CC02095E
	for <git@vger.kernel.org>; Tue,  7 Apr 2015 10:13:16 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute4.internal (MEProxy); Tue, 07 Apr 2015 10:13:20 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=AkTYfPzqNkmtKxKkYD/pRO2Z/Fo=; b=LQyV8l
	NsaReBkWpcMAqOezEnnq/PkbLPN/Zd2+XmFGJmR5oEYMrRy8UyzAbtqKnorBRAks
	BqCkvDfmi+/T8a/6PWkbtTzaY8yGor6oNGKTFNqNwbptdLvzsep9dMnbpQ6dQKIw
	uBIWVCCvRKbZK8iLxGfx5ba8FPNGMAIpZRtt0=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=AkTYfPzqNkmtKxK
	kYD/pRO2Z/Fo=; b=ISm0fv/bkhHripbO9vpBKi0+A/m1b6dMM6xwCkIdqnrYqRH
	vJsLARK/fymyW/rN826BjdSEnmUf4gUI09sd9H93nHNIW4jHW6mwsvJTbYz7cgFj
	nXO979mWJOQ9ye7mHBo9zg79FHNU9DMAZvlFQA6w1aBRM4pD+Swzxu/0VdCY=
X-Sasl-enc: VYNsaFx+PR5TzT3RLZ7w9oclFKFn5jLZo8AAM55kNUW0 1428416000
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 531B06801EB;
	Tue,  7 Apr 2015 10:13:20 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <5523E479.2010701@ubuntu.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266917>

Phillip Susi venit, vidit, dixit 07.04.2015 16:06:
> On 4/7/2015 9:40 AM, Michael J Gruber wrote:
>> Phillip Susi venit, vidit, dixit 02.04.2015 21:34:
>>> I can't seem to get gitk to show notes, even when I give it
>>> --notes. Does it just not handle notes?
>>>
>>>
> 
>> Have you tried with "--show-notes"?
> 
>> It works over here even without --show-notes, by the way, but I'm
>> not on Windows. Are you?
> 
> Yes... and this just got weird... I shutdown and restarted gitk and
> now they show up just fine.  It seems that adding the note while gitk
> is already open, and hitting refresh fails to detect the note.

Rebooting is the Windows version of refresh ;)

Seriously: gitk knows F5 and Shift-F5 for refresh, and I think the
latter is the thorougher refreshment.

Michael

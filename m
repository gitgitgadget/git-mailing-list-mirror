From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: What's cooking in git.git (Aug 2011, #03; Thu, 11)
Date: Thu, 18 Aug 2011 23:00:45 +0530
Message-ID: <CALkWK0mN_SUK4pkZZccmvTTrAJK0ZPjY77d7iaKT8RWtEJzFCg@mail.gmail.com>
References: <7vr54rpogf.fsf@alter.siamese.dyndns.org> <CALkWK0mxHT8by86-P=Msopgib1ToeHcfwsSXBYBgvN_dm75GnA@mail.gmail.com>
 <7vwredi9uu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 18 19:31:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qu6R0-0007B8-4T
	for gcvg-git-2@lo.gmane.org; Thu, 18 Aug 2011 19:31:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160Ab1HRRbI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Aug 2011 13:31:08 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:45496 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750896Ab1HRRbH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2011 13:31:07 -0400
Received: by wwf5 with SMTP id 5so2327223wwf.1
        for <git@vger.kernel.org>; Thu, 18 Aug 2011 10:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=tVbN5H4THK5Hcj5kVSLxvNWNWsV/JfIYOpeIj4CrCsw=;
        b=sTD1Bcsqfnw6IEpnxif9fpY+n5UQ5MfkrywcYBk2SjiMzT4hGfoquBg7uoqOfrxkAW
         /cuXFf4+W9RUvc8SJg2Dvn/g6EihgATjMjCialc2snmIU3nS7kOT+HpBIxu0NweNwt0S
         z4xSwW1qLKbqr21Q6xoK9ecQFDIuwMH0HcJX0=
Received: by 10.216.175.130 with SMTP id z2mr842870wel.63.1313688666118; Thu,
 18 Aug 2011 10:31:06 -0700 (PDT)
Received: by 10.216.172.132 with HTTP; Thu, 18 Aug 2011 10:30:45 -0700 (PDT)
In-Reply-To: <7vwredi9uu.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179607>

Hi Junio,

Junio C Hamano writes:
> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>>> * rr/revert-cherry-pick-continue (2011-08-08) 18 commits
>>> [...]
>>> Will merge to "next".
>>
>> If this won't graduate to 'next' before the 24th, I have plenty of
>> time to re-roll fixing all the issues that I've addressed in the
>> beginning of the new series.
>
> I take it that you mean by "the new series" the 6-patch "Towards a
> generalized sequencer" topic?

Yes.

> It is ultimately up-to-you. If you feel the fix-up is against glaring
> errors in the earlier round that you would prefer not to see in the
> history cast-in-stone, I am perfectly Ok to wait for a re-roll. On the
> other hand, if they are mostly cosmetic fixes without major semantic
> changes, it may be easier for everybody to see them fixed in-tree.

Hm, I didn't think they were glaring errors.  After reading your
latest review about my '--continue' patch in the generalized
sequencer, I've decided not to re-roll.  Please merge
'rr/revert-cherry-pick-continue' into 'next' as usual.  It'll take me
some more time to think about my "generalized sequencer" series.

Thanks.

-- Ram

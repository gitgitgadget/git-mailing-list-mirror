From: Elliott Cable <me@ell.io>
Subject: Re: [PATCH/RFC] rev-list: add --authorship-order alternative ordering
Date: Thu, 6 Jun 2013 15:32:08 -0400
Message-ID: <CAPZ477O4DyAcd-eZp2UQhta61e6AeGZiTxPuXOcuEP0X+8wRAA@mail.gmail.com>
References: <1370369299-20744-1-git-send-email-me@ell.io>
	<1370369299-20744-2-git-send-email-me@ell.io>
	<7vip1t7koi.fsf@alter.siamese.dyndns.org>
	<7vobbl60aj.fsf@alter.siamese.dyndns.org>
	<CAPZ477OFM6D4n_Wz-OozN=aYn5-LmNA2ggL+9GNrbGrRQh9pRQ@mail.gmail.com>
	<7vtxlbxcl7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 06 21:32:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ukfuw-0006gD-Ql
	for gcvg-git-2@plane.gmane.org; Thu, 06 Jun 2013 21:32:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752449Ab3FFTcK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Jun 2013 15:32:10 -0400
Received: from mail-oa0-f49.google.com ([209.85.219.49]:52871 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752101Ab3FFTcJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Jun 2013 15:32:09 -0400
Received: by mail-oa0-f49.google.com with SMTP id k14so2518906oag.8
        for <git@vger.kernel.org>; Thu, 06 Jun 2013 12:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ell.io; s=google;
        h=mime-version:x-originating-ip:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=7v/UfnQhbPPzU7w7v8TVIOUu/V3wmH8oNzVkEzGjCzE=;
        b=Dxb1lLDqXw4V9s82vsQB11ACCfjMPzapR9W8TeooyolVKMGU+Lr3iI4vaibZK5JUbS
         ciD7DMBvxZqp1nL61tdzq2NmLT33LXLcDPUmG0Om6UOxWfwL+LrDo9FIVWa9tNjlOaOc
         WGPK+dL9yJG6IO0+MskAYkAgjMgFGk1ktmTYw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-originating-ip:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding:x-gm-message-state;
        bh=7v/UfnQhbPPzU7w7v8TVIOUu/V3wmH8oNzVkEzGjCzE=;
        b=egyLoY4k5sJxnDrPBrXNMnq9qDTF6if174kE7+0jjGDMzUGxTMoxSM68/OH26+WKzd
         3jTlS1ZaaU9KLELd8YM4iXYd/iM0pGUgiHEe8kIyLDAzKuFccKtST0TGj0e22tJP0Gsu
         L5Ghwo2lxfWhJ8mB2w/dI1nAgefEPfyBqMTYcVKnoLzfNZxKcFUPdKNRCbUPRVu/bedO
         PU1gHGXeyHJssV6ASi/tXsFWqlnheoT5xs504NXy05W2OvF8QgB2sk/74E5aCzQ7ffZJ
         0kRmHdXUj/uD027lDLsE0/4J0y6dQxN2oXVLJzSOEJWwI5esEncC4WSVU/CJW2JSmzjb
         dPHw==
X-Received: by 10.60.61.80 with SMTP id n16mr10391141oer.46.1370547128473;
 Thu, 06 Jun 2013 12:32:08 -0700 (PDT)
Received: by 10.60.28.194 with HTTP; Thu, 6 Jun 2013 12:32:08 -0700 (PDT)
X-Originating-IP: [70.197.160.229]
In-Reply-To: <7vtxlbxcl7.fsf@alter.siamese.dyndns.org>
X-Gm-Message-State: ALoCoQml/wTRER1N1cPeXv/tL1mmX3/vcbCvme7GDbNPCgP5jiZ/UwzFvGP9OEESIIxQhITNnCnf
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226532>

Wow. That's my bad entirely. I apparently hallucinated a section
suggesting that you =E2=80=9Csign-off=E2=80=9D commits that you'd revie=
wed, or
something; and I'd completely skipped the section on certifying that
you have legal rights to the work, because I'd *written* it, and
didn't think it'd be relevant.

I feel like an idiot. Forgive me. I'll --signoff my next version of
the patch. o7

On Thu, Jun 6, 2013 at 3:29 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Elliott Cable <me@ell.io> writes:
>
>> On Tue, Jun 4, 2013 at 3:14 PM, Junio C Hamano <gitster@pobox.com> w=
rote:
>>> elliottcable <me@ell.io> writes:
>>>> Thus, I've added an --authorship-order version of --date-order, wh=
ich relies
>>>> upon the AUTHOR_DATE instead of the COMMITTER_DATE; this means tha=
t old commits
>>>> will continue to show up chronologically in-order despite rebasing=
=2E
>>>> ---
>>>
>>> Missing sign-off.  Please see Documentation/SubmittingPatches.
>>
>> Will-do.
>>
>> I read that part, and was rather confused. At no point did I get the
>> idea that I should sign-off *my own initial commit*. Perhaps that pa=
rt
>> of the documentation needs to be slightly re-written? Would that be =
a
>> welcome change?
>
> I fail to see what more needs to be clarified on top of what we
> already have; please re-read "(5) Sign your work" section, paying
> with special attention to:
>
>  - "YOU WROTE IT or otherwise have the right to pass it on".
>
>  - "the contribution was created in whole or in part BY ME and I
>    HAVE THE RIGHT TO SUBMIT".
>
> But perhaps you meant something else by "*my own initial commit*"???

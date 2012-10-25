From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/3] t9350: point out that refs are not updated correctly
Date: Thu, 25 Oct 2012 07:40:37 +0200
Message-ID: <CAMP44s3Xwt5+J_yGte_HC3hG+MhMkWnJQ7mtuB_Y+sOLB1b1+A@mail.gmail.com>
References: <1320535407-4933-1-git-send-email-srabbelier@gmail.com>
	<1320535407-4933-2-git-send-email-srabbelier@gmail.com>
	<CAMP44s1hdZb_7Lv8SEe+MsfC_q-nXsnjJobABFq6eFR_er4TaA@mail.gmail.com>
	<20121024180807.GA3338@elie.Belkin>
	<CAMP44s2RspCrRXZbRTsVwezyU9X=+8RF=_9Q+3zX75LBJkdoPA@mail.gmail.com>
	<20121024191149.GA3120@elie.Belkin>
	<CAMP44s2kjv9fHbruXv7NyVm9m+FjFnYDryuPZQ-RQXN9Nj6MAw@mail.gmail.com>
	<20121025042731.GA11243@elie.Belkin>
	<CAMP44s1Pe8Ef6-GRbmSs7rY7gWyaPCN+jWGysyttZp3drSDoZg@mail.gmail.com>
	<20121025052823.GB11243@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Eric Herman <eric@freesa.org>,
	Fernando Vezzosi <buccia@repnz.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 25 07:40:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRGBX-0007JD-Vf
	for gcvg-git-2@plane.gmane.org; Thu, 25 Oct 2012 07:40:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756609Ab2JYFkj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2012 01:40:39 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:55760 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756546Ab2JYFki (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2012 01:40:38 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so1241110oag.19
        for <git@vger.kernel.org>; Wed, 24 Oct 2012 22:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=yLGhwimQ1KfFW4ehGUlPPhR0lgsJHTXztQq7+MqVNAw=;
        b=mFBZwWl/tDy/Ncr+5QUY8Otrem8yeFeQEAz1opzCBzznNr/nM/HGUdeA7rYrqKt7ZM
         9ZAofpz0NduMMP1Xr256AP0mp8cwh2VOUCP7CQh8jezrCxTd1xDuTA4mOoubKAfpvU3a
         XxRrvvMvAnWPQf3j6F8wEdQRBVe9wX/xFC5TLM0HiUeBOmO5lFvVR7HbUIMnbaIvYmt7
         5ASOV43ytfJo38Y+gXm1a9HCD80nPVhJddGTXMdrCW5Z1mv2eYNwvtjfMPgpAIsWam/B
         M2fm0wP55+tnAxzP2Tb2n3ye/3mVltrTnxX3Ds0FeSEpbhcnUTfMNiSZIeNKUpxeZ/Uh
         gDvQ==
Received: by 10.60.27.201 with SMTP id v9mr6869675oeg.85.1351143637775; Wed,
 24 Oct 2012 22:40:37 -0700 (PDT)
Received: by 10.60.4.74 with HTTP; Wed, 24 Oct 2012 22:40:37 -0700 (PDT)
In-Reply-To: <20121025052823.GB11243@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208346>

On Thu, Oct 25, 2012 at 7:28 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Felipe Contreras wrote:
>
>> I don't need help, I am helping you, I was asked to take a look at
>> this patch series. If you don't want my help, then by all means, keep
>> this series rotting, it has being doing so for the past year without
>> anybody complaining.
>
> Ah, so _that_ (namely getting Sverre's remote helper to work) is the
> work you were trying to do.  Thanks for explaining.

No, that's not what I'm doing. I haven't even seen a remote-hg branch
from either Sverre, or Johannes. IIRC the msysgit wiki mentions that
there were some patches not quite accepted in upstream that prevented
the remote-hg from getting upstream. But I don't know which patches
are those, I don't know why they are needed, and I haven't even been
able to run this stuff.

I was told this might be an issue for all remote helpers, and it seems
to be the case (albeit a small issue IMO).

> If I understand correctly, it is possible to get Sverre's remote
> helper to work without affecting this particular testcase.  From that
> point of view I think you were on the right track.

That makes sense. So are there any other patches?

> The testcase is imho correct and does not need changing.  So yes, I
> don't want your help changing it.  I don't suspect you will be using
> "git fast-export $(git rev-parse master)..master".  It is safe and
> good to add additional testcases documenting the syntax that you do
> use, as an independent topic.

All right, so I run this and get this:

% git fast-export master..master
reset refs/heads/master
from 8c7a786b6c8eae8eac91083cdc9a6e337bc133b0

As an user of fast-export, what do I do with that now?

-- 
Felipe Contreras

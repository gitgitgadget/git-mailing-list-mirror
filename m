From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v5 00/36] Massive improvents to rebase and cherry-pick
Date: Mon, 10 Jun 2013 22:52:21 -0500
Message-ID: <CAMP44s0+Qz5urzUtv-ZQr-4r-jzYMcnXD4=8f51sQbXdEyQvKg@mail.gmail.com>
References: <1370805890-3453-1-git-send-email-felipe.contreras@gmail.com>
	<CAMP44s2nbo97qFenwm3RaHYQ4K14knZpSvpLPPM3uPiFSRinuQ@mail.gmail.com>
	<CABURp0p7axsFHRLpXBCAZaMpeE1Ae5N1wNugEe3vsHCtX6_7EQ@mail.gmail.com>
	<CAMP44s10T55_OBQrzXg6jwPrtJh_J9dJnTfDKJhkUc_oCm_cOA@mail.gmail.com>
	<CABURp0qG6AqR-y1YLB0FdX-=kniHoZBfwUs0d7gPnfDfh9Pajw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 11 05:52:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmFdF-0001jX-Ko
	for gcvg-git-2@plane.gmane.org; Tue, 11 Jun 2013 05:52:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753658Ab3FKDwZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jun 2013 23:52:25 -0400
Received: from mail-lb0-f173.google.com ([209.85.217.173]:41524 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751737Ab3FKDwY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 23:52:24 -0400
Received: by mail-lb0-f173.google.com with SMTP id v1so2184226lbd.4
        for <git@vger.kernel.org>; Mon, 10 Jun 2013 20:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=5TdIOHWeQMQSjudKP4/6CUg/L10in/MdwGItw6L/DLg=;
        b=Y5RHbKpIV89ygByoLzXii9n/My4v/477OwdI9SrcgpSmYLTa+VHX/rx0V0p9yGnjoc
         FP+um+7qSrESgUdO/506wYTWCfmODM64Mb4pP1xbYv03IHzR7xBSKlSuRABHZqQusJuK
         ZlduAkTFtyPIw9GntwNcIYHBlorHQEN31CjU0tGIEzXSyoMMl/eX0ttEj6p2ndNQgQEd
         kvHh8AfY4YBbwETNCUZVXUc1YvaIg3WQXoi/LMNS44F+LGbsC1Ka5H4RYhmft3QKHhMW
         G070Q78zHQcL7+R+nLM6va9Slvvxla8WV4KwIhZou5vhslThYnvVCskH4gKioqynkv3l
         9dpA==
X-Received: by 10.112.219.133 with SMTP id po5mr7649856lbc.80.1370922741639;
 Mon, 10 Jun 2013 20:52:21 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Mon, 10 Jun 2013 20:52:21 -0700 (PDT)
In-Reply-To: <CABURp0qG6AqR-y1YLB0FdX-=kniHoZBfwUs0d7gPnfDfh9Pajw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227411>

On Mon, Jun 10, 2013 at 8:09 PM, Phil Hord <phil.hord@gmail.com> wrote:
> On Mon, Jun 10, 2013 at 7:43 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> On Mon, Jun 10, 2013 at 5:55 PM, Phil Hord <phil.hord@gmail.com> wrote:
>>> On Sun, Jun 9, 2013 at 3:37 PM, Felipe Contreras
>>> <felipe.contreras@gmail.com> wrote:
>>>>
>>>> On Sun, Jun 9, 2013 at 2:24 PM, Felipe Contreras
>>>> <felipe.contreras@gmail.com> wrote:
>>>> > Same as before, but:
>>>>
>>>> Also, remove the patches from Martin von Zweigbergk, because
>>>> apparently some people have trouble understanding that they were not
>>>> part of this series.
>>>
>>> Please try not to sound disgruntled. This attitude is toxic. You have
>>> turned this change into a complaint: that "some people have trouble
>>> understanding" which shows a genuine lack of understanding and
>>> compassion on your part.  Instead you can phrase your change notes
>>> more helpfully if you make changes only when you yourself actually
>>> believe the change should be made.  If you cannot do this, perhaps you
>>> can pretend.
>>
>> That would be dishonest. Moreover, there wasn't a good reason to
>> remove these patches, I made it clear I added those patches only to
>> make sure the real patches of this series worked correctly. Also, I
>> clarified that to Thomas Rast[1], only to receive a totally
>> unconstructive comment[2].
>>
>> Why don't you ask Thomas Rast to be more constructive[2]?
>>
>> Then Johan Herland uses that as an example of a constructive
>> comment[3]. Why don't you correct Johan Herland?
>
> I do not see what their comments have to do with your attitude.

My attitude is fine. I sent a lot of patches, and I made clear that
some of them were meant only to test the rest. And I clarified that
twice.

There's nothing wrong with that.

> Aren't your own man with cogent self-will and personal responsibility?
>  Why should I also have to consider these other emails which I have
> not bothered to read yet?

Don't be that girlfriend that brings the times you haven't picked up
the towel properly when talking about something completely and totally
different.

When talking about the attitude in *this* patch series, limit yourself
to *this* patch series.

>> No, you pick the easy target: me.
>
> You seem to have mistaken me for someone else.  Moreover, you seem to
> have mistaken you for someone else.  You are the least easy target I
> know of on this list.

> Everyone else seems open to community standards.

And yet you try to correct me, who did nothing wrong. And ignore the
transgressions of the other people, whom I already demonstrated
actually *did* do something wrong. How convenient of you to not
mention my arguments *at all*.

>> I already dd more than my fair share by carrying these 36 patches
>> through several iterations, yet you ask *more* of me. Why don't you
>> ask more of the people that just hit reply on their MUA?
>>
>> Thomas' task was easy; he simply had to say "Oh, these aren't meant to
>> be applied, got it."
>>
>> [1] http://article.gmane.org/gmane.comp.version-control.git/227039
>> [2] http://article.gmane.org/gmane.comp.version-control.git/227040
>> [3] http://article.gmane.org/gmane.comp.version-control.git/227102
>
> I did not comment on their posts because they did not catch my eye.
> Rebase and cherry-pick improvements are interesting to me, so I read
> your post.  I will try not to make this mistake again.

Yes, because my patches are so obviously wrong.

If you were a truly productive member of this community, you would
ignore all the bullshit, take the patches, fix whatever is technically
wrong with them (nothing), and resend them.

But no, that would be way too productive.

-- 
Felipe Contreras

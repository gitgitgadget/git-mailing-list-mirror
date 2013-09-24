From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3] build: add default aliases
Date: Tue, 24 Sep 2013 09:35:05 -0500
Message-ID: <CAMP44s2j_ra_Tk_s-tjwwvX=T8y=bKPTaUdOQk1jD8QpUm+-zA@mail.gmail.com>
References: <1379791221-29925-1-git-send-email-felipe.contreras@gmail.com>
	<CAEBDL5WQLx4rsN+yRs62fgTBWkuAhCSWDRkoCc8M_akpSqMKvg@mail.gmail.com>
	<CAMP44s3nQv97B2=mq-mn8S41sMA43qRfr+nC7eQ=Jft=zRgTRw@mail.gmail.com>
	<CAEBDL5V1kyRwtKSM+L_E_XbJRauvdmOLc+g2acbixt0+pd6_ag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>
To: John Szakmeister <john@szakmeister.net>
X-From: git-owner@vger.kernel.org Tue Sep 24 16:35:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOThq-0002Pj-O0
	for gcvg-git-2@plane.gmane.org; Tue, 24 Sep 2013 16:35:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753860Ab3IXOfI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Sep 2013 10:35:08 -0400
Received: from mail-lb0-f177.google.com ([209.85.217.177]:44793 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752652Ab3IXOfH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Sep 2013 10:35:07 -0400
Received: by mail-lb0-f177.google.com with SMTP id w7so3874062lbi.22
        for <git@vger.kernel.org>; Tue, 24 Sep 2013 07:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=TzyA7aYimK2xXLz4YYtwUcL6JFFzIxzB8RfiYLszZ2I=;
        b=eKyPWRhYA4mweN2xfFUc6iF6ZRYh3HWSNOaTcKgRdaSmLkSkz/UCdBHmtwEHlt0P/3
         NCtq5QhXKOBr4kORbXYxax3OZAheF0DSKhT/3apDfPUjV5MUAIWKSnP7qnyJ84HGJ202
         Ydrie09L/QghN308zysFXQpbflnKRSgrjWJLq+VnR36SJnQ6bZE4+kp3GaX7uBddiaV0
         Wf/NFTrKqHpJPNHuKmC3xEC1nCPUy5nfEYsIcIQAISszi736T+t64+9EghHACmy3oaUr
         bE/B/ZfxgvVa7DG7HMax5122rHyynkN0Qy3orj5Wsjztl5nioVy/594HXtQjRSyInHG+
         7rNg==
X-Received: by 10.112.155.39 with SMTP id vt7mr6702551lbb.29.1380033305835;
 Tue, 24 Sep 2013 07:35:05 -0700 (PDT)
Received: by 10.114.91.230 with HTTP; Tue, 24 Sep 2013 07:35:05 -0700 (PDT)
In-Reply-To: <CAEBDL5V1kyRwtKSM+L_E_XbJRauvdmOLc+g2acbixt0+pd6_ag@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235303>

On Tue, Sep 24, 2013 at 6:06 AM, John Szakmeister <john@szakmeister.net> wrote:
> On Tue, Sep 24, 2013 at 6:25 AM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> On Tue, Sep 24, 2013 at 4:19 AM, John Szakmeister <john@szakmeister.net> wrote:
>>> On Sat, Sep 21, 2013 at 3:20 PM, Felipe Contreras
>>> <felipe.contreras@gmail.com> wrote:
>>>> For now simply add a few common aliases.
>>>>
>>>>   co = checkout
>>>>   ci = commit
>>>>   rb = rebase
>>>>   st = status
>>>>
>>>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>>>> ---
>>>>
>>>> I still think we should ship a default /etc/gitconfig, but the project needs to
>>>> agree it's a good change, and nobody every agrees changes are good. So this is
>>>> the minimal change that achieves the desired result.
>>>
>>> I wish you would stop attacking the project every time you send a
>>> patch--it's simply not productive and it's certainly not getting you
>>> any closer to a resolution.
>>
>> I'm not attacking the project, I'm making an objective claim, and I
>> can back it up with several instances of evidence where 99% of the
>> users would benefit from a change, yet it does not move forward.
>
> There's nothing objective about "Nobody every (sic) agrees changes are
> good".  If it were true, no changes would get in.

It is true, where by "changes" I mean "changes from common user's
point of view", actually, a tiny amount of then do sneak in, so let me
be precise: "Virtually nobody ever agrees important changes from the
common user's point of view are good".

So now that I'm being clear, do tell, name one important change in Git
from the user's point of view that happened in the last two years.

> Also, you don't know that any of those changes would benefit "99% of
> all users".  It's a guess or an estimate but it's not based on
> anything concrete.  It might be a good guess--and in this case, I
> think it is--but it's not a concrete fact.  Don't make it sound like
> it is.

Sure, it's not a concrete fact, but the actual probability most likely
follows a beta distribution with alpha=15 and beta=1. Is that more
precise for you?

>> If you don't agree my comment is accurate, that's one thing, but
>> labeling it as an attack is another.
>
> Don't turn it around.  A number of your patches and emails poke at the
> community of the Git project and you know it.  It's simply not helping
> the situation.

Show me a patch that "pokes" at the community. All my patches have
technical descriptions, and help improve Git.

> Your clearly a bright and motivated individual--which makes it all the
> more frustrating that you don't approach this differently.  I even
> agree with your motivations for Git: I'd like to see less shell and
> perl involved and to see Git run faster on Windows.  But I wish you'd
> stop with the jabs.

Don't worry, I'll stop the "jabs" (which are really objective
observations which are not particularly flattering for the project,
but true, and serious problems that need to be fixed) as soon when I
leave the project, which I'll do once it's clear my patches are going
nowhere without any valid justification, and we are right on track for
that.

>> I would admit I was wrong if an /etc/gitconfig is indeed shipped by
>> default, and agree that the Git project is indeed welcome to change,
>> but that's not going to happen.
>
> And there it is again.  Predicting the future now?  Objectively and
> accurately?  Please stop.

Yes I am. Feel free to go back to this mail and tell me I was wrong
when they do what I said they won't.

-- 
Felipe Contreras

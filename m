From: John Szakmeister <john@szakmeister.net>
Subject: Re: [PATCH v3] build: add default aliases
Date: Wed, 25 Sep 2013 09:33:59 -0400
Message-ID: <CAEBDL5X1QRLaTvxhEu4e5_NE5fEWc6fd60YJyA8wye4d4T3wpQ@mail.gmail.com>
References: <1379791221-29925-1-git-send-email-felipe.contreras@gmail.com>
	<CAEBDL5WQLx4rsN+yRs62fgTBWkuAhCSWDRkoCc8M_akpSqMKvg@mail.gmail.com>
	<CAMP44s3nQv97B2=mq-mn8S41sMA43qRfr+nC7eQ=Jft=zRgTRw@mail.gmail.com>
	<CAEBDL5V1kyRwtKSM+L_E_XbJRauvdmOLc+g2acbixt0+pd6_ag@mail.gmail.com>
	<CAMP44s2j_ra_Tk_s-tjwwvX=T8y=bKPTaUdOQk1jD8QpUm+-zA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 25 15:34:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOpEE-0007BB-Li
	for gcvg-git-2@plane.gmane.org; Wed, 25 Sep 2013 15:34:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755327Ab3IYNeC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Sep 2013 09:34:02 -0400
Received: from mail-wg0-f50.google.com ([74.125.82.50]:63381 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754563Ab3IYNeA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Sep 2013 09:34:00 -0400
Received: by mail-wg0-f50.google.com with SMTP id f12so6211735wgh.5
        for <git@vger.kernel.org>; Wed, 25 Sep 2013 06:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=OhvnxMP2QHZa2dy0DnU/ff1hEdvVJdlEMo1Zp7mM2ZY=;
        b=LV7uFvu44iBvL7HWHRFAXYzqCmb5TWpz19eq6q1xmowJf+UowSgLwS3MmuKQ5ICqOj
         Ehm04nSH28XNO+3VwNYpcIcJ4l0X+x0Dlo/+W0/tYAjTFvQ8zhuKCPLPTRxxDuOdh3MM
         Yruhu38Q9bjFsjdj+6UbM2O6q5Hzy9GBgjwGZ/wbeWRhlsXZ0TPP5YcX+w270/yqhb7C
         41uC2EyIqzTPAhEaGDyFxwjpF+rxAXXgFqWpUhyjQOcgPPVui3vGB9JRcWt3ULWtRfwQ
         7/P9TLCj/4hx3dJUJ7UGvHDuXhOTSku/XfJaYtNL5tvHGyMi3jnBm6Ni81Y+ILYoj7DN
         NpMw==
X-Received: by 10.181.12.104 with SMTP id ep8mr22725492wid.54.1380116039199;
 Wed, 25 Sep 2013 06:33:59 -0700 (PDT)
Received: by 10.180.228.42 with HTTP; Wed, 25 Sep 2013 06:33:59 -0700 (PDT)
In-Reply-To: <CAMP44s2j_ra_Tk_s-tjwwvX=T8y=bKPTaUdOQk1jD8QpUm+-zA@mail.gmail.com>
X-Google-Sender-Auth: L9oAvJ0DOF5T6j5fKasHJfLlqi0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235345>

On Tue, Sep 24, 2013 at 10:35 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Tue, Sep 24, 2013 at 6:06 AM, John Szakmeister <john@szakmeister.net> wrote:
[snip]
>> There's nothing objective about "Nobody every (sic) agrees changes are
>> good".  If it were true, no changes would get in.
>
> It is true, where by "changes" I mean "changes from common user's
> point of view", actually, a tiny amount of then do sneak in, so let me
> be precise: "Virtually nobody ever agrees important changes from the
> common user's point of view are good".
>
> So now that I'm being clear, do tell, name one important change in Git
> from the user's point of view that happened in the last two years.

Credential helpers.

>> Also, you don't know that any of those changes would benefit "99% of
>> all users".  It's a guess or an estimate but it's not based on
>> anything concrete.  It might be a good guess--and in this case, I
>> think it is--but it's not a concrete fact.  Don't make it sound like
>> it is.
>
> Sure, it's not a concrete fact, but the actual probability most likely
> follows a beta distribution with alpha=15 and beta=1. Is that more
> precise for you?

It's not about precision, it's that you don't have any actual facts to
stand on but you speak like you do.  Then when someone questions it,
you accuse them of being against fixes for the user.  I wish you'd
stop it and do something more constructive to help move things along.

>>> If you don't agree my comment is accurate, that's one thing, but
>>> labeling it as an attack is another.
>>
>> Don't turn it around.  A number of your patches and emails poke at the
>> community of the Git project and you know it.  It's simply not helping
>> the situation.
>
> Show me a patch that "pokes" at the community. All my patches have
> technical descriptions, and help improve Git.

You're filtering what I said again.  Take a look at the first message
is this thread.

I'll agree the patches themselves have been free of this, but the
cover letters--which I consider to be part of the patch--and ensuing
conversation has not.  If you need another example, look at the cover
letter for your transport helper patches.

None of this is news to you.

[snip]
>>> I would admit I was wrong if an /etc/gitconfig is indeed shipped by
>>> default, and agree that the Git project is indeed welcome to change,
>>> but that's not going to happen.
>>
>> And there it is again.  Predicting the future now?  Objectively and
>> accurately?  Please stop.
>
> Yes I am. Feel free to go back to this mail and tell me I was wrong
> when they do what I said they won't.

I have no need for that, and I'm done talking to you about any of this.

-John

From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: What's cooking in git.git (Apr 2013, #05; Mon, 15)
Date: Wed, 17 Apr 2013 13:50:50 -0500
Message-ID: <CAMP44s3pZt3QVjS7GbXqjMS4ti3p=Vs2DmFXQjsMM3rs9qURmw@mail.gmail.com>
References: <7vhaj7r116.fsf@alter.siamese.dyndns.org>
	<CAMP44s2_wiNr4RaBOEnKnZzT4CF0qKK+bp+Lyi=Nfx3Q9ggqOQ@mail.gmail.com>
	<7vip3npet0.fsf@alter.siamese.dyndns.org>
	<CAMP44s3NE3yrQoa1nZXAgy3KFXGF56Ki8icJ2z2TDigzax0nWg@mail.gmail.com>
	<8761zm4wzg.fsf@linux-k42r.v.cablecom.net>
	<CAMP44s0a2VsPBMd9Vrrhwdw=SPp2HrvDdXZ9Dmzhr9A6T+Sz7w@mail.gmail.com>
	<CABURp0qGYG4T+t36=Us328YdLzy9KjBOWot2gSOk=FgCRUCLnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thomas Rast <trast@inf.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 17 20:51:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USXRZ-0006GY-3D
	for gcvg-git-2@plane.gmane.org; Wed, 17 Apr 2013 20:50:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757537Ab3DQSux (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Apr 2013 14:50:53 -0400
Received: from mail-la0-f48.google.com ([209.85.215.48]:58143 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756067Ab3DQSuw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Apr 2013 14:50:52 -0400
Received: by mail-la0-f48.google.com with SMTP id fq13so706918lab.7
        for <git@vger.kernel.org>; Wed, 17 Apr 2013 11:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=ImyWsoiD7r7HqIAWzeXs7Gm/18tXR56ZEt4B360RVcA=;
        b=iiKjyILrjSbngDgGtcYQTlre9p0X08vppIUZMjD+/1y6uNz0GjFgtuUbwG0/gBixRn
         2R+VP28TPowWE3yuII3RbyP8Yxd6a5K2yDtudhk743X/JYqn7ADva0c9CfI6uWtA4Lml
         dk6Ccz81o71X4jmSXrI8Curu4xojh1zo6/I+/7vupWWkz0w5Vs3yoF3Rlls0zwGoV8x/
         9EywfNyajPixnGgPW9TrValloF50XFPeTjTwEOFUtpdShozPWzKP4S7nxt5sfjjq1qm2
         9DVZl9vPJnbEBV8m7ifm2AqBh3pON5ppZq5iUwq0y9BASFAOx9/8GQ9Qhna2tjkSYx+V
         BOBw==
X-Received: by 10.112.135.3 with SMTP id po3mr1105834lbb.103.1366224650543;
 Wed, 17 Apr 2013 11:50:50 -0700 (PDT)
Received: by 10.114.59.210 with HTTP; Wed, 17 Apr 2013 11:50:50 -0700 (PDT)
In-Reply-To: <CABURp0qGYG4T+t36=Us328YdLzy9KjBOWot2gSOk=FgCRUCLnQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221563>

On Tue, Apr 16, 2013 at 5:45 PM, Phil Hord <phil.hord@gmail.com> wrote:
> On Tue, Apr 16, 2013 at 3:04 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> On Tue, Apr 16, 2013 at 4:59 AM, Thomas Rast <trast@inf.ethz.ch> wrote:
>>> A cursory look^W^Wreview of the messages in fc/remote-hg:
>>
>> [skipping irrelevant comments]
>>
>> I'm sorry, did you actually hit an issue that required to look at the
>> commit message to understand where the issue came from? No? Then I
>> won't bother with hypotheticals.
>>
>> If you want to waste your time, by all means, rewrite all my commit
>> messages with essays that nobody will ever read. I'm not going to do
>> that for some hypothetical case that will never happen. I'm not going
>> to waste my time.
>
> This is not a hypothetical.  Almost every time I bisect a regression
> in git.git, I find the commit message tells me exactly why the commit
> did what it did and what the expected result was.  I find this to be
> amazingly useful.  Do I need to show you real instances of that
> happening? No.  I promise it did, though.

Yes please. Show me one of the instances where you hit a bisect with
any of the remote-hg commits mentioned above by Thomas Rast.

> Of course, 99% of the commit messages may never be useful to me or
> anyone else.  But we do not eschew them altogether.  The 1% I have to
> rely on are nearly always helpful and clear, and that is the part I
> care about.

And how do you know this will be part of the 1%? You don't. How many
times have you tracked regressions in transport helper's import/export
functionality? How many times in remote-hg? How many times has
*anybody* done so?

> If you will not waste your time to write a decent commit message, why
> do you waste our time asking us to review and accept ill-defined
> patches?

Because it *fixes a problem*. And a commit essay doesn't fix any,
because nobody will ever go back in history and wonder, hey, what is
up with this commit. If somebody does, then I will accept that commit
essays are always a must. But it won't happen.

> Here, of course, I use the royal "us" as I do not review
> your patches.  I do not know why that is; I suppose you patch things
> outside of my interests, but it may also be that your patches are
> simply incomprehensible by design.

Yeah, but that's the thing, if you don't understand the code the
patches are changing, then how can you know the commit message is
sufficient to figure things out when a regression is found? You don't.
You can't.

Let's face the truth, you are advocating for stopping progress on the
name that something might happen sometime in the feature, although
most likely won't. When in reality, it just won't.

And you are not saying "it would be nice to have full commit essay",
you are saying: "without a commit essay this patch should NOT be
merged", even more "without a commit essay this patch should NOT be
considered a cooking patch".

I think the commit message is fine, you don't. So YOU go ahead and
write the proper one. If you don't, all you are doing is being an
impediment to progress.

Cheers.

-- 
Felipe Contreras

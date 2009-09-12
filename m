From: John Tapsell <johnflux@gmail.com>
Subject: Re: obnoxious CLI complaints
Date: Sat, 12 Sep 2009 21:32:09 +0300
Message-ID: <43d8ce650909121132n76cda485ycd53a0497e397960@mail.gmail.com>
References: <ef38762f0909091427m5b8f3am72c88fd4dbfebc59@mail.gmail.com>
	 <m3fxavvl5k.fsf@localhost.localdomain>
	 <ef38762f0909091709t7336d86dkd2f175e5b3a6a3f@mail.gmail.com>
	 <20090912103156.GA30385@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Brendan Miller <catphive@catphive.net>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 12 20:32:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmXOc-000106-SO
	for gcvg-git-2@lo.gmane.org; Sat, 12 Sep 2009 20:32:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754791AbZILScI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Sep 2009 14:32:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754722AbZILScH
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Sep 2009 14:32:07 -0400
Received: from mail-yx0-f176.google.com ([209.85.210.176]:59264 "EHLO
	mail-yx0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754691AbZILScG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Sep 2009 14:32:06 -0400
Received: by yxe6 with SMTP id 6so2797430yxe.22
        for <git@vger.kernel.org>; Sat, 12 Sep 2009 11:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=IazDugsvolQtKmAxNJh+apo5nxKTzKt4UgJM5avGiq0=;
        b=V0DcHoXqeoOGNb3TJInpG6EOQH3NnZqPhWCdcFDva9PxtmJFymZpBOpxdkhWyjbgMR
         wUYJy7BUuD/vBDVxD5medZtKiAMpkn+SL9bwvQcVNwuhSuQMoLUOXCwJCIfVQ/nUvC5J
         d9njwXkEyB3g6v2sjx/36tkS1rTcFs67lR9Z8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=OxfmS0oc6ETlKvl44FqL84XbF7Eo+wqaTeYJ9exaFBRsCoP/+h617lAOH+e6WzNB3V
         OwLkBFqMe9rUOhZYOqFFzksU2Z1Wg4R8EyWYRKxmCU9T13WUWOUNJSjbaKcSHcG/XU1k
         WvnFnHNwm2riryZ+dSwUaxwsE0ZCueL7KJ7D0=
Received: by 10.150.88.2 with SMTP id l2mr7042753ybb.260.1252780329496; Sat, 
	12 Sep 2009 11:32:09 -0700 (PDT)
In-Reply-To: <20090912103156.GA30385@dpotapov.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128278>

2009/9/12 Dmitry Potapov <dpotapov@gmail.com>:
> On Wed, Sep 09, 2009 at 05:09:31PM -0700, Brendan Miller wrote:
>> On Wed, Sep 9, 2009 at 2:54 PM, Jakub Narebski <jnareb@gmail.com> wrote:
>> > Brendan Miller <catphive@catphive.net> writes:
>> >>
>> >> This is what I want to do 90% of the time, so it should just have the
>> >> proper defaults, and not make me look at the man page every time I
>> >> want to use it.
>> >
>> > You learn those idioms.
>>
>> I guess. Is that a good thing?
>
> In general, yes, because most of them exist for a good reason.
>
>> Is the goal of interface design to make
>> it difficult so I need to learn a lot of things, or easy so I can
>> remain blissfully ignorant but still do what I want?
>
> Neither. You cannot get what unless you have specified what you want,
> and for that you have to learn how to say that. Having good defaults is
> very important, but the problem with choosing them is that people have
> different preferences about them. For instance, you wanted the default
> prefix for git-archive to be $myproject. For me, a good default would be
> either $tag_name, or $myproject-$tag_name, or empty (as it is now!). So,
> what you propose is *never* a good default for me. Moreover, changing
> any default will cause a lot of pain for other people who use Git now.
> Besides, writing something like --prefix='' is very ugly. So, the
> current default makes perfect sense.

Ah, great logic.  You can't find a default that will suit everyone,
therefore don't bother.

>> Yeah, I've been reading them. I'm saying that the docs are a crutch.
>> RTFM is the problem not the solution. It makes the user do more work
>> to avoid fixing usability issues.
>
> A usability issue exists when a person knows how to do that, but it is
> inconvenient or error-prone; or when a learning curve is too steep.
> But when someone cannot use, let's say, a compiler, because he or she
> refuses to read to learn the language, it is not a usability issue.

It's a usability issue when it doesn't just do the right thing in the
majority of cases and lets you specify what you want it to do in the
rest of the cases.

John

From: Hilco Wijbenga <hilco.wijbenga@gmail.com>
Subject: Re: Your branch and 'origin/master' have diverged
Date: Tue, 14 Aug 2012 10:07:07 -0700
Message-ID: <CAE1pOi0UJYhFXYi_GQyK7EL+wifu1g-R34wgqHCcKpdhirytuw@mail.gmail.com>
References: <CAE1pOi1WTbMSK8dOus6pFCa2C9vGA8QNE3+8w0LFmGkvcfq5fg@mail.gmail.com>
 <CAJsNXTmUB-isPVHPcWupL-gAag--DzhdkazXj0Z+aEbv+_w7Rg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Users <git@vger.kernel.org>
To: PJ Weisberg <pj@irregularexpressions.net>
X-From: git-owner@vger.kernel.org Tue Aug 14 19:07:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1Kad-0003Ok-W2
	for gcvg-git-2@plane.gmane.org; Tue, 14 Aug 2012 19:07:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755616Ab2HNRHb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Aug 2012 13:07:31 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:39154 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753061Ab2HNRHa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2012 13:07:30 -0400
Received: by bkwj10 with SMTP id j10so222787bkw.19
        for <git@vger.kernel.org>; Tue, 14 Aug 2012 10:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=0+CuyXYFhoK4UwGJ+jP7hO0hbh05u5/4eJ59yK2+0mQ=;
        b=QFyS7AY7HSLltTIr4kQDw8z4AxEb5aSAKly/zFzOn/So/Pao00yn4TGGr5I2uzrWn5
         WEh8hQbWDs5+/U/jpJM2M79XuMxJZWLKM3MI8WQA8R2PexXPfGmJtfKpvRkwoX8AZ5ki
         EfwwIM2RLm7LkKL1DNMZ50FLOTr58KJFZVP01/gnKfXFvLsJSIkK2pTQ+u3e/Uog5yth
         p60Akbf4MRdFM/PwB8kQc0LxyXO65PD+BVQQ5j3jjPEbIjfXMS1b7iLyGT4j3N9EJJpk
         pEX+G+4x6P0l/+KOAWfD+XMv83H6ObgdVpV1ZNKl0q+/KBcOp5ZTIAmh2JpsCo0y7bc1
         qfNw==
Received: by 10.204.128.68 with SMTP id j4mr6489858bks.122.1344964048810; Tue,
 14 Aug 2012 10:07:28 -0700 (PDT)
Received: by 10.204.132.72 with HTTP; Tue, 14 Aug 2012 10:07:07 -0700 (PDT)
In-Reply-To: <CAJsNXTmUB-isPVHPcWupL-gAag--DzhdkazXj0Z+aEbv+_w7Rg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203415>

On 14 August 2012 09:02, PJ Weisberg <pj@irregularexpressions.net> wrote:
> On Mon, Aug 13, 2012 at 12:58 PM, Hilco Wijbenga
> <hilco.wijbenga@gmail.com> wrote:
>> Hi all,
>>
>> A colleague of mine (after a relatively long absence) noticed the
>> following when running "git status":
>>
>> # On branch master
>> # Your branch and 'origin/master' have diverged,
>> # and have 250 and 19 different commit(s) each, respectively.
>> #
>> nothing to commit (working directory clean)
>>
>> He asked me what to do and I told him to do what has always worked for
>> me in the past when something like this happened: gitk, "reset master
>> branch to here" (to a commit before the divergence and using --hard),
>> git pull origin master. Problem solved.
>>
>> Well, not this one. This one is persistent. :-) I am at a loss what to
>> do. "master" and "origin/master" do *not* point at the same commit.
>> Even after the "git reset --hard ..." and "git pull". Running my
>> silver bullet solution gets us in the same situation every time.
>
> I assume that the commit you reset to wasn't actually before the
> divergence, then.

It was according to gitk.

> It sounds like what you're trying to do is just
> long-hand for 'git reset --hard origin/master'.  As mentioned before,
> that *does* assume that you want to throw out everything you've
> committed locally.  If that's *not* the case, try 'git rebase
> origin/master' or 'git pull --rebase'.  And then go slap the person
> who rewrote the history of origin/master.

I'm not convinced anything is wrong with origin/master. This
particular colleague is the only one with a problem. And not for the
first time. :-)

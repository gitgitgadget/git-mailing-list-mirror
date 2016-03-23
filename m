From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: error: src refspec refs/heads/master matches more than one.
Date: Wed, 23 Mar 2016 18:17:05 +0700
Message-ID: <CACsJy8BR-f0qLV9VC1YPMhdBu3hFMZqqrNq-6RPBmTu1iQ+7hg@mail.gmail.com>
References: <20140214113136.GA17817@raven.inka.de> <87a9dt981o.fsf@igel.home>
 <CACsJy8BevKQaRLYMMv7bTjf_ZAOnkrimws519OyhGZz6_Vr_-A@mail.gmail.com>
 <xmqqy51dirjs.fsf@gitster.dls.corp.google.com> <20140215085355.GA15461@lanh> <xmqqha7wfdld.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	Josef Wolf <jw@raven.inka.de>,
	Git Mailing List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	John Keeping <john@keeping.me.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 23 12:17:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aignF-0004de-TI
	for gcvg-git-2@plane.gmane.org; Wed, 23 Mar 2016 12:17:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754221AbcCWLRi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2016 07:17:38 -0400
Received: from mail-lf0-f42.google.com ([209.85.215.42]:33954 "EHLO
	mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752573AbcCWLRg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2016 07:17:36 -0400
Received: by mail-lf0-f42.google.com with SMTP id c62so5403878lfc.1
        for <git@vger.kernel.org>; Wed, 23 Mar 2016 04:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=nekrLf9Kdp9AlPsfB5E99JM6VSMSNxnNViT9L2rGgEI=;
        b=PghYRX3uFuXQvXbNJVeoCyY+0/+NlR3K21KYhq6ZckBUsFHyvWI400N0qCjcRh6aWx
         0OPeQnLtmsGOKZWaprlm89TGe8hDkQt5jV8izLAdLWhyHO5QMrhrVcvZ9Iyg1aA6e+kS
         kAi+o5Wsbeo0SkcqwsPKZQFAFyW17BMRBNjgHrGBc8J9d0SgDZ7vMDhz/4Z8nUAyjUWX
         OirV/JDbxOj1u9oNABnDfX+GtznQkOCSPP6DZTZVj7+EIpbAa2ssvqx4gQ5FJ/fDE1Bq
         BLP3mnFGv1oks3q+eL7SzT3q4DC3Kyf+a+kqTXCGzL8wxLtHBjKgZGSAq0NIyMomD7oL
         fbLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=nekrLf9Kdp9AlPsfB5E99JM6VSMSNxnNViT9L2rGgEI=;
        b=hOK4zEocSFXdna4EubOnWIyse9t+/379T+NFCMG8ZcxnB5lA5/cK7i710DuhSDY80r
         zc1HHd+XPSztPD7oa2bv0ji62kngVEB2DD58fj8VNVU1V3Iorb1rejFFOnX6UyuU1Q7f
         2MB3PG5dQgo+WTb1L07YUFzQmZe0g2tutVz/hyGZ2mbFme5pz2I73cjlWGjTk7S3fY9c
         954BKNhCSmFZFUCAFEIoaOzPgnMf6wkdBcx0931zHIWccn8qzCDcjRZYOKpu2Px7cnTP
         NDc+dt8xowHebb0STqxo6tYOkoyCvUEiPFjiG5AE1sJZ3dw1rKCaApOJ1smJm2scU1+8
         I9Vw==
X-Gm-Message-State: AD7BkJKd3oH+HRPyMYpioQHWM63msc7R9OloFcY710zThLYwatUkxd1q3/rsHRF1qHfRLi7hSZpopsvujthuhg==
X-Received: by 10.25.211.75 with SMTP id k72mr931716lfg.45.1458731854857; Wed,
 23 Mar 2016 04:17:34 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Wed, 23 Mar 2016 04:17:05 -0700 (PDT)
In-Reply-To: <xmqqha7wfdld.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289649>

I'm digging this topic up from the ground because if it was fixed, I
would not have spent many confusing (and a little bit panicking)
minutes wondering how the hell I managed to push to "origin/master"
which I did not have push access to begin with, which turned out to be
the local branch, refs/heads/origin/master, not the remote branch
refs/remotes/origin/master.

Summary until this point in the old thread, you can accidentally do
"git branch refs/heads/next", which happily creates
refs/heads/refs/heads/next. If you also have refs/heads/next, things
can get confusing for commands that accepts both branch and non-branch
refs. There were some more discussion about unambiguously specifying
full ref in git-branch but it was getting nowhere.

On Wed, Feb 19, 2014 at 2:03 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> Prevent is a strong word. I meant we only do it if they force
>> it. Something like this..
>>
>> -- 8< --
>> diff --git a/branch.c b/branch.c
>> index 723a36b..3f0540f 100644
>> --- a/branch.c
>> +++ b/branch.c
>> @@ -251,6 +251,11 @@ void create_branch(const char *head,
>>                       forcing = 1;
>>       }
>>
>> +     if (!force && dwim_ref(name, strlen(name), sha1, &real_ref))
>> +             die(_("creating ref refs/heads/%s makes %s ambiguous.\n"
>> +                   "Use -f to create it anyway."),
>> +                 name, name);
>
> Does this check still allow you to create a branch "refs/heads/next"
> and then later create a branch "next"?  The latter will introduce an
> ambiguity without any prevention, even though the prevention would
> trigger if the order in which these two branches are created is
> swapped--- the end result has ambiguity but the safety covers only
> one avenue to the confusing situation.

It could be fixed by checking all existing refs if any of them becomes
ambiguous after refs/heads/next comes to life. We can filter and check
only branch that shares the same base name (or starts with "refs/",
"heads/", "tags/" or "remotes/"), so it's still expensive but not as
much as checking all refs.

Even with covering only one avenue, it would definitely help my case
(refs/remotes/origin/master exists and refs/heads/origin/master asked
to be created).

Also in my case, if refs/heads/origin/master already exists then I
think I should reject creating refs/remotes/origin/master, or warn
loudly.

Sounds promising enough to start making patches?

> And the only way I can think of to avoid that kind of confusion is
> to forbid creation of a subset of possible names by reserving a set
> of known (but arbitrary) prefixes---which I am not sure is a good
> way to go.  At least not yet.
-- 
Duy

From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: first parent, commit graph layout, and pull merge direction
Date: Thu, 23 May 2013 18:53:36 -0500
Message-ID: <CAMP44s1D06ggmTjXBEL0puFLqYDShhy6HV0S+oj0AwDGz-sUqA@mail.gmail.com>
References: <20130522115042.GA20649@inner.h.apk.li>
	<7v4ndukhx0.fsf@alter.siamese.dyndns.org>
	<20130523090657.GB23933@inner.h.apk.li>
	<CAEBDL5WqYPYnU=YoCa2gMzcJCxeNbFmFgfWnHh=+HuouXLLsxg@mail.gmail.com>
	<20130523102959.GP9448@inner.h.apk.li>
	<20130523110839.GT27005@serenity.lan>
	<7vd2shheic.fsf@alter.siamese.dyndns.org>
	<20130523164114.GV27005@serenity.lan>
	<7vbo81e7gs.fsf@alter.siamese.dyndns.org>
	<20130523215557.GX27005@serenity.lan>
	<7vli75cpom.fsf@alter.siamese.dyndns.org>
	<CAMP44s3-3gpAAyp-WfDjHxJiotO68GUbb5tHw9Qo35yCTGFNqA@mail.gmail.com>
	<7v8v35cnp0.fsf@alter.siamese.dyndns.org>
	<CAMP44s1N=xy2B-YkCLC67pX_EVqAziGWyN1qkrs0Sq=o2jL6Sw@mail.gmail.com>
	<7vzjvlb7mu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: John Keeping <john@keeping.me.uk>, Andreas Krey <a.krey@gmx.de>,
	John Szakmeister <john@szakmeister.net>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 24 01:53:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UffKO-0006QC-EX
	for gcvg-git-2@plane.gmane.org; Fri, 24 May 2013 01:53:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757145Ab3EWXxj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 May 2013 19:53:39 -0400
Received: from mail-lb0-f173.google.com ([209.85.217.173]:52612 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756890Ab3EWXxi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 May 2013 19:53:38 -0400
Received: by mail-lb0-f173.google.com with SMTP id t10so4022240lbi.4
        for <git@vger.kernel.org>; Thu, 23 May 2013 16:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=vcn39bzQK8ju+1aAnFd25NwrPqrOgqzs9QnnAS+64kw=;
        b=scNCvdDmXD+HmtGyUvH511f5qNn39pHCFevG7K8yCnBtmofXauRihwIkODJCjJjw2r
         uvMjRMpORGYS5L9UjVB3pGV/yJ3co2ORGFC3f5QwJyP5iMj1TaYKlbS/3oYO8C4yVp99
         N1nZssVdL15wEIs9sYMA8V4UUKrLgz3BsqVY3py8yVZvNyOpj92wge1Ocl1M0cyunHax
         zKyYzVNC7cml1pLx72wSiQKGSsG0DE202tlZDxzZe1aXvGkVkTbyqO9+jbpg0r3G6F/u
         bc0nmfCf/fHpRLfKeFEkC4nSPs/1uf1pa5wqoUT1L7Bop+Yx/TP7pyA5w9evj9XWwrYT
         ywrA==
X-Received: by 10.112.167.2 with SMTP id zk2mr7385460lbb.83.1369353216981;
 Thu, 23 May 2013 16:53:36 -0700 (PDT)
Received: by 10.114.174.170 with HTTP; Thu, 23 May 2013 16:53:36 -0700 (PDT)
In-Reply-To: <7vzjvlb7mu.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225321>

On Thu, May 23, 2013 at 6:26 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>>>>> Unless your primary user base is those who use Git as a deployment
>>>>> tool to always follow along the tip of some external repository
>>>>> without doing anything on your own on the branch you run your "git
>>>>> pull" on, defaulting it to --ff-only does not make much sense to me.
>>>>
>>>> A lot of people do stuff, but the rebase it.
>>>
>>> If I am parsing the above properly, I think that is only saying that
>>> "pull --rebase" makes sense for people who do real work, which I am
>>> not disagreeing.
>>
>> You claimed that 'git pull' (--ff-only) only makes sense if the
>> primary user-base doesn't do any work on it, but that's not true; they
>> can do a 'git rebase' after such pull (or a merge).
>
> Either you misread what I wrote or I was unclear.  I really meant
> "anything on your own *ON* THE BRANCH YOU RUN your "git pull" on".
> With
>
>         git checkout frotz ; git pull --ff-only
>
> you do not do anything "on frotz" other than following along.  You
> can of course commit, rebase and all others on other branches like
> xyzzy and push them out directly.  But you cannot even do this once
>
>         git checkout frotz; git merge xyzzy
>
> if you expect the next "git checkout frotz; git pull --ff-only" will
> keep working usefuly.

Unless you rebase. We could of course have a
'branch.<name>.allow_merge' configuration that gets automatically
turned on the first time a 'git merge' is executed, but I feel that
creates more inconsistency.

>> We don't have to assume our primary user-base wants to do full fledged
>> merges, in fact, such assumption would be wrong.
>
> I think we are in agreement on that point already.
>
> An assumption that people who do merges are somehow more well versed
> in Git and are more capable than others to configure their
> repository or they will not be annoyed if you asked them a single
> configuration change is also wrong, though.

s/people who do merges/people who should do merges/

And no, it's not wrong. People who do merges should know what they are doing.

The alternatives are these:

a) you annoy the vast majority of the user-base by making 'git pull' a
dangerous operation that should be avoided, and replaced with 'git
fetch'+'git rebase'.

b) you annoy a minority of the user-base by making 'git pull' not do
the merge the expected, so they have to do +'git merge' (which is
already less of a change than a)), or configure the default (which
they most likely are able to do, if they did intent to do a merge).

b) is clearly superior.

-- 
Felipe Contreras

From: Stefan Beller <sbeller@google.com>
Subject: Re: Starting on a microproject for GSoC
Date: Wed, 27 Jan 2016 17:18:39 -0800
Message-ID: <CAGZ79kbKe8C6iDtRNXgNU4-8EAvgE4RvxVvi-Xzg5Tf++m7z3Q@mail.gmail.com>
References: <56A96380.3020308@moritzneeb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Moritz Neeb <lists@moritzneeb.de>
X-From: git-owner@vger.kernel.org Thu Jan 28 02:18:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aObET-00017S-7m
	for gcvg-git-2@plane.gmane.org; Thu, 28 Jan 2016 02:18:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966368AbcA1BSm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2016 20:18:42 -0500
Received: from mail-ig0-f172.google.com ([209.85.213.172]:35262 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965598AbcA1BSk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2016 20:18:40 -0500
Received: by mail-ig0-f172.google.com with SMTP id t15so2550582igr.0
        for <git@vger.kernel.org>; Wed, 27 Jan 2016 17:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=WNwlfPvTGjWN99U1YeOBgUsTYTn7kQWnJ5xZdLFO7pM=;
        b=TjHEj4d2vcud//lCxqB1/u/qGhvBVo05fz3QWWZ8dnMsWc2AmX8ky4txaEXXjwHooh
         GhNVX79xkqqrBaYPaQaoY1CnD+X6Hpc6crlQkXsWQeG9x2tTBF5gYKG0zvVvJbRe72Lb
         RYmkMnLRwFgt+VS6nJny1MX8v9uCkwFZqJd8DjiVDgB9ZUHZr46LK9vg73FkuOJ4WLNE
         n9AkCRs4mWd0KYO/HCJ0togunUMSXpOjYHGTGO4zEvvhylfMojQ29aRMkNMveobjMsSc
         7gg3Z+/B5CEtXPXVsGmPfZVOh7IzZJ5k7bJKVWYS+W5ysEw9oGH/u7rL6qRnKfrcN4lw
         Ia7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=WNwlfPvTGjWN99U1YeOBgUsTYTn7kQWnJ5xZdLFO7pM=;
        b=QfOGPbzQluUHEqvgUzdL3ELLSg49weu9C2UutWfbbppJdYYn81PvrBmY5jwB9xCcY3
         LT9GOeo5I0zzAuZ0RBYH+nW2ifRZUq9hOBG/rj4gNoWBX+eTjbXjznlfx+O3tlklCnH8
         f6SLh8SXCl/3/YHZsvuYcks2mOqbhfcm1nSQIPLGoQHhV+/0QDkHYk0BXbOxJJhOV99R
         Mvr0KoQp1/TZZMCHfi1HbolfPDlPT4R0BcTQS4spjf5EUj/HwZFr8d5mhnIddms44VpL
         iLlaLb5SsErpqJ8SZHHRNg61vXJF0Ii82/kqYMufZ9eoZY+ZoMq+UqIi+bz9Bbil1FuH
         IZ1A==
X-Gm-Message-State: AG10YOS02U6EXbcFZ1e1gTEvFFdl5Kz5MxIJdhd313uqipoIZQYmzs/ZgMfTuqb0Y7cuahhwo3KMAAWMsIk0PREA
X-Received: by 10.50.102.40 with SMTP id fl8mr215676igb.85.1453943919289; Wed,
 27 Jan 2016 17:18:39 -0800 (PST)
Received: by 10.107.8.74 with HTTP; Wed, 27 Jan 2016 17:18:39 -0800 (PST)
In-Reply-To: <56A96380.3020308@moritzneeb.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284965>

On Wed, Jan 27, 2016 at 4:40 PM, Moritz Neeb <lists@moritzneeb.de> wrote:
> Hi git developers,
>
> the next Google Summer of Code is not too far away. I expect git to
> apply for it and hopefully have some student spots which in turn I plan
> to apply. It was recommended elsewhere and on this list as well, that it
> is beneficial to engage with the community early, that's why I am
> writing to you already now, before all this formal stuff has begun.
>
> Before I may introduce myself: I'm a Computer Science student in
> Germany, coming towards the end of my Masters. I am an enthusiastic git
> user that's why I'd like to give something back.

Giving back is a noble thing. To have most fun at it, you need to ask yourself:
What is the most obnoxious part of Git that you personally use? What was
the latest problem you had, which you'd want to fix? If you identified
that, is that the right size to fix it? (Usually it is way bigger than thought,
but you can ask around if there are approaches for solving that problem ;)

> This would be my first
> time to actually contribute to a FOSS project and I am quite excited
> (also a bit frightened ;)).

Each FLOSS project is run differently. So in case your fright
was the right instinct, go for some other project, it will be totally different.

>
> As the list of available microprojects 2016 is still to be created, I
> might need your help in finding a project to work on. I started to dig
> through the archives along items of the list of 2015 [0] and so far
> found out the following:

Some smaller starter projects may be found at
http://git-blame.blogspot.com/p/leftover-bits.html
The size and difficulty of these projects may vary
a bit more than the micro projects for GSoC though.

>
> The first task, to make "git -C '' cmd" not to barf seems to be solved.
> I tried it with "git -C '' status" at least. I could not find the
> related patch, maybe it did use other keywords. I would be interested.
>
> The second task, to allow "-" as a short-hand for "@{-1}" in more places
> seems to be still open for reset, although someone almost finished it
> (cf. $gmane/265417). I suppose just fixing/revising this would be kind
> of a too low hanging fruit? More interesting (also because I am a bit
> earlier) might be to unify everything, as suggested by Junio in
> $gmane/265260. Or implementing it for another branch command, e.g. rebase.
>
> The other tasks I did not yet dig into.
>
> If all of that is considered as not relevant, I might just go for a
> newer idea, like converting strbuf_getline_lf() callers to
> strbuf_getline(), as suggested in $gmane/284104.
>
> Any thoughts?
>
> A question regarding the process of "taking a task (or bug)" in general:
> Is it solely organized through the mailing list?

Yes, I'd say 95% of the discussion is done on the mailing list.
(The remaining 5% is done on conferences,
or privately for security related stuff I'd assume)

> Suppose I start to work
> on something, should I announce it to not risk work duplication?

[In the context of fighting procrastination,] I recently read that announcing
that you are going to work on $FOO is not necessarily helpful
for actually doing it. Chances are lower that you actually finish a
thing which you announced.

However feel free to announce what you work on. Usually people don't.

> Does it
> happen often that more people accidentally work on the same task?

It happens rarely for larger goals. For the GSoc micro projects however
some students did the same thing with slight differences. (2015 we only
had 2 spots to fill but a few more applicants (3-5?), but seeing
how students approached the same problem helped on deciding whom
to mentor. (Given different problems it would have been harder.)

>
> Best,
> Moritz
>
> [0] http://git.github.io/SoC-2015-Microprojects.html

I just realized there are some micro projects on the 2014 page
as well which haven't been solved yet. (maybe, they are not
striked through)

Thanks,
Stefan

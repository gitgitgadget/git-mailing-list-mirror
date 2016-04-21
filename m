From: Stefan Beller <sbeller@google.com>
Subject: Re: history damage in linux.git
Date: Thu, 21 Apr 2016 10:44:50 -0700
Message-ID: <CAGZ79kY9cpT7FN673P1u78XUwmqd0S4trAe5mauC1bdjrEsq9Q@mail.gmail.com>
References: <20160421113004.GA3140@aepfle.de>
	<87lh473xic.fsf@linux-m68k.org>
	<CA+55aFx8hPKKcuwe-HHoO7LHVYLmJ6khndd-OtQotMs3EJzZ0w@mail.gmail.com>
	<xmqqzismsxsu.fsf@gitster.mtv.corp.google.com>
	<20160421170815.GA10783@sigill.intra.peff.net>
	<CA+55aFyadCxX_Ws5fUC0QXwYYyaAjC5TC=y+tVA+YUHX1o+-iQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Olaf Hering <olaf@aepfle.de>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Apr 21 19:45:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atIez-0006Nh-RS
	for gcvg-git-2@plane.gmane.org; Thu, 21 Apr 2016 19:45:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753315AbcDURox (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Apr 2016 13:44:53 -0400
Received: from mail-io0-f181.google.com ([209.85.223.181]:33617 "EHLO
	mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751720AbcDURov (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2016 13:44:51 -0400
Received: by mail-io0-f181.google.com with SMTP id f89so73792199ioi.0
        for <git@vger.kernel.org>; Thu, 21 Apr 2016 10:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=t7N0sHCcRlQfIJvupZ7jZL/IOVOJFYqPpjAcCneBwWE=;
        b=hpTh06aRObPQCA+KERuF7g3GZsZ+GREt1hQOB6P4cGrGbBvVmSr0w4BF1Hf4PsJKn5
         0azKh1wFI1lVqlaFfDYhnUjt21B63u78SYj0AJUgIfCOn5ORXFokDyNXtSk3HF89rYRU
         ucyAdVIJsE0MqSgX0pczofjnyKYpUz1vWgEP6/XDPXqn3k0Zr60LhE6bh18WEesYlDX5
         2VDKSkhidW1ahool3K5Fpc/orMml54SomRRXCN4Agoc42Uz3VMyOn4CYvJmcbgVRBdWW
         XDnMnxBq8DitU8HqyByC9/nkilZvNG064KKexR8xaecQa2Otko+gufNDM7Um4VlybbqH
         FFiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=t7N0sHCcRlQfIJvupZ7jZL/IOVOJFYqPpjAcCneBwWE=;
        b=iYMQNJjAQfjTJIpREyggbJMVoMwynjQ08PwlXK5dq4yrDW+gmnqovndft6tkWsFmyA
         kkZao7/DKXDvaQ0Zi51nj0LLfhtLmFLD9NPwURsKPQN2gxSjLjmliE5iApesscdH/+Uj
         EgQ/kpLOZzf+6ajH/tGxkQ3xtRDzepAEkQItakAP8xs3a9Pw8rHEQlAl3uIRiquFEPbu
         XfCjaTMAXe/JEj5KLLP2psPUAUrIsiSPY13MrVfly+LxGXVTAX95lNjj5PjZVQRq7c0l
         o6eVvJgeHB+w1w06fyHf0XRGAq8jxWBZ1AGfL7073S1BwzPfE5D01I95yGlkl7HV2fK8
         CUlg==
X-Gm-Message-State: AOPr4FXMMYoODjIhsVUv0zudvS2hmcPEsxavOTocSXKkO3EsUIIgKen82kjn9599MEeHGtNZhJJqdauedg83+gEw
X-Received: by 10.107.53.200 with SMTP id k69mr10922029ioo.174.1461260690326;
 Thu, 21 Apr 2016 10:44:50 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Thu, 21 Apr 2016 10:44:50 -0700 (PDT)
In-Reply-To: <CA+55aFyadCxX_Ws5fUC0QXwYYyaAjC5TC=y+tVA+YUHX1o+-iQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292134>

On Thu, Apr 21, 2016 at 10:23 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Thu, Apr 21, 2016 at 10:08 AM, Jeff King <peff@peff.net> wrote:
>>
>> Right, because it makes the names longer. We give the second-parent
>> traversal a heuristic cost. If we drop that cost to "1", like:
>
> So I dropped it to 500 (removed the two last digits), and it gave a
> reasonable answer. With 1000, it gave the same "based on 4.6" answer
> as the current 65536 value does.
>
>> which is technically true, but kind of painful to read. It may be that a
>> reasonable weight is somewhere between "1" and "65535", though.
>
> Based on my tests, the "right" number is somewhere in the 500-1000
> range for this particular case. But it's still a completely made up
> number.
>
>> However, I think the more fundamental confusion with git-describe is
>> that people expect the shortest distance to be the "first" tag that
>> contained the commit, and that is clearly not true in a branchy history.
>
> Yeah.
>
> And I don't think people care *too* much, because I'm sure this has
> happened before, it's just that before when it happened it wasn't
> quite _so_ far off the expected path..
>
>> I actually think most people would be happy with an algorithm more like:
>>
>>   1. Find the "oldest" tag (either by timestamp, or by version-sorting
>>      the tags) that contains the commit in question.
>
> Yes, we might want to base the "distance" at least partly on the age
> of the base commits.
>
>>   2. Find the "simplest" path from that tag to the commit, where we
>>      are striving mostly for shortness of explanation, not of path (so
>>      "~500" is way better than "~20^2~30^2~14", even though the latter
>>      is technically a shorter path).
>
> Well, so the three different paths I've seen are:
>
>  - standard git (65536), and 1000:
>    aed06b9 tags/v4.6-rc1~9^2~792
>
>  - non-first-parent cost: 500:
>    aed06b9 tags/v3.13-rc7~9^2~14^2~42
>
>  - non-first parent cost: 1:
>    aed06b9 tags/v3.13~5^2~4^2~2^2~1^2~42
>
> so there clearly are multiple valid answers.
>
> I would actually claim that the middle one is the best one - but I
> claim that based on your algorithm case #1. The last one may be the
> shortest actual path, but it's a shorter path to a newer tag that is a
> superset of the older tag, so the middle one is actually not just
> better based on age, but is a better choice based on "minimal actual
> history".
>
>                Linus

Combining Junios and Linus idea:

* We want to have the minimal history, i.e. that tag with the fewest
cummulative parent commits. (i.e. v3.13-rc7 is better than v3.13
because `git log --oneline v3.13-rc7 |wc -l` (414317) is smaller tha
`git log --oneline v3.13 |wc -l` (414530).
The difference is 213.

tags/v3.13-rc7~9^2~14^2~42 has 9 + 14 + 42 additional steps (65)

tags/v3.13~5^2~4^2~2^2~1^2~42 has 5 + 4 + 2 + 1 +42 steps (54)

tags/v3.13~5^2~4^2~2^2~1^2~42 has 9 less steps, but its base tag
has a higher weight by 213.

v4.6-rc1 has even more weight (588477).

So I guess what I propose is to take the weight of a tag into account
via `git log --oneline <tag> |wc -l` as that gives the tag which encloses
least history?

We also do not want to have "a lot of side traversals", so we could
punish each additional addendum by a heuristic.


> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

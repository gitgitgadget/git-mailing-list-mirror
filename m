From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: storing cover letter of a patch series?
Date: Thu, 10 Sep 2015 14:03:48 -0700
Message-ID: <CA+P7+xq2H-ZRix_71bQdswuEm++64ZA8FmK7J+1jhUhFeCZbgg@mail.gmail.com>
References: <CA+P7+xpHDGY5RTR8ntrABdxqM6b4V9dndS68=kV1+1Ym1N6YKw@mail.gmail.com>
 <xmqqh9n241el.fsf@gitster.mtv.corp.google.com> <CA+P7+xq9P2NHqQe-y+2n38ZvbR74UxR0Rik=btgy=JtEoZbX2A@mail.gmail.com>
 <xmqqvbbi2jy5.fsf@gitster.mtv.corp.google.com> <CA+P7+xodgeu6Vo+Rt57_iFycxkEnNjxP-TTOfY8DdXwzeVKbZg@mail.gmail.com>
 <A20C476954134C53B0D256D644B1CCC2@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Thu Sep 10 23:04:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Za911-0004bu-Lb
	for gcvg-git-2@plane.gmane.org; Thu, 10 Sep 2015 23:04:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751324AbbIJVEJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Sep 2015 17:04:09 -0400
Received: from mail-io0-f174.google.com ([209.85.223.174]:35312 "EHLO
	mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750877AbbIJVEI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Sep 2015 17:04:08 -0400
Received: by ioiz6 with SMTP id z6so76032538ioi.2
        for <git@vger.kernel.org>; Thu, 10 Sep 2015 14:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=eiLnbo8k8wxFGbsF+ObcmYJ9u5Zm4+naeZXFxXNAWtg=;
        b=e0m9Nn9kZnAWC9gszvzc0mt0kAgXkXXa85nWRi9H6OuGzREL/A9Ib96a9AJVbk30RB
         cGuQvAoJQGWWKNaelsH2Ksa5d2E+neJzmpL7FSNKcM+Nku8+zQpF0UeZQWC+y4emmXEi
         RYhHfY5dCvNEA6GsSYloc5/jqmjSEPU3m+a2S6k8wdrBuYU5KLFjC2dUSUwJN5d9kjUV
         kzMwuH0EeLqTHCghzh64xyjeDvg8GztvwubxSzjfuIyXA9zKG/3u9tVrpseWzBBCxVyt
         pIvYBdodvidahulVKjFdQ39cr206iamvUZWTlqNyaGgb2fGbRzd2j03Dsed+uOCgES4W
         0TxA==
X-Received: by 10.107.166.201 with SMTP id p192mr31198561ioe.0.1441919047755;
 Thu, 10 Sep 2015 14:04:07 -0700 (PDT)
Received: by 10.107.132.155 with HTTP; Thu, 10 Sep 2015 14:03:48 -0700 (PDT)
In-Reply-To: <A20C476954134C53B0D256D644B1CCC2@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277637>

On Thu, Sep 10, 2015 at 1:09 PM, Philip Oakley <philipoakley@iee.org> wrote:
> From: "Jacob Keller" <jacob.keller@gmail.com>
>>
>> On Thu, Sep 10, 2015 at 11:44 AM, Junio C Hamano <gitster@pobox.com>
>> wrote:
>>>
>>> Jacob Keller <jacob.keller@gmail.com> writes:
>>>
>>>> I hadn't thought of separating the cover letter from git-send-email.
>>>> That would be suitable for me.
>>>
>>>
>>> Yeah, I said this number of times over time, and I said it once
>>> recently in another thread, but I think it was a mistake to allow
>>> git-send-email to drive format-patch.  It may appear that it will
>>> make things convenient in the perfect world where no user makes
>>> mistakes, but people are not perfect in real life.  Expecting them
>>> to be is being naive.
>>>
>>
>> Yep. I didn't even know cover-letter was an option of format-patch
>> only thought it was in send-email.
>>
> Actually, the one feature I'd like (I think) is to be able to join together
> the empty commit mechanism and the cover letter mechanism within format
> patch so that:
>
> * the empty commit message would detected and automatically become the [0/N]
> in the patch series (without need to say --cover-letter)
>
> * the cover letter would still have some 'template' markings to say "***
> insert what's changed here***" or smilar (with option to exclude them).
>
> That way, when starting a series / branch, the first item would be to add
> the explanatory 'empty commit' that states the requirements of what one
> hopes to achieve (a key cover letter content), which is then followed by
> commits that move toward that goal.
>
> The series can then be rebased as the user develops the code, and that cover
> note can be edited as required during the rebase.
>
> When it comes time to show it to the list, the format patch will *know* from
> the empty commit that it is the [0/N] cover letter and (perhaps -option) add
> the appropriate markers ready for editing.
>
> The user edits the cover letter with the extra 'what's changed' / interdiff
> / whatever, and sends. sendmail barfs if the user hasn't edited the markers.
>
> This could also work with the sendmail patch formating (though I've never
> used that workflow) as now the cover letter becomes automatic for the
> upstream.
>
> Philip

If there was a way to store this empty commit message tagged as "cover
letter" that could work well, though generally I prefer the
non-fast-forward merges as this shows you where the series ended *and*
began. It's somewhat confusing to newer users.. and this doesn't get
rebased very well either.

Some way to indicate a particular "empty" commit is actually a cover
letter seems easy enough. This seems like the way that I was thinking.

Using "edit description" of git-branch seems also to be pretty
effective for this, even if it doesn't get shared across remotes. (not
really a necessary feature for what I do).

But having some way to indicate "cover letter" which gets used as the
beginning of a log message when doing a particular "merge
--tip-as-cover" or something like Junio suggested above seems like the
nicest approach.

Regards,
Jake

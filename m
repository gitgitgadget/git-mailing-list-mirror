From: Phil Hord <phil.hord@gmail.com>
Subject: Re: Composing git repositories
Date: Sun, 31 Mar 2013 19:50:05 -0400
Message-ID: <CABURp0q9mV+-tEtHGpE4mh9cdbhkA8fr4i7XpBtK0fpfSYg-+A@mail.gmail.com>
References: <CALkWK0=CsuAWQwk5Guf0pbC4_ZEoZiwQpamcRvBGz5LJ0QGKHg@mail.gmail.com>
 <7vmwtqt8rs.fsf@alter.siamese.dyndns.org> <CALkWK0kNH2A4eLML22RTofarR3MB++OECiNXMi-bWLLMWK1GAg@mail.gmail.com>
 <7vvc8comj5.fsf@alter.siamese.dyndns.org> <CALkWK0nARWAtC-D3UiNLccuaSwjR6meJb+Cu590N=8Ti8O7OMg@mail.gmail.com>
 <51537A7B.7050206@web.de> <CALkWK0nfNCu775MBB-Y28=V93RkV24kbTLTDKWO2dZ-0yxX=Sw@mail.gmail.com>
 <5154AACC.7050006@web.de> <CALkWK0k=g3iFjmpUQA1VkuH2kZsVX1_Hpo=LZ7CuotwHz_1++g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 01 01:50:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMS1W-0004f3-HW
	for gcvg-git-2@plane.gmane.org; Mon, 01 Apr 2013 01:50:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756137Ab3CaXu0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Mar 2013 19:50:26 -0400
Received: from mail-vc0-f170.google.com ([209.85.220.170]:35470 "EHLO
	mail-vc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756071Ab3CaXu0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Mar 2013 19:50:26 -0400
Received: by mail-vc0-f170.google.com with SMTP id lf10so1917990vcb.1
        for <git@vger.kernel.org>; Sun, 31 Mar 2013 16:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=+VYnnAWTpHW2n2Aje6975olFYCAnKiS9gu//qh47Lf4=;
        b=zqSA//TK8rjCwFxZFD4eD5x1/O/07Sm2Z/F8S5To0fRhRhI65aAH5wZfWFafcjTsWV
         5K4/FEZEPKMMaRRiYZWQ0i+ZQuhdzYM/T3vwiq/Mr7PfWiD4GahyDDwaAVtonaJZy9nN
         WSEf32Ry7DDyp1I8BjZR6bcCbFIONBazaB+lPm6YvakJQL1gefOlIke6V5yJP+6lnN6W
         ly84lQNWZ2uosdhswIo0R7qZO0+kd0MeRbscjsbJWVWV8c2M4ezN8WVXEMefeJH8/Be4
         HL3GS3nEVwRT5+xECvgOafyAGXE9nuPpPbot96w1en74TNWovsCrwLN2G1vIJUOJ/y38
         cw7Q==
X-Received: by 10.58.96.72 with SMTP id dq8mr7595270veb.49.1364773825439; Sun,
 31 Mar 2013 16:50:25 -0700 (PDT)
Received: by 10.58.23.135 with HTTP; Sun, 31 Mar 2013 16:50:05 -0700 (PDT)
In-Reply-To: <CALkWK0k=g3iFjmpUQA1VkuH2kZsVX1_Hpo=LZ7CuotwHz_1++g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219649>

On Sun, Mar 31, 2013 at 4:34 PM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Thanks for taking the time and effort to review my thoughts.
>
> Jens Lehmann wrote:
>> A
>> commit is the thing to record here because it *is* the perfect fit
>
> Might be, but saying that doesn't help one bit.  I want to know why.
>
>> I want to improve the user experience
>> of submodules and don't care much in what language we achieve that.
>
> You missed the point entirely.  If git didn't have a commit object,
> would you use a special kind of blob and code around everything to
> avoid fixing a more fundamental issue?
>
>> What happens when you rename "magit" to "foo" in that branch and want
>> to check out an older commit of the same branch? That is one of the
>> reasons why that belongs in to a checked in .gitmodules and not
>> someplace untracked.
>
> Good point.  I learnt something new.
>
>> Are you aware that current Git code already stats all files across
>> all submodules recursive by default? So (again) no problem here, we
>> do that already (unless configured otherwise).
>
> I didn't know that.  Why does it do this?
>
>> Guess what: submodules are the solution for a certain set of use
>> cases, and tools like subtree are a solution for another set of
>> use cases. There is no silver bullet.
>
> That's the core of your argument: submodules already solve what it
> was meant to, and we can't get it to solve a larger class of problems.
>  In other words, you're implying that it's impossible to build a tool
> that will be able to compose git repositories in a way that solves a
> very large class of problems.  I don't see conclusive proof for this,
> so I have to disagree.

I think it is possible to solve larger classes of problems with
submodules, but it is a harder problem than you seem to think.  In any
case I do not think you need to re-engineer submodules to improve
them.

Sumodules are good for preserving history.  When properly managed,
they answer the question git always answers, "Where was my code in the
past?"  I would like proper management to be easier, but I understand
why it is difficult; and I see it getting easier.

Some users also want submodules to handle other tasks, like "Import
branch-tracked upstream changes (i.e. git pull origin master)."  This
too is useful, but it is a different problem than submodules'
primarily try to solve.  But they do already solve _part_ of that
problem ("Show me how these modules are related"), so it seems a
trivial thing to ask them also to handle the "floating branch" task.
The trick is to handle this task in a way that does not break the task
they are designed and used for already.

Some other users want submodules to solve the problem of composition,
like "Show me the combined log of all these submodules."  (Replace
"show log" with "diff", "merge", "bisect" or even "rebase" if you
like.)  I think this is where Jens is leaning when working to improve
the user experience.  But this direction does not require
re-architecting the fundamentals of submodules.


> To summarize, everyone seems to be elated with the current state of
> submodules and is vehemently defending it.

That's a gross overstatement.  Everyone understands that is
complicated and dangerous tweak a machine in operation.  Such tweaks
should be safe, prudent and justifiable, in roughly that order.

Phil

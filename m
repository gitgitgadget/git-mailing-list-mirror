From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v6] Add new git-related helper to contrib
Date: Thu, 23 May 2013 17:59:37 -0500
Message-ID: <CAMP44s14Gdadmgy2zi6dRnKLYdZ=HO85OiPSVxGZ8Hquv_58=g@mail.gmail.com>
References: <1368978823-18247-1-git-send-email-felipe.contreras@gmail.com>
	<7vr4gyizti.fsf@alter.siamese.dyndns.org>
	<CAMP44s0pXLmjVUwsVWiN2G5QReh80spXjvy_6GuUGRz1RmUbLQ@mail.gmail.com>
	<7vd2siiqsr.fsf@alter.siamese.dyndns.org>
	<CAMP44s2ETSxebGxXJV_BYEqTC5gJMVdQLbnTUomrie2rHhdmDg@mail.gmail.com>
	<7v8v36iq3e.fsf@alter.siamese.dyndns.org>
	<7v4nduipvb.fsf@alter.siamese.dyndns.org>
	<7vzjvmh98r.fsf@alter.siamese.dyndns.org>
	<CAMP44s1_=HSgZA=abHJ3sgDbUyfkF78qO+sR1+Aact3o7bAgLA@mail.gmail.com>
	<7vvc6ah81g.fsf@alter.siamese.dyndns.org>
	<CAMP44s37a0_wVVef+QVnLNvc8Uos_XpCZAtpX0RmQyMcuJHUHw@mail.gmail.com>
	<CAMP44s18ps9JtY7+mvXVbuZu3cm7bHnK1vCzMWqBdvawLr+zzA@mail.gmail.com>
	<7v8v35hc11.fsf@alter.siamese.dyndns.org>
	<CAMP44s0X-79Pn4gq_rqBbti-xUobyYDc8Gy-3-g=sq8siZqq8g@mail.gmail.com>
	<7vppwhcqjq.fsf@alter.siamese.dyndns.org>
	<CAMP44s3LcEkTghg-cBRux7sA54L-U93w5Znqa1jz2MnUWj8Rhw@mail.gmail.com>
	<7vhahtco5b.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 24 00:59:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfeU3-0004jF-UA
	for gcvg-git-2@plane.gmane.org; Fri, 24 May 2013 00:59:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759894Ab3EWW7k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 May 2013 18:59:40 -0400
Received: from mail-la0-f54.google.com ([209.85.215.54]:53443 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759759Ab3EWW7j (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 May 2013 18:59:39 -0400
Received: by mail-la0-f54.google.com with SMTP id eg20so3851228lab.27
        for <git@vger.kernel.org>; Thu, 23 May 2013 15:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=HxZvcmhIdbsqPx3gd37OFIVXYei7j6x6pZnuJgeIF5w=;
        b=d7ejV0wptWNaRaf/OoJzhuD8JDQGfHzLq0eVf2xl1bw7qXZ8GCACBY1PmV+IGfbphq
         1BCVlX9ULQ/9zHhjdnbM+ptLi5zdC35oaPk4UlKmbBmRm8O4zzfaHdfiJRrzVWLW3pLX
         vgUORjjnIldIBbT4vqcif/py6rXD64fWAKK6uaU4n7ncvX1TCwfUkZo6oHGpRMMrnJDf
         TLp34RKFnnJelKKnEyIWcLF/nWwEBTkZ3bc+EHS0xVtW/EMu/d5/K73xfAtUJYWKXZwA
         UBrIVvkGrxGO3QFHT5tXqAJx990SvC9Kc9u91mSxEItJyuaeBx+6ezLs0XntDr/9qmwP
         ZtkA==
X-Received: by 10.112.142.196 with SMTP id ry4mr7606302lbb.93.1369349977119;
 Thu, 23 May 2013 15:59:37 -0700 (PDT)
Received: by 10.114.174.170 with HTTP; Thu, 23 May 2013 15:59:37 -0700 (PDT)
In-Reply-To: <7vhahtco5b.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225315>

On Thu, May 23, 2013 at 5:44 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>>> Then in that "next iteration", we pick blame entry for A and decide
>>> to see if HEAD^, which is the suspect for A, can be exonerated of
>>> blames for _any_ (not just A) blame entry it currently is suspected
>>> for.  We call pass_blame() and it will find and process both A and
>>> C with a single "git diff-tree", attempting to pass blame to HEAD^^
>>> and its ancestors.
>>
>> All right, my code still works in that situation.
>
> When HEAD^ was processed, pass_blame() finds that the first line in
> A is attributable to HEAD^ (our current suspect) while the rest were
> copied from a different file in HEAD^^ .  All lines in C are found
> to be copy from a different file in HEAD^^.
>
> Then your scoreboard would have:
>
>   1. a blame entry that failed to pass blame to parents of HEAD^ (the
>      first line in A), which still has suspect == HEAD^
>
>   2. a blame entry that covers the remainder of A, blaming HEAD^^.
>
>   3. a blame entry that covers all of B, whose final guilty party is
>      known already.
>
>   4. a blame entry that covers all of C, blaming a different file in
>      HEAD^^.
>
> Your "Take responsibility" loop goes over these blame entries, sets
> found_guilty to true because of the first blame entry (the first
> line of A), and calls print_guilty_entry() for blame entry 1,
> showing that HEAD^ is guilty for the first line of A.
>
> After the loop, your "if we did not find anybody guilty" logic does
> not kick in, and the original line range for block A you saved in
> tmp_ent is not used.
>
> You lost the fact that the second and remainder of A were in this
> file at the commit HEAD^ but not in HEAD^^ (i.e. these lines were
> moved by HEAD^ from elsewhere).

> The fact that HEAD^ touched _something_ is not lost, so if _all_ you
> care about is "list all the commits, but I do not care about what
> line range was modified how", you can claim it "working",

The line range printed is correct.

> but that
> is a very limited definition of "working" and is not very reusable
> or extensible in order to help those like gitk that currently have
> to run two separate blames.  They need an output that lets them tell
> between
>
>  - this is the earliest we saw these lines in the path (it may have
>    been copied from another path, but this entry in the incremental
>    output stream is not about that final blame); and
>
>  - this is the final blame where these lines came from, possibly
>    from different path"
>
> and coalesce both kind of origin..

They can already do that by looking at the lines; if they get replaced
by another entry; they are not guilty.

Or we can add a 'guilty' line to the incremental output, that's trivial.

> Also the fact that the entire C was copied from elsewhere by HEAD^
> is lost but that is the same issue.  The next round will not find
> any blame entry that is !ent->guity because the call to pass_blame()
> for HEAD^ already handled the final blame not just for blame entries
> 1 and 2, but also for 4 during this round.

No, that's not true. If it's a different file the blame entry is not
found guilty.

> If the change in HEAD^ in the above example were to copy the whole A
> and C from a different file, then your !found_guilty logic would
> kick in and say all lines of A where copied from elsewhere in HEAD^,
> but again we would not learn the same information for C.

We would, when it's the turn for C, which is not guilty at this point.

> I do not think "I care only about a single bit per commit, i.e. if
> the commit touched the path; screw everybody else who wants to
> actually know where each line came from" can be called "working".

They can know where each line came from; the lines of each entry are
printed properly; that's the whole point of 'tmp_ent'.

-- 
Felipe Contreras

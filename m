Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 556B11FF40
	for <e@80x24.org>; Fri, 24 Jun 2016 02:33:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752166AbcFXCc6 (ORCPT <rfc822;e@80x24.org>);
	Thu, 23 Jun 2016 22:32:58 -0400
Received: from mail-yw0-f169.google.com ([209.85.161.169]:35463 "EHLO
	mail-yw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752159AbcFXCc5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jun 2016 22:32:57 -0400
Received: by mail-yw0-f169.google.com with SMTP id l125so87848607ywb.2
        for <git@vger.kernel.org>; Thu, 23 Jun 2016 19:32:56 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=j4MkvsMEik8VWZ08MIRgEexjkTmvyIoXjHGGwQDrwSc=;
        b=sKvh+fAi33E1263cVsqh2AdHDFcly8/5J7mjHpBjJhLogO0R7hBxHzwy2g/MX9j3Wu
         zuE9IvGBkZBnFL4PPRVbKBWQZs7efgctKoaXnRBkdlhfNisxSjZ/jc79slp1JW3bSB6w
         in8M55RUt/GJKpY7eTwupd2QP3dFhS0NMKqAxuPQ1ZqkY3ZNG1P+IzgJliSYnIGdXW0u
         YMtmatopoZDo/26NAe0jrS4LPueK3H/YXMHMjdOr5z/Zb1uyF5ZTeThimTCxvAoUA7Mb
         uJ/Dk2J8T1h5wemhOv6+/KhydbK+qrmwxvHoVI2yZAMyKbLTc81tQshAW/PEaakNNs3p
         umsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=j4MkvsMEik8VWZ08MIRgEexjkTmvyIoXjHGGwQDrwSc=;
        b=Rl2rKbzMSlNYE1p8O9lKdi9FECs6x76jaKT1tXEkPRpm6IeAuVkzBVseXd+itvovg1
         53mschz/hpCUKSOqwpIZSdhvWJUZyTiScFUsFYGzV2H3DpaN2sEAs+H1xRHHnWzU737G
         +UT3o/j0dPnrSlNg69Iqw44UU02xpVAsEcJ//mDARqkMR+eyxXVi9RTw9Dqau0SLayRR
         cCNfEOP0Z2vQS5vMOch27/xw2fNOQmKpRFi6f9l9wi9a0hIt3klwrrGIPxbQftXJCQy+
         WrU4FxYF4PiAvmwc5ThXy0YO7JjEBSAkO6GvIFopgKluPNwq+8JI9iAE8FLBuvw0KrJq
         H9tA==
X-Gm-Message-State: ALyK8tLXeQ0Us1/bgx+OiKzMBpCZ109cBdXBzvrNTe8dOxbj0l8OoIU7cUgpuJ4ck+/COY+94vpYcup/ioujXw==
X-Received: by 10.129.154.204 with SMTP id r195mr1287828ywg.119.1466735576082;
 Thu, 23 Jun 2016 19:32:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.87.134 with HTTP; Thu, 23 Jun 2016 19:32:36 -0700 (PDT)
In-Reply-To: <CAKU2X8ZTf6_ptGkD4na+j5MPeD=yCKUTpK6VT2Ye87Ffs_KdrA@mail.gmail.com>
References: <CAKU2X8bAXmVfJz9P7d3k-_d12sjyrzWt+kJCGj8V6fTDAjsFog@mail.gmail.com>
 <87eg8vovsj.fsf@waller.obbligato.org> <CAKU2X8ZTf6_ptGkD4na+j5MPeD=yCKUTpK6VT2Ye87Ffs_KdrA@mail.gmail.com>
From:	ELI <eliptus@gmail.com>
Date:	Thu, 23 Jun 2016 19:32:36 -0700
Message-ID: <CAKU2X8ZqRgXpqV+97VYUW9o7ZHxgo5dKURYB3k_21FGpj0dUng@mail.gmail.com>
Subject: Re: Subtree Split Includes Commits Outside Prefix Directory
To:	"David A. Greene" <greened@obbligato.org>
Cc:	git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Attempting to resend without HTML...

- Harpreet "Eli" Sangha


On Thu, Jun 23, 2016 at 7:18 PM, ELI <eliptus@gmail.com> wrote:
> Sorry for the delayed response... your email somehow found it's way into my
> Gmail spam folder.
>
> I've created a simple reproduction case and hosted the test repositories on
> BitBucket for sharing:
> https://bitbucket.org/eliptus/subtree-test-sup
> https://bitbucket.org/eliptus/subtree-test-suba
> https://bitbucket.org/eliptus/subtree-test-subb
> https://bitbucket.org/eliptus/subtree-test-subc
>
> Quick Repro Step:
> git -C Sup subtree push --prefix=c SubC working
>
> You can reproduce the behavior I describe previously with the test
> repositories by simply attempting a subtree push from Sup to SubC.  The
> result is that SubC contains commit history for changes make exclusively to
> SubA and SubB.  Below are details of how I got to this state.
>
> Test Setup:
>
> Created four new git repositories with initial commits: Sup, SubA, SubB,
> SubC
>
> The branch "working" in repository SubC still reflects the state after this
> step.
>
> Performed "subtree add" for SubA, SubB, and SubC into Sup with prefixes a,
> b, and c, respectively.
> Added additional commits directly in repositories SubA and SubB.
>
> The branch "master" in repositories SubA and SubB still reflect the state
> after this step.
>
> Performed "subtree pull" from SubA and SubB to Sup.
> Added a commit in repository Sup that modifies prefix "c".
>
> The branch "master" in repository Sup still reflects the state after this
> step.
>
> Performed "subtree push" to SubC from Sup.
>
> The branch "master" in repository SubC still reflects the state after this
> step.
> A "git log --patch master" in repository SubC shows commit's made in SubA
> and SubB.
>
>
> Regards,
>
> On Sat, May 21, 2016 at 4:06 PM David A. Greene <greened@obbligato.org>
> wrote:
>>
>> ELI <eliptus@gmail.com> writes:
>>
>> > I then reviewed the commit history of contrib/subtree/git-subtree.sh
>> > and determined that the last successful subtree push was performed
>> > prior to the integration of this change:
>> >
>> > https://git.kernel.org/cgit/git/git.git/commit/contrib/subtree/git-subtree.sh?id=933cfeb90b5d03b4096db6d60494a6eedea25d03
>> >
>> > As a next step, I reversed that patch on my local install of git
>> > subtree, and the result was a successful subtree push.
>>
>> So you're saying that this patch caused a regression?
>>
>> > Unfortunately, I have not yet reproduced this with a test main project
>> > and subprojects, and I cannot make the project I observed it in
>> > public.
>>
>> I very much want to see a testcase for this.  I'm planning to
>> fundamentally rewrite the split code this year and want to make sure it
>> covers everything it does now and fixes a few bugs that have been
>> exposed lately.
>>
>> It's tough to revert that patch since it fixed a problem for someone and
>> we don't have a testcase demonstrating the problem you encountered.  Not
>> saying your problem isn't important but we need to understand it and
>> have a way to flag it before fixing or hiding it with a revert of the
>> above patch.
>>
>>                        -David
>
> --
> - Harpreet "Eli" Sangha

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05C591FD99
	for <e@80x24.org>; Tue, 30 Aug 2016 05:12:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751749AbcH3FMm (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Aug 2016 01:12:42 -0400
Received: from mail-yb0-f176.google.com ([209.85.213.176]:34603 "EHLO
        mail-yb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751230AbcH3FMl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2016 01:12:41 -0400
Received: by mail-yb0-f176.google.com with SMTP id x93so2832394ybh.1
        for <git@vger.kernel.org>; Mon, 29 Aug 2016 22:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=nw+8+T6mqqjfIeOtw3EzbBqqq0GhG7KaMkLXNhHX5M0=;
        b=csaTXSa19b/EdNu4kuzocCINlRMhy7Kywqy/ljJEnBvdOtveDZb0X8Sn4YTjDIT2dl
         //3U/KSiNH7DI1rbCCNWE6CnlCy9X51nVn9CRLoGUVYqJoF8t4cmiaWXcYbnPc23fL/2
         65BFb1mLLt+t/oT+Pq7TLqtF4vCmlvf2ucsCRqzrG/vE13u+LYysQvI5n5AmIkq3HjbS
         iAHxm/ZdaAGLCRyIPVlKnt+rsg/l2bEgFgVVoAX5Zbpcwj81q7Dmoxb6R9PA/i+34yae
         yfJcY9Z8DE8ReiHaKTXexCi47/9wkB6HeTDt/OTPV4MUTXQWJ7T9Y6JzAwyg0MFKdtyk
         iJAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=nw+8+T6mqqjfIeOtw3EzbBqqq0GhG7KaMkLXNhHX5M0=;
        b=HniorNAkjvSj8zPG09Xatn1y++9CcaIvmCNu9HlTHB/u26qsWcEuaxP/7+LZsjTNu6
         xsgvdVZZZRU5ZYBlAsFvix6RbRGSrmhBPQvxAoS7uT/4mCcIzx7fSiGklMvG33ToEC/F
         Jb0ax9HysSlT9+z/bx0Mt7YyiUwD3zic5ZS2I5ZuO9XWVrytPdFT9pT70X1U5mwWBVTh
         XNBoRENVSTcJ3QTxf5opLXVOdNPrh2Jcpnm44bd31hoG4xBXRV6+1HPFKbUcw4EvggQN
         7H94j1SylfgQLxo1eVPOucRfgFBapRQ6OBZ/IP3Juwvxeqxa5568zjH4iAVr32ttVPnT
         tKbw==
X-Gm-Message-State: AE9vXwN1z2PttRb2Jn4TczkGgnLgttu90qM0lD0Qo0dXAHhmi1vy8/pcsr9rI2yfJqeZDG1YBMfyi8urmd8Iog==
X-Received: by 10.37.30.70 with SMTP id e67mr1414812ybe.94.1472533960173; Mon,
 29 Aug 2016 22:12:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.57.207 with HTTP; Mon, 29 Aug 2016 22:12:19 -0700 (PDT)
In-Reply-To: <CAKU2X8ZqRgXpqV+97VYUW9o7ZHxgo5dKURYB3k_21FGpj0dUng@mail.gmail.com>
References: <CAKU2X8bAXmVfJz9P7d3k-_d12sjyrzWt+kJCGj8V6fTDAjsFog@mail.gmail.com>
 <87eg8vovsj.fsf@waller.obbligato.org> <CAKU2X8ZTf6_ptGkD4na+j5MPeD=yCKUTpK6VT2Ye87Ffs_KdrA@mail.gmail.com>
 <CAKU2X8ZqRgXpqV+97VYUW9o7ZHxgo5dKURYB3k_21FGpj0dUng@mail.gmail.com>
From:   ELI <eliptus@gmail.com>
Date:   Mon, 29 Aug 2016 22:12:19 -0700
Message-ID: <CAKU2X8a8n3kr+K-Jk9_-mxE_GtjzsHMkPY86=JjWeWseT8ecXg@mail.gmail.com>
Subject: Re: Subtree Split Includes Commits Outside Prefix Directory
To:     "David A. Greene" <greened@obbligato.org>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey David,

Did this give you the repro case that you needed?
- Harpreet "Eli" Sangha


On Thu, Jun 23, 2016 at 7:32 PM, ELI <eliptus@gmail.com> wrote:
> Attempting to resend without HTML...
>
> - Harpreet "Eli" Sangha
>
>
> On Thu, Jun 23, 2016 at 7:18 PM, ELI <eliptus@gmail.com> wrote:
>> Sorry for the delayed response... your email somehow found it's way into my
>> Gmail spam folder.
>>
>> I've created a simple reproduction case and hosted the test repositories on
>> BitBucket for sharing:
>> https://bitbucket.org/eliptus/subtree-test-sup
>> https://bitbucket.org/eliptus/subtree-test-suba
>> https://bitbucket.org/eliptus/subtree-test-subb
>> https://bitbucket.org/eliptus/subtree-test-subc
>>
>> Quick Repro Step:
>> git -C Sup subtree push --prefix=c SubC working
>>
>> You can reproduce the behavior I describe previously with the test
>> repositories by simply attempting a subtree push from Sup to SubC.  The
>> result is that SubC contains commit history for changes make exclusively to
>> SubA and SubB.  Below are details of how I got to this state.
>>
>> Test Setup:
>>
>> Created four new git repositories with initial commits: Sup, SubA, SubB,
>> SubC
>>
>> The branch "working" in repository SubC still reflects the state after this
>> step.
>>
>> Performed "subtree add" for SubA, SubB, and SubC into Sup with prefixes a,
>> b, and c, respectively.
>> Added additional commits directly in repositories SubA and SubB.
>>
>> The branch "master" in repositories SubA and SubB still reflect the state
>> after this step.
>>
>> Performed "subtree pull" from SubA and SubB to Sup.
>> Added a commit in repository Sup that modifies prefix "c".
>>
>> The branch "master" in repository Sup still reflects the state after this
>> step.
>>
>> Performed "subtree push" to SubC from Sup.
>>
>> The branch "master" in repository SubC still reflects the state after this
>> step.
>> A "git log --patch master" in repository SubC shows commit's made in SubA
>> and SubB.
>>
>>
>> Regards,
>>
>> On Sat, May 21, 2016 at 4:06 PM David A. Greene <greened@obbligato.org>
>> wrote:
>>>
>>> ELI <eliptus@gmail.com> writes:
>>>
>>> > I then reviewed the commit history of contrib/subtree/git-subtree.sh
>>> > and determined that the last successful subtree push was performed
>>> > prior to the integration of this change:
>>> >
>>> > https://git.kernel.org/cgit/git/git.git/commit/contrib/subtree/git-subtree.sh?id=933cfeb90b5d03b4096db6d60494a6eedea25d03
>>> >
>>> > As a next step, I reversed that patch on my local install of git
>>> > subtree, and the result was a successful subtree push.
>>>
>>> So you're saying that this patch caused a regression?
>>>
>>> > Unfortunately, I have not yet reproduced this with a test main project
>>> > and subprojects, and I cannot make the project I observed it in
>>> > public.
>>>
>>> I very much want to see a testcase for this.  I'm planning to
>>> fundamentally rewrite the split code this year and want to make sure it
>>> covers everything it does now and fixes a few bugs that have been
>>> exposed lately.
>>>
>>> It's tough to revert that patch since it fixed a problem for someone and
>>> we don't have a testcase demonstrating the problem you encountered.  Not
>>> saying your problem isn't important but we need to understand it and
>>> have a way to flag it before fixing or hiding it with a revert of the
>>> above patch.
>>>
>>>                        -David
>>
>> --
>> - Harpreet "Eli" Sangha

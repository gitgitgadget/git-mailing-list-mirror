Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19D0A2035A
	for <e@80x24.org>; Tue, 11 Jul 2017 18:10:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756130AbdGKSK2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jul 2017 14:10:28 -0400
Received: from mail-it0-f50.google.com ([209.85.214.50]:36886 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755947AbdGKSK0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2017 14:10:26 -0400
Received: by mail-it0-f50.google.com with SMTP id m84so29944874ita.0
        for <git@vger.kernel.org>; Tue, 11 Jul 2017 11:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=91NHagNNA97H8XdeWz+3nrFpajyu9ccbFZtOJtYTLeM=;
        b=IM2vn7DChVyjoGWEgmanDcbqtXnVaIAuXGzb9cdXBCq3iVj3QprfJMymii5Jeq89RS
         Cddk2E327zAhqLO/9B0cW1teEEOQly0U1SW2zESxKKh4nu9yxpbMagcsnTpFBzeuyH+P
         rIWEfh7kgaZB9TsyDC7Pvq3X9ltcIoHfL+XKkU8HdWu03oD//sLh88UHmH5axcOTQiCB
         6cYuzcOw959xiphf/hw8UMnkT1313zi8UQlI6Y7CKkTSPwjBHhe/+IzkMnLA8OUnIYlw
         Fln4t6ho3SoZsPu5JFzrhag+OTwnTpFBz05+xtPqkO5klAJR6gRkHXWQJHzWKtkYqKse
         Lu/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=91NHagNNA97H8XdeWz+3nrFpajyu9ccbFZtOJtYTLeM=;
        b=Ft/6ccJ7zoBorJ7qtTNboDmm6xw0u76IPdNHLP8sF3gv+C22PN+WPiNz8tzi4y9g3A
         yNshKYtJIJAuQ2FNw1+WAviyK9N/4DiEP158q/7YES0lrNKlB5NxjQu6zxx+DVM/3Sbf
         KX4Uq1+KGk9gXPxE6Px1t9YVBJ0s7YuDcdhbBB/bWqUT5XFdT/qpihHAFm8uHGgNvboz
         57QNNiy4tffPBkNfegavg20wfMTMEgvK6giTBBeW4QXaR2h/nm8OFGm9Olk6+Dl6BNrG
         2g/x1OecVLRoOyWeH6PQ3ZUKeiuWHaNM3TPAYt8l7xk10L2xslksk4K3K2bbE3cEe3Ne
         NTVw==
X-Gm-Message-State: AIVw110/toEYx1Wc91TuXCsn+LW/dtYT4+Whd6PolUWSUycHp/TgUt+c
        TphBTikk3T3A00CWH0YW2P9pI08Jzg==
X-Received: by 10.36.172.29 with SMTP id s29mr9063000ite.32.1499796625727;
 Tue, 11 Jul 2017 11:10:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.26.138 with HTTP; Tue, 11 Jul 2017 11:10:24 -0700 (PDT)
In-Reply-To: <xmqqh8yi3mur.fsf@gitster.mtv.corp.google.com>
References: <CAEcERAz3vYekvJ8SM1FfdAVsP3LMVqA1O3yoJVThvg-0fPtVCg@mail.gmail.com>
 <xmqqh8yi3mur.fsf@gitster.mtv.corp.google.com>
From:   Nikolay Shustov <nikolay.shustov@gmail.com>
Date:   Tue, 11 Jul 2017 14:10:24 -0400
Message-ID: <CAEcERAzRMo+fRPbc3_MAU2XgKUyaLAeCVsZvCr9FbSjo7u+MfA@mail.gmail.com>
Subject: Re: "groups of files" in Git?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for the explanation. The example about backend and frontend
is relevant even though I normally have to deal with more layers at
the same time.

However, in my case I have the thing that you have already tried to
address, partially: the changes always align with file boundaries BUT
not with directory boundaries. Imagine you have the stack of backend,
data transport and frontend layers. The feature has to touch all three
layers thus resulting in the changes in the apparently different
directories. Thus, making the distinction by the pathspec (if I
understood it right from reading the documentation) would not help.

The attributes could be a solution, if I could:
1. create attribute designated to the feature
2. "mark" uncommitted files in different directory with that attribute
3. filter the list of unchanged files with such attribute
4. create commit for the files only with the certain attribute

You've kindly demonstrated that #4 is doable; however I could not
clearly get for the Git documentation if #1 - #3 are achievable...
Could you point me to the right place in the documentation, please?


On Tue, Jul 11, 2017 at 1:27 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Nikolay Shustov <nikolay.shustov@gmail.com> writes:
>
>> I have to work on several features in the same code tree parallel, in
>> the same Perforce workspace. The major reason why I cannot work on one
>> feature then on another is just because I have to make sure that the
>> changes in the related areas of the product play together well.
>>
>> With Perforce, I can have multiple changelists opened, that group the
>> changed files as needed.
>>
>> With Git I cannot seem to finding the possibility to figure out how to
>> achieve the same result. And the problem is that putting change sets
>> on different Git branches (or workdirs, or whatever Git offers that
>> makes the changes to be NOT in the same source tree) is not a viable
>> option from me ...
>
> Naturally.  If these separate changes need to work together, it is
> way too inconvenient if these changes do not appear in a single
> unified working tree to be built and tested.
>
>> Is it worth considering adding to Git a feature like "group of files"
>> that would offer some virtutal grouping of the locally changed files
>> in the checked-out branch?
>
> Let's step back and let me make sure if I understand you correctly.
> You want to work on a system with two distinct areas (say, the
> frontend and the backend), that have to work together, but you want
> to make two commits, one for each area.  You make changes for both
> areas in your working tree, build and test them to make sure the
> whole thing works well together, and at the end, you make two
> commits.
>
> In your real project, you may be doing more than two areas and more
> than two commits, but is the above a good degenerative case that
> shows the basic idea?  If not, then please disregard all of the
> following.
>
> You can make partial commits in Git.  In the simplest case, you may
> have two separate files backend.py and frontend.py, you make edits
> to both files and then make two commits:
>
>         $ git commit backend.py
>         $ git commit frontend.py
>
> Changes to some files may contain both changes for the backend and
> for the frontend that does not allow you to separate commits at file
> boundary, and Git even lets you handle such a case.  If you have the
> third file in addition to the above two, called common.py, you could
> instead
>
>         $ git add backend.py
>         $ git add -p common.py
>
> to prepare the index to contain only the changes for the backend
> part ("add -p" lets you interactively pick and choose the hunks
> relevant to the backend part), and conclude the commit for the
> backend part with
>
>         $ git commit ;# no paths arguments
>
> and then when all the remaining changes are for the frontend part,
> you can follow it with
>
>         $ git commit -a
>
> to make another commit for the frontend part.
>
> A short answer to your question, provided if I understood you
> correctly, is "no, there is no way to say 'backend.py, backend-2.py,
> ...' are the backend things and call it a filegroup", accompanied by
> "a filegroup would only be effective when changes align with file
> boundary".
>
> And if your response is "but most of the time changes align with
> file boundary", a counter-response is "and most of the time changes
> align with directory boundary (in well structured project, at
> least), so you can do 'git commit backend/' for all the backend part
> without having to name all the paths anyway".
>
> There is an experimental "attributes-limited pathspec" feature in
> recent versions of Git, which lets you assign arbitrary sets of
> labels to each paths, and using that you may be able to do
>
>         $ git commit ':(attr:filegroup=backend).'
>
> and I suspect that would be the closest thing you would want (read
> about 'pathspec' in 'git help glossary')
>

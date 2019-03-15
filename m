Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1D3A20248
	for <e@80x24.org>; Fri, 15 Mar 2019 01:55:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbfCOBzv (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Mar 2019 21:55:51 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:39744 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727061AbfCOBzv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Mar 2019 21:55:51 -0400
Received: by mail-oi1-f194.google.com with SMTP id b4so6082754oif.6
        for <git@vger.kernel.org>; Thu, 14 Mar 2019 18:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/HS4skE0pvKav+lJK+r2Tzx8EP4uwaL7kFT5k2pbrAY=;
        b=TLljUOvahLegWm7Tm/nxGtKbraa/5OMxzC6vOqrB7ci0wCvGKYb6aWVs1wCElh5dVw
         RK1jGhYegQ5JqD/ObZsIzBDeuhFNLou6V7PFiOB/lYHVpuArvvwXsByVHobRXaxyVJet
         dEVskKJ8fuMYO2++RsXSojH/RZoemZZzMcFnD2+Tttdqstk2Ry/esL9SI3uOvtBPLD4e
         +/eIlCVv9IRK3fSwaCwU1gk/ngG/EwP8Cd4JMSVoVjUaFmYh952TJMnOx+yWwiMBvT+9
         nEZvw+0ceG+ALSEbuizV7sKI1qbVqZvD/i0je31I7MVHUj4G1XQfvU6vvdMy0euZCFLJ
         Jtsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/HS4skE0pvKav+lJK+r2Tzx8EP4uwaL7kFT5k2pbrAY=;
        b=LFBttJ3/Xo48mVRL7le1nEVwFXOfmSQczwx66aWzsBxhNIADPnV/vz9nD2vojAeBji
         xGLCoyf7DyqFGEH3/nUwa8up3KNiANMvFk4RS4bWOVPlhr6inUfcC92oAnTztQSdVFvr
         7Z9QZopNo6FL8Qi+qLvRgYp86iR3ICh2wqJegfCc6CseOTW0nEmnLBHzSMEgimgNgXzk
         0gtuOvNymKSfhX/1N5NaS/OUyPCQLaQKyMEf44G2oke8k3GzYGeltA2ioDFv7OQZr3m5
         cU0VfO18OptIxVLmziHFoO/lU+PQ0SVMhIZtUssXUFV4/6m5INL/AFKSbHy38elUnecc
         6mzA==
X-Gm-Message-State: APjAAAU9zPf85D/SQ0dELeqH+PzOKJeuMI+gfIpFOxRdcAeN9Wy99obT
        1/rrXV58FHIYQXCJa/1laU41zSz/e9n/MIClDDg=
X-Google-Smtp-Source: APXvYqzeMpoQtWgGx0u3XMKS/cbDxcsTrpxjWvVNBajimOWmxIooQjdPWTbrM3CnxRH/8fZHDwVJPdRFT09CRM3BmS0=
X-Received: by 2002:aca:cf93:: with SMTP id f141mr123257oig.130.1552614949801;
 Thu, 14 Mar 2019 18:55:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190309164508.GB31533@hank.intra.tgummerer.com>
 <20190310080739.63984-1-ttjtftx@gmail.com> <20190310175924.GF31533@hank.intra.tgummerer.com>
In-Reply-To: <20190310175924.GF31533@hank.intra.tgummerer.com>
From:   jonathan chang <ttjtftx@gmail.com>
Date:   Fri, 15 Mar 2019 09:55:39 +0800
Message-ID: <CAOAu_YLTft7xmx4xvoM5Qqe0CHjqWrH+DUysHq0zfSEU8vodkg@mail.gmail.com>
Subject: Re: [GSoC][PATCH v2 1/5] t0000-basic: fix an indentation error
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 11, 2019 at 1:59 AM Thomas Gummerer <t.gummerer@gmail.com> wrote:
>
> On 03/10, Jonathan Chang wrote:
> > Hi,
> >
> > Thanks for the reviews.
> >
> > Here are the changes in the second version:
> >       - bug fixes
> >       - add preparatory patch
> >       - seperate different files to different patch
> >       - change to use test_line_count in a seperate patch
> >
> > Also I found that there is no such function as test_char_count,
> > is it worthwile to add such function? Here are some stat:
> >
> > `git grep 'test_line_count' | wc -l` = 626
> > `git grep 'wc -l' | wc -l` = 294
> > `git grep 'wc -c' | wc -l` = 68
>
> I do think it would be helpful to introduce that helper, especially if
> it is useful in this patch series.  There seem to be enough other
> places where it can be useful to make it worth adding the helper.

Thanks for the feedback.

> > -- >8 --
> >
> > This is a preparatory step prior to removing the pipes after git
> > commands, which discards git's exit code and may mask a crash.
>
> The commit message should also describe why we need this preparatory
> step. Maybe something like:
>
>       To reduce the noise in when refactoring this pipeline in a
>       subsequent commit fix the indentation.  This has been wrong
>       since the refactoring done in 1b5b2b641a ("t0000: modernise
>       style", 2012-03-02), but carries no meaning.
>
> > Signed-off-by: Jonathan Chang <ttjtftx@gmail.com>
> >
>
> Out of curiosity, how did you create the patch?  'git format-patch'
> would add a '---' line followed by the diffstat, where you would
> usually put the commentary that you put before the scissors line.  It
> seems like 'git am' still handles this fine, which I didn't know, just
> something I noticed because I'm used to the other format.

I believe I used git for that. But I cannot think of why it happened nor
reproduce it.

> Since this patch series is now 5 patches, that commentary should go
> into a cover letter (see the --cover-letter option in format-patch),
> so the reviewers can read that first, and read the patches with that
> in mind, focusing on the patch only, and not additional commentary
> that applies to the whole series when reading the patch.

I wasn't aware of this option. I tried to produce the format in others
cover letter using 'git diff' and options like '--stat', '--summary', with no
success. I consulted Documentation/SubmittingPatches, where I got the
idea of cover letter, but it doesn't mention the option '--cover-letter' and
the idea of cover letter is even confused with '--notes'[1].

I just reread some of the GSoC related mails in the mailing list and
found one[2] that introduced the usage of 'cover-letter', '--range-diff' and
'--interdiff'. As a newbie, I personally think it would be helpful to include
theses options along with others mentioned in SubmittingPatches.

[1]: Documentation/SubmittingPatches:

> You often want to add additional explanation about the patch,
> other than the commit message itself. Place such "cover letter"
> material between the three-dash line and the diffstat. For
> patches requiring multiple iterations of review and discussion,
> an explanation of changes between each iteration can be kept in
> Git-notes and inserted automatically following the three-dash
> line via `git format-patch --notes`.

[2]: https://public-inbox.org/git/CAPig+cSsAufCnHPJfjQd8A778UNAsXEst1m+ekQ7T83=2mMUnw@mail.gmail.com/

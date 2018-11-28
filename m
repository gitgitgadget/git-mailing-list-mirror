Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2D641F609
	for <e@80x24.org>; Wed, 28 Nov 2018 20:27:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbeK2Hai (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Nov 2018 02:30:38 -0500
Received: from mail-ed1-f52.google.com ([209.85.208.52]:38652 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbeK2Hai (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Nov 2018 02:30:38 -0500
Received: by mail-ed1-f52.google.com with SMTP id h50so23243324ede.5
        for <git@vger.kernel.org>; Wed, 28 Nov 2018 12:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7n9eLBbhzMX5FRQbo+AaegUPsXtGlLAu3lJ5wZT0VEQ=;
        b=oC6CKPzsO0+x7xrRYdtuNohOkmVupP7gOew4YiEhL4OTGxNxQeOMQAAmmrSsqYWDE1
         8quto4u4tuJQA8M6HTxWuJlLmoy8TxeOxUtj5s7x/znu/cXt8EOIqiHg/Qfk7tX7iVd1
         mX+b5ZzGw4CNCuBFlNivQJCtqeBrHA9WNWMtONC+xchFeMbuFnyFtW4sw2Ek/dYDrZSQ
         0GS1sVy0JSQ8sCY6z6a1+tMuCyIfntDJWa60X7HKjMOiyui5g/54vxEC1x7GvqOcMNBq
         aYkA0vYPDMHcagd8iPWdqBG7g81L3qY1l7BpTRePIwx3+y5wlLQ91ZP6x+vTZTzFY12y
         dIfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7n9eLBbhzMX5FRQbo+AaegUPsXtGlLAu3lJ5wZT0VEQ=;
        b=dIEJHrRcBGaAXKNCIFm77YqhHOY2xj5UwLa1Ki34W2ObAQr2lvohEWUI9tQSR1J6+F
         csbreEfDSu+p9vLfKyj046z38ixaoSl0Oz1uonzaJjyPTVLEGe8G5hOgkOyy9crvvwke
         xOyz6hHhon87+ikI972cVCreClzC0hPr/wxsHU39fwZyrOeryF8Lo4Y7b+OIc6XuyHh1
         HAfBJlCpIbnZRGaYEG8YS2ld5+Hja6/RZQ+kUDQqM5/O08hBF0scEYhESouEgcVsFvVF
         SpzsuM6pet2NQ8E6VT/ZfPC4NvCJBPQwb5eq668UOwa6P9FJ4uk/nXFWpUl0QRk15HEh
         w/8g==
X-Gm-Message-State: AGRZ1gJvWPgGzTMRlOZSGsYukmaAwPtQh4JzLcF+CPhpxgBSdc75RXnk
        6XBw3T2hiOzFOBeGfhuSxl5Q1IVBqfxwfBSzukbfTw==
X-Google-Smtp-Source: AJdET5eAKzdxG3PXIv5j8KgyKF6XDJJE48Xb1wh+NXMlSEQ6emCfiuPJz7H5a0VW47HrykC/B4TAb3cYvmnvMBF0xsc=
X-Received: by 2002:a17:906:f04:: with SMTP id z4-v6mr28253613eji.106.1543436864426;
 Wed, 28 Nov 2018 12:27:44 -0800 (PST)
MIME-Version: 1.0
References: <758FA299-0842-4462-8CF6-D7210D26A6C7@gmail.com> <xmqq36rlsofp.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq36rlsofp.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 28 Nov 2018 12:27:33 -0800
Message-ID: <CAGZ79kbORHfkZOYXrCrHgKX_66M8=3jppn9_SU5fuB6_CfAMag@mail.gmail.com>
Subject: Re: Git pull confusing output
To:     Junio C Hamano <gitster@pobox.com>
Cc:     William Duclot <william.duclot@gmail.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 27, 2018 at 10:31 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Will <william.duclot@gmail.com> writes:
>
> > I=E2=80=99m far from being a guru, but I consider myself a competent Gi=
t
> > user. Yet, here=E2=80=99s my understanding of the output of one the mos=
t-used
> > commands, `git push`:
> >> Counting objects: 6, done.
> > No idea what an =E2=80=9Cobject=E2=80=9D is. Apparently there=E2=80=99s=
 6 of them
> > here. What does =E2=80=9Ccounting=E2=80=9D them means? Should I care?
>
> You vaguely recall that the last time you pushed you saw ~400
> objects counted there, so you get the feeling how active you were
> since then.
>
> It is up to you if you are interested in such a feel of the level of
> activity.  "git fetch" (hence "git pull") would also give you a
> similar "feel", e.g. "the last fetch was ~1200 objects and today's
> is mere ~200, so it seems it is a relatively slow day".
>
> As to "what is an object?", there are plenty of Git tutorials and
> books to learn the basics from.  Again, it is up to you if you care.

While this is very interesting to the experienced git user, the
approximation of activity by object count is very coarse to say at least.

As It approximates changes in the DAG object count and nothing
about the deltas (which as we learn comes later and it comes with
a progress meter in bytes), it only provides the basics.

>
> I think we have "--quiet" option for those who do not care.

I think some users are not focused as much on the version control as
much as they are focused on another problem that is solved with
the content inside the repo.

Which means they only care about 'actionable' output, such as
* errors
* information provided by remote
  (e.g. links to click to start a code review)
* too long waiting time
  (so they can abort and inspect the problem)

I would suggest we come up with a mode that is "not quiet", but
cuts down to only the basic actionable items [and make that
the default eventually].

Now these actionable items depend on the workflow used,
for which I think an email based maintainers workflow is not
the norm. The vast majority of people uses git-push to
upload their change to a code review system instead.
And for such a workflow the size (as proxied by
object/delta count) is not as important as the target ref
that you push to or potentially the diffstat output of
a potential merge to a target branch.

TLDR: I still think making git-push a bit more quiet is
beneficial to the user base at large.

Stefan

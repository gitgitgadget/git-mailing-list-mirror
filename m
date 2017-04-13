Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3EA3520970
	for <e@80x24.org>; Thu, 13 Apr 2017 10:43:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751250AbdDMKnf (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Apr 2017 06:43:35 -0400
Received: from mail-vk0-f51.google.com ([209.85.213.51]:33742 "EHLO
        mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751088AbdDMKnd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2017 06:43:33 -0400
Received: by mail-vk0-f51.google.com with SMTP id j127so19727163vkh.0
        for <git@vger.kernel.org>; Thu, 13 Apr 2017 03:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mN7Qe73VAcrz3hn7XUz+UvL5/q7bv7WLGrotSlj1uZM=;
        b=Zr1W0VMEzQh0ZzY5Vq/8JXp08sUtqgIx+Rp65oDlN660B4olYYviZocq/qQ102k231
         sD0pCwXmDjkZmBW9/lQg0FmPW23QY7IG93n/A6z7YXuDvXC3Y1ksYSQ3KYlTWDOOEEgO
         OYYaFs291I8peB/roq0ys7o98q2Oc0clt6e1nLmOxxWKukbWPBwgvM/54RZwfzWUbCIL
         wz/zqB0VHpyx9/26sm40CUzZMrooDHihR2iA0qHcmQrLXeDt47oD2ZMRD1Kjx5KBktl1
         fUkZDTYwaFnyroq1ZF1INuq9Qccp0hti/qbCznmR/TUTl2VYIy4aEVIHOFoUP3WPIhEd
         WorQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mN7Qe73VAcrz3hn7XUz+UvL5/q7bv7WLGrotSlj1uZM=;
        b=ds0/2Rak79dd1MNQzh95CNsu1NVXIdSEuy5yn8Doqsy16uabJuYrmYvCwiY3pjRsqc
         Amg24tcwikcCxXv2zL3yF/bDj/M6f553R0lmkw4zaIYIQZnAJgMPbivNfW9id/+ZCnUq
         Zf8968EDtpW+YeTOLjNAh4TZY2+KrEFkDGm4sZb45WL8932Q/GfsFcpwpHFfSVp0cDLf
         ToU1+vy4J9XcTZIJ60C4Qj+qpi1zkNo2dKR5K0G/Q2fL7jOO725/gvEPE+wr9c6T9+I4
         Qirg2xYAO52p6zRJRlGqbkFLS+L43AAPv5u2if6A9u33eofv3T9xcEWvucxsG1Ps3adz
         N1Tw==
X-Gm-Message-State: AN3rC/6gnOgF9INxUfcHxqHm2UzTGkDvwqKlrWqAFubENvLvN1vq6pqr
        9h5rrm0WpF/J2aN7PtAB4mmt4J3hrQ==
X-Received: by 10.31.248.69 with SMTP id w66mr903007vkh.70.1492080212418; Thu,
 13 Apr 2017 03:43:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.23.211 with HTTP; Thu, 13 Apr 2017 03:43:32 -0700 (PDT)
In-Reply-To: <33eebca1-b78f-1e9c-539c-120e32ecfded@grubix.eu>
References: <20170406143342.14770-1-szeder.dev@gmail.com> <33eebca1-b78f-1e9c-539c-120e32ecfded@grubix.eu>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Thu, 13 Apr 2017 12:43:32 +0200
Message-ID: <CAM0VKjkbs1SD3YK6Um7t_Z72z8S4-xz5XpV3ywEmphMJRrmTzQ@mail.gmail.com>
Subject: Re: [PATCH] status: show in-progress info for short status
To:     Michael J Gruber <git@grubix.eu>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 7, 2017 at 4:05 PM, Michael J Gruber <git@grubix.eu> wrote:
> SZEDER G=C3=A1bor venit, vidit, dixit 06.04.2017 16:33:
>>> @@ -1779,6 +1780,31 @@ static void wt_shortstatus_print_tracking(struct=
 wt_status *s)
>>>      }
>>>
>>>      color_fprintf(s->fp, header_color, "]");
>>> +
>>> + inprogress:
>>> +    if (!s->show_inprogress)
>>> +            goto conclude;
>>> +    memset(&state, 0, sizeof(state));
>>> +    wt_status_get_state(&state,
>>> +                        s->branch && !strcmp(s->branch, "HEAD"));
>>> +    if (state.merge_in_progress)
>>> +            color_fprintf(s->fp, header_color, "; %s", LABEL(N_("MERGI=
NG")));
>>> +    else if (state.am_in_progress)
>>> +            color_fprintf(s->fp, header_color, "; %s", LABEL(N_("AM"))=
);
>>> +    else if (state.rebase_in_progress)
>>> +            color_fprintf(s->fp, header_color, "; %s", LABEL(N_("REBAS=
E-m")));

In the prompt "REBASE-m" is only shown during 'rebase --merge', while
"REBASE" is shown during a plain 'rebase'.  Here "REBASE-m" will be
shown during both.

>>> +    else if (state.rebase_interactive_in_progress)
>>> +            color_fprintf(s->fp, header_color, "; %s", LABEL(N_("REBAS=
E-i")));
>>> +    else if (state.cherry_pick_in_progress)
>>> +            color_fprintf(s->fp, header_color, "; %s", LABEL(N_("CHERR=
Y-PICKING")));
>>> +    else if (state.revert_in_progress)
>>> +            color_fprintf(s->fp, header_color, "; %s", LABEL(N_("REVER=
TING")));
>>> +    if (state.bisect_in_progress)
>>
>> else if?
>
> No. You can do all of the above during a bisect.

Right indeed.  I think the prompt should do the same.  Onto the TODO
list it goes, then.

>>> +            color_fprintf(s->fp, header_color, "; %s", LABEL(N_("BISEC=
TING")));
>>> +    free(state.branch);
>>> +    free(state.onto);
>>> +    free(state.detached_from);
>>> +
>>>   conclude:
>>>      fputc(s->null_termination ? '\0' : '\n', s->fp);
>>>  }
>>
>> This reminded me of a patch that I have been using for almost two
>> years now...
>>
>> git-prompt.sh's similar long conditional chain to show the ongoing
>> operation has an else-branch at the end showing "AM/REBASE".  Your
>> patch doesn't add an equivalent branch.  Is this intentional or an
>> oversight?
>
> I go over all states that wt_status_get_state can give.

Yeah, but are those states exclusive?  Or is it possible that both
'am_in_progress' and 'rebase_in_progress' are set?  I suppose it's not
possible.
It would certainly be more obvious if it were a single enum field
instead of a bunch of ints.

>> I suppose it's intentional, because that "AM/REBASE" branch in the
>> prompt seems to be unreachable (see below), but I never took the
>> effort to actually check that (hence the "seems" and that's why I
>> never submitted it).
>
> Note that wt_status_get_state and the prompt script do things quite
> differently.
>
> I suppose that the prompt could make use of the in-progress info being
> exposed by "git status" rather doing its on thing.

The prompt currently gets all this in-progress info using only Bash
builtins, which is much faster than running a git process in a
subshell.  This is especially important on Windows, where the overhead
of running a git process is large enough to make the runtime of
__git_ps1() noticeable when displaying the prompt.  That's the main
reason for much of the shell complexity and ugliness in git-prompt.sh.

Besides, current output formats make 'git status' unsuitable for the
prompt.

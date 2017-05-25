Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 304ED209FD
	for <e@80x24.org>; Thu, 25 May 2017 12:57:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761500AbdEYM47 (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 May 2017 08:56:59 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:34568 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751671AbdEYM45 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 May 2017 08:56:57 -0400
Received: by mail-wm0-f47.google.com with SMTP id 123so33345751wmg.1
        for <git@vger.kernel.org>; Thu, 25 May 2017 05:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7cPeI+Va2weMVk+CS00tDIST049HlQAhBlM6lecG4DE=;
        b=Fo0z09WtQJjFyA0WfpHXSEMwHqrEGZaKgLiITAFiG8zu6SUOJpGqgLFOFnPYOVglWS
         rQBNgi/uVL6owcpUiWuNaH+thOoYPol3v4Yfchqv1dyJZFbKUOD7ZthrmmEQMMFqXMrg
         rgbtNby0T5nXP7OG+gXh4Rq1O6YQisht25TUx6owuM1I88bEsGru9qbhO8W/yF/3BKdK
         9uc88HFb510V9lGE5bF9ZKJdVi74qko8yryHV8jQxCJClxdse4dedbk1bA5rszptV0tM
         Mtu+ZwT6RLhCjP7zlQf03BvUBUB+wNOxRx87NeRr+cABIZPjvH9D80eWhfPVAXjEaPBn
         V2Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7cPeI+Va2weMVk+CS00tDIST049HlQAhBlM6lecG4DE=;
        b=bgz3LLBJOHbrfV/aqt26rb++KitGqy0HxXxzWVihXNnuJOha/yMKiZ+YvWV5UEYH8U
         Ee42b4PuwObfXY7EwH6E8L008oUPUHDqUk66OxQCvnlv9oGp8ZYfJPQqR4nzSEBqnIyj
         9vxq0wBhJB6qjt75WP9DMMUE3WtF+jG0Opd0abiLI+C8NnXK1Ygq0EkbXLah8MW/rJ+m
         hpCk97H9g1NJadUMFHculHMc1vdbNzN6Z+AVXyMbEg0FVugdMz991PsH3KI2Nv7EzplR
         nmqCE/d7Pj1fKnaS7zIr3tksfy1JX2F6GZG7tppUEuYr2u0CNojukxB2I6ykvXS7wqgx
         du6A==
X-Gm-Message-State: AODbwcC/povMoxWH7Zhh2JcxEITelogdtg2xNycpSye+NGrlFBj/kjTH
        fLJrMR06CAhoRD1nzDLUyUlcHqEy4atH
X-Received: by 10.28.140.133 with SMTP id o127mr9197707wmd.7.1495717016333;
 Thu, 25 May 2017 05:56:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.223.132.34 with HTTP; Thu, 25 May 2017 05:56:55 -0700 (PDT)
In-Reply-To: <xmqqfufteb2i.fsf@gitster.mtv.corp.google.com>
References: <20170524051537.29978-1-whydoubt@gmail.com> <20170524051537.29978-29-whydoubt@gmail.com>
 <xmqqfufteb2i.fsf@gitster.mtv.corp.google.com>
From:   Jeffrey Smith <whydoubt@gmail.com>
Date:   Thu, 25 May 2017 07:56:55 -0500
Message-ID: <CAPX7N=7b_Ett_h-NM9okxdQV8+bvOjbVWF1fY5_GwiGkqVhwEg@mail.gmail.com>
Subject: Re: [PATCH 28/29] blame: move scoreboard setup to libgit
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I had meant to change the name to match what is in find_single_final.
While the intent was for it to change while in builtin/blame.c,
apparently I missed that in the shuffle.

On Thu, May 25, 2017 at 12:53 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff Smith <whydoubt@gmail.com> writes:
>
>> Signed-off-by: Jeff Smith <whydoubt@gmail.com>
>> ---
>>  blame.c         | 279 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>>  blame.h         |  10 +-
>>  builtin/blame.c | 276 -------------------------------------------------------
>>  3 files changed, 281 insertions(+), 284 deletions(-)
>>
>> ...
>> +static struct commit *find_single_initial(struct rev_info *revs,
>> +                                       const char **name_p)
>> +{
>> +     int i;
>> +     struct commit *found = NULL;
>> +     const char *name = NULL;
>> +
>> +     /*
>> +      * There must be one and only one negative commit, and it must be
>> +      * the boundary.
>> +      */
>> +     for (i = 0; i < revs->pending.nr; i++) {
>> +             struct object *obj = revs->pending.objects[i].item;
>> +             if (!(obj->flags & UNINTERESTING))
>> +                     continue;
>> +             obj = deref_tag(obj, NULL, 0);
>> +             if (obj->type != OBJ_COMMIT)
>> +                     die("Non commit %s?", revs->pending.objects[i].name);
>> +             if (found)
>> +                     die("More than one commit to dig up from, %s and %s?",
>> +                         revs->pending.objects[i].name, name);
>> +             found = (struct commit *) obj;
>> +             name = revs->pending.objects[i].name;
>> +     }
>> +
>> +     if (!name)
>> +             found = dwim_reverse_initial(revs, &name);
>> +     if (!name)
>> +             die("No commit to dig up from?");
>> +
>> +     if (name_p)
>> +             *name_p = name;
>> +     return found;
>> +}
>> +...
>> -static struct commit *find_single_initial(struct rev_info *revs,
>> -                                       const char **name_p)
>> -{
>> -     int i;
>> -     const char *final_commit_name = NULL;
>> -     struct commit *found = NULL;
>> -
>> -...
>> -
>> -     if (!final_commit_name)
>> -             found = dwim_reverse_initial(revs, &final_commit_name);
>> -     if (!final_commit_name)
>> -             die("No commit to dig up from?");
>> -
>> -     if (name_p)
>> -             *name_p = final_commit_name;
>> -     return found;
>> -}
>
>
> In a patch whose primary purpose is to move code between files,
> making what used to be public to static and vice versa is an
> integral part of moving code.  That is why we want to see a patch
> organized in such a way that comparing the lines that are lost from
> builtin/blame.c and the lines that are added to blame.[ch] is made
> easy.
>
> And from that point of view, it was somewhat irritating to find this
> kind of meaningless change.  If you didn't like the name of the
> variable "final-commit-name", that shold have been renamed while the
> code was still in builtin/blame.c
>
> The end result looks OK anyway (I've checked 29/29 as well).
>
> Thanks.
>
>

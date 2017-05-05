Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81317207B3
	for <e@80x24.org>; Fri,  5 May 2017 23:28:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751391AbdEEX2r (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 May 2017 19:28:47 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:34718 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750951AbdEEX2q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2017 19:28:46 -0400
Received: by mail-io0-f195.google.com with SMTP id 12so4220102iol.1
        for <git@vger.kernel.org>; Fri, 05 May 2017 16:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9fnDwEnxgtYslZeNmYa60Sj9o+FYWnKhhrS/AyOvZlE=;
        b=OwFj+C14y5B5u+Tzx1uUTijKKe1QPBMm4bs/JuFch/wGLoxWjcN8wFFzSgXyqNoRcn
         CvjBtp22fdpR0bTv23SPJ4DbBwMwWde0Of3zCFw5lKJHjUst3t//VkawDUqBqHNKl62j
         wUa5igcNrJ70TIPdp99YF+2B/Bbn+xpKb79guk37uskv1CDkhw6ARM2DHSdKJqE0tba6
         fsnzsBY9OYA0Y5fd+lSDpiEd7weHq0hZW51S+pLR2Y2icVrHzsmyljhYqNV8el8LirAy
         vzmw6gTzTZmgoi90iwHdXh5YTAGf752LvcX25LeYjAPZpmqscu9q24DSrSf1cSKrUQYo
         LoPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9fnDwEnxgtYslZeNmYa60Sj9o+FYWnKhhrS/AyOvZlE=;
        b=Rf+t70b9MtM0ipB8yBZRDCiC0CenM46udvds9YWsVKxma+e55XV0ugXA89qbT+yQdM
         Xj6pQKWowT5g/BgG0w4cSIAseovp6Kezf5tYPHr8HhJlhC39gCio58ATAa6vDB1w/zO2
         uKSHsK3PsjTbf0J0xRjjuxcBEJNPrInSKCUGnzb3kfMSSZwFSMwVgogfZeoYmAgAx/Q+
         Got4j4Ftc0EzU+XEL0RcEdsbbUUMATeycEQm010FG53+bM0xCoapUC5KxOCLi5W3g0dQ
         nUHgwfCMwxUYFg+a8X9zg881APoOcH8moEHv1m69UpgJaZzuTY9TGrXuWgIuYhPh3MsP
         H+bA==
X-Gm-Message-State: AN3rC/4a63oduvks+6VFzCUk2c1FUvxJZBUZN3XH4wlrXkkWFXeyNeq3
        qbE7jTv+kACyQ7FHZR/fwdhM+gBZfQ==
X-Received: by 10.107.138.9 with SMTP id m9mr47289570iod.80.1494026925611;
 Fri, 05 May 2017 16:28:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Fri, 5 May 2017 16:28:24 -0700 (PDT)
In-Reply-To: <CAEA2_RKzUdSPP4bBvGiFVfNnAY3wwp+0LYriC4q5XfCP-1-F4w@mail.gmail.com>
References: <1494009820-2090-1-git-send-email-bnmvco@gmail.com>
 <1494009820-2090-3-git-send-email-bnmvco@gmail.com> <alpine.DEB.2.21.1.1705052328380.146734@virtualbox>
 <CAEA2_RKzUdSPP4bBvGiFVfNnAY3wwp+0LYriC4q5XfCP-1-F4w@mail.gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Sat, 6 May 2017 01:28:24 +0200
Message-ID: <CACBZZX6-ZmxkPo14N_D5f9rm=WtR_MkJzgZv_xYMqtcq5xfBHA@mail.gmail.com>
Subject: Re: [PATCH 2/3] add--interactive: add builtin helper for interactive add
To:     "Daniel Ferreira (theiostream)" <bnmvco@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 6, 2017 at 1:13 AM, Daniel Ferreira (theiostream)
<bnmvco@gmail.com> wrote:
> On Fri, May 5, 2017 at 7:30 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>>> +static int git_add_interactive_config(const char *var,
>>
>> Not git_add_interactive__helper_config()? ;-)
>
> I don't get if you mean this ironically (because of the verbosity) or
> if you do think this would be a good name ;P
>
>>> +     for (i = 0; i < q->nr; i++) {
>>> +             struct diff_filepair *p;
>>> +             p = q->queue[i];
>>> +             diff_flush_stat(p, options, &stat);
>>> +     }
>>> +
>>> +     for (i = 0; i < stat.nr; i++) {
>>> +             int file_index = s->file_count;
>>> +             for (j = 0; j < s->file_count; j++) {
>>> +                     if (!strcmp(s->files[j].path, stat.files[i]->name)) {
>>> +                             file_index = j;
>>> +                             break;
>>> +                     }
>>> +             }
>>
>> So basically, this is looking up in a list whether we saw the file in
>> question already, and the reason we have to do that is that we run the
>> entire shebang twice, once with the worktree and once with the index.
>>
>> I wonder whether it would not make sense to switch away s->files from a
>> list to a hashmap.
>> [...]
>> BTW in the first pass, we pretty much know that we only get unique names,
>> so the entire lookup is unnecessary and will just increase the time
>> complexity from O(n) to O(n^2). So let's avoid that.
>>
>> By moving to a hashmap, you can even get the second phase down to an
>> expected O(n).
>
> How would you go about implementing that hashmap (i.e. what should be
> the hash)? Does Git have any interface for it, or is there any example
> I can look after in the codebase?

Git has a hashmap API already. 7d4558c462 is a good example of using it.

>>> +     printf(ADD_INTERACTIVE_HEADER_INDENT);
>>> +     color_fprintf(stdout, header_color, modified_fmt, _("staged"),
>>> +                     _("unstaged"), _("path"));
>>
>> I think these _() need to become N_().
>
> I cannot find any call to N_() outside of Perl code. What should that
> even do differently?

N_() is to mark a string for later translation, not to return it. See
my "how to use getopt" patch for an example of that, but this doesn't
look like such a case, since _() is returning the string to
color_fprintf, surely...

    $ git grep -P '\bN_\(' -- '*.c'

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D597B1F5CB
	for <e@80x24.org>; Mon, 22 Apr 2019 22:27:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729444AbfDVW12 (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Apr 2019 18:27:28 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38274 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727336AbfDVW12 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Apr 2019 18:27:28 -0400
Received: by mail-qk1-f193.google.com with SMTP id g1so7421679qki.5
        for <git@vger.kernel.org>; Mon, 22 Apr 2019 15:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MwtRlnCh0GVjsrTCTf6yGIoTQmXZHPOSUCRPxK4gNp8=;
        b=IXioICEDRX6bHACUdtmhDGM4Cx52swNTqQAYDSbZttc+1gV0JZetmxG5oXyHXbLLs+
         dgReF7E043RjBqc/DsFYChU08gv/piFrZJwKZLi3mPDyo1rpbrDWc+Da/I2mOQXVuHS4
         oYil6zdZugVTNOObDbS2RMpI3uQPiPcSKin7qnHQhuGIg6Bzs/RA1Iun3tgZl1Mb+piN
         rfWMLYgXf/JKnW77FwuLoqOB0/0CvV1VzDFG4VoVg7VYor1WTjhvroor2ClfAQo2Ix2X
         pRLJAgjczE28TYY4MP8TagidW+2D9IbHteekNG5o8dpPdgwQHcZzrIWdPzwi85kfpqNw
         +bqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MwtRlnCh0GVjsrTCTf6yGIoTQmXZHPOSUCRPxK4gNp8=;
        b=OHu0G1sY0wUEu4Y7vqBwCTCXrXqguFrHJ7XAUG6CkAGc/fGTAPeOjNvCbQw30UEdQH
         QmPgatGYUsIBKOeq0BZ6ldKclnF7zJgHxRBg/JCBLOkiah+CAEye15RzRaPuL/vkON6x
         BP3mdl2+Qr3V3aFd8Jj0nAI5AVFs6pli/UBT+JQQzCNQPlcQAE7mzPpKOHEHkcLcpbrH
         f8+2Rv0/XquB+EPeGP1UU0cuCDwcmCs5/kxvdvK1DG0ryIYFgtjc9sRs+UPnG0LEkr/8
         ZzYMyvVpdvjenrK/lVgjTeztMQCpkmoWlArlbMaXcTkYw+UfPF5+CUGRIQBuKxahsIPP
         PLBQ==
X-Gm-Message-State: APjAAAUELb6uKASfzoIVxC3CKZPc39g64ipI9sYh0q/6JsJEjb40YZUe
        R5vBUKLjAyq6uSK1pYCAvrzWdt1QkKD8cPD8i8j+Vnu+nuY=
X-Google-Smtp-Source: APXvYqy5odnm6G13hfB9DJu197TIzVlaeXk6k4XLzV/FrhVv5d457b8rtk+omszprk0NwYzpDrEjjeb0fdOHXqiYJng=
X-Received: by 2002:a37:7b05:: with SMTP id w5mr16044907qkc.354.1555972046928;
 Mon, 22 Apr 2019 15:27:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190419165709.123502-1-emilyshaffer@google.com> <xmqqr29vbpge.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqr29vbpge.fsf@gitster-ct.c.googlers.com>
From:   Emily Shaffer <emilyshaffer@google.com>
Date:   Mon, 22 Apr 2019 15:27:15 -0700
Message-ID: <CAJoAoZn6O5nN-SkTiNNNsGz7CWeWYbY4vmP+2fMpNoCE5CQf+A@mail.gmail.com>
Subject: Re: [PATCH v3] documentation: add lab for first contribution
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 21, 2019 at 3:52 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Emily Shaffer <emilyshaffer@google.com> writes:
>
> > This tutorial covers how to add a new command to Git and, in the
> > process, everything from cloning git/git to getting reviewed on the
> > mailing list. It's meant for new contributors to go through
> > interactively, learning the techniques generally used by the git/git
> > development community.
> >
> > Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> > ---
>
> I think a stray "lab" remains in the title of the patch.  They seem
> to have disappeared from all the other places, and "tutorial" is
> consistently used, which is good.

Thanks, finished.

>
> My eyes have lost freshness on this topic, so my review tonight is
> bound to be (much) less thorough than the previous round.

I appreciate the thorough reviews you gave til now, thanks very much
for all your time.

>
> > +- `Documentation/SubmittingPatches`
> > +- `Documentation/howto/new-command.txt`
>
> Good (relative to the earlier one, these are set in monospace).
>
> > +
> > +== Getting Started
> > +
> > +=== Pull the Git codebase
> > +
> > +Git is mirrored in a number of locations. https://git-scm.com/downloads
>
> Perhaps URLs should also be set in monospace?

This breaks the hyperlink. So I'd rather not?

>
>
> > +NOTE: When you are developing the Git project, it's preferred that you use the
> > +`DEVELOPER flag`; if there's some reason it doesn't work for you, you can turn
>
> I do not think you want to set 'flag' in monospace, too.
> i.e. s| flag`|` flag|;

Thanks, good catch.

> > +     git_config(git_default_config, NULL)
> > +     if (git_config_get_string_const("user.name", &cfg_name) > 0)
> > +     {
> > +             printf(_("No name is found in config\n"));
> > +     }
> > +     else
> > +     {
> > +             printf(_("Your name: %s\n"), cfg_name);
> > +     }
>
> Style.  Opening braces "{" for control structures are never be on
> its own line, and else comes on the same line as closing "}" of if,
> i.e.
>
>         if (...) {
>                 print ...
>         } else {
>                 print ...
>         }

Took this suggestion.

>
> Or just get rid of braces if you are not going to extend one (or
> both) of if/else blocks into multi-statement blocks.
>
> > +----
> > +
> > +`git_config()` will grab the configuration from config files known to Git and
> > +apply standard precedence rules. `git_config_get_string_const()` will look up
> > +a specific key ("user.name") and give you the value. There are a number of
> > +single-key lookup functions like this one; you can see them all (and more info
> > +about how to use `git_config()`) in `Documentation/technical/api-config.txt`.
> > +
> > +You should see that the name printed matches the one you see when you run:
> > +
> > +----
> > +$ git config --get user.name
> > +----
> > +
> > +Great! Now we know how to check for values in the Git config. Let's commit this
> > +too, so we don't lose our progress.
> > +
> > +----
> > +$ git add builtin/psuh.c
> > +$ git commit -sm "psuh: show parameters & config opts"
> > +----
> > +
> > +NOTE: Again, the above is for sake of brevity in this tutorial. In a real change
> > +you should not use `-m` but instead use the editor to write a verbose message.
>
> We never encourge people to write irrelevant things or obvious
> things that do not have to be said.  But a single-liner message
> rarely is sufficient to convey "what motivated the change, and why
> the change is done in the way seen in the patch" in a meaningful
> way.
>
> i.e. s|verbose|meaningful|;

Thanks, done. I'll leave out repeating the lecture here as it was
given in the full sample commit.

>
> > +Create your test script and mark it executable:
> > +
> > +----
> > +$ touch t/t9999-psuh-tutorial.sh
> > +$ chmod +x t/t9999-psuh-tutorial.sh
> > +----
>
> I never "create an empty file" before editing in real life.  Is this
> a common workflow in some circles?
>
> I'd be tempted to suggest s/touch/edit/ here, but I dunno.

Looking back, I'm wondering why I wrote it this way - I think I wanted
to avoid prescribing an editor and also mention the permissions.

I'll try to reword this to mention the executable bit after the
content of the test script.

>
> > +https://public-inbox.org/git/foo.12345.author@example.com/other/junk
> > +----
> > +
> > +Your Message-Id is `foo.12345.author@example.com`. This example will be used
>
> Technically, <foo.12345.author@example.com> with angle bracket is
> the message Id, but the tool is lenient to allow this common mistake
> ;-) so this one, and the "send-email --in-reply-to=" example below
> can stay as-is.

I've since reworded this section to mention reading the Message-Id
from the permalinked email in public-inbox. I think it might be easier
than spying on the URL as the URL is different in some views and
doesn't reflect the Message-Id.

>
> > +below as well; make sure to replace it with the correct Message-Id for your
> > +**previous cover letter** - that is, if you're sending v2, use the Message-Id
> > +from v1; if you're sending v3, use the Message-Id from v2.
> > +
> > +Now send the emails again, paying close attention to which messages you pass in
> > +to the command:
> > +
> > +----
> > +$ git send-email --to=target@example.com
> > +              --in-reply-to=foo.12345.author@example.com
> > +----

Since I made a meaningful change in this section anyways, I've fixed
this to include the angle brackets.

> > +
> > +=== Bonus Chapter: One-Patch Changes
> > +
> > +In some cases, your very small change may consist of only one patch. When that
> > +happens, you only need to send one email. Your commit message should already be
> > +verbose, but if you need to supply even more context, you can do so below the
>
> s|be verbose|explain what and why of the change well| or something
> like that?
>
> > +`---` in your patch. Take the example below, generated with `git format-patch`
> > +on a single commit:

Thanks again. I'll send v4 later today or tomorrow to give more time
for comments if anybody else is planning to look.


-- 
Emily Shaffer

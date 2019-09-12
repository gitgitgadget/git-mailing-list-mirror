Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5DE01F463
	for <e@80x24.org>; Thu, 12 Sep 2019 19:10:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727586AbfILTK1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Sep 2019 15:10:27 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:40306 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727362AbfILTK0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Sep 2019 15:10:26 -0400
Received: by mail-vs1-f68.google.com with SMTP id v10so13715994vsc.7
        for <git@vger.kernel.org>; Thu, 12 Sep 2019 12:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tPH/Qvg5qj0MBub2/GVB/jDQn0xWOVpfQRfk6qBksTw=;
        b=kT8nQKkEubf2JDW7b3yWPR10TDqHih3UyDe29HLxaZU1Aqi7E/O6XlqJgLb16HwRRQ
         eFwJqEaaDxTGnx5/lQ23dy0jsJ3NdJzCjUKbPwWjJHsYvrGazFFoHQXmOCLkgMUg168B
         SLgysr+wMXkA8qfCWtPtCoMKDAbXrhDomIeGj5c/KWMD+oSjc/CRHnUtrPNEEJuUAU61
         w2Rj2eeN9YO5ObvGoHyjB3LN3Ks3hnDox4mAjGAw6wpP2UPMkTnOdT0+IOnU7MyOSRHu
         BQCX4lpkHcfWLgIA0ZYzokENKo/OGf44xNJ53DOQbRQbXpxGfccjIefFUtVyAwR9WEVK
         LHLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tPH/Qvg5qj0MBub2/GVB/jDQn0xWOVpfQRfk6qBksTw=;
        b=JS5R8FbQBph77QoKzirOkLHNlp6JIso67bQ8LJK3gTGXGTwu/HEGSl3sxKRDr4TVfh
         6IJfv1i3/bFnbWzXf8PZrSOIS1EiDfUK6//k8sSAmWOgDW2linJwr7ALJTukB61+6NJy
         nYc78K/GsAeA/JTM2FfpIhsiUUxrFVuWx26kjyVX4mP9mAL+JF4qCagLnqKCKqnZPh9B
         rkaLmxW5cRpx9pIjouJMajXudAMq/+yJYeLuV+5q5hCYPvYIWQlvFxdp8W/L9MwE5KAN
         +K1CoLdo5EM56QbE6e+Yhrm8jdea8W1L/pvGPnujxZOU3MaQtaMjI77mqH0W+UQ2Dttr
         uhDg==
X-Gm-Message-State: APjAAAUhvw1wWJsZaomEb7PHArVVYw8pB4ULwovMCvn4LhvfPPxU5wN5
        tkZifZdMKq6YRJweu2CU+Z0XKHiL5DlqrnjvNzc=
X-Google-Smtp-Source: APXvYqz6IVLczqqoDc2U71dX31qi79nZp5bpJ55H2mVibD3e/TAVZ9W3kG2U5hUtfnf6v+yMxn1NmvXkl/1U7SXi3i8=
X-Received: by 2002:a67:b409:: with SMTP id x9mr24567539vsl.197.1568315425684;
 Thu, 12 Sep 2019 12:10:25 -0700 (PDT)
MIME-Version: 1.0
References: <7da71d89f9fa987eca2e25974e4cec382c146e44.1567627609.git.bert.wesarg@googlemail.com>
 <62ef03a2938ac0d2158b1c3201c7f10e52e30ecb.1567627609.git.bert.wesarg@googlemail.com>
 <20190910202823.hifl7mivwm6yaewy@yadavpratyush.com>
In-Reply-To: <20190910202823.hifl7mivwm6yaewy@yadavpratyush.com>
From:   Bert Wesarg <bert.wesarg@googlemail.com>
Date:   Thu, 12 Sep 2019 21:10:13 +0200
Message-ID: <CAKPyHN16Ogz-MXx-W+LGnaHwOjhyC1awQneozzzt0tDdCszWGw@mail.gmail.com>
Subject: Re: [PATCH 2/2] git-gui: add horizontal scrollbar to commit buffer
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Birger Skogeng Pedersen <birger.sp@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 10, 2019 at 10:28 PM Pratyush Yadav <me@yadavpratyush.com> wrote:
>
> On 04/09/19 10:10PM, Bert Wesarg wrote:
> > While the commit message widget has a configurable fixed width, it
> > nevertheless allows to write commit messages which exceed this limit.
> > Though it does not show this content because there is not scrollbar for
>
> Like we discussed before, it does show the content, you just have to
> scroll by keyboard, and can't scroll by mouse. So maybe reword this?
>
> > this widget. No it is.
>
> I pulled from your GitHub since you seem to have fixed this typo there.
>
> > There seems to be a bug in at least up to Tcl/Tk 8.6.8, which does not
> > update the horizontal scrollbar if one removes the whole content at once.
> >
> > Suggested-by: Birger Skogeng Pedersen <birger.sp@gmail.com>
> > Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
> > ---
> >  git-gui.sh | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/git-gui.sh b/git-gui.sh
> > index a491085..fa9c0d2 100755
> > --- a/git-gui.sh
> > +++ b/git-gui.sh
> > @@ -3363,14 +3363,20 @@ ttext $ui_comm -background white -foreground black \
> >       -relief sunken \
> >       -width $repo_config(gui.commitmsgwidth) -height 9 -wrap none \
> >       -font font_diff \
> > +     -xscrollcommand {.vpane.lower.commarea.buffer.frame.sbx set} \
> >       -yscrollcommand {.vpane.lower.commarea.buffer.frame.sby set}
> > +${NS}::scrollbar .vpane.lower.commarea.buffer.frame.sbx \
> > +     -orient horizontal \
> > +     -command [list $ui_comm xview]
> >  ${NS}::scrollbar .vpane.lower.commarea.buffer.frame.sby \
> > +     -orient vertical \
> >       -command [list $ui_comm yview]
> >
> > +pack .vpane.lower.commarea.buffer.frame.sbx -side bottom -fill x
> >  pack .vpane.lower.commarea.buffer.frame.sby -side right -fill y
> > -pack $ui_comm -side left -fill y
> > +pack $ui_comm -side left -fill both -expand 1
>
> Dropping this change does not seem to make a difference. The commit
> message buffer expands on resize even without it. Can you please explain
> why you did this?
>
> >  pack .vpane.lower.commarea.buffer.header -side top -fill x
> > -pack .vpane.lower.commarea.buffer.frame -side left -fill y
> > +pack .vpane.lower.commarea.buffer.frame -side bottom -fill both -expand 1
>
> I'm not too familiar with pack, but why did you change the side from
> left to bottom? I tested by changing it back to left and didn't notice
> any difference.
>
> >  pack .vpane.lower.commarea.buffer -side left -fill y
> >
> >  # -- Commit Message Buffer Context Menu
>
> Other than these couple of minor things, the patch LGTM. Thanks.

Will re-roll.

Thanks.

>
> --
> Regards,
> Pratyush Yadav

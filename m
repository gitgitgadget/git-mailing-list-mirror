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
	by dcvr.yhbt.net (Postfix) with ESMTP id 39F861F463
	for <e@80x24.org>; Fri, 13 Sep 2019 20:27:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388871AbfIMU13 (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Sep 2019 16:27:29 -0400
Received: from mail-vs1-f42.google.com ([209.85.217.42]:41471 "EHLO
        mail-vs1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388080AbfIMU13 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Sep 2019 16:27:29 -0400
Received: by mail-vs1-f42.google.com with SMTP id g11so19119443vsr.8
        for <git@vger.kernel.org>; Fri, 13 Sep 2019 13:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JK0qhVksAolqgyy3mSS0XHsg0/GhF2U91AAOzjDXXfs=;
        b=FjXdJ6pW0LUHwUSBrdhcyzRpBeQ5quGrXh0WbnQIm10GLnO7po+48xAy6sYGD6eWQF
         aXf99YipC/57h/DhVAfqiZjavknl/yPzZvJ6k+yMWzU7YM1vevpAh3OJpXKISLpYaFPX
         kWbi8k8laD4FRs4SvuS9R70+8xgMfcAui2OpXMiKKbQp5AZIFB3QI4JT3DZ/WtPm2/c1
         BwwXmwIdx6fPBBgoRC/WlUo0wFdPopYIBBxSV1+UZ99IZCF73x6zWMDUQGlsFt1e5eP0
         68VZNFb69Y3x0snW1anEpojxMWvbGw8C2ujabu+c6eSyzHxNtpaca7tLVEqH2sMlBDRL
         9eug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JK0qhVksAolqgyy3mSS0XHsg0/GhF2U91AAOzjDXXfs=;
        b=ANbNAXa667dKLq8wKy8xw3A32GrCWNfrRhH96oK9EtpD51fHqpivVAUpQF+Fc8u//7
         BvD5p/7/KtNCjqVfkltI5Xs7XX8h0iXebA0GTv3tCmxMCH5oy286MQLA6bcgRdEvd9AM
         UT7OF+dcoxAURKlkliQbGkXoegQcvlpX11ns8Yb0aqvwIcHaGzU+IfOYX1FS/wXaov2v
         0vMsKcPI+JXL2veOdP13Pd2wn8nFcR5N2AtuJAORy1BqNYOBrZVtPFXsSkOojhMBqyh5
         OQyCJetUpc1jr+3eYPDHCmh7n4ZVcRKJSDFsMcftHUYGUpnfcNv/HfBsJamlLxc292mq
         yZFQ==
X-Gm-Message-State: APjAAAXft/ZV8bU01ZNBbYVcegNrNX1afufZmU/uP3Ye/Ut/0BYlhg6U
        Lvp4pI1MEELxi4g8vBp/PItAabJ+ryfy3zggckNp83rq
X-Google-Smtp-Source: APXvYqy9EuiVVhFZcgArs1z/7vnKqmy5einnPbKd3+lHFz1ENpZXMYdqtMZsw42UWBKYFe3PHIVVabd9llqyCFGUibA=
X-Received: by 2002:a67:c408:: with SMTP id c8mr2593933vsk.63.1568406447931;
 Fri, 13 Sep 2019 13:27:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAL-6oQorDOzAr4sDoddoAQv3hzAgUMx7K+V=bMcvScv8G=7oqg@mail.gmail.com>
 <20190913143229.5yop5oaascgavynl@yadavpratyush.com>
In-Reply-To: <20190913143229.5yop5oaascgavynl@yadavpratyush.com>
From:   Bert Wesarg <bert.wesarg@googlemail.com>
Date:   Fri, 13 Sep 2019 22:27:16 +0200
Message-ID: <CAKPyHN0=AHzr1V35PDzsq02aeGK1e54CxTeunED_u6GRUygkuA@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_Git_Gui_=2D_enhancement_suggestion_=2D_Can_a_double_?=
        =?UTF-8?Q?click_on_the_file_name_in_the_=E2=80=9Cunstaged=E2=80=9D_area_move_the_i?=
        =?UTF-8?Q?tem_to_=E2=80=9Cstaged_changes=E2=80=9D?=
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     Allan Ford <allan.ford17@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 13, 2019 at 4:32 PM Pratyush Yadav <me@yadavpratyush.com> wrote=
:
>
> On 13/09/19 12:24PM, Allan Ford wrote:
> > Dear Git Authors,
> >
> > Not a bug, but a suggestion consideration for =E2=80=9CGit Gui=E2=80=9D
> >
> > Can a double click on the file name in the =E2=80=9Cunstaged=E2=80=9D a=
rea move the
> > item to =E2=80=9Cstaged changes=E2=80=9D .. (rather than having to clic=
k on the small
> > icon to the left of the file name?)
>
> It has been something on my radar for some time. Shouldn't be something
> too difficult to do.
>
> While I like the idea in general, I have a question that I'd like to ask
> other git-gui users:

I miss a general problem description: Whats wrong with the
single-click on the icon to begin with?

I consider adding a second way as not not acceptable. I also consider
double-click on a file in a GUI an "open" action. But in git-gui, this
"open" action (showing the diff) is already done with a single-click.

From my point of view, it can stay as is.

Best,
Bert

>
> If we implement something like this, what happens when you single-click
> on the icon? Do we treat that as a stage/unstage command? If we keep the
> legacy behaviour of single-click on the icon stages/unstages, then a
> part of the row is single-click and the rest double-click.
>
> If we make an entire row of the stage/unstage widget double click, it
> messes with people who are already used to it.
>
> Is partial single and partial double click behaviour acceptable? Or
> should we make the entire row double click only? Or something else that
> I missed?
>
> --
> Regards,
> Pratyush Yadav

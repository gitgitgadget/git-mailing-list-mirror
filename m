Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF6841F463
	for <e@80x24.org>; Sat, 14 Sep 2019 15:57:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbfINP5o (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Sep 2019 11:57:44 -0400
Received: from mail-io1-f49.google.com ([209.85.166.49]:36173 "EHLO
        mail-io1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbfINP5o (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Sep 2019 11:57:44 -0400
Received: by mail-io1-f49.google.com with SMTP id b136so69375412iof.3
        for <git@vger.kernel.org>; Sat, 14 Sep 2019 08:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=KhflKOQAQzUR81TiPu9q6Jrgl8rUaK7qToNk+p//mng=;
        b=osW//XUiv/fW3trLrr1z+hhB4hwK7ub2++InEcoy/yQ1NK/VGUYflTJ9+ePGFBe1EM
         NMUGaAlFCdd5A9bvKY2zwg2xd2Nsj1103qf7opxJZ/u8CRpKQ/806hbK0a5526XQodDQ
         NVMifPToMT64cU6cz4YWYausX5Ns/KyEzywpJS1LqhskSqqbHlQb8/xbKK3br2EmdZJK
         Um5V4MEyv3c9664vz+7dIF7YaVZO4NiaFtAdJtnarYJuconQkXAwmOJ+PewsHIA2MQsO
         /lWsG1kqAatJdhUXtiuablaYoacojHs0JBpiAiWfJ0OPJ92ZT3k7WmrMM5sExCnsYdkU
         4ZJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=KhflKOQAQzUR81TiPu9q6Jrgl8rUaK7qToNk+p//mng=;
        b=LJA9MOGe4VOcgvWWHcP2EN2DTpeLms0DIorIoXkIJvUU2wf5j7n+BsUi92XcESE2No
         TrIGOjZXJ2irLIQsdLZWhDRVH16kttl+AU1bbu7boQyQ1SmYvmhEZst0ZxjXVpo7V1Yi
         KZ96/7dLZDF7c6zCWUTiofZxOV8VHyBOMzxn85aO7s5Ucy47OsZ08JVJ6kXxr81TvHgM
         +GWFPUrqOm85rzdKPHXUUwMEAtsn5+p7YdC+ArLbH2hU5rQNt+tghrufzwoD9Q5BdkcS
         4Ujdl3VMusXST3prQuSmiMFAU1n0+qMUowrNykVjX/o2uiP+NXuDIlDUjpK/PETLtcyG
         Hb/Q==
X-Gm-Message-State: APjAAAWSzvDYPveNWRGoTZ8Rwxc/qYS57aVLOGC3ZaxGTMsftAaUEANk
        Tczhdj9M9XTRl1PncPH5vIo/gvsPv8YUiIZH+sfVTygf
X-Google-Smtp-Source: APXvYqxZTJrlssuqVdAVD4y1tf6t01+5HXK/Zw1HqH1Yt8DrmNiQQO0TzuR//4/FEyTQ2c4DWyuhG8soN0uEm11j6Ko=
X-Received: by 2002:a5d:9b06:: with SMTP id y6mr6826387ion.77.1568476663164;
 Sat, 14 Sep 2019 08:57:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAL-6oQorDOzAr4sDoddoAQv3hzAgUMx7K+V=bMcvScv8G=7oqg@mail.gmail.com>
 <20190913143229.5yop5oaascgavynl@yadavpratyush.com> <3fac912d-9e3c-bf19-e1e5-2691a835b151@xiplink.com>
In-Reply-To: <3fac912d-9e3c-bf19-e1e5-2691a835b151@xiplink.com>
From:   David <bouncingcats@gmail.com>
Date:   Sun, 15 Sep 2019 01:57:31 +1000
Message-ID: <CAMPXz=pNFpg7B0uYCBWvKwOqG8VZWfOxvf+8mZ9qc7w6DkF=+w@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_Git_Gui_=2D_enhancement_suggestion_=2D_Can_a_double_?=
        =?UTF-8?Q?click_on_the_file_name_in_the_=E2=80=9Cunstaged=E2=80=9D_area_move_the_i?=
        =?UTF-8?Q?tem_to_=E2=80=9Cstaged_changes=E2=80=9D?=
To:     git list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 14 Sep 2019 at 08:07, Marc Branchaud <marcnarc@xiplink.com> wrote:
> On 2019-09-13 10:32 a.m., Pratyush Yadav wrote:
> > On 13/09/19 12:24PM, Allan Ford wrote:

> >> Not a bug, but a suggestion consideration for =E2=80=9CGit Gui=E2=80=
=9D

> >> Can a double click on the file name in the =E2=80=9Cunstaged=E2=80=9D =
area move the
> >> item to =E2=80=9Cstaged changes=E2=80=9D .. (rather than having to cli=
ck on the small
> >> icon to the left of the file name?)

> > It has been something on my radar for some time. Shouldn't be something
> > too difficult to do.

> > While I like the idea in general, I have a question that I'd like to as=
k
> > other git-gui users:

Thank you for asking.

> I've always felt this was a bit of user-experience failure on git-gui's
> part.  Single-click should not behave differently just because you click
> the icon.

> I've seen many new git-gui users find this (mildly) confusing.

I acknowledge that consistency is an important aspect of GUI design.
Particularly for new and/or low-competency users. But surely
efficiency must also be valued too. Repetitive strain injury is not
nice. I have some days where I have hundreds or possibly even
thousands of such single clicksto stage and unstage items. Currently
it is possible to review and accumulate them efficiently due to how
that pane responds.

And this seems a very small aspect to learn. if a person is so
"confused" by such a small thing to learn, I wonder what hope they
would have to comprehend git itself.

> I'd be happy if the click behavior was consistent across the entire
> row: single-click to select,
> double-click to stage/unstage
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Please, no.

I can't say it strongly enough. Please do not change stage/unstage
to require double-click. This would be most unwelcome here, unless it
comes with a configuration option to preserve the old behaviour.

Maybe the actual problem is that the present icon (perhaps surprisingly)
has the behaviour of a blank check-box that relocates. I don't wish for
any change, but if the desire for change is irresistable then the
simplest solution is for the icon (that appears to the left of filenames
in the unstaged pane) to be replaced with blank check box that
behaves exactly as the current icon does. That is:
When clicked, it becomes a checked-box alongside the filename in
the staged area. And if that staged-checked-box is clicked, it reverts to
an unchecked-box (instead of the icon) in the unstaged pane.

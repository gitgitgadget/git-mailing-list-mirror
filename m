Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCBBA208EB
	for <e@80x24.org>; Mon,  6 Aug 2018 15:36:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732866AbeHFRqD (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Aug 2018 13:46:03 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:45918 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729552AbeHFRqC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Aug 2018 13:46:02 -0400
Received: by mail-io0-f193.google.com with SMTP id k16-v6so11347699iom.12
        for <git@vger.kernel.org>; Mon, 06 Aug 2018 08:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eLbSWxw/+OOl8dYtTOAqJ5j9s3Df/UpYdXYsEs0ZwRs=;
        b=OY3MJP7Zgr477WUsz371bb7a27bXZl54/K292r2GoA/jdDmeP/hPZGb9lqc1p6Buzi
         n4hZXjg4ouV8O04vj2+0xrBftcaK+ugARD0glG7lXKPXz+oPtUgoWzEelAfZbQOx2XJD
         aqmVLnf81e6qCetNRVRYMzc28hqvoD99FT2EkqGuslc3q1pquNIh+boMhPwkN5D5AjCp
         hwOYtXH1HOirwmc17hZuLD4ToM0C4DaMACGjbK1yDIeQtG10SePCITQY9qwIkjduAS+z
         jZ2fVsGIpEmGbQrPxuE9hi4qYQO/OO8buHnBU3f5CFn/BGeHabacURmjLisM2TfCn28T
         BwFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eLbSWxw/+OOl8dYtTOAqJ5j9s3Df/UpYdXYsEs0ZwRs=;
        b=VbH8nybDiH3BznyMYB4lHP/MhgyDxZFJ9rQ1Upj3f7CJcc5FhUVGRdxnXB6QIYmNCe
         q7DT/x2wJU5jr2RCBVNEAxW+qPI2fEPuOAf+XUaC4h0bck3zc3XwV4xeRKp9gkVrnLVm
         lkQwkIlMp8nDWVOo/nbHnrg7wGK/S7j/IfvOOYTfiMffMwOfpojp4kkL0w2KX3PdUPZx
         0D4B3rX9C4rwuET2uzFeIHxjkJeBTPN77b6gOqWxGa5pb1ic3DMilDOiiUsJS0gmzHX2
         aumoVs+NuZSg+riqkrgUIPs+wVWR6pgn0JZa1a8/yyy0QN0TfV6yQS92gFcHcwIUcJYD
         5JxQ==
X-Gm-Message-State: AOUpUlFdSk1BiuyqnhkEgxQJhMjqUzi5ZRktaKhqpsZ/AhiKZps3GfQf
        hE27zqSn8ENo1CLTkU2dRrOA3Jbr8SOYHrYfKxE=
X-Google-Smtp-Source: AA+uWPzQKzb8fovCYLbokS5xO5L7UruxwxYttif+O95N5RFqmRkquv+ZmmLyoZe9jeQdkfQc6shaPLgJcn6EuoQvrhM=
X-Received: by 2002:a6b:a2cf:: with SMTP id l198-v6mr14244440ioe.282.1533569783594;
 Mon, 06 Aug 2018 08:36:23 -0700 (PDT)
MIME-Version: 1.0
References: <20180804062500.20188-1-pclouds@gmail.com> <CAGZ79kbS7K0yUak9g5vH5ZyJ2aZ4RBmbBXHVtBzQjfRG4Fx1jg@mail.gmail.com>
In-Reply-To: <CAGZ79kbS7K0yUak9g5vH5ZyJ2aZ4RBmbBXHVtBzQjfRG4Fx1jg@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 6 Aug 2018 17:35:57 +0200
Message-ID: <CACsJy8DE=WCBrHZ-GH1+iCa+yn6QcKYzMmNW29-DwxKNo=go=A@mail.gmail.com>
Subject: Re: [PATCH] config.txt: reorder blame stuff to keep config keys sorted
To:     Stefan Beller <sbeller@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 6, 2018 at 7:59 AM Stefan Beller <sbeller@google.com> wrote:
>
> On Fri, Aug 3, 2018 at 11:25 PM Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy=
 <pclouds@gmail.com> wrote:
> >
> > The color group in config.txt is actually sorted but changes in
> > sb/blame-color broke this. Reorder color.blame.* and move
> > blame.coloring back to the rest of blame.* (and reorder that group too
> > while we're there)
> >
> > Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
.com>
>
> FWIW:
> Acked-by: Stefan Beller <sbeller@google.com>
>
> Are there more hidden sorts in the config.txt that I am not aware of?

I think it's "mostly sorted" now. It's easier to see when you do

    git grep '::$' Documentation/config.txt
--=20
Duy

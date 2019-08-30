Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 746961F461
	for <e@80x24.org>; Fri, 30 Aug 2019 14:09:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727914AbfH3OJb (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Aug 2019 10:09:31 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37117 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727783AbfH3OJb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Aug 2019 10:09:31 -0400
Received: by mail-pf1-f194.google.com with SMTP id y9so4735511pfl.4
        for <git@vger.kernel.org>; Fri, 30 Aug 2019 07:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NtaXbTVjVGLka07Dv0EyjR4F/zb8dpvf9V6J7LSXNhM=;
        b=DypR7MuaPylzkIfF+x5afB9DchWXKKRSqSAsIxnlyQZ+/tjRbsytnJbXm7pp2VbexX
         tTKiesBPNQG0832TVsPoi1G7yrmN9/4I3gGnPPi/uBgLxAUg4dWW5XwqEo2Yt+X1LuPj
         ptiG4GD9iib0uNMglHaowYw47gzhBjFgZYGis/H4l2+PC+Zhi8i7xcHHA1jEFRTLMQp8
         7PFQxWv871cwlJiCKhD5clwMKKGwDRV2cbeCwv4J+qdt8DhlRUNWVIE4d2jq7PwyzrkV
         TJQVtepIVv6C4dM/wusNptCBQBkx+2fNcKFWnM63n+WoRwrQGi8MKIuQEeevpWtn2wW3
         GMeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NtaXbTVjVGLka07Dv0EyjR4F/zb8dpvf9V6J7LSXNhM=;
        b=LdfT0z7hRyP3FtBtkNQSwnXMP+kfGuwUJXIpx/F/gDul0biBF5BBn+b/7m7zZLyIOM
         MeuI0jAFT7VMIiYmCqkJAq5tp5MWT10GXRWazM8/mwr4oGWebSp1q3V7td4CARlST0Q3
         YrJpzwMsjrqM+YaWr7k+RE+ASOSILsgfrSjvqdU5VnJAeOUyqtecKiAagGOgQRn5vHUN
         HY+gzOBbwGbPss0haQLSYvsP7u9/ddNXOvjtp406fLQPQCpGqDd7iLPnybicbfCJ3J9z
         9nEFfm1GCUiOvYgDMSWyrozifNvL86Vus9tF8DJtHN0OUjJudmOkSY2qoWP8S/qP2oUC
         YP3A==
X-Gm-Message-State: APjAAAUewBUKsv9SnjNJ/Z7p5qT84Sp4U5dxi9SRqhhyRlU+BHTlUKJT
        aHT3eGo4UrTBkZ5Gex8ww8KVGPxzMJZmkwe1egQ=
X-Google-Smtp-Source: APXvYqyjK7XQsa6sEVm4R3r09BycSar2GuA+H9zePAnBcV9gJOP5mvuQu7E1x80Kcwrb/0ZLU6h2YAPCUG7pNJk0JcA=
X-Received: by 2002:a63:d741:: with SMTP id w1mr12825555pgi.155.1567174170227;
 Fri, 30 Aug 2019 07:09:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190830134805.9588-1-dturner@twosigma.com>
In-Reply-To: <20190830134805.9588-1-dturner@twosigma.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Fri, 30 Aug 2019 16:09:17 +0200
Message-ID: <CAN0heSouGV+0Z+j_Th794u-RNiLLLNNEpJu__nAH38_q_TSuig@mail.gmail.com>
Subject: Re: [PATCH v2] clarify documentation for remote helpers
To:     David Turner <dturner@twosigma.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 30 Aug 2019 at 16:00, David Turner <dturner@twosigma.com> wrote:
>
> Signed-off-by: David Turner <dturner@twosigma.com>
> ---
>  Documentation/gitremote-helpers.txt | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/gitremote-helpers.txt b/Documentation/gitremote-helpers.txt
> index 43f80c8068..f4a165387f 100644
> --- a/Documentation/gitremote-helpers.txt
> +++ b/Documentation/gitremote-helpers.txt
> @@ -297,9 +297,9 @@ Supported if the helper has the "option" capability.
>         same batch are complete. Only objects which were reported
>         in the output of 'list' with a sha1 may be fetched this way.
>  +
> -Optionally may output a 'lock <file>' line indicating a file under
> -GIT_DIR/objects/pack which is keeping a pack until refs can be
> -suitably updated.
> +Optionally may output a 'lock <file>' line indicating the full path of
> +a file under $GIT_DIR/objects/pack which is keeping a pack until refs

I'd still like to suggest backticks: `$GIT_DIR/objects/pack`

> +can be suitably updated.  The path must end with ".keep".
>  +
>  If option 'check-connectivity' is requested, the helper must output
>  'connectivity-ok' if the clone is self-contained and connected.

Here's how I interpret the motivation behind the patch:

  Reading the text on the optional 'lock <file>' line, it's easy to
  believe that the filename should be given relative to
  $GIT_DIR/objects/pack. Actually, one needs to provide the full path.
  Also, we fail to mention that the filename must end with ".pack".

But I'd have to take your word for these two claims, since I haven't
actually tested or dug myself. ;-)

I do wonder... If we're giving a full path which points outside of
$GIT_DIR/objects/pack, what will happen? Will /mnt/my-packs/foo.pack
work just as fine? If yes, then I don't see a reason to mention
$GIT_DIR/objects/pack at all. If no, it sort of begs the question of why
we don't accept relative filenames. (Or mandate them, but that boat has
obviously sailed.) Either way, I'm wondering if there isn't a bug left
here. What do you think?

Martin

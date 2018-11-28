Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E30F01F609
	for <e@80x24.org>; Wed, 28 Nov 2018 18:13:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbeK2FQN (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Nov 2018 00:16:13 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39389 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbeK2FQM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Nov 2018 00:16:12 -0500
Received: by mail-ed1-f67.google.com with SMTP id b14so22886015edt.6
        for <git@vger.kernel.org>; Wed, 28 Nov 2018 10:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=loskot-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=1eRzifCQVvSuOcJx5E3tYr0MJZ9S1Fp99h+wfxBKUqs=;
        b=lpmRgb0HttNXIsruMqt+2N7wT508GBbQ/8Ugzm5oP1XLSbeC/TWunnxqjeToAv80nl
         75ghAmGgi7RG+mO9ZAuH29dklv/IfDgNRJE93oKpEugkPnwymDQ00eC/KDwu8Lv5R4ba
         4m2zbDz3RWPFohitU8YyeF9A/Rxyr1igXN9mGRGh//5ccueAYz+PPHd6ca+Ct4wYprhg
         AavvUU42I4TzbVAMxga1soC31gJPHkVDL5AIRdmK5v6eMIdiyEFToYIQpFFrZq+ZVRlg
         zFWuHYlkSyhEWIusU1IIvwDJyzzDA7Zi+JgLQGpVB9TgNQRyH7LgGsaY3aSKFshuKZQm
         +BTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=1eRzifCQVvSuOcJx5E3tYr0MJZ9S1Fp99h+wfxBKUqs=;
        b=d7OhT6FAHR/Coy74WCc09QafH/KimhGdB6aTFAibS6VJYTqfqZ4cICgSfdP5RbKWwK
         HP8mh9LWPxmUQHDw7k0g+IuFT4Ulvn1SFoWXXAQWqAaV1ZqSRBynm9jfOWa4nHKP1EiB
         AhWHAxxUN3hZ3SlishUIsQpbozjcnAZgtNuEeYXfvj4IS0o1aWhgBRoUaBdFwcmmqX/s
         Cddq/2HbGzplIv/kz9/6Cz3YYbmhfXqT1gyjg1PyfoXWRaaUrgsdlHeIzFSVPW74JHRG
         QtGMOXVARMnUDJblyZtWRNKe6fn3lORzFJZ1pGX+HT5/oD1yU7yyxf6Q6dTP4stuNT4j
         eCjw==
X-Gm-Message-State: AA+aEWbsdvL5N4IQdIT83bjOuGvAEzrKZTA7TtN30y5cCXLYGiT2UoNt
        syXSrKozaxBbmXzuhsq4RKC9lzlMBlj/FkLjZ4G5oA+ouPhTH5wR
X-Google-Smtp-Source: AFSGD/VxHyFnPZTvOZqVJpkyeM8to6Y3EagP6X/wOb7orlqWm+kbsNOzzwu8E77RI4xypaTlJlk7kjoS8eM9WvxvCKc=
X-Received: by 2002:a17:906:7087:: with SMTP id b7-v6mr8296551ejk.194.1543428820510;
 Wed, 28 Nov 2018 10:13:40 -0800 (PST)
MIME-Version: 1.0
References: <CABUeae-e33Jc4s4MezjhpVsEJ_0sO8QZ1mpa1z_79ZGuQWM-Xw@mail.gmail.com>
In-Reply-To: <CABUeae-e33Jc4s4MezjhpVsEJ_0sO8QZ1mpa1z_79ZGuQWM-Xw@mail.gmail.com>
From:   Mateusz Loskot <mateusz@loskot.net>
Date:   Wed, 28 Nov 2018 19:13:14 +0100
Message-ID: <CABUeae-eOFGxAHWuhP50GE8fAMnDH7rfqSV8MSVZ2ZnYH-2W6Q@mail.gmail.com>
Subject: Re: Simple git push --tags deleted all branches
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 28 Nov 2018 at 17:50, Mateusz Loskot <mateusz@loskot.net> wrote:
>
> (using git version 2.19.2.windows.1)
> [...]
> I restored the repo and tried out
>
> git push origin 1.0
> git push origin --tags
>
> and this time both succeeded, without wiping out any refs.

And, to my surprise, this pushed all branches and all tags:

git push --all origin

So, I  did not have to run follow with tags push only using

git push --tags origin

Has anything changes in [1] that now
--all
Push all branches ...AND tags?

[1] https://git-scm.com/docs/git-push#git-push---all

Best regards,
-- 
Mateusz Loskot, http://mateusz.loskot.net

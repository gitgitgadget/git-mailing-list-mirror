Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F013D2042F
	for <e@80x24.org>; Wed, 16 Nov 2016 15:37:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753157AbcKPPhI (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Nov 2016 10:37:08 -0500
Received: from mail-qk0-f171.google.com ([209.85.220.171]:34426 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752015AbcKPPhH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Nov 2016 10:37:07 -0500
Received: by mail-qk0-f171.google.com with SMTP id q130so179949943qke.1
        for <git@vger.kernel.org>; Wed, 16 Nov 2016 07:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=zHcO1VanHcHZeA660zjW34mG+/m3b00phtFlPY8ZEeo=;
        b=n79J8kxXmNDWtniWuNcGEhjqAzH6KKQK1Ajaty0Kjwu3gkZh7IezF1HSObIRAxlH8R
         AwW+pfRYYl/9J/4gaapjTcVF21S5v1Z855/aFg/t8UGkpnyzMPfb54nwNuyZ9LDDNPxd
         V0q9Ni840z8gTy3pshUk9cBQJq2KMt8MXuJYELUAq7zseVRdhIm3YbagevreCNfKre+3
         g4mGuceOIAy4eSM2lttnu1XFgOi4/YCCySB+uKM9Pp8cKlT1qJonld6WlvhT2TVGGdNu
         AzJup4EIpvB+k8nJIhUbEOrJxhi3zLIMJjMUao8g2NwXyAYMD+aibuEa0NSOAHsop1zW
         vMVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=zHcO1VanHcHZeA660zjW34mG+/m3b00phtFlPY8ZEeo=;
        b=gE1U3d+4QWKyfkIyKp6OjR77uI2uvEXM4O54fWKJXhXzBkdOgd7Cv1yKPwN8jnQ/73
         WEadcZ96zkt4JR+SJ5SjoeFzPpiy3vBc2e3EQqCZWzddnVR6DZhJ0smwFcYBMjcoFCpk
         VRkuxhqfGmGu2sRuw51jDUSjkxuCUuWGZMsOtIgCh/fqxBZOuJnXOHFqUW8W4qTw8eJz
         6dQO69jFrQO2B0YYnVvvw8bhzDYUfX0IXRWWBQ8LZDWpXoOOSZ98uWe3mUlNYYZXR6L3
         eyKZT12BYsKHFNQvUxrNjpEvnmnA/QdDYWPSTc8C6wo8yKzCsyoWalIdrsfaND+G0vPR
         WlRg==
X-Gm-Message-State: AKaTC02CpbVapBi0qxI7QErDja45KOkf7aETRBkI4J2zhVoOVYsaobX83bB12njo4IKPkIYvpeoMeEFtWctdNA==
X-Received: by 10.55.220.69 with SMTP id v66mr3998688qki.264.1479310626965;
 Wed, 16 Nov 2016 07:37:06 -0800 (PST)
MIME-Version: 1.0
Received: by 10.237.45.100 with HTTP; Wed, 16 Nov 2016 07:36:46 -0800 (PST)
In-Reply-To: <2C8817BDA27E034F8E9A669458E375EF2BE63B@APSWP0428.ms.ds.uhc.com>
References: <2C8817BDA27E034F8E9A669458E375EF2BE63B@APSWP0428.ms.ds.uhc.com>
From:   Mike Rappazzo <rappazzo@gmail.com>
Date:   Wed, 16 Nov 2016 10:36:46 -0500
Message-ID: <CANoM8SX91JAvJ6EAE6=wavPutUG4ZU1BY-A=5EobW=8zrdEcjw@mail.gmail.com>
Subject: Re: merge --no-ff is NOT mentioned in help
To:     "Vanderhoof, Tzadik" <tzadik.vanderhoof@optum360.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 16, 2016 at 10:16 AM, Vanderhoof, Tzadik
<tzadik.vanderhoof@optum360.com> wrote:
> When I do: "git merge -h"  to get help, the option "--no-ff" is left out of the list of options.

I am running git version 2.10.0, and running git merge --help contains
these lines:

       --ff
           When the merge resolves as a fast-forward, only update the
branch pointer, without creating a merge commit. This is the default
behavior.

       --no-ff
           Create a merge commit even when the merge resolves as a
fast-forward. This is the default behaviour when merging an annotated
(and possibly signed) tag.

       --ff-only
           Refuse to merge and exit with a non-zero status unless the
current HEAD is already up-to-date or the merge can be resolved as a
fast-forward.

>
> This e-mail, including attachments, may include confidential and/or
> proprietary information, and may be used only by the person or entity
> to which it is addressed. If the reader of this e-mail is not the intended
> recipient or his or her authorized agent, the reader is hereby notified
> that any dissemination, distribution or copying of this e-mail is
> prohibited. If you have received this e-mail in error, please notify the
> sender by replying to this message and delete this e-mail immediately.
>

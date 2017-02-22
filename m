Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E662201B0
	for <e@80x24.org>; Wed, 22 Feb 2017 23:23:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933051AbdBVXX0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Feb 2017 18:23:26 -0500
Received: from mail-qk0-f175.google.com ([209.85.220.175]:32789 "EHLO
        mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932393AbdBVXXZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2017 18:23:25 -0500
Received: by mail-qk0-f175.google.com with SMTP id n127so17790151qkf.0
        for <git@vger.kernel.org>; Wed, 22 Feb 2017 15:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xiYP2Z8XnRrzdz2XAhgS2BRgLkY93FeUA36PTjxYh3A=;
        b=YpwYid6GX0zD8oC6YXQNBWYc/2ZwAeOPl3xpc8EaT7R5+2lrwpUTgXlp7ULn/f5q1O
         D1Z5UWmUKIzTaMOwkxu9EkcixoSPdz3svuQDrTz7WT0aReXZU0q9N0mkrBpzB9c4M78t
         yVpQGQecIKCyKesCyUW5ZCQ8ognr1tbySSr3nv+swOXsYvQ9FuNhJNa7QxlRLnSkJcJC
         S8ZZrWHn4R3dxPoApkRdf89zc4uWs+WI5JOiM9InM5ByBk4Jb0NRAMIuEX+CYJhecbJw
         sffY3oocl+HYE/LpH0z/JuLoslggXgJialLn2EL1cdKQAaEkw+/6WeCyomiQw1lo2vrm
         Lo2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xiYP2Z8XnRrzdz2XAhgS2BRgLkY93FeUA36PTjxYh3A=;
        b=VrKRznLqB1g0zfLDS0kzC4mSGnHVUEv7zcQNVMheC7LO5hlWeqWz3MFkBEMai46Vr4
         u1Y7XBwy55oyWfpF2EBTXER37dSH1cDA04SvgPOGkF6x4VasUd8QRi26PZkKbWuAKtqP
         xFDAlHcIS1OmTNipVSgAzK1GqN0UbrkTs5BQ9G2DQWjFxocxCsNcXDFwMA4C7BJplNhW
         eB7zPjycmVUY8gXG7/fWX3Zurk94yb/0k5aFWmQazAR9YkXR7hocrxHO8D2x9ZTtKCB9
         V6yHpg0F2ysCEsrBoo++nDWGNqmMo/kg9O7i2RORs68lryBU03lLcCGa1rPzxkXaSUUa
         i0/w==
X-Gm-Message-State: AMke39lkXiFeO1x92DRtvjtSEB3Pyzy3eiNQUJEZNz+BU64IgzeLinPJSraQf5C6F/n93kuy9FpJ0r5FdUHuJg==
X-Received: by 10.55.106.134 with SMTP id f128mr305040qkc.16.1487805712569;
 Wed, 22 Feb 2017 15:21:52 -0800 (PST)
MIME-Version: 1.0
Received: by 10.200.0.66 with HTTP; Wed, 22 Feb 2017 15:21:12 -0800 (PST)
In-Reply-To: <CAN0Skmmjd5Y0uWz_WC69mAStucZ6nR0mjdp4-ODJz2UnTaB-eQ@mail.gmail.com>
References: <CAN0Skmmjd5Y0uWz_WC69mAStucZ6nR0mjdp4-ODJz2UnTaB-eQ@mail.gmail.com>
From:   Andrew Ardill <andrew.ardill@gmail.com>
Date:   Thu, 23 Feb 2017 10:21:12 +1100
Message-ID: <CAH5451=AqQ3+sE9P6njXdrFWcgbQoECJX2PXmL1b3xoKX6wv8A@mail.gmail.com>
Subject: Re: feature request: user email config per domain
To:     Tushar Kapila <tgkprog@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23 February 2017 at 00:12, Tushar Kapila <tgkprog@gmail.com> wrote:
> I can set my email via:
> git config --global user.email tgkprog@xyz.dom
>
> this is dangerous when I use this my office or in a multi repository
> provider environment where my email is different for a few (like
> tgkprog@search.com for github and tushar@mycompany.com for my company
> private repo).

There has been a large discussion around this idea before, see this
thread for example [0].

The proposed idea was to have something set in your global config that
would only be turned on if you were within a given directory. This
would allow you to have two root directories, one for your work
projects and one for open source projects (for example) and any git
repositories within those folders would each would have their own
config options automatically applied based on their location.

There was a patch suggested, and it worked quite well, but nothing
further has been done to my knowledge.

[0] http://public-inbox.org/git/7vvc3d1o01.fsf@alter.siamese.dyndns.org/

Regards,

Andrew Ardill

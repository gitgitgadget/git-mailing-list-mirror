Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0418A1F404
	for <e@80x24.org>; Wed, 10 Jan 2018 15:30:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932981AbeAJPaz (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jan 2018 10:30:55 -0500
Received: from mail-vk0-f50.google.com ([209.85.213.50]:35343 "EHLO
        mail-vk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932459AbeAJPax (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jan 2018 10:30:53 -0500
Received: by mail-vk0-f50.google.com with SMTP id o73so11769703vkd.2
        for <git@vger.kernel.org>; Wed, 10 Jan 2018 07:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=NFw54+E9e+Ce+PFUrE55aPJwtiKNugrmIbSV1v2RRLc=;
        b=YZ3zRgMHkVpdnIzIgaAbs3r84zGWefztnbOj2A7u3aXKBuRR0b0AOM/cC8r/23zUBZ
         mx/KmWFCEpvYL6cWTfvttRaXWTVdI6/hjJVJr/tUA2o8ER/X68mPrpZss6bhiY+JwF+T
         3dZ6y1Q8UD4cQvdRH9OGUQjWY0jX7rgvriH9BO07WF2FwSHywMVzaIIri/t6C2BA1mEJ
         Y9x0XDglNJVsrFz8xrdkCE3r7rIZlj8JHjCzTYyuOiQm4BEourT1QvnngOD7J31a4cQ2
         FF8p86MmnynrBvxcZikLKrgHcl5Rxq67/MF58yAhrFmPzHnLYiT+5SqqHHCzUJHzz1qZ
         SUQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=NFw54+E9e+Ce+PFUrE55aPJwtiKNugrmIbSV1v2RRLc=;
        b=E0oisfaKizDh6pkHRgaYf4O+2jLzULntEsgQWi0WxTCoG8QVm931bN0v/mE3c37HOh
         V3tPe8nfYplN4gGBYZNqNJHhu28MjRibPCRr4RZNOsO9269+kl5tkBIWZCkj4Mkwmm5n
         28ea7x28PNO/elaMAL8MZYHhOd+Yc6KpukL5DBr0xfMblWlsHrRiNhidzLO6ZHnq61Zg
         hTQDtIvBBdQ4TqyBhXu4riYzXyGxJuhkJXPMN+M9XPZqOq6ckJadK6ef0TOyk0cut2xg
         5Td00mWDB3JOwjNx4cv5F4NN7IpFNDXQ2kjBxivmGijtd91ckEZ+GFyn0OgupO1g7oDi
         yvAg==
X-Gm-Message-State: AKwxytcgXofWWNivHRo53wzLHuUr32NbsSieMT5vS/SqSVl5bGH93odi
        S+xOzuCrhvYcKLHq3hycs9OJFEYFPPHw7uevZ+uWwa4B
X-Google-Smtp-Source: ACJfBovmJKnPvYwNPaT+Cx0IAQNiL3J7+STGlR+/gNPOOuhOIQ4HXhZatAxL9l1rUIj7jOt1hQIqpkmAqZAKzkNSPjg=
X-Received: by 10.31.221.66 with SMTP id u63mr15420409vkg.80.1515598253024;
 Wed, 10 Jan 2018 07:30:53 -0800 (PST)
MIME-Version: 1.0
Received: by 10.103.142.195 with HTTP; Wed, 10 Jan 2018 07:30:52 -0800 (PST)
In-Reply-To: <CALKyTE7+qJSYHQRB44HjHXK_EjOxNnCfQOROSDVVwAFR-gMnXQ@mail.gmail.com>
References: <CALKyTE7+qJSYHQRB44HjHXK_EjOxNnCfQOROSDVVwAFR-gMnXQ@mail.gmail.com>
From:   Sam Millman <sam.millman@gmail.com>
Date:   Wed, 10 Jan 2018 15:30:52 +0000
Message-ID: <CALKyTE7VpeCoofzzutdEmsjtGe7NaC3EywQWJvM0EOH3U6XvoA@mail.gmail.com>
Subject: Re: How to use multiple SSH keys on Git exe (not bash)
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I am trying, for the sake of PhpStorm, to get multiple SSH keys
working using git . exe, which means no GitBash.

I can get the keys to work just fine with GitBash.

I edited my .ssh/config to look like (I know this is incorrect):

Host bitucket . org
IdentityFile ~/.ssh/id_rsa1

Host bitbucket . org
IdentityFile ~/.ssh/id_rsa


And id_rsa1 works, I can actually pick from the other repo. But, of
course, id_rsa does not now.

I change to:

Host bitucket . org-dd
HostName bitbucket . org
IdentityFile ~/.ssh/id_rsa1

Host bitbucket . org-sas
HostName bitbucket . org
IdentityFile ~/.ssh/id_rsa

And now only id_rsa works.

I also tried combining the two IdentityFile lines together like so
(for some reason):

Host bitucket . org
IdentityFile ~/.ssh/id_rsa1
IdentityFile ~/.ssh/id_rsa

I have even tried running ssh-agent . exe, adding id_rsa1 to that and
then running the git clone with no result.

The weird thing is, I have two public keys as well and they both load
in the ssh . exe (they return errors about format), I just cannot get
my ssh . exe to work with multiple private keys.

On 10 January 2018 at 15:29, Sam Millman <sam.millman@gmail.com> wrote:
> I am trying, for the sake of PhpStorm, to get multiple SSH keys working
> using git . exe, which means no GitBash.
>
> I can get the keys to work just fine with GitBash.
>
> I edited my .ssh/config to look like (I know this is incorrect):
>
> Host bitucket . org
> IdentityFile ~/.ssh/id_rsa1
>
> Host bitbucket . org
> IdentityFile ~/.ssh/id_rsa
>
>
> And id_rsa1 works, I can actually pick from the other repo. But, of course,
> id_rsa does not now.
>
> I change to:
>
> Host bitucket . org-dd
> HostName bitbucket . org
> IdentityFile ~/.ssh/id_rsa1
>
> Host bitbucket . org-sas
> HostName bitbucket . org
> IdentityFile ~/.ssh/id_rsa
>
> And now only id_rsa works.
>
> I also tried combining the two IdentityFile lines together like so (for some
> reason):
>
> Host bitucket . org
> IdentityFile ~/.ssh/id_rsa1
> IdentityFile ~/.ssh/id_rsa
>
> I have even tried running ssh-agent . exe, adding id_rsa1 to that and then
> running the git clone with no result.
>
> The weird thing is, I have two public keys as well and they both load in the
> ssh . exe (they return errors about format), I just cannot get my ssh . exe
> to work with multiple private keys.
>
> Has anyone got any ideas on how to solve this?

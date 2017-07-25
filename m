Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A41CC20899
	for <e@80x24.org>; Tue, 25 Jul 2017 05:42:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750811AbdGYFmr (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jul 2017 01:42:47 -0400
Received: from mail-io0-f182.google.com ([209.85.223.182]:34819 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750723AbdGYFmq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2017 01:42:46 -0400
Received: by mail-io0-f182.google.com with SMTP id m88so42637109iod.2
        for <git@vger.kernel.org>; Mon, 24 Jul 2017 22:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ENeSSmGDdzzuzJdaCBMRQoZoj/zhrFGojYg0IpirpSc=;
        b=An2pv0lVS69Qt1DvD5dTs2ZatRbVcJ363FxLuweBTWEbvSGmOkbZTYeKiVbTIU4Xo0
         +XpgceVGMHAlZhguy2lLOckvqK/u1kIWabmxsjPKm+m9VVan/rbzfCOGzs44hzi6ZBkO
         4VRm+4Mfepw10PbiqjXy7hQ5Gb3aS05oenrTbde3Y8n+Qs4YmDFgcQJzhhSbgglDSumV
         BlxiNTcnXxgyU4vsstZhvt+oQlYGFzpQJLkLEEznOXNcrDDm2H39ZYhfDbc0pwZsaAa3
         Rwc2rLJDCDmw3uUjNLmYrB4fpyUGBSHR2Oj7fhgmh7bNrWG9zJlw1yPIfi/riNcLzKFy
         i6vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ENeSSmGDdzzuzJdaCBMRQoZoj/zhrFGojYg0IpirpSc=;
        b=gBlWAeRqwyFy3ztg+rjtARvSWjb+xvpxFd1XR0mRr34ZroCR8Eehizj2cLqQqipWNU
         Y3V/accWGj+i3c1HgepzBVqtVq5dv1K4zp3xVpo+zKqlzMETqAm6wYA0C5+Sfu3AxEjD
         zfIRt/V0tLe+3FFdfeqG2kzPEJfnoPHDvdW+qpOtqtCQKm/RrSfSQbOVfd1cropEiIoW
         vbgmcKC5Np7djiRK5e3wbseFYhU3Wx6fbE23B7ATBNxcqbJahlP0zB4Ani9tfCTFjDSR
         ksDGECabOJ7IPIvxRE2csZ2fgdBXZ/kw7xeQivfHHEDP6p6g00BjioeTWdMOYjAoDJc3
         zbMQ==
X-Gm-Message-State: AIVw111am8EKmJOI8wC3jkkwaYFVEkJUjrS9cNJoxSXk4hLPuwHTmoim
        xqWvd+EifL2tW34vwjSQCq+TTKXjpA==
X-Received: by 10.107.19.133 with SMTP id 5mr17266228iot.312.1500961366043;
 Mon, 24 Jul 2017 22:42:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.47.106 with HTTP; Mon, 24 Jul 2017 22:42:45 -0700 (PDT)
In-Reply-To: <CAHv71zK5SqbwrBFX=a8-DY9H3KT4FEyMgv__p2gZzNr0WUAPUw@mail.gmail.com>
References: <CAHv71zK5SqbwrBFX=a8-DY9H3KT4FEyMgv__p2gZzNr0WUAPUw@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 25 Jul 2017 07:42:45 +0200
Message-ID: <CAP8UFD0KoamG88x-vWXPWT-pv8=f-v+fxOKH1=B9NrZrZhTm=g@mail.gmail.com>
Subject: Re: Request for git merge --signoff
To:     Dan Kohn <dan@linuxfoundation.org>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 1, 2017 at 5:24 PM, Dan Kohn <dan@linuxfoundation.org> wrote:
> https://github.com/coreinfrastructure/best-practices-badge is a user
> of the https://github.com/probot/dco bot which checks that commits
> have a signoff. The issue is that there is no `--signoff` option in
> git for merge commits, which is a standard part of our workflow with
> feature branches. Here is a workflow where we currently get stuck:

[...]

> Or, I could manually add the Signoff line to the proposed git merge
> commit message, which would allow me to skip the `--amend` step.

Perhaps you could use a prepare-commit-msg hook (or maybe a commit-msg
hook) to automatically add your Signoff line to any commit message if
it isn't there already.

In the prepare-commit-msg hook sample there is already commented out
code to do that:

https://github.com/git/git/blob/master/templates/hooks--prepare-commit-msg.sample#L35-L36

Alternatively you might want to use `git interpret-trailers` to do
that or more fancy trailer related things.

> Could you please add a `--signoff` option to `git merge`?

I am not opposed to add a `--signoff` option to `git merge`, but I
think the main plan to improve git in this area has been to first make
it possible for git commands that can create commits to accept options
like "--trailer 'Signed-off-by: Alice <alice@example.com>'" and to
pass them to `git interpret-trailers` (or its underlying code).

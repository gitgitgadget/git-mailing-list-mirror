Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90A011F453
	for <e@80x24.org>; Wed,  3 Oct 2018 16:04:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbeJCWxK (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Oct 2018 18:53:10 -0400
Received: from mail-it1-f181.google.com ([209.85.166.181]:55656 "EHLO
        mail-it1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbeJCWxJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Oct 2018 18:53:09 -0400
Received: by mail-it1-f181.google.com with SMTP id c23-v6so9023447itd.5
        for <git@vger.kernel.org>; Wed, 03 Oct 2018 09:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s5DPh8Qr6p10h2dmXfdVqF5N2FkDp3tWwiVa8YEWyCE=;
        b=m7Ex4jtvE4CHfEwnSaRRQexkoGLsMsiKj0XPJq1gS3PTXKuWLH2BntA2r3iso98Sbx
         KN/siVfiJhOhQOMxBzaOeqJG1E+ojpn3jkyrLQR+rA4gA0XmQGsVX2BVtFBsfTN5PSvM
         4XVBhdW6hYGVg6GPRH8cviseolzwfzMDEu0MBPDLw5wmHRranTC5M5RmOpGGvokqwDFR
         9l6Y76m0NX8/yxO5E6Wzt68S4VX3+SobXkrmM8QZXxDSByuXGwQpWOqnfYVyXKQfEn+H
         B/5opZlcQDK7brzE8OBltEphl0ggDGl2DuvOCUxAOY240q0xQhAB8sGcGLBU2qMXPqta
         CyfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s5DPh8Qr6p10h2dmXfdVqF5N2FkDp3tWwiVa8YEWyCE=;
        b=r7B+BkIHpchaFzxx+J14T7D10jo0qn5x599alAAgM1p9b53zDp70AaupcemRJoZ0uA
         xaJChVcqij1NtD7rBxLJg9FrQkrSpkFIAeCXwMw/2dvf/4GK7WkaE2ur5LAp8BWmEY41
         JQBa6I+4+pj2TmoGP5ObuTDtjQKYITu8Fy8K56wRrAps7jTZZUG65LjlCaf6TtToPNZ7
         lghy/M2KpMjGbS8iYLEla/rpcTm3Bl3nRaPSsqNlqXdyH5JaVfLjiXI3SQB6vvSRsfGb
         5qDRb4NnFi7ddPIihVbd22GdLzkbChWyIgQvPUY9lE8bFL85EtfBWSh3Q5SEO7shQao7
         gjcQ==
X-Gm-Message-State: ABuFfoiQqBDbu+10I56qc1KUgizgHqpvd2NLHz3b3QMu7LPN1S8ASU19
        /JcgjoLTZIKJbvI1DPCRVJY0aEUAeABf1ueL/98WIa/8
X-Google-Smtp-Source: ACcGV60tnhXKm7sGfMIj8B5ZKM6XnsoWuwvKUklyj7eNjyaoBWDBK+oFNI5rs7xo1UvBRZUFwQQcyjQXEhtgywDgC4k=
X-Received: by 2002:a24:45cf:: with SMTP id c76-v6mr1856935itd.112.1538582648634;
 Wed, 03 Oct 2018 09:04:08 -0700 (PDT)
MIME-Version: 1.0
References: <a1ceb967-6020-6074-f504-c684242c79ab@gmail.com> <f4f7bd2c-4c48-e749-4df1-ddf05896b337@gmail.com>
In-Reply-To: <f4f7bd2c-4c48-e749-4df1-ddf05896b337@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 3 Oct 2018 18:03:56 +0200
Message-ID: <CAP8UFD3LEYd7RytZU_-wVcDosH+6VSdM2j3NUcnR0aQc8QfoQg@mail.gmail.com>
Subject: Re: Git credentials not working
To:     d.kopriwa@gmail.com
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(removing git-security from CC)

On Wed, Oct 3, 2018 at 4:09 PM Dimitri Kopriwa <d.kopriwa@gmail.com> wrote:

> Git credentials in ~/.git-credentials and ~/.config/git/credentials are
> being removed by git upon reading.

https://git-scm.com/docs/git-credential says:

"If the action is reject, git-credential will send the description to
any configured credential helpers, which may erase any stored
credential matching the description."

So maybe this is expected.

Another possibility is that your .gitlab-ci.yml might launch scripts
writing into those files, like the before_script.sh script that is
described on:

https://stackoverflow.com/questions/50553049/is-it-possible-to-do-a-git-push-within-a-gitlab-ci-without-ssh

Could you also check which credential helper and which options are
used? For example with commands like:

$ git config -l --show-origin | grep -i cred
$ git config -l --show-origin | grep -i http
$ git config -l --show-origin | grep -i askpass
$ env | grep -i askpass

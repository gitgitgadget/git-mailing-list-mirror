Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D58B1F42D
	for <e@80x24.org>; Sat,  2 Jun 2018 12:28:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751037AbeFBM2t (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Jun 2018 08:28:49 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:40475 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750892AbeFBM2s (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Jun 2018 08:28:48 -0400
Received: by mail-ua0-f195.google.com with SMTP id g9-v6so19144945uak.7
        for <git@vger.kernel.org>; Sat, 02 Jun 2018 05:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2LH6fpHTBSZifMIxR6lsEHsU1IO7ab8BHaVnNl7Z9Q8=;
        b=oOalCiA7th9xfFn/eKryGxa0CEXnd6HMiRQPbBWnPN5PaUBhUMFdMQIOTQUnYJ/nlA
         9/M4ynma9EORQ8TcrDCXc4WtOCEa4Temktu6GkIw5XLms+ai6U2D7KR7BE0c0e54mJ0A
         wNkfxpf7++V1URez3K6YXHRsJMfarrHseBYc+Q3VluLdieIbbn8RDMfWrfT2NaXw3TMF
         Z7h16e699+n+bCExHOGPijbtRdxa0PxwuVb902KhDduanHRWfNE5VQq0MRG3VCkznjWr
         +pfPRgYX/b05qKbrhH2RbkxrubVsIQJeT7Y9Xwa30XZC9QjkWOpZjamPy5z90oESTKcy
         CGBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2LH6fpHTBSZifMIxR6lsEHsU1IO7ab8BHaVnNl7Z9Q8=;
        b=NDo1OiZ3fyESiqcOELPuOEDvQ4TwdPsAsz6AUyySDW0RpKUZGgZ+EGTLjWOtY3ydkw
         JIFSuyfqZrsTgpqFNBJfSzzU4RfWfDxESCBYKu2f8lk1tjIW9p5l+OZnGolVZAI4EZpn
         4CgRF67MS5EhCiNCtJJFABIEuw9myiwL6F5REoO3LWX2da8yU57KsrjgniQW4TsLdDGF
         sUE009YjLPsu18D6eEyJlQ79dP/w+it9tkXQ6H7ykP/PALZAgtAbaZp/jkA6VBovDEIs
         ctc/lUlsRm33lEelrk1BjjkUk9WlWqpzVn6XL0le9wM06HGG7vVj2UdMMIZ6hpeJiCrH
         sgVg==
X-Gm-Message-State: ALKqPwcSH+JPFNu4TuPomtDnWnNWTbEreX9R9+IV+G5LoYeCpKN9rbNb
        nMz2uDAIBDFOqDsD1E1FILj7ndGfOVw8COiggtA=
X-Google-Smtp-Source: ADUXVKKuy6w0IyRbJ7GhfPk+dubMFvue2yAJTU4pkaJ3IRkic7abNKGf3e6yY1A2AOsE4IIlhgEc0LQkDnOpp23MMRs=
X-Received: by 2002:ab0:5b56:: with SMTP id v22-v6mr10111687uae.31.1527942527482;
 Sat, 02 Jun 2018 05:28:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:16d4:0:0:0:0:0 with HTTP; Sat, 2 Jun 2018 05:28:46 -0700 (PDT)
In-Reply-To: <20180601050833.27676-1-chriscool@tuxfamily.org>
References: <20180601050833.27676-1-chriscool@tuxfamily.org>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Sat, 2 Jun 2018 14:28:46 +0200
Message-ID: <CAM0VKj=YgNAb_-BfhBJNjYScfUCnU9Vp_Upy7jtyBisYXzg8Ng@mail.gmail.com>
Subject: Re: [PATCH] t9104: kosherly remove remote refs
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@dwim.me>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        David Turner <novalis@novalis.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 1, 2018 at 7:08 AM, Christian Couder
<christian.couder@gmail.com> wrote:
>  test_expect_success "multi-fetch works off a 'clean' repository" '
> -       rm -rf "$GIT_DIR/svn" "$GIT_DIR/refs/remotes" &&
> +       rm -rf "$GIT_DIR/svn" &&
> +       git for-each-ref --format="option no-deref%0adelete %(refname)" refs/remotes |
> +       git update-ref --stdin &&

Is that "option no-deref" really necessary when deleting refs?  Does
it have any effect at all?

The synopsis in 'git update-ref's manpage indicates that '--no-deref'
is only applicable when updating a ref, but not when deleting one;
though the usage shown by 'git update-ref -h' doesn't indicate this.
Anyway, it appears that when deleting refs no symref dereferencing is
performed and '--no-deref' is simply ignored:

  $ git branch one
  $ git branch two
  $ git symbolic-ref ONE refs/heads/one
  $ git symbolic-ref TWO refs/heads/two
  $ cat .git/{ONE,TWO}
  ref: refs/heads/one
  ref: refs/heads/two
  $ git update-ref -d ONE
  $ git update-ref --no-deref -d TWO
  $ cat .git/{ONE,TWO}
  cat: .git/ONE: No such file or directory
  cat: .git/TWO: No such file or directory
  $ git for-each-ref
  95c5b8654fd75df13ed29f43cff52287414c3877 commit       refs/heads/master
  95c5b8654fd75df13ed29f43cff52287414c3877 commit       refs/heads/one
  95c5b8654fd75df13ed29f43cff52287414c3877 commit       refs/heads/two

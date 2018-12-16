Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA9171F405
	for <e@80x24.org>; Sun, 16 Dec 2018 00:21:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729638AbeLPAVn (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Dec 2018 19:21:43 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52409 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727227AbeLPAVn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Dec 2018 19:21:43 -0500
Received: by mail-wm1-f68.google.com with SMTP id m1so9002576wml.2
        for <git@vger.kernel.org>; Sat, 15 Dec 2018 16:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+EDyjIHG4dtWcfCGqpKvAJGq6PBGQT0mde1Bzj2QgkM=;
        b=IeNhS4Kihz+lMfYTunAcpS6HfDPT8k+Iv9HNiUM5Cz/BN9r7dUsAnQyc2xaqdilrOA
         Cd/7R4GP+nPjndow3JCVbtF8JgLIi1EjptDnZyA7reuJgOfd9e5tPlJvtttKSMR9OKod
         LQuGzLRjfFgS8tekalBLpBBCrZcMN848lgUi73vARDD7Edv62eX4iTgPXQd9jIsE4cLC
         CXZZqB45ny1vWk6CCrRf4B6RDqV6wpXvnHjdJWKw5N19ESi+w57qrANdPpOFDevh5cuF
         L5Xn/KeSmZX7UjK/FSPoJtkQjlVaviqw4AtGYeyzJIZFgve8mhvdV9Ts4z+pyd/WhVrR
         VwrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+EDyjIHG4dtWcfCGqpKvAJGq6PBGQT0mde1Bzj2QgkM=;
        b=HrkUc/6C1xmsYQvqNJQDBJRZqrAbpW5IxNcOR1GaoFTTA8nxZp9EwK9ExbOJXuWrPy
         /wI+OHABsV6K7TWrCruZq9LprSLJfMzm6rXG0PEEX2zp5WIgAA05lZs1ocFZmb4MNPiW
         iU7Gq2ZNIL4VzaXIJXohmS5speLzE1qOJ7yPU0w0X0OJT//vbqQq0nm9FjYgtO2kDAH3
         73NNXmmG2rQhqNvyRZp5OXRUQduAFYhMgi1qzMi8JlVf4vsG3KMFYwiTaLLKZGSQ2+lC
         9S8YYWtX9WXf+IhrYZoK65pcbTSqPjOiRpj0+m7PDu8Cfy+Jvq2qZVRFwa5BFUjTDtiA
         /e+w==
X-Gm-Message-State: AA+aEWY6RHN0tWBqFuphgJDhGYR3MlQGOLzVWKQQDPJuBE3ld3airRo8
        RxhZk9vsIbACKh1y79PVfZy7Ap4y3NNId6RxcVjsOw==
X-Google-Smtp-Source: AFSGD/UWzn7s5jmzloBkOQ/F3W51gv6lgudOa/po75tjEsN0kFbrKhqTYDEN+1YNimRfSog9GQPEFb3V1UVOov/jy80=
X-Received: by 2002:a1c:c87:: with SMTP id 129mr6893011wmm.116.1544919701314;
 Sat, 15 Dec 2018 16:21:41 -0800 (PST)
MIME-Version: 1.0
References: <20181214212504.3164-1-asottile@umich.edu> <bfe22381-864a-4a6b-8dd9-78e268e52c36@iee.org>
In-Reply-To: <bfe22381-864a-4a6b-8dd9-78e268e52c36@iee.org>
From:   Anthony Sottile <asottile@umich.edu>
Date:   Sat, 15 Dec 2018 16:21:34 -0800
Message-ID: <CA+dzEBnDGt-yUtExX+ExNPbDeNTuJ+G1D62uwmfOA6MOic0NHw@mail.gmail.com>
Subject: Re: [PATCH] doc: improve grammar in git-update-index
To:     philipoakley@iee.org
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 15, 2018 at 9:18 AM Philip Oakley <philipoakley@iee.org> wrote:
>
> On 14/12/2018 21:25, Anthony Sottile wrote:
> > Signed-off-by: Anthony Sottile <asottile@umich.edu>
> > ---
> >   Documentation/git-update-index.txt | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
> > index 1c4d146a4..9c03ca167 100644
> > --- a/Documentation/git-update-index.txt
> > +++ b/Documentation/git-update-index.txt
> > @@ -326,7 +326,7 @@ inefficient `lstat(2)`.  If your filesystem is one of them, you
> >   can set "assume unchanged" bit to paths you have not changed to
> >   cause Git not to do this check.  Note that setting this bit on a
> >   path does not mean Git will check the contents of the file to
> > -see if it has changed -- it makes Git to omit any checking and
> > +see if it has changed -- it means Git will skip any checking and
> >   assume it has *not* changed.  When you make changes to working
> >   tree files, you have to explicitly tell Git about it by dropping
> >   "assume unchanged" bit, either before or after you modify them.
>
> Doesn't this also need the caveat that it is _a promise by the user_
> that they will not change the file, such that Git doesn't need to keep
> checking, and that occasionally Git will check, or may perform
> unexpected actions if the user has the wrong mental model.
>
> --
>
> Philip
>
>

yep, the rest of the documentation in this file explains that in
detail -- I'm just fixing up a sentence that doesn't read well :)

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D6EBA1F453
	for <e@80x24.org>; Wed,  3 Oct 2018 20:04:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbeJDCxy (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Oct 2018 22:53:54 -0400
Received: from mail-io1-f53.google.com ([209.85.166.53]:36928 "EHLO
        mail-io1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726950AbeJDCxy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Oct 2018 22:53:54 -0400
Received: by mail-io1-f53.google.com with SMTP id m16-v6so1877721ioj.4
        for <git@vger.kernel.org>; Wed, 03 Oct 2018 13:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2JVdMuPZMUHHxrpWpZctRkBaWmbESk47ZXQWGZrIIPc=;
        b=KROMlVhjfdieXv8af+EMcyQExzTBwuG079NA1kRFaxna/huPbqRWQ6XjoeTIS0VP3h
         +LEQlbnRlIcZABMqgXXevCSr46HiMISmFMsrMbhEVBzXLzaFAFSm6LQypfQ27pF2KQGo
         qe47iVloVqt+JXACXmkwishM6GX9u/JreOCaaVwxHqcmOeTtu09CspE58WF+YGZ0CqHJ
         6/CwOXuCok/dTwtHuFyUlFWJFU86ELsh/nRLxpStcOazb6dw3DfIjlh1hnAGGthwx3x2
         sDU0jIUUjSrv771PXh1QNbregQmB57rp8sGGUas0K8ED6QS0xnmMmKonyvI/0waPolRv
         jVCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2JVdMuPZMUHHxrpWpZctRkBaWmbESk47ZXQWGZrIIPc=;
        b=ZFOUBLG/+EN2nVkT5TaAuk3fWciSvyavMs2gMxVAfac4PS0/o9MFEf9+BxjD04P9xq
         6P158VQdNheYiC5ZjEArtg0NOcY6BuIM5+F1ZwI/pIhnAyQ+ldka8GEW1fZmwulL8wNv
         YdHt7q8/ibRjvbC+TSEL2FkdyrW3KCKQ39xNVdMWmXB+N0pWUmGATO/AzCk0vAMXY4Op
         zBBzfnjrb2byaQaQij5WDUoVK4gls17C7EJ7hO92BWco3jTt3Sl2OTos0kXSHC6LIOxQ
         FumFpOn9m32aHzWCVE0TYxpZv2KrcJ5baBkaYKiAZ4snipymOdiszmt3RSp1O39ZSIrs
         zHsA==
X-Gm-Message-State: ABuFfojBHMc0CPdSKqYoixQKU0iGMK+eYtD6s3p7kptR64vMBySNfrFJ
        Qoz6YPzpYInYQ4jEnDkyzvg1y0A02HkMeoKQd11qPQ==
X-Google-Smtp-Source: ACcGV62wYmgrxZr3QwIYGVX3hVFacgFNsAE7KU1iiQxtBgrRt3loTM8APFKNwhSycKxOyvIbi+FtWw1EBQB1Uc15tGA=
X-Received: by 2002:a6b:f304:: with SMTP id m4-v6mr2223959ioh.253.1538597041822;
 Wed, 03 Oct 2018 13:04:01 -0700 (PDT)
MIME-Version: 1.0
References: <a1ceb967-6020-6074-f504-c684242c79ab@gmail.com>
 <f4f7bd2c-4c48-e749-4df1-ddf05896b337@gmail.com> <20181003171104.GA12200@sigill.intra.peff.net>
 <89f60502-c67d-83b6-593b-a0e6d8567183@gmail.com> <20181003182409.GA14848@sigill.intra.peff.net>
 <84e704e0-fbf9-230f-459c-2927dea19a03@gmail.com>
In-Reply-To: <84e704e0-fbf9-230f-459c-2927dea19a03@gmail.com>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Wed, 3 Oct 2018 13:03:50 -0700
Message-ID: <CAGyf7-EL3Ch8iGZ0m4J9OJfQXs0DRxL9Du2UE2C-g9ECx0L10Q@mail.gmail.com>
Subject: Re: Fwd: Git credentials not working
To:     d.kopriwa@gmail.com
Cc:     Jeff King <peff@peff.net>, Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 3, 2018 at 12:34 PM Dimitri Kopriwa <d.kopriwa@gmail.com> wrote:
>
> I have replaced the way I fill the git credentials store, I have verify
> ~/.git-credentials and information are there, the ~/.gitconfig look fine
> too.
>
> I still have 401 error when reading from that file.
>
> This is the paste log : https://paste.gnome.org/pmntlkdw0
>
> Now that I use git approve, I dont think that I need a custom helper.
>
> Any idea why I still can't log in using git-credential?

I'm pretty sure Peff touched on this in his reply. When it works,
you're either sending a "Private-Token" header or including it in the
URL, but, as Peff said, Git will never do either of those things. It
sends an "Authorization" header, and, based on their documentation, it
doesn't appear Gitlab accepts access tokens in that header.

It looks like you're either going to need to include it in the URL
(like what happens earlier in the posted trace), or adjust your git
config with a "http.extraHeader" set to "Private-Token: <token>" to
include the "Private-Token" header (or you could pass it on the
command line, like `git -c http.extraHeader="Private-Token: <token>"
clone ...`.

Hope this helps!
Bryan

>
> Thanks in advance,
>
> On 10/4/18 1:24 AM, Jeff King wrote:
> > On Thu, Oct 04, 2018 at 01:12:11AM +0700, Dimitri Kopriwa wrote:
> >
> >> Thanks for your reply. I have activated GIT_TRACE_CURL=1 and I can see that
> >> the request is failing 401.
> >>
> >> I can't see which token is used and using what header ?
> >>
> >> The log say:
> >>
> >> 17:50:26.414654 http.c:657              => Send header: Authorization: Basic <redacted>
> > Yeah, we redact the auth information so people don't accidentally share
> > it publicly. If you use the older GIT_CURL_VERBOSE=1, it will include
> > the credential (I think it may be base64 encoded, though, so you'll have
> > to decipher it).
> >
> >> I have retested the token locally and it work when used in the url or using
> >> `Private-Token: <token>` as stated in the Gitlab documentation
> >> https://docs.gitlab.com/ee/api/README.html#personal-access-tokens
> > I don't think Git will ever send your token in either of those ways. It
> > will always some as an Authorization header.
> >
> >> Peff, what would be the appropriate way to input my git credential in a 100%
> >> success way in a CI?
> > I don't know the details of what GitLab would want, but...
> >
> >> Is this good:
> >>
> >> git credential approve <<EOF
> >> protocol=https
> >> host=example.com
> >> username=bob
> >> password=secr3t
> >> OEF
> > Yes, that would work to preload a token into any configured helpers.
> >
> > -Peff

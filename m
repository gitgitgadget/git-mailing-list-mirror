Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8797E1F6BF
	for <e@80x24.org>; Tue,  6 Sep 2016 21:01:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934564AbcIFVBJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Sep 2016 17:01:09 -0400
Received: from mail-qt0-f172.google.com ([209.85.216.172]:35764 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932538AbcIFVBI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Sep 2016 17:01:08 -0400
Received: by mail-qt0-f172.google.com with SMTP id 93so112781138qtg.2
        for <git@vger.kernel.org>; Tue, 06 Sep 2016 14:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oDMVxMbtC2zqPXD+1cECNAC27HH9otmHivvRxx35Wbw=;
        b=P4Xbk2IlvvKDZI+7YfiT5Qcc2aC41u/77BaiKHJaKw23Z1qWp2XtMXlftkAHsDSxsB
         85BDRFNDMzBIXMzHVHsTyphrJpmcWMu49aYer5TstgFd1KDL32/2wJ3Z7EIQYAr49dXt
         tun7yDMXwW2KJdrHn6gdcDB9AKMiPLx1T6Tpxm+hSDZrEv5vMv/jYfy+1dAJk9YGvZGk
         sXwSFGju/n6+7It7OoIRcUFHeT9FrIL/sMMuYv3laQ5c4QEyMAjBFDLUN4g9Y2wSTYXO
         IfrV8ITBWqyafHmyZymx1slsDxgjmFLsv0a4GPujldAtO92VUh9T55hC4y8llm6cuYo7
         qMyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oDMVxMbtC2zqPXD+1cECNAC27HH9otmHivvRxx35Wbw=;
        b=Bl6yUjynVZu2cJruHmLurMAPhVzA9p/GzV4kcD5bdffd6BRyDh5DpPljsbJN/lb3g/
         jUobCOwplM2CK1G/dRM7sin9VVZSMk5D73l5MY7SlwMpr6i3Uplh0eoTa7v4OF3y/9LG
         /+Tj18Xo3dJB6i07cHDThi9YB8GsG7C/RpwnO8KZ4AAoqFhLRdwWA4CXmUaFfYLJsmjt
         7GTIfyuCxkMMqFM5KwDeJ6MLTupXVVeBT4RqFYopUddTGaYYUOuNPOwg1ODI8rYt35wE
         wtIWdgVrYYu5NFLPYpL6hMVc4wZfBWaCTBeXv41FNYCDxzJs+pGYBhnuNhwnleA3/2Lw
         SFvQ==
X-Gm-Message-State: AE9vXwPcLAMInmBJVCIqRyylvGaj0B2SY/9CNyyAFUQMPPsspuhupx3x/nIroDbxbFPvDeB71aNm/F64bWMYXg==
X-Received: by 10.237.35.6 with SMTP id h6mr35292869qtc.37.1473195667694; Tue,
 06 Sep 2016 14:01:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.237.49.227 with HTTP; Tue, 6 Sep 2016 14:01:07 -0700 (PDT)
In-Reply-To: <b71adc54-2ae6-ef8e-1dca-0883cd617e6e@web.de>
References: <CAKmQUfa_U-g6vC+SjbQSicEUwO+WofNfzezEEwikeOAeL31W5g@mail.gmail.com>
 <b71adc54-2ae6-ef8e-1dca-0883cd617e6e@web.de>
From:   john smith <wempwer@gmail.com>
Date:   Tue, 6 Sep 2016 23:01:07 +0200
Message-ID: <CAKmQUfbemaid61xPyvNheLM2jVGXGjiyF_x=NZnxkZ=5wccQ=Q@mail.gmail.com>
Subject: Re: How to simulate a real checkout to test a new smudge filter?
To:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/6/16, Torsten B=C3=B6gershausen <tboegi@web.de> wrote:
> On 06.09.16 19:47, john smith wrote:
>> I am looking for a way to force smudge filter to run by simulating a
>> real life checkout. Let's say I just created a new branch and did not
>> modify any files but want to test my new smudge filter. According to
>> some answers such as
>> https://stackoverflow.com/questions/22909620/git-smudge-clean-filter-bet=
ween-branches
>> and
>> https://stackoverflow.com/questions/21652242/git-re-checkout-files-after=
-creating-smudge-filter
>> it should be possible by running:
>>
>> git checkout HEAD --
>>
>> but in doesn't work with git 2.9.0. Method suggested in accepted
>> answer here
>> https://stackoverflow.com/questions/17223527/how-do-i-force-git-to-check=
out-the-master-branch-and-remove-carriage-returns-aft
>> works but I don't like because it seems fragile. Is there a safe way
>> to do what I want to do in Git still today?
>>
> It depends what you mean with "safe way".

I want to store all my dotfiles in a single repoitory.  The problem is
that that some specific pieces of these files are different on
different machines.  I have a special .conf file that is different on
every branch and contains machine-specific definitions of some
variables such as EMAIL or SMTP server.  In my smudge filter I call a
script which parses .conf file and replace all template variable
definitions saved in the given file with correct definitions.  For
example in my ~/.bashrc I have this on all branches:

export EMAIL=3D"@EMAIL@"

and in my .conf file on `home' branch

EMAIL=3Dhome@address.com

and on `work' branch:

EMAIL=3Dwork@address.com

And in .gitattributes on both branches:

bash/.bashrc     filter=3Dmake-usable

I also have single `master' branch that only contains template
dotfiles and no .conf.  When setting up a new machine I could just
create a new branch off master branch and add a new .conf.

In turn, clean filter replace all correct definitions in the given
dotfiles back into template definitions.

I'd prefer smudge/clean filters instead of `make' scripts etc. to
convert template dotfiles into something usable and back because
filters:

1. could be run automatically

2. do not modify files as shown by `git show HEAD:<file>' and
therefore no files are reported as modified by git status and also
there are not conflicts when merging master into work/home branch.

I have problems because with point 1 because apparently smudge filter
is not run automatically every time when branch is changed if files
listed in .gitattributes do not change. As the last resort I could
force smudge/clean filter to run just to keep advantage specified in
point 2.

--=20
<wempwer@gmail.com>

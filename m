Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7829B20A1E
	for <e@80x24.org>; Sat,  8 Dec 2018 16:24:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbeLHQYq (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Dec 2018 11:24:46 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:40909 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbeLHQYq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Dec 2018 11:24:46 -0500
Received: by mail-yb1-f195.google.com with SMTP id c15so3575656ybf.7
        for <git@vger.kernel.org>; Sat, 08 Dec 2018 08:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0WT7RZxk7JFrfiHANOSV9Rh1x6/JtGpNNQQwswflxSU=;
        b=sLAGaHa88SN4WfY1RrW67KFqr0WzXb8CU1Sn66bJNuxzA839ODTgr17tGq6Nz9oxsV
         yzV3SQUd5p5LKl+mcxuWyTnqwRASCYE4GbOqraD2cUtvN46OynhP/b4KQYK060mRaIx5
         5SL7gYQmwdVtBsLaXIi51tBV3XVUQNoYLgvo0VlCcwxlz/MpXvZ5OLmzY/jOpQ2MYh9g
         K6rStrzH42I9xT+YkjTzpyLVlrIzUr0oFkS0sK80PxHJT9VxTK4I0o4KF3sLwdjx9L8f
         lfSOCWCQmOn+BnM5xW8ei5AQcdZ0QsBluFZYOci0a0rbAQxRjoVRRmUtf4oeJiBtvYQB
         C2Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0WT7RZxk7JFrfiHANOSV9Rh1x6/JtGpNNQQwswflxSU=;
        b=r0W9g65p4ADmWPxjURjCi45O3Yxh7IANj12gt7QqyYOugq50Cn0JT/Sq6PcHbW5TQ9
         JYDG7K1ITdIovtWB0aXicJscSgp6vqfU2w6O8SnGZwtEbk/F9wrxkyvhFFpbp1NSUDR3
         wGG+WVi8zkj/C8G5BubAdWb6eEk+zFZQ6/cpRMjj2COSDKf9R72gmVu/U/AbmfhqlCxG
         cxWLHG67TVACQ/344G7FkRHu10zmF9i07n2u6CgnmgkkpEjUEBxFP07GycnbYpedctQV
         DM449SFGbPmDMr/gDLHXry+zseyW1GyBVGfkfStYn19zmiJ+O3qYi1wsbU3EsHK6QjAH
         CUnQ==
X-Gm-Message-State: AA+aEWb7460PogsLoGSDAmW/HM61tXgjDwhMzMgclGxfmKq5/j7RA1t/
        CuStbghfPtnbGE+RsbczwSQE7XIQR+pYZTYAapg=
X-Google-Smtp-Source: AFSGD/WUoPsYACT7ypsK1vAg8oqetm5RSoBRw+aPL8EYnMmTgmH4NcDYLyOYGcSKW8n98ZKjc+b2yqlzHPHfVdAUXYM=
X-Received: by 2002:a25:14d5:: with SMTP id 204-v6mr6416722ybu.109.1544286284285;
 Sat, 08 Dec 2018 08:24:44 -0800 (PST)
MIME-Version: 1.0
References: <5bf18396.1c69fb81.20780.2b1d@mx.google.com> <20181208151109.2097-1-tboegi@web.de>
In-Reply-To: <20181208151109.2097-1-tboegi@web.de>
From:   Steven Penny <svnpenn@gmail.com>
Date:   Sat, 8 Dec 2018 10:24:46 -0600
Message-ID: <CAAXzdLXrFNz=bbyZrx=N6D38aWpATLhQS4Q8qWmv89cuvrdNTg@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] git clone <url> C:\cygwin\home\USER\repo' is
 working (again)
To:     tboegi@web.de
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 8, 2018 at 9:11 AM wrote:
> Changes since V2:

latest patch still fixes original issue - thanks

> - Settled on a better name:
>   The common code is in compat/win32/path-utils.c/h
>   [...]
> - The "DOS" moniker is still used for 2 reasons:
>   Windows inherited the "drive letter" concept from DOS,
>   and everybody (tm) familar with the code and the path handling
>   in Git is used to that wording.
>   Even if there was a better name, it needed to be addressed
>   in a patch series different from this one.
>   Here I want to fix a reported regression.

i still disagree with this - but i understand if naming argument is out of scope
for thread

> And, before any cleanup is done, I sould like to ask if anybody
> can build the code with VS and confirm that it works, please ?

sorry but i am decidedly *not* interested in doing this. i use cygwin
specifically so that i can avoid VS. hopefully someone else will be able to
test. cheers

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66ADA1F404
	for <e@80x24.org>; Thu, 22 Feb 2018 22:28:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751901AbeBVW2T (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Feb 2018 17:28:19 -0500
Received: from mail-oi0-f44.google.com ([209.85.218.44]:34731 "EHLO
        mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751731AbeBVW2S (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Feb 2018 17:28:18 -0500
Received: by mail-oi0-f44.google.com with SMTP id c83so4930015oib.1
        for <git@vger.kernel.org>; Thu, 22 Feb 2018 14:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ngEdjiXGAUyKGnD5GfLkqjPp/CoaE6hIexRbUjFeeSY=;
        b=R4iDJNjsC+7Vz6yOgqK10rFNbnjSM9WCwIFNemLTxyea4NMwfgMKhrHaQSY79OJk5Q
         YPwFqHTCKNdnAd3Hml8ylsy3n2vy2VwrwwEinQR1Vuo4cKRT+xtfEe1G43CmWbFGRllT
         mU7COz0YnBHt0lmOCr7R06U5jcsXlCO2ek+W4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ngEdjiXGAUyKGnD5GfLkqjPp/CoaE6hIexRbUjFeeSY=;
        b=ZzyviAK1+jkkIL8cn+EB2hYto6ZJilfGsCkVDJY7OmLLZIrC1iRGbGXoyEcIUaoApM
         4dcMNuHFDfrixwhKi4yWe3dYGbc64TH14as3RcxSDnRX7fHg0geTVloodttlRai52khe
         XSQjiF/YW/7mvWYvavysThMfKFo3oWV8yZ9WyNJk5SLHrA8Kf6sB4IJoe87uuRYR+mNw
         vJR+J18JYvfCl6CVA88KC8N1zRB4cFtxxxuUIcQhy9+ncRm0V0pG5nlEYe/7T5N9M4L+
         4QUUVyxZawVoXxHTY8c0QwWXg1S7KUfnUoGsO3mOdo8x+1Eu7L67AZc+Sky/Y98jjB27
         OBBA==
X-Gm-Message-State: APf1xPB0jnjLjmRemudKBu51J7gWFcCoYbaUBruJleIqfcAhscMelXz2
        MI/tjSJk8UtKoHY9duPVyNw9EolWE95JRSfeBbxNFg==
X-Google-Smtp-Source: AG47ELtFwqeQlUxKJtDOhzeT6SOAEOzOi3n2BcL3OD8JfqbG3QcV4S1ze1WqR6KFh/3jYHWhkr8i6WBwJg1Y4YK2bYs=
X-Received: by 10.202.74.148 with SMTP id x142mr6024540oia.157.1519338497532;
 Thu, 22 Feb 2018 14:28:17 -0800 (PST)
MIME-Version: 1.0
Received: by 10.157.2.231 with HTTP; Thu, 22 Feb 2018 14:28:16 -0800 (PST)
In-Reply-To: <CAKYtbVYe5hHDXf=nQzt6r9N20CrTgbEMbBS0JBBXQLpz+BVu1A@mail.gmail.com>
References: <20180222095022.6227-1-luke@diamand.org> <20180222095022.6227-2-luke@diamand.org>
 <CAKYtbVYe5hHDXf=nQzt6r9N20CrTgbEMbBS0JBBXQLpz+BVu1A@mail.gmail.com>
From:   Luke Diamand <luke@diamand.org>
Date:   Thu, 22 Feb 2018 22:28:16 +0000
Message-ID: <CAE5ih79E1Z8h+hAgr8zCw7=Dtec6sxT7Xf4cWn8zOLNs=mY1jg@mail.gmail.com>
Subject: Re: [PATCH 1/1] git-p4: add unshelve command
To:     Miguel Torroja <miguel.torroja@gmail.com>
Cc:     Git Users <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        gvanburgh@bloomberg.net
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22 February 2018 at 21:39, Miguel Torroja <miguel.torroja@gmail.com> wrote:
> Hi Luke,
>
> I really like the idea of creating a branch based on a shelved CL (We
> particularly use shelves all the time), I tested your change and I
> have some comments.
>
>  - I have some concerns about having the same "[git-p4...change =
> .....]" as if it were a real submitted CL.
>     One use case I foresee of the new implementation could be to
> cherry-pick that change on another branch (or current branch) prior to
> a git p4 submit.

OK, I think we could just not add that in the case of an unshelved commit.

>
>  - I see that the new p4/unshelve... branch is based on the tip of
> p4/master by default. what if we set the default to the current HEAD?

There's a "--origin" option you can use to set it to whatever you want.

I started out with HEAD as the default, but then found that to get a
sensible diff you have to both sync and rebase, which can be quite
annoying.

In my case, in my early testing, I ended up with a git commit which
included both the creation of a file, and a subsequent change, even
though I had only unshelved the subsequent change. That was because
HEAD didn't include the file creation change (but p4/master _did_).

>
>  - Shelved CLs can be updated and you might have to run "git p4
> unshelve" a second time to get the latest updates. if we call it a
> second time it fails as it's trying to update p4/unshelve... rather
> than discarding previous one and creating a new one.

OK, that should also be fixable.

>
>
> Thanks,

Thanks for the feedback, very useful! I'll reroll.
Luke

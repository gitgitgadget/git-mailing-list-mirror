Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A84FC1FF40
	for <e@80x24.org>; Mon, 19 Dec 2016 19:23:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753171AbcLSTXi (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Dec 2016 14:23:38 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:32946 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752905AbcLSTXh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2016 14:23:37 -0500
Received: by mail-pg0-f68.google.com with SMTP id g1so7522777pgn.0
        for <git@vger.kernel.org>; Mon, 19 Dec 2016 11:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9lYGO0CImGNcc+lOeN4GYZJsNttJX0l0omNVfTQKxSY=;
        b=lPixOBb117km/Y8RwxnbbJkF1iBNU5YE736gZ+s1qSg58qq0OWipLoO+s7C6tvaX07
         6g8KgQlKVaaksqWBmRZbvBogN0TJniP1aBqf1o6j1iNlO3YdG3bosIi/YLu9cwlvHJxk
         RFfM3Mifuu9XA59E5/o1K9nv/bau1/5eatXoGwYnEGwxvE4X4VD752GH7vXZqLsdBTes
         iVp/DIip48y7eMu/rZHhEZ6yKFRvJzlgENzJX1HLtlL3wFpovLtTm5boUIsk6gNlr/Wu
         iYYJ5/P33ZRoSZxYhggWRy1UwGa2qkbpoKXKLiHjn1oUz8eXg5DWGSIZ+Dn8mG0aM+rk
         B0pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9lYGO0CImGNcc+lOeN4GYZJsNttJX0l0omNVfTQKxSY=;
        b=nu+8GzwZJxTnjNsXorxlJ4krpaNX53xgux9ayhJj7sQWAncOCdseFGq2Mokx2Wi9XV
         gW9F9K0KXFhZVT6TTepWMsZ7b0wHMkf4+aIExMm4KYAKETnXF3zsodpZx4dSaflexvwC
         O9v3rYspFMk9ywdtJgFOYQ5wmH2xerTJBaXoBsD6/xYlXeHAynY/8y1AWhvr1ttDsk9E
         9j3GQqDfrUV0+Qb2peT4Y8nWAlUcnfD9lavMsr62C3Mh1n0r57uoK8hMiWVfpKgeQ0QM
         ekeZs2nOxoMrDJpFwZSCUmRAPMPb+bFXYOkqp94XXBJ3jXhafz16G22SpR8EKmmo3nK7
         uSZw==
X-Gm-Message-State: AKaTC02lOLrld1YCutSH0TJRDUFm7qXuWOvsIy+2+b1unxZTB4iVBu19se/CMuosVhrYww==
X-Received: by 10.98.150.88 with SMTP id c85mr16515976pfe.68.1482175416823;
        Mon, 19 Dec 2016 11:23:36 -0800 (PST)
Received: from unique-pc ([14.102.13.66])
        by smtp.googlemail.com with ESMTPSA id s197sm33503255pgc.38.2016.12.19.11.23.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 19 Dec 2016 11:23:36 -0800 (PST)
Message-ID: <1482175466.2882.2.camel@gmail.com>
Subject: Re: Suggestion for the "Did you mean this?" feature
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     Chris Packham <judge.packham@gmail.com>
Cc:     GIT <git@vger.kernel.org>
Date:   Tue, 20 Dec 2016 00:54:26 +0530
In-Reply-To: <CAFOYHZDnpzdYq9j4-xGSdKZQX9deLBpZZhz209qV7cCtq537SA@mail.gmail.com>
References: <1482063500.10858.1.camel@gmail.com>
         <CAFOYHZDnpzdYq9j4-xGSdKZQX9deLBpZZhz209qV7cCtq537SA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello all,

On Sun, 18 December 2016 at 20:59, Alexei Lozovsky wrote,
> It's definitely a good thing for human users. For example, I am
> annoyed
> from time to time when I type in some long spell, mistype one minor
> thing,
> and the whole command fails. Then I need to press <up>, correct the
> obvious typo, and run the command again.
> 
> Though, there is one aspect which may be the reason why git does not
> have
> this feature: it requires interactive input. For example, it won't
> work
> if some script tries to run an invalid git command. And git cannot
> really
> tell whether it is running interactively or in a batch mode. If it is
> running in batch mode then the whole script may hang indefinitely
> waiting
> for nonexistent input. This also may apply to using git with pipes.
> 
> Maybe a configuration option or some GIT_NO_PROMPT environment
> variable
> may be used to force disable this, but it still will be a hassle for
> the
> scripts.

This is a good point that I didn't think of, sir. Thanks for bringing
it up. It seems that in some other form git does have the feature I was
suggesting.


On Mon, 2016-12-19 at 13:48 +1300, Chris Packham wrote:
> This feature already exists (although it's not interactive). See
> help.autoCorrect in the git-config man page. "git config
> help.autoCorrect -1" should to the trick.
Thanks for bringing this to notice, sir. I wasn't aware of it before.
It's in essence the same feature.


On Mon, 2016-12-19 at 12:01 -0500, Marc Branchaud wrote:
> Signed-off-by: Marc Branchaud <marcnarc@xiplink.com>
> ---
> 
> Awesome, I was unaware of this feature.  Thanks!
> 
> I found the message it prints a bit awkward, so here's a patch to fix
> it up.
> 
> Instead of:
> 
>    WARNING: You called a Git command named 'lgo', which does not
> exist.
>    Continuing under the assumption that you meant 'log'
>    in 1.5 seconds automatically...
> 
> it's now:
> 
>    WARNING: You called a Git command named 'lgo', which does not
> exist.
>    Continuing in 1.5 seconds under the assumption that you meant
> 'log'.
Happy that my mail introduced a little change to git by revealing a not
often used feature.

-- 


Regards,
Kaartic

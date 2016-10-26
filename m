Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10AD62022A
	for <e@80x24.org>; Wed, 26 Oct 2016 13:18:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S942859AbcJZNRt (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Oct 2016 09:17:49 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:35546 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S942785AbcJZNRp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2016 09:17:45 -0400
Received: by mail-wm0-f51.google.com with SMTP id e69so29828748wmg.0;
        Wed, 26 Oct 2016 06:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=LTy7dW0yo8yc785WWInVhiWKBF6I9DLf3TbNZG+teaQ=;
        b=UEzOxft/bTuvzSX5h7JFd+JSIwmz+w5fXM+w/xDFfA2Ae5i+ik1BgCmkgTeyY3nXT3
         S7ed8rjguxzTYVYaWZO3UdxdoCoMak7z/ilrUoKEvi2odgJOoOmOjOAPTL7iezZna8JX
         4YyIXGgGfDsLnw5b2xeF98jxb11RbEurDJ8ZCu/a/o37BMYQswyLbuhvoXXYrngrKT57
         e39XwrPTj8Ro6GGZe2u8PzgGBMK7o9olVWl7LD4uW0UidUvioxTL04CVVDAG9sUx4Rp7
         iju31bRVO+R1D4hJSsYUndf3ji4kFfIFlRdh/oATFH+1K1KVPGaKFUi71eUkf8pe1PZv
         jbjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=LTy7dW0yo8yc785WWInVhiWKBF6I9DLf3TbNZG+teaQ=;
        b=GO+hbroS+wIImpNxo4CTJbBbg7rFBRxnr1m+NleVC6wAGvpkJUvbrPr/wL9gWqWjK3
         laAHT+sg7XqOJy4N218yW2lVmCNbOwWvtMyf2Ejmta6Yh58EX0WE4d4asobrA/RfoaYX
         fwYB1GQ4EGvpmEsZPTvV0mPWe1HnXvWLw+RDkmRtCQk1mBltM3udNEUMqnx8q0qiuUHS
         QE1KaD3Yc5kzz2o0zuv00aYyuiJqnTQpyVzieqBjxidR678IllHL1QMc7dNf8ZOu/99y
         qi+DVz+FXbsO/Kv5+kJ0C9/TedQ3YDcstYV8+QW8rHaxx1sGD5sYGpwxOs3jfhhey/dk
         ibow==
X-Gm-Message-State: ABUngvffTs98nwgVYJa76j2R7Fgr9iKl5qFbwZPO1rjs49jD/KbZbh3RpT3vvGqw49Iyx9w58bar3dAsAhBupw==
X-Received: by 10.28.229.132 with SMTP id c126mr2904318wmh.110.1477487863632;
 Wed, 26 Oct 2016 06:17:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.140.148 with HTTP; Wed, 26 Oct 2016 06:17:23 -0700 (PDT)
In-Reply-To: <CAJwJo6apgP-pTUccB1Hs81rQbaVCnxeh355fgCKvXc630WTJNg@mail.gmail.com>
References: <CAJwJo6apgP-pTUccB1Hs81rQbaVCnxeh355fgCKvXc630WTJNg@mail.gmail.com>
From:   Dmitry Safonov <0x7f454c46@gmail.com>
Date:   Wed, 26 Oct 2016 16:17:23 +0300
Message-ID: <CAJwJo6YvwXbxq5=pSU9wCNJ-H0mYMxTv4DcJzwPsUu7HuO8N5g@mail.gmail.com>
Subject: Re: [Question] Git histrory after greybus merge
To:     open list <linux-kernel@vger.kernel.org>
Cc:     gregkh@linuxfoundation.org, Greg KH <greg@kroah.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adding Cc: git list, Junio.

2016-10-26 15:55 GMT+03:00 Dmitry Safonov <0x7f454c46@gmail.com>:
> Hi,
>
> Is there any way to specify git-log or git-rev-list which root tree to use?
> I mean, I got the following situation:
> I saw the commit a67dd266adf4 ("netfilter: xtables: prepare for
> on-demand hook register")
> by git-blame and want to see commits on top of that particular commit.
> Earlier I've used for that:
> $ git log --reverse a67dd266adf4^..HEAD
>
> But now after merging greybus it follows the greybus's tree and shows me:
> [linux]$ git log --reverse a67dd266adf4^..HEAD --oneline
> cd26f1bd6bf3 greybus: Initial commit
> c8a797a98cb6 greybus: Import most recent greybus code to new repo.
> 06823c3eb9c4 greybus: README and .gitignore updates
>
> Which quite sucks as this isn't a hash I'm referencing.
> Anyway, back to the question, is there any option to tell git which tree to use?
> I'm sure this was asked before (on btrfs merge?), but I didn't find
> the answer so far.
> I'm using git v2.10.1 if anything.
>
> Thanks,
>              Dmitry

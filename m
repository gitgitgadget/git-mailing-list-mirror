Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 612EE2023D
	for <e@80x24.org>; Fri, 19 May 2017 21:55:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932189AbdESVzZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 May 2017 17:55:25 -0400
Received: from mail-oi0-f42.google.com ([209.85.218.42]:35983 "EHLO
        mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754506AbdESVzY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 May 2017 17:55:24 -0400
Received: by mail-oi0-f42.google.com with SMTP id h4so107789520oib.3
        for <git@vger.kernel.org>; Fri, 19 May 2017 14:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6dX3ayPPTIqD/0G3is0zVNtj7fMC0t8Tdsrqqe5ga+E=;
        b=AhDISgoZ13kNmxTP7KRakoQ9L3r04qKUzQqx0aMJUoH0ofAGdweN5NmJdugSVyX/38
         rqlSJnJTXmQxhJ3cRenucf9n1CRqXgjw2tBpG8X93BcE3JrpA5suoLxsDOh6FDDYwNwb
         qBwgqZIv1R36eugMn3TUvP6pHLg2R04nR1CJ+j+B74c7owwrwWgy7fHmFJe/9HZMWCSE
         JRq7PBtH+wd6GM2EOd3Be3PcCcF433z1Uxv5i2GZxiMLDrKson5IepCsie+5zAZ8K2/N
         +XVtUW5iD05+LnGnsipnPdFtcd4mQp3qWTil4tgk7Z6E8A1mhHmvACWyjLDM4UCWWJxP
         ofqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6dX3ayPPTIqD/0G3is0zVNtj7fMC0t8Tdsrqqe5ga+E=;
        b=Act+tFsdFQy2j9YOL5Zqcxyln4cKO6ymjjghSvwF++6EJdlTyodfpkFyOpDqU+Wpq4
         6L6DSkKmBWmAnE3pfjkgPWaHHrAsosoLJdAPLAVPQI4dpsIVAQPyjH7vmOFBTW0JRNrO
         ISJmsBjqjLvfa1UNPRGY9zF9/M0eqMhtew8RX+zcxvzMkcloe+cnZFVFBBNCHxpcnV8s
         zxg/FIIOvRPHP9bzzCN8uVg49mnss/Y12oYdvv0++YMzd4BGa8gPu+3ZGjlmZXu4S2jc
         755Z1vygqkveTDL9L+bpvUDPSRiKJBdaaVQ5aEr/qrclXUVkSlUvpwjCOREOrw6QRKXc
         4dzQ==
X-Gm-Message-State: AODbwcBp+ywHT4GQPH2mDJY+jZxb+xxfLxIWwrL9If2qRuXJ69spmMmg
        gaSgtxjcK1b7rJFCLfypcdkQ9QZtxA==
X-Received: by 10.157.35.125 with SMTP id k58mr6365133otd.214.1495230923423;
 Fri, 19 May 2017 14:55:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.38.143 with HTTP; Fri, 19 May 2017 14:55:22 -0700 (PDT)
In-Reply-To: <CALKRkrxHNao6NY+-_UmznHdq29yVJJynu8Xx5M__YfK9UkdOAw@mail.gmail.com>
References: <CALKRkrxHNao6NY+-_UmznHdq29yVJJynu8Xx5M__YfK9UkdOAw@mail.gmail.com>
From:   Atousa Duprat <atousa.p@gmail.com>
Date:   Fri, 19 May 2017 14:55:22 -0700
Message-ID: <CA+izobvwRCwGEtpCbey=gFbCh9sHBb5xB1i1LpMG0JCUy0O2mQ@mail.gmail.com>
Subject: Re: [Bug] git branch -v has problems with carriage returns
To:     Animi Vulpis <animi.vulpis@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry for the noise with previous response...

I have tried to repro this issue but git goes out of its way to store
the commit messages using unix end-of-line format.
I think that git itself cannot create a repo exhibiting this problem.

Most helpful would be if you could create a mini repo using gitlab.
All it would need is one file, two branches, and a merge.
With that in hand, it should be pretty easy to track down the problem
and fix git.

You mentioned that the previous version you were using was working
fine, can you tell me which version that was?
It'll help to narrow down the changes that could have affected the issue.

Thanks,

Atousa

On Tue, May 16, 2017 at 4:22 PM, Animi Vulpis <animi.vulpis@gmail.com> wrote:
> Hi,
>
> I upgraded to git v2.13.0 and since then git branch -v has problems
> with carriage returns in subject lines.
>
> We are using gitlab (not the newest version). So this bug (It's about
> carriage returns in auto-generated merge messages (\r\n)) is not yet
> fixed in our version:
> https://gitlab.com/gitlab-org/gitlab-ce/issues/31671
> That's were the carriage returns are coming from.
>
> In my specific case the auto-generated merge message has three lines
> with empty lines in between.
> So every line ends with `\r\n\r\n`
>
> If I do `git branch -v` with such a subject line somehow the third and
> second line get combined before the hash. Example:
>
> $ git branch -v
> See merge request !XXXX temp space 84e18d22fd Merge branch
> 'feature-XXX' into 'develop'
> # <begins with third line> <ending of seconds line (if longer than
> third)> <commit hash (correct)> <subject line (correct)>
>
> Before git v2.13.0 `git branch -v` worked completely normal.
>
> I was not able to create a minimal local example, because my manually
> created \r\n in commit messages were transformed into \n\n
>
> Please let me know if I can provide any more information that would be helpful.
>
> Cheers

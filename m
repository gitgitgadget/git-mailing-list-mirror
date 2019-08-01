Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87D001F731
	for <e@80x24.org>; Thu,  1 Aug 2019 04:54:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728851AbfHAEyS (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Aug 2019 00:54:18 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:35605 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbfHAEyS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Aug 2019 00:54:18 -0400
Received: by mail-io1-f65.google.com with SMTP id m24so141503230ioo.2
        for <git@vger.kernel.org>; Wed, 31 Jul 2019 21:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dereferenced-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cEmNdA+kB8A0ps2FWGPG5kJYeUZWL06tTxPing1koOg=;
        b=G62xileuH8fj0xRWYAzC8baVs3iM53VChq3mrAAKezftOCMVzgyppjDIc74UyHk9jB
         wdqXO17ZAro/7pqINSYew8wIGju1wYK1i+RPR3TZVI/KFzpWMgzR5E++KgOKvHI5xY+G
         4y/XvKSS+gWucdubkaKAJdTT1oeh+o0fcCjaGe6wfzxCNsDirBwk+VWwT6++ErSPftXI
         x2V7MXRX7xdWfvidWCQ08tLOZiD8m95kp6B8b8JQUEZ/N5fxw/KEbH94H4O6AnqCajie
         h70Y2JngdresSWFn+ED9dJkJ8n26/8xxPk4r2D2VxD52JPxPFYdCgojh5GleEubqg6O1
         YNrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cEmNdA+kB8A0ps2FWGPG5kJYeUZWL06tTxPing1koOg=;
        b=nsSTOzGWgeBU0dTi3GIa8oDZOPHV/4/UXTlmE+NxYAOAJHnbnVV/MoeEH56U6KcDFv
         zdEkeCRpRMdW/LpdU6E/15di2oomwW6MybSpwXQ1+J3NeXLiWhGE/x1s87Ct4mBpWX2x
         4z4P8rYoinzMMqVKYs904oNA8VY+/2MQPh6v78VTBKPQkN1JKhZsoPLvongX/MJMIg13
         OkB7WfjAm23tC0pw/n3otrFrV0sovuJqK1RjgjbKboov31XcXsNzq+2Cy/v8rpz7SQxC
         itLl4eR11xDWSuf3BAE6zy4YA1fp/l8mrvdOtulqZXGTUxIqKF15BPIgBDzz3YrHt0+f
         nVNA==
X-Gm-Message-State: APjAAAXrMGJF7WZW+YdF4YXUCohRtgZirugL+9nVPxXQe9pc1XX+bMkv
        k54gbvCFueYg8uf+mCeeOGtfutEdL/ZumSXosTo=
X-Google-Smtp-Source: APXvYqyg7JmSsiasPw/C8QyCPAIaIn2j1SlTzTrZFn2TSm9tFKKtMcLOXgTFDHdqpy7rlywvdiIsRzUoWTS1z6BzOAk=
X-Received: by 2002:a5e:8a46:: with SMTP id o6mr14570667iom.36.1564635258002;
 Wed, 31 Jul 2019 21:54:18 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqh874tssp.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1907311440130.21907@tvgsbejvaqbjf.bet>
 <20190731231848.GC1933@sigill.intra.peff.net> <20190801002125.GA176307@google.com>
 <20190801010022.GA6553@sigill.intra.peff.net> <xmqqsgqlo9j6.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqsgqlo9j6.fsf@gitster-ct.c.googlers.com>
From:   Ariadne Conill <ariadne@dereferenced.org>
Date:   Wed, 31 Jul 2019 23:54:07 -0500
Message-ID: <CAAOiGNzzGqSYxhw=KACYRTxArCY+5H8M4UyY5LFdsnO5VehpOA@mail.gmail.com>
Subject: Re: Git for Windows v2.23.0-rc0, was Re: [ANNOUNCE] Git v2.23.0-rc0
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git-for-windows@googlegroups.com,
        Git Mailing List <git@vger.kernel.org>,
        git-packagers@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

On Wed, Jul 31, 2019 at 10:21 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Jeff King <peff@peff.net> writes:
>
> > This seems OK to me, though I kind of wonder if anybody really wants
> > "auto". Unlike log.decorate, which changes the syntax, there is no real
> > reason to avoid mailmap when somebody else is parsing the output. And I
> > could imagine it is especially confusing if:
> >
> >   git log --author=whoever
> >
> > and
> >
> >   git log | grep whoever | wc -l
> >
> > do not agree.
>
> I personally do not think it is too late to change for the upcoming
> release, either.
>
> But 'auto' that changes the displayed name depending on the output
> being or not being a terminal makes little sense, I would think, for
> the above reason.
>

I think if the warning is annoying people, then we should just change
the default and document it in the release notes.  Ultimately, I think
that this is behaviour that most see as a bug (especially when you
consider that `git shortlog` and `git blame` default to using mailmap
already), so simply describing it as a bugfix is arguably sufficient.

Ariadne

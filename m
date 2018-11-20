Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FFEA1F97E
	for <e@80x24.org>; Tue, 20 Nov 2018 23:17:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725949AbeKUJs7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Nov 2018 04:48:59 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:55917 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbeKUJs6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Nov 2018 04:48:58 -0500
Received: by mail-it1-f195.google.com with SMTP id o19so6058471itg.5
        for <git@vger.kernel.org>; Tue, 20 Nov 2018 15:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h6kea0oqCyKADfCIEptJNry7GKAQP55KyY7WAeNNX+U=;
        b=NIkgN8HaE+c8nE9igvJ8WWYiSh+VSEMWB1BdFOflEjMIyTqNBXDc1WzRWWcwyhnvOK
         vwqFS5EE89l64712suZslyQLLeoOvJ4733NV2Td2D5AQ4Cqz7xExqu94KbDxUpOVpwXu
         dj8Rc0D/O9OHi09V3d6UN4qvJXVJCehklueHkOg5n+dBisNWSzVmPSOvlfoDqG0ig4CD
         HtvZGOrg3eN42Tfo0nVyxJlGs7sKQeXMbmEFIJG9IIoMiLqQ3WbfQQkQ6HiVe/5X0Xfd
         mMgi2q/QYD1/gXLm1MwG0sKTML2hRVreU80g288C9OKxhPGk9OqyZOJOuMUc5Zs9TjSg
         xifw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h6kea0oqCyKADfCIEptJNry7GKAQP55KyY7WAeNNX+U=;
        b=eN91ichA7ovujx6L76CcKZTLt8oRIux1ZReGfw0Qwgk8/rQwuWOePWp544RfC5wwNQ
         y4IYrpuKXlsbZulNMfBpf85g2cYMcZqFkjxSAVT6WME/MB2XnezINX4503fE9Zg+wU4b
         XzpbO2JYptQlkIFuod343fMeJSAap6FAddUh28Mh6GHJGQqqTb1P1fR7c0wBOUQLbDTt
         j484JeIDNLbbX3N/p5gRywE35Ktl5Rw/WDf6cnLD3ExqUEN6AXJmH7VFcTmqQo7vF2rU
         9Gno2FppsZ/70EldN8gnwnIXgvZtUR2MTv9Jcyz6pdFC3zCahLBC2OMZhiWusH6p4wXT
         SmnA==
X-Gm-Message-State: AGRZ1gKjdoLzxz9ibbdMqkNSBB1ZnbAFM0eSURB/4FtWK9WsFaaYgsYc
        XSHTEYxKgAv5pUrITwDevsN+IIQ5jtsQ/8kSUIYg1g==
X-Google-Smtp-Source: AFSGD/Wy1hTUQekhNVgFsJ1aDUGOdZ3QEYi1kMLYEIxMng/C5nvzAd1AExyzzB5PsDI2aRNuTvWB+p5RZxtNn6YUuJE=
X-Received: by 2002:a24:648f:: with SMTP id t137mr3748705itc.95.1542755838493;
 Tue, 20 Nov 2018 15:17:18 -0800 (PST)
MIME-Version: 1.0
References: <xmqqh8gefowy.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1811202152290.41@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1811202152290.41@tvgsbejvaqbjf.bet>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Tue, 20 Nov 2018 15:17:07 -0800
Message-ID: <CAGyf7-FALWBEfcu4OOsrQEKZJ=ub0=exM_f-Y7=avPqiwOeH7Q@mail.gmail.com>
Subject: Re: Git for Windows v2.20.0-rc0, was Re: [ANNOUNCE] Git v2.20.0-rc0
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Users <git@vger.kernel.org>,
        git-for-windows@googlegroups.com, git-packagers@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 20, 2018 at 12:57 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Team,
>
> On Sun, 18 Nov 2018, Junio C Hamano wrote:
>
> > An early preview release Git v2.20.0-rc0 is now available for
> > testing at the usual places.  It is comprised of 887 non-merge
> > commits since v2.19.0, contributed by 71 people, 23 of which are
> > new faces.
>
> The "for Windows" flavor of Git v2.20.0-rc0 is available here:
>

Thanks again for publishing these release candidates! I greatly
appreciate the effort that's involved, and the opportunity it affords
to test new versions prior to their final release.

I've run 2.20.0-rc0 through the test matrix for Bitbucket Server on
both Linux and Windows, and the only failures were related to this
change:

* "git branch -l <foo>" used to be a way to ask a reflog to be
   created while creating a new branch, but that is no longer the
   case.  It is a short-hand for "git branch --list <foo>" now.

Since this is an intentional change I suspect there's nothing to do
for it but patch Bitbucket Server and move on, but I'll confess it's a
little frustrating that the option was deprecated in 2.19 and then
immediately removed in the next minor release. Such a
backwards-incompatible change seems far more apt for a major release,
a perspective that's reinforced by having the change follow such a
brief deprecation period--2.19.0 was only tagged September 10th (in my
timezone), so it's been less than 3 months. (Looking at the git branch
documentation for 2.18.0 [1] shows nothing about this deprecation; the
messaging first appears in 2.19.0 [2]. To be honest, I didn't even
realize it was deprecated until now, when it's gone--our test suite is
automated, so the deprecation warning was not visible.)

For what it's worth, I think having -l mean --list is a _good change_,
and one that will likely be more natural for both new and existing
users. It's the rapid changeover that hurts.

Best regards,
Bryan Turner

[1] https://git-scm.com/docs/git-branch/2.18.0
[2] https://git-scm.com/docs/git-branch/2.19.0

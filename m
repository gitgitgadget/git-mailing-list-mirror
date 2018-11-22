Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AAD0F1F87F
	for <e@80x24.org>; Thu, 22 Nov 2018 08:29:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731928AbeKVTHp (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Nov 2018 14:07:45 -0500
Received: from mail-ed1-f42.google.com ([209.85.208.42]:45357 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730527AbeKVTHp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Nov 2018 14:07:45 -0500
Received: by mail-ed1-f42.google.com with SMTP id d39so6958675edb.12
        for <git@vger.kernel.org>; Thu, 22 Nov 2018 00:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=loskot-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=V7AR5EeBppsSc/nRTthwg+BvQjOJEznL5A+mJTu/olg=;
        b=y5Ik2nR/7mcQwAtaUBnbmsbZ9Ntzi8crdHabVEYEA82AxivDORdJgVrXKnpGF3oXHd
         TjtiLm/cnp4zBtlubZIZ23njzyHsYO6o9nsRyVKSpaXX1O2der4L+WTMvyi1hk1gLqtN
         /vugJFn1RXvb2VvK/vJl2SyvqIrLZZr07FlkQ20fBdpzuvairmknrzHAXIJMyvnnB+zD
         bYOmNH6GDDgxCEChjVg7XIxCilerAIVsJ+39EUOiak1jFAcjEh3MDV9BeaRZRIsnXE+Z
         nlJ+Oby/XbPQrWo4LPyaRPCmpBF6+eAzEzu5KqYlfAByIW+kJUYDAfMBenKSDO7J/uQY
         jO6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=V7AR5EeBppsSc/nRTthwg+BvQjOJEznL5A+mJTu/olg=;
        b=AzPIk5K4kghM6hKN4RxJ69PV4egUKTn88RZexyfE2X8ipcOdgIo/ggb2inpJRzzZxN
         VfKxssiW1yPPNuyeK4A4i6Y47CttSXlPVHGeCFq4yn0a6zqPqfIE0OdUA/WP+tRHbN4J
         gViSQsEYe/g1r5/5hcNdtxL3eEtYdcRx+UNIDbsd1T4299OLprRM18QaaU0YWc479Whr
         AZVWvtyFjFRGIduGJsGyvwZQNdGeLA6kGFcKAOU6tDxPO/y0xA0fHzjDPQZnJwfqTUsH
         pW8SdMSQf+S/jkWsuPW/MWZaZRSPpX19QwTRRwltdO5Ka3avXvFA2U4ZcYjKWTARxI/e
         G0/A==
X-Gm-Message-State: AGRZ1gLn1yitb9tsq4UTx0WtXuCe7AWKKZEnhcIaZ2bDRX6YngITkt4g
        WjWSDpAjvoWjZEupqYzdvDuBI2+b0QSHqhNQdW4/SZ6Un+9Cv1iq
X-Google-Smtp-Source: AJdET5dRE308WRtLtQJjl3JMwXmIKWEWUXttOkQ837gV9ADz6+I6wG3wad9Nh6SFaHLBKN9FFlRnOe1KStHvVUkBwAo=
X-Received: by 2002:a17:906:7087:: with SMTP id b7-v6mr7303177ejk.194.1542875359048;
 Thu, 22 Nov 2018 00:29:19 -0800 (PST)
MIME-Version: 1.0
References: <FTG.5ClN.5saZnXxVpgT.1Rzay9@seznam.cz>
In-Reply-To: <FTG.5ClN.5saZnXxVpgT.1Rzay9@seznam.cz>
From:   Mateusz Loskot <mateusz@loskot.net>
Date:   Thu, 22 Nov 2018 09:28:53 +0100
Message-ID: <CABUeae92Uxmc3xfLJ_=bScdjELL0nEMQxy+fvS+bD_7-cSVn_Q@mail.gmail.com>
Subject: Re: How to propagate critical fixs from master to develope branch.
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 22 Nov 2018 at 07:39, Mgr Georg Black <georg.black@seznam.cz> wrote:
> Hello everyone.I red git manual but I can't figure out how to propagate critical change from master branch to long live develop branch.

Have you considered "using git cherry-pick can be used to backport
changes one by one" [1]

> I red chapter about rebasing that I think could solve it but at the end of this chapter is written that it's not recommended for pubic repositories. I don't know how to do it without merging develop branch to master.

rebase vs merge vs cherry-pick is a topic of constant debates and
opinionated practices indeed [2]

The cherry-pick has its cons, like duplicate commits (BTW, it is a
good idea to learn more about pros and cons of cherry-pick before you
apply this technique).
That is why workflows like GitFlow require to prepare a hotfix in a
topic branch which is merged back to long-lived branch.
In your case, I assume, you've done your work in long-lived master, so
I think easiest is to pick that change from master
and port it to the develop branch [3].

I would cherry-pick.

[1] https://www.atlassian.com/blog/git/the-essence-of-branch-based-workflows
[2] https://www.atlassian.com/git/articles/git-team-workflows-merge-or-rebase
[3] https://reallifeprogramming.com/git-process-that-works-say-no-to-gitflow-50bf2038ccf7

Best regards,
-- 
Mateusz Loskot, http://mateusz.loskot.net

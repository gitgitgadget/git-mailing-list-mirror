Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A0EB1F9AF
	for <e@80x24.org>; Thu,  2 Feb 2017 22:52:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751850AbdBBWw3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Feb 2017 17:52:29 -0500
Received: from mail-ua0-f195.google.com ([209.85.217.195]:34683 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751638AbdBBWw2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2017 17:52:28 -0500
Received: by mail-ua0-f195.google.com with SMTP id i68so201668uad.1
        for <git@vger.kernel.org>; Thu, 02 Feb 2017 14:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=28vnh8hhD90RNkf3GdoXkosSqwVf3YnnVliHDnrh6Ls=;
        b=IeaKiJoEIdRslcC9eJAwfYV/rGyOak8IiXfYCjyBQsMEoKrOcELpdxOWa7Cxcp+qbB
         tIs8fMHeUKvkWpe7OsCcqFWCe4qE0aTJ2jph6930rcJZQs+FEIC3bLvq1lSXmwebHMcA
         TNoQ5C3FQlrylkQtIOkKRJp4Kc/iWhhgHRDyaT5WFN+H4pRNxabW6QRbqjsgMthPfK9Z
         txJFuRuOUTqjLMQyN4kQ150kSd+idk64EfmN/SbITRYcDSlQt/q3nM/vUJ9z6nrIcdKL
         IpDGO42EmsWmbEGGEBwhChxIXZPE/2P5SsAHcP2FPDgoT1RtUQajVMspSrGsn0hpEh/2
         leSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=28vnh8hhD90RNkf3GdoXkosSqwVf3YnnVliHDnrh6Ls=;
        b=FdWbuFUaf7WqUxfPDSAZP2eV443EZ1ynl5G98Bcgw/ybPlyAgz2QvNQy8fzsn3bekg
         SkpVzE1VlzlHQqV9cxw5UaaUWU6IjbbOnLs32eEaFybMrWFCXWSivueCsB4YSm84qR5C
         ARVrm1FM0q7qbOQHLL9RgpDBVyfKxahE5vY0g1a9AFXAduufC4sg2qpuwDWSHo2L+n9+
         fd1XCCQN8J3YgSk/WCb/Axl5Iv38N4HXIM1gh61PqxR7jYVZGzrywydPfhiXKooyCcp/
         TYH374tUWvUdR0K3wY1mrB4fMGHLeezZ/Rtqyx0ATvNwfnKpd08MR6u67krqlhaeI/zo
         pMKg==
X-Gm-Message-State: AIkVDXJCQheXuy41ydi1V+e+V6pUbpvGQ3t+wdsqVCY6crCPb9/zsEq2eLl5y5ZWlI9ZqiUP37bb+HC1dQayOw==
X-Received: by 10.176.2.99 with SMTP id 90mr5262524uas.63.1486075947260; Thu,
 02 Feb 2017 14:52:27 -0800 (PST)
MIME-Version: 1.0
Received: by 10.159.34.48 with HTTP; Thu, 2 Feb 2017 14:51:46 -0800 (PST)
In-Reply-To: <16F9F83D-5A7F-4059-9A27-DB25A8FB1E99@gmail.com>
References: <16F9F83D-5A7F-4059-9A27-DB25A8FB1E99@gmail.com>
From:   Samuel Lijin <sxlijin@gmail.com>
Date:   Thu, 2 Feb 2017 16:51:46 -0600
Message-ID: <CAJZjrdVuvDReSuV4bE=b-Ug_1DYMdB+1ejxSDqf8DO5emp+xDg@mail.gmail.com>
Subject: Re: git-scm.com status report
To:     pedro rijo <pedrorijo91@gmail.com>, j@justinkim.com
Cc:     Eric Wong <e@80x24.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For anyone interested, this thread is on the HN front page right now[0].

There's one suggestion in particular that stands out to me - shifting
to Digital Ocean[1], which for $240/mo offers wayyyy more than what it
sounds like the current Heroku costs are.

[0] https://news.ycombinator.com/item?id=3D13554065
[1] https://news.ycombinator.com/item?id=3D13554632

On Thu, Feb 2, 2017 at 4:01 PM, pedro rijo <pedrorijo91@gmail.com> wrote:
> Hey,
>
> While I=E2=80=99m not experienced with Rails apps, I would like to give m=
y
> contribution to the Git project. I could help doing some kind of triage,
> removing abusing PRs/issues (like
> https://github.com/git/git-scm.com/pull/557), looking for typos and other
> tasks that wouldn=E2=80=99t require a lot of RoR knowledge to get start. =
Also,
> completely free and available to start digging into the RoR stuff of cour=
se!
>
> If you are interested, just let me know :)
>
> Thanks,
> Pedro Rijo

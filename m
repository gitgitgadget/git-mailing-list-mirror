Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD,
	UNPARSEABLE_RELAY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA50E202F2
	for <e@80x24.org>; Wed, 22 Nov 2017 08:16:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751639AbdKVIQc (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 03:16:32 -0500
Received: from mail-yw0-f169.google.com ([209.85.161.169]:36325 "EHLO
        mail-yw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751606AbdKVIQb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 03:16:31 -0500
Received: by mail-yw0-f169.google.com with SMTP id a4so6846884ywh.3
        for <git@vger.kernel.org>; Wed, 22 Nov 2017 00:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:in-reply-to:references:mime-version:date:message-id:subject:to;
        bh=dgLWYiemM78+QJUYSrWNq3NxPNeHr8YvUOZjzQyFBxM=;
        b=aqtc+AZwHBWaPcS4m2u7m8fMNyMdCnmrIEZAvg8jTx0DDnecuchQQXuSzkMTYBJLmP
         D9bJSrg3uODiaLIbvhmsF1N5R9xC+Z1tUuHjDt0T8rKZt1bil1vxsdNxsVuJ33Z5Q/Yc
         Zx/a9yJ6JiXVYX1mh707ph1JIZVVYRxrp5zormBPK5IDqWOXYEuK9BkEc95Jh1gZaYiB
         92usUTYTVJ5u5RhyN4q5/UtszA/f6gM62LTe4pAjovz+RqU/+hYFX0iQEgJye4aLd3wi
         JxVaLe0PbcnMuM/jH8p1U9mRiXVlohBtYzGfl44ly4kmyKQW/whmKJr3d/RfovpQwVYy
         WY7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:in-reply-to:references:mime-version:date
         :message-id:subject:to;
        bh=dgLWYiemM78+QJUYSrWNq3NxPNeHr8YvUOZjzQyFBxM=;
        b=JDuR6dJFVa9P9aEhV6ZPvaojYHhqURGuVuiXktFZyohfsAntRy1iVWSc7W48W0FHTH
         BWqvALgHKb+rafez1k2bY6nMrUwz3b9bA6HBHxZ2+GwTwIMCsezl96owTwGtAbMePUY4
         AkOWDj6d5jNGGTHuwyWahIRHHjjujKISU5XNfZNhdZP4MlHhZznccpXhD1eBjnKN3fQw
         FMwFUwZBpAN3YpIrqznN/3WUGB05eSkfpsS/MIHX2YBxneHz7c3EUaFwVxmeAKmsiELZ
         MJlgTAO3V/SksJrGc7srxgVpfUKsUkz8c3EU5Uvyf6tpiqfSb5xxNSHdVqF1cUqfqrDE
         ivAQ==
X-Gm-Message-State: AJaThX60ce0YBG+rnPxUf+Z7wxewzswREw1DzLRyQjghlkf5kcFAtau6
        j2Zv1JKGYIsdHom1+itpo1osN4HeT9F2oFIugRU=
X-Google-Smtp-Source: AGs4zMZRZ9I+h9AR4eeYFyIDMZ83DnDpJjCT7XeS4qDmShEYIRaIL+bvFyvH5DfFAyZ/Wy0mKIytRXXp6YIzspmS0is=
X-Received: by 10.13.210.6 with SMTP id u6mr13261161ywd.301.1511338590575;
 Wed, 22 Nov 2017 00:16:30 -0800 (PST)
Received: from 1058052472880 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 22 Nov 2017 00:16:30 -0800
From:   Viet Nguyen <ntviet18@gmail.com>
In-Reply-To: <ba0c7ff2-98b1-7331-dfeb-b6adae0d6207@gmail.com>
References: <CANb5NdLCFiaUjit10aV8ewaJOe3UxM28+PwY96dHDM_95GRv+w@mail.gmail.com>
 <ba0c7ff2-98b1-7331-dfeb-b6adae0d6207@gmail.com>
X-Mailer: Airmail (457)
MIME-Version: 1.0
Date:   Wed, 22 Nov 2017 00:16:30 -0800
Message-ID: <CANb5NdL3=L-z7E=XSzfKF_JunpDUrwfK101jEAwua8C5_cEooQ@mail.gmail.com>
Subject: Re: Add feature to stop tracking files while keeping them in the index
To:     Igor Djordjevic <igor.d.djordjevic@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Igor,

On November 20, 2017 at 7:15:00 PM, Igor Djordjevic
(igor.d.djordjevic@gmail.com) wrote:
> Hi Viet,
>
> On 20/11/2017 10:52, Viet Nguyen wrote:
> > Currently, a file can be either tracked or untracked. So, I propose we
> > add a feature to stop tracking files while keeping them in the index.
> >
> > Example scenario:
> > - A developer would like to add some configuration files with example
> > values, e.g. DB_PASSWORD=changeme. But in the future he also want to
> > update those files and to notify the others with conflicts.
>
> If I`m understanding you correctly, what you want should already be
> possible through `git update-index --[no-]skip-worktree`[1].
>
> Regards, Buga
>
> [1] https://git-scm.com/docs/git-update-index#git-update-index---no-skip-worktree
>

We are currently using git-update-index in a client hook, but found it
a little tedious because sometime we forget to configure the hooks
correctly and it just stop working. So I am thinking that it would be
a lot better if we can store it somewhere in the shared repository, so
the other developers could ignore the fact that some files in our
project are special and treat them just like the regular files.

Best regards,

Viet

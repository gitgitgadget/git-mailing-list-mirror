Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0E1D1F597
	for <e@80x24.org>; Tue, 17 Jul 2018 17:45:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730092AbeGQST1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jul 2018 14:19:27 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:40469 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729927AbeGQST1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jul 2018 14:19:27 -0400
Received: by mail-io0-f194.google.com with SMTP id l14-v6so1716360iob.7
        for <git@vger.kernel.org>; Tue, 17 Jul 2018 10:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VHT0Z7w5fPtT2OdcO6FIBpW7tuzIf6uR1BRTO8di4NQ=;
        b=OyVzzW8CPM3iemitGubb/a58JV1hnzazIzAG6wSE+OuVQsuvvNeU26gjkOjQGqT5p0
         oWRZfwgJsgT724Ab345yDLlOZSOS8p7/i3DXkPYsf79S/VTecETuWfb9ZTMF4HvqIlhS
         j+pxU5qyrDVKSUi93y8heVOGIsZAWDQYdZLWubVVbRbhLhQ4f92JG/yg3yvLLavfsbXs
         K9sASEy8vrUwDiM/q/zcO7oMl7MrpQo92zzPlwauQEMM0ICqDdWPO0IoXKWgOeSW4v+G
         KsTCm4lrtZn/ftwMO8ffbgLWqGOAlPkFGpFIref5e1OSDmMEKuw7cG1JBFRM5HClNXz/
         AZvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VHT0Z7w5fPtT2OdcO6FIBpW7tuzIf6uR1BRTO8di4NQ=;
        b=V9byh7E/pSWITvQ/Bkumr+KRZ8vLBW7RWykT0utu9ifDLs31cODk5Z0pbDnl/Dt0hb
         rtbAzwp/zdqjQWnxkLJgPM7RcRmVaIJ3fToFZAPqz0SSMOTJPszyBCDhfMl7f+UWtFv9
         TvA4EYfGeBschbWxglJF25ojiKfy2TnaS8rjhco+j6JuJ6GbI7DU9rpEoNecALsy6LF6
         o5gAFUKAGhu7U4g2e/EcuykWDGXhUG7mnClQ2oZ/RU5g031s6/p8u05UjkOMtmJDc+g7
         hojw1FNI2/XzHaOk0SrStKO633xAhi5m4ZS0ONxYp3CoXCTh0PxH75BOcUbQFcBn0Sro
         j+OQ==
X-Gm-Message-State: AOUpUlG6dtGAeFHBqaagIpzBILXqqJjU3YRTHIJESFFVxL5ah3JZn5d0
        KlGG/YNcf+v/w8iRmJNg/r580dtg/M7an3KJ1T4=
X-Google-Smtp-Source: AA+uWPy3qXNvBF+zbxLwOaKSxZXlxWwGq2j+aeq0n2lblLvzTXa7BNZR/e6uYGimFYE1x54EtImoNUvcjN1++5aMemE=
X-Received: by 2002:a6b:825e:: with SMTP id e91-v6mr2301208iod.118.1531849543847;
 Tue, 17 Jul 2018 10:45:43 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1531778417.git.ungureanupaulsebastian@gmail.com>
In-Reply-To: <cover.1531778417.git.ungureanupaulsebastian@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 17 Jul 2018 19:45:17 +0200
Message-ID: <CACsJy8AEDmyg1XpgXc5KgKdG33t2SeOHw56tEgL_VVXh1Bcprg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/6] Add gentle alternative for `get_oid()`
To:     ungureanupaulsebastian@gmail.com
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 17, 2018 at 2:10 PM Paul-Sebastian Ungureanu
<ungureanupaulsebastian@gmail.com> wrote:
>
> At the moment, `get_oid()` might call `die()` in some cases. To
> prevent that from happening, this patches introduces a new flag
> called `GET_OID_GENTLY` and a new function `get_oid_gently()`,
> which passes the mentioned flag further to `get_oid_with_context()`.

Since get_oid() callers must handle failure when it returns non-zero,
I would say "gently" is already implied by get_oid() and we could just
convert those die() to error() or warning(). Unless some of those
die() are very special that we need to choose which call sites should
go "even gentler" where some sites should still die()?
-- 
Duy

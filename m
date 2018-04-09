Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 195A41F404
	for <e@80x24.org>; Mon,  9 Apr 2018 15:32:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752892AbeDIPcR (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 11:32:17 -0400
Received: from mail-oi0-f50.google.com ([209.85.218.50]:41588 "EHLO
        mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751673AbeDIPcQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 11:32:16 -0400
Received: by mail-oi0-f50.google.com with SMTP id 188-v6so8015444oih.8
        for <git@vger.kernel.org>; Mon, 09 Apr 2018 08:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Vt0L/5Lz1UwUe2ip/X/Ooy5GGLuMeAU5teN0wUW/4lE=;
        b=tFlhWNYyDD8THyoIhQjU3iL1EQkEwHyEE6UJZ8Jfx8uSEuWvxoPAFK+jW3CEsDXCDW
         1izfM/2osQXhNoyaBYjl9JOxx737FZb32hYbRRDmE7ptSHwq9B9cyt/9AemgEGjuzhRm
         PD+Ue9EbhE/3QOn3GTjpEZ7DLmjdgqPOH48EWFxM+5qgXDBag+gKAKVLdHJJluUsJlqm
         ldaHI2d009eoh5GS3o8ZiXfX0NZ4uaX3y77HmSdatuShLMg/OSOxQr800c1MWDCOECpA
         K/LhkFr9TMJaZPzIYePMBSQ46tAOCH7AsBO7vGU9UaepkNot/3uWBEXSX+H0zIRRq1WN
         mLeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Vt0L/5Lz1UwUe2ip/X/Ooy5GGLuMeAU5teN0wUW/4lE=;
        b=OpBe7cABqqIFdPez4zSdIYp4Xwt6CrUVPs2d+taxjCQxFSigmFgMUdhcLY+h/1Om0K
         cF7pnCt1CuKh8QhhVNm3mO6FeaeFa7zHPUiKEQ1+/pakmCi7DNdsc3RAF44XxQ3BfIVT
         V080RKk6DsHPLIkS0bH2taHV0coih74Bim26BSdHmia5O7/paSzcvugr0zWeVkfkDBqW
         ieJtyUDVg79CRzt7h7TevVmF9pllXY5Ta2ylGHx47VXZP8CvpsPmyVngm7fdMohD/2Xb
         P6VjKm/hWb3wzF1edkRGRp4+0SkkdYasxiQcJE0TMLXKBG82Yd9xAevMy5ebGjLwAAVf
         W2+w==
X-Gm-Message-State: ALQs6tC7+5pQJBLzqeI/ii+w3C9ezDD+hw0R9t/0vGWEuY3c02NxgFyN
        ZSeBrdZrwIpbQeOYUqYuTO/6loD3zuDR/8tiHvw=
X-Google-Smtp-Source: AIpwx49uHmrC5pVYGhG1naHvMpNlfhtkK5toKQtuxtepaargYAWQHcuUpiorglhxgVCO8THCz0gpG1zrKAQg+UGqX/U=
X-Received: by 2002:aca:51c8:: with SMTP id f191-v6mr23339347oib.32.1523287935331;
 Mon, 09 Apr 2018 08:32:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.198.152 with HTTP; Mon, 9 Apr 2018 08:31:44 -0700 (PDT)
In-Reply-To: <xmqqd0z865pk.fsf@gitster-ct.c.googlers.com>
References: <xmqqd0z865pk.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 9 Apr 2018 17:31:44 +0200
Message-ID: <CACsJy8C4GUy1xv10oQyrDVkdy4nq636N24b2_pGo-nivPY-x=A@mail.gmail.com>
Subject: Re: What's cooking in git.git (Apr 2018, #01; Mon, 9)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 9, 2018 at 12:21 PM, Junio C Hamano <gitster@pobox.com> wrote:
> * sb/packfiles-in-repository (2018-03-26) 12 commits
>   (merged to 'next' on 2018-03-30 at caa68db14d)
>  + packfile: keep prepare_packed_git() private
>  + packfile: allow find_pack_entry to handle arbitrary repositories
>  + packfile: add repository argument to find_pack_entry
>  + packfile: allow reprepare_packed_git to handle arbitrary repositories
>  + packfile: allow prepare_packed_git to handle arbitrary repositories
>  + packfile: allow prepare_packed_git_one to handle arbitrary repositories
>  + packfile: add repository argument to reprepare_packed_git
>  + packfile: add repository argument to prepare_packed_git
>  + packfile: add repository argument to prepare_packed_git_one
>  + packfile: allow install_packed_git to handle arbitrary repositories
>  + packfile: allow rearrange_packed_git to handle arbitrary repositories
>  + packfile: allow prepare_packed_git_mru to handle arbitrary repositories
>  (this branch uses nd/remove-ignore-env-field and sb/object-store; is tangled with sb/submodule-move-nested.)
>
>  Refactoring of the internal global data structure continues.
>
>  Is this ready for 'master' by now?

I think so. Things start to look much nicer.
-- 
Duy

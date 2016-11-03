Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06DBA2021E
	for <e@80x24.org>; Thu,  3 Nov 2016 17:05:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758261AbcKCRFM (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Nov 2016 13:05:12 -0400
Received: from mail-vk0-f50.google.com ([209.85.213.50]:34075 "EHLO
        mail-vk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752273AbcKCRFL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2016 13:05:11 -0400
Received: by mail-vk0-f50.google.com with SMTP id x186so45317560vkd.1
        for <git@vger.kernel.org>; Thu, 03 Nov 2016 10:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=CdYh/4t7WWcnuMcrIrjC4AAhH+qyUu3yUaIbOcsudXU=;
        b=i7r2sd0YfnXcSygR7ykO/T5GNm5noQ58GUYHMRzsRCjWlIZmQgdBscIZp6jtwm/5+i
         aTT8Lws4Lf3IZtS4MTPkAL2dDfEjllxa9/Al56mGecDo06WtOKMEZtxTHutoT6VdfhEM
         PLpTvoEak59dLIY836bg+Fign7dfQdwT4m47RKDd3DJ0zH9DwgQTiz4oXJKLIzOkq3Ti
         Sn364r+bf4UZQN8xRy1x13H9DZkljaWalpji//sqbSWSuyXogTFttSW6WgvwMJzosb8k
         SykeDOk/1K/frdm2uNSWr92P7AtKNDNYKGhJ/K0LeRRLtnBJ5ROXyw2ntnloJLNob1Ae
         DRQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=CdYh/4t7WWcnuMcrIrjC4AAhH+qyUu3yUaIbOcsudXU=;
        b=Aor8qpPV29NfU5T6b8vf1j0yQ1jbQUfTI8MlQF1rfyScrMoKl+FQKM+91xEeMvvXqT
         +ag0YRPQ79gkMW4pns6NnsbArNlkme0MsZ28l/CRS73dXD6ULkkleypaFDgd/ngBVV4h
         n6iobiHDjJ994rpTlwn+10/KonlTARrEcNhoCsaUFGYz1y0Cog02opiyJtbm3yrH5jlZ
         uGPOUsR59wiUWTsuE/wuNz48kkTQtTulukdW8t+orQOP9zeaOLWcZ0IuhKo1E3j3P5up
         j2+LJtk1F3OWpp2/2vXANNIzMbU2PincZEXq0CF2w8kSeMVSe7z3uHZsscW6VmtQpQnf
         CJJA==
X-Gm-Message-State: ABUngvcPODk9DWfbIEhy4S2HOLxLBAZqTBQmesmoSu/IeqqpciwmgzhDvWFdJO8KKEgCEq5pnyjI3CRc+40Nng==
X-Received: by 10.31.60.7 with SMTP id j7mr7389889vka.30.1478192710599; Thu,
 03 Nov 2016 10:05:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.47.133 with HTTP; Thu, 3 Nov 2016 10:04:50 -0700 (PDT)
In-Reply-To: <CAJtFkWu1qf3xFg1-B-xVONOmqQZfJhe4+qAb4E3H2A5-st_2dw@mail.gmail.com>
References: <CAJtFkWsUL=9K=VGTDejE+4RR3HJevk+2aRAhUyf8-mDrqi5MRg@mail.gmail.com>
 <CAJtFkWu1qf3xFg1-B-xVONOmqQZfJhe4+qAb4E3H2A5-st_2dw@mail.gmail.com>
From:   Stefan Monov <logixoul@gmail.com>
Date:   Thu, 3 Nov 2016 19:04:50 +0200
Message-ID: <CAJtFkWt8VEGHAigx7Wd49mj6erdM=y_jFbhQ+xaMaAsk91EmWg@mail.gmail.com>
Subject: Re: `git stash apply` deleted a random dir from my working copy
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Scratch my last message, I figured out how to restore it. In the
TortoiseGit context menu I selected "Diff", and in the list the
deleted files were listed as "missing". I selected them all, right
clicked them, and selected "revert". Still don't know why the dir got
deleted in the first place though.

On Thu, Nov 3, 2016 at 7:01 PM, Stefan Monov <logixoul@gmail.com> wrote:
> Actually, I just tried restoring my dir with `git pull origin
> clipping`, but that didn't restore it. So, besides the question "why
> did it get deleted", I'd like to ask "how do I restore it?", as well.
>
> On Thu, Nov 3, 2016 at 6:06 PM, Stefan Monov <logixoul@gmail.com> wrote:
>> Hi.
>>
>> I just tried `git stash save` for the first time. It worked fine. Then
>> I tried `git stash apply` and while my uncommitted changes were
>> restored, another effect was that a random dir from the root of my
>> working copy was deleted. I don't know why it chose that exact dir,
>> there's lots of other dirs like it in the root.
>>
>> `git stash save` output and shortened `git stash apply` output are attached.
>>
>> Note: The dir that got deleted was a committed and pushed dir. It had
>> no uncommitted local changes.
>>
>> It's not a huge problem, because there was no data loss - I can pull
>> the deleted data back from the repo. But I'd still like to know why
>> this problem happened.
>>
>> TIA, Stefan Monov

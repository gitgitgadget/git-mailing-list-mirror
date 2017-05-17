Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62CF9201A7
	for <e@80x24.org>; Wed, 17 May 2017 13:39:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753746AbdEQNj3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 May 2017 09:39:29 -0400
Received: from mail-ua0-f170.google.com ([209.85.217.170]:32889 "EHLO
        mail-ua0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753496AbdEQNj2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2017 09:39:28 -0400
Received: by mail-ua0-f170.google.com with SMTP id e28so7701439uah.0
        for <git@vger.kernel.org>; Wed, 17 May 2017 06:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=crX8NW3KcEx2+grtfT5HeQfi1XRtcodUe2oPWlhzWA0=;
        b=KdSjsKBxg/WWKPeNKwvS9lajHhAuUHUNPqutfsuKl+O9fY41UPIadBytZf7HJmG5iX
         /TysHyvwcVL8ZDGaL5FFay6pE/pAxoT/efa8Ks8o/X3hMrzLDiMCe/yAAfF/DiCcCNlb
         5KsBfCV2cgNegt2pS6mkdP4t4cHoJ7BCNN/CBQJOtcnv5EPF00F3Fd+S6dFg3XBAkW/H
         5+7E1u8/XlqlZ4luE/rdj+8gceMUViSskdisiuMVgAhSm0srJHK3yZ44pQgUP8TU2zNo
         oQA4ImIozkuUnpn0YRapaz7A9pCE+6ZmPvqQOw1YDl/QOf/b3N9KYJPkLWkHbQf0WX0h
         UkwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=crX8NW3KcEx2+grtfT5HeQfi1XRtcodUe2oPWlhzWA0=;
        b=P26zQ49NeiUkUvTRDzwnTux2sHpgUSdIonRWHp2T3MJsWqs2PTCGOEEKIbWyeKP+ay
         rwPM8Af4vdpm3+g9nI7IVZJgFnv2gCNT6bFtaPsoRuG7SnS3UsyvGMKiN/bu9rGbPZI3
         DwKN9xYjsWqzSmvS/dQhMB3ypjl4KbQCij0YOehfEIfYxuZGuaAzk1ODX1DtoEvZeUjm
         wr8Ktw/n8/V0acnMudMR/PPFLK7kcta2Fu1dB7zU25EPIOKqfJJUMHDqN3+KhXbLnaj8
         8WtE5o4RC5HnGF6lx6byWkt/rxRzuO5hukdOT9u3aTxcjEvAnl1PnCi8SzauVWU7oA70
         vZKA==
X-Gm-Message-State: AODbwcDk284taUtr1sjgM61PmkhOjnmSSycf9ol77m6fCnBbHw6eivZT
        Wj8GopNkOfLJ40DoX4DzJWP4XufK1A==
X-Received: by 10.176.7.198 with SMTP id d6mr1800382uaf.61.1495028367100; Wed,
 17 May 2017 06:39:27 -0700 (PDT)
MIME-Version: 1.0
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.159.55.163 with HTTP; Wed, 17 May 2017 06:39:26 -0700 (PDT)
In-Reply-To: <xmqq37c4yzb3.fsf@gitster.mtv.corp.google.com>
References: <CAHd499ADTbO09OJhH_wWBbAcXZeLRLFAqOw5eTe6=abN-JUrUA@mail.gmail.com>
 <xmqq37c4yzb3.fsf@gitster.mtv.corp.google.com>
From:   Robert Dailey <rcdailey.lists@gmail.com>
Date:   Wed, 17 May 2017 08:39:26 -0500
X-Google-Sender-Auth: hv6Q-FAt6Q0sh1AzKE_Bny-53Ns
Message-ID: <CAHd499DNa1zFm+ktWJb-4Rp09DjSc+p4HMqoHiXDj57muwxukw@mail.gmail.com>
Subject: Re: Diff topic branch + working copy changes?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 16, 2017 at 9:47 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Robert Dailey <rcdailey.lists@gmail.com> writes:
>
>> So for a topic branch based on master, I can diff ONLY my changes on
>> the topic branch by doing this simple command:
>>
>> $ git diff origin/master...
>>
>> However, this does not include uncommitted working copy changes. To
>> work around this, I can do this instead:
>>
>> $ git diff origin/master
>>
>> (No three-dot notation above)
>>
>> However this implies a ".." notation which will include changes on
>> master that have been made after I branched my topic (I use three-dot
>> to exclude those).
>>
>> Is there a way I can do the first diff but also include working copy
>> changes?
>
> I've wished this a few times, but the answer is no.  Not as a
> short-hand like "..." anyway.
>
> You can still do
>
>     $ git diff $(git merge-base origin/master HEAD)
>
> of course.

Thanks Junio, I forgot about merge-base. I'll create some aliases for now:

    # Diff Branch
    db = "!f() { : git diff ; git diff $(git merge-base @{upstream}
HEAD) ; }; f"

    # Diff Tool Branch
    dtb = "!f() { : git diff ; git difftool -d $(git merge-base
@{upstream} HEAD) ; }; f"

Since I use push.default = current, I always keep my upstream set to
the parent branch (origin/master, origin/release/1.2.3, etc). So in my
case these aliases work, but probably not for other push.default
settings like 'upstream'.

Would be nice in the future to have another revision specification
like @{wc} for "HEAD + working copy". I guess this technically isn't a
revision, but something along those lines. Or maybe just an
--include-wc for diff or something.

Thanks again!!

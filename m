Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D49F20323
	for <e@80x24.org>; Wed, 15 Mar 2017 07:01:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751190AbdCOHBR (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Mar 2017 03:01:17 -0400
Received: from mail-ua0-f170.google.com ([209.85.217.170]:33278 "EHLO
        mail-ua0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751021AbdCOHBQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2017 03:01:16 -0400
Received: by mail-ua0-f170.google.com with SMTP id u30so4323938uau.0
        for <git@vger.kernel.org>; Wed, 15 Mar 2017 00:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mVw0PIv+F2HNlqK5ZEaqM0zpzekuPAY8D8rVy88wfDo=;
        b=okt0w1ct19KVEVcgSfdbQlYg5z3B+Amnzo6r1Ibb2SuaqrFqwvi4V9UVZL2Zfkse0y
         vulhYu+49PnoCt70DonSFEjmdJEEzfPZID3xxV51BYMONlxQIQcxGVqy9AEkZyceEbV2
         t0WbsgZt8y3K/kTOwqcVte+i6+cwevehPo57PNHrIM6NIOlyg/ZlxEf8IvEaXvWWvbbe
         WdiWcK3nKi3+6ayXHzqgbYAbo6CEEaxVKt5zyR0QVY88oRiaWPm9eCvxaac3DKJemGC5
         U0IXn0u8LRXG7B/1FsrgmVqbPZLiyHh3djYHGzxWXqESPh6OcCF0tsPrNV6/OmFhfp0h
         oSpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mVw0PIv+F2HNlqK5ZEaqM0zpzekuPAY8D8rVy88wfDo=;
        b=jY9OVgsWoCZF2jqriaDf/2InCIZX3Q8BOFofhKXZwDnR1Sv/m85sUqLP8/tQFMyd/v
         fys+3fKN8I4gIRWFmVIZ/Xrc2SOPXbdn4G8CPy3qYGkEzQAtgS9RzHH29oTC5EH2dNir
         T/Ym8MzxutiG97NRYJ0YB5GLJ3loublGLO9ZBHC9rPAn2gkfbz6+MBrwyvLAGU59QdNM
         K+3rjYKeVbDRzteG9Zn1snogkNxbEc2Wi/H81GMQJnm3D/6aMUmPRLOf/7D1FVlXQI/r
         gYWHGStf7qqsSZqRKAeNCEJJk7kMofjYRL/ujpERgMggiBZYwvkW4Ln/2NnH8ey4CpfS
         J8OQ==
X-Gm-Message-State: AFeK/H3YGve/hHF3BgEoVMGfH5aUv5oz17L826DNff+80i2gf6HA1hkd9/T4Ei6SW+S/IP2MBIDI+s6OHCdj1g==
X-Received: by 10.176.65.198 with SMTP id 64mr706064uap.40.1489561275240; Wed,
 15 Mar 2017 00:01:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.31.8.135 with HTTP; Wed, 15 Mar 2017 00:00:34 -0700 (PDT)
In-Reply-To: <CAFOYHZDEoDrX-R=GOm6VJ9d4x-UuOzVfnCwb0zkPezkoL=WLdA@mail.gmail.com>
References: <CACHUE0-MyuL+8wvt1BeKMtxNUdg7AK0bDAg4BSeoj5aHjLARMQ@mail.gmail.com>
 <CAFOYHZDEoDrX-R=GOm6VJ9d4x-UuOzVfnCwb0zkPezkoL=WLdA@mail.gmail.com>
From:   =?UTF-8?B?RMWpbmcgxJDhurduZyBNaW5o?= <dungdm93@gmail.com>
Date:   Wed, 15 Mar 2017 14:00:34 +0700
Message-ID: <CACHUE0-eep6cyunAwY5PC06+5QE6Q67-_EmWYGAtOWC7HXHQpg@mail.gmail.com>
Subject: Re: [Bug] Unicode display
To:     Chris Packham <judge.packham@gmail.com>
Cc:     GIT <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Chris,

Thank you. I will keep an eye on that issue.

On Wed, Mar 15, 2017 at 1:48 PM, Chris Packham <judge.packham@gmail.com> wr=
ote:
> Hi,
>
> On Wed, Mar 15, 2017 at 5:51 PM, D=C5=A9ng =C4=90=E1=BA=B7ng Minh <dungdm=
93@gmail.com> wrote:
>> Hi Git team,
>>
>> Thank you all for create a great tool.
>> Last week, I updated the last version of git (2.12.0 x64-Windows) and
>> all Unicode characters are display un-correctly. You can see:
>> http://imgur.com/a/eriKQ
>>
>
> Looks like the same issue as
> https://github.com/git-for-windows/git/issues/1087 doesn't appear to
> have a fix yet but you might want to keep an eye on the progress of
> the issue.



--=20
Dzung Dang Minh - Software Engineer
Email: dungdm93@gmail.com
Phone: (+84) 94.505.1024
Skype: dungdm93

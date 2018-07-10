Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F6EB1F85A
	for <e@80x24.org>; Tue, 10 Jul 2018 12:28:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933132AbeGJM2T (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 08:28:19 -0400
Received: from mail-qk0-f180.google.com ([209.85.220.180]:33718 "EHLO
        mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752652AbeGJM2S (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jul 2018 08:28:18 -0400
Received: by mail-qk0-f180.google.com with SMTP id c131-v6so11384321qkb.0
        for <git@vger.kernel.org>; Tue, 10 Jul 2018 05:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=LERw5sFc32ORUme84eZuwg2n/j29QNddvkHTgs2N9Xw=;
        b=RTiv6mpsz2TBzVcaCTkCh0T8YYp22cBVGMf2TevK7jo2MKVkK0UeOBP09hbi5bElWl
         VQXwXgs07ScNdeRplUiRVs3Q9B2j/XaRh8Fdu+S7UlnytVHsvwbnDNhHtlYMZzvfjLyV
         oYQ7ULV72OGUrj6ajCXWHgmHa/QTqVMd+n/72erTXa3SWhGc43DGVcTc4F3eV/fSeAlc
         ViXpZvI17gcDU6vNaxGAPyMOICxJWTCv0Rc2U/R1dgqHbUkaW1wwmmfp453RdIGBWBft
         PuG3ZSe3Kq/IWVF+r3djQTn0HI60vVvONMXvYZutsJ+uxKelboqt3VmJ5pqh8bl1FBgz
         52UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=LERw5sFc32ORUme84eZuwg2n/j29QNddvkHTgs2N9Xw=;
        b=hr2FCpzNAabziVq3TM+1tn4mZVfMOuLSF0IrhA8JGUnKDZ5YD4PIVHEWk+BynH7zbc
         Qav/1W8MRaCMib9udbUAqZeLwjPZ6qZHSmnDnpNOzcPxgXtPefkI69fqhlEcppm05r4a
         o3OmH1Rgi+/1+2wdqD85vMZlurlHD1hpAL1GCtFcLiJDcoeXmzmfMxmlCncBYTRinB89
         +g5Pk6cy7SpBvjRJzNFyqf+BfDd+W2qkYgrTFn6Y37oE7fw+HLCAQggw/XyIBnMzs12g
         CAT8R4nP8re0mnEQnCMrudrXyBHT7NGqnshRICSHiOkxhIdiu6SjGZRTJcVeCxzV1R4d
         b5kQ==
X-Gm-Message-State: APt69E34ZrxuRmsEsd8FCrXhpvHHUvt0S/b36s1qBu4y9U/8+7N8osim
        EuHoQOAjqKvNvtETlS+1PME1hugp8N7RP+vQ3ng=
X-Google-Smtp-Source: AAOMgpfzDe5MiIUh2lVzRdRLWBfOA05OmDmhZc7Q1DiZl2nnhcPgOqVXw5egHGltA0VnOvomQ9zBkmbIuPkhEJt/zL4=
X-Received: by 2002:a37:c204:: with SMTP id i4-v6mr14288303qkm.438.1531225697915;
 Tue, 10 Jul 2018 05:28:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:53c2:0:0:0:0:0 with HTTP; Tue, 10 Jul 2018 05:27:57
 -0700 (PDT)
In-Reply-To: <20180703133645.GA20316@sigill.intra.peff.net>
References: <CAGba+=U4nbxL2uuSxyqyZqiiavJpo_E=GhUkipz6DczLdmnkgQ@mail.gmail.com>
 <20180702195016.GA17102@sigill.intra.peff.net> <91A9F3A0-5F3F-4137-9A40-CB42EDE4F243@apple.com>
 <20180703133645.GA20316@sigill.intra.peff.net>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Tue, 10 Jul 2018 14:27:57 +0200
Message-ID: <CACBZZX4X05EHd+OpBpLotGuY6H=pnB9dS9Rv5BONfCKjZM3a1A@mail.gmail.com>
Subject: Re: Subscribing Apple people to git-security@googlegroups.com
To:     Jeff King <peff@peff.net>
Cc:     Jeremy Huddleston Sequoia <jeremyhu@apple.com>,
        Akilsrin <Akilsrin@apple.com>,
        Christian Couder <christian@gitlab.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Tim Triemstra <timt@apple.com>,
        Eliran Mesika <eliran@gitlab.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 3, 2018 at 3:36 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Jul 02, 2018 at 01:15:19PM -0700, Jeremy Huddleston Sequoia wrote:
>
>> > I hope that maybe they're also interested in reducing the overall
>> > diff between upstream Git and what ships with XCode. Last time I
>> > looked (which was admittedly a while ago), a lot of the changes
>> > seemed like things that could probably be considered upstream.
>>
>> I'm very very interested in having reduced differences between what we
>> ship in Xcode and what is upstream.  I've been maintaining a repo with
>> our patches that I rebase as we move forward, in the hope that these
>> changes might be useful to others and a derivative of them might
>> eventually be accepted upstream.  See
>> https://github.com/jeremyhu/git/commits/master for the current set of
>> changes that are in our shipping git (currently on top of 2.17.1).
>
> Thanks for sharing. Skimming over it, I see:
>
>  - several of the changes look related to run-time relocation. There was
>    a series that shipped in v2.18.0 related to this, so that may reduce
>    your diff once you rebase.
>
>  - The xcode_gitattributes() bits aren't likely to go upstream as-is.
>    But possibly these could ship as a default $sysconfdir/gitattributes?
>
>  - the rest look like assorted little fixes that probably could go
>    upstream

Jeremy, could you elaborate on what
https://github.com/jeremyhu/git/commit/61b42bc5d2 was about? I.e.
where was this discussed & tests for this refused?

Seems sensible to me to have this in some form, but the test as-is
seems to be a general regression test, not Apple-specific, so it would
need to be changed somewhat, or does it only happen with some other
custom patch of yours?

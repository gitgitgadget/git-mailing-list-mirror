Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA4B31FAFB
	for <e@80x24.org>; Wed,  5 Apr 2017 09:22:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932728AbdDEJWY (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Apr 2017 05:22:24 -0400
Received: from mail-oi0-f54.google.com ([209.85.218.54]:36693 "EHLO
        mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933067AbdDEJWW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2017 05:22:22 -0400
Received: by mail-oi0-f54.google.com with SMTP id r203so8262638oib.3
        for <git@vger.kernel.org>; Wed, 05 Apr 2017 02:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=UtJVvNM4DOKYo43P4ujWcMvrOfu7EQbAZFdbbqsBWfQ=;
        b=LMBP2Zvxd561w5xqmHEdC0BPHuTx927vnUh8zZAZOuuOQ5Z7vSRuDcdDv15FDQaDEH
         XMefmkE5TGkOkX3vPBgDrJy5WKCm9EDV+0t1f6csjqn+Uuzx4Jlgu/nIstR0qKrilCRx
         4LGqhQ9lfj6B18L/jRY2Ppq6lC9crx8y52efcjCq4iHodfPKf34zW0lvLNb0Ske6tPQC
         Rx4OTac3x5btz6ODE8iaB5O/Kl15pTBYj0mS7MeW9SiTluAY8kx3B/FHZ3j1BGmZMcFo
         zERfNM6feFgVGbgKD8xEpxONZ1n8VQ1RM/FX60X6yjTIXvHl8BFOsUYBsAV/Sc+Z9pZb
         YTTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=UtJVvNM4DOKYo43P4ujWcMvrOfu7EQbAZFdbbqsBWfQ=;
        b=cgldltJ9McDnuEiAaeqHexXqhFrMFX9eGIbpMOlcA/OKZiaW54H7hZcIMHfta+GWPB
         TtxhnURgibQ8cF3xyrl/vDUeDiM/njDI1zAmvFPYo0vgJxOuJOfXIV/bvZV/H5X1Y4b4
         EKhdhfStmmBuwt6MpCkg3XYcmLTHUUBRdrc0r3gz5hKp5hwGixviBRlqU8C4AOCjbr5o
         hXhgSHx8r2hMdEMiZZptyj1JKhc+qLTHo3ox3iKip40DHEnJuTgq7DpKOy98HIrSCUeU
         u+ViML56CB4uEP2UmrYRVc3s7pEXEDPghu6Q3SCt2gYnymbTDLFLTMibE0XBC+JycjeO
         zsfA==
X-Gm-Message-State: AN3rC/6we4vLTKgfWIeXMrwOWY5Xt5E7W3wVS1eJO9eUkT7IbORAe0Bf+jmCOAT5StBG9s0MATYRIAvZvwU2kQ==
X-Received: by 10.157.46.246 with SMTP id w109mr1956949ota.225.1491384136428;
 Wed, 05 Apr 2017 02:22:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.158.70 with HTTP; Wed, 5 Apr 2017 02:21:45 -0700 (PDT)
In-Reply-To: <CAEA2_RKFwL8K=-QBYbmfbjJ44obB+PJit0pd5im0Jy_=E_-+MA@mail.gmail.com>
References: <1490747533-89143-1-git-send-email-bnmvco@gmail.com>
 <1490747533-89143-3-git-send-email-bnmvco@gmail.com> <7a665631-da6a-4b9f-b9e7-750f2504eccd@alum.mit.edu>
 <xmqqk278av4x.fsf@gitster.mtv.corp.google.com> <e412ef09-276b-92df-d2c0-0bf2f80238d2@alum.mit.edu>
 <xmqqinmr70uc.fsf@gitster.mtv.corp.google.com> <1751d788-d1f1-1c97-b33b-f53dab78ef86@alum.mit.edu>
 <CACsJy8DBa-oH3i+5P=iVr9NhJwsicZ43DO89WmvpYEQu90RrMw@mail.gmail.com> <CAEA2_RKFwL8K=-QBYbmfbjJ44obB+PJit0pd5im0Jy_=E_-+MA@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 5 Apr 2017 16:21:45 +0700
Message-ID: <CACsJy8BTKHZqsJfbvmi9YgeaDyHK6wjBLf9dkBXfbZ=BRMa=pA@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] dir_iterator: iterate over dir after its contents
To:     "Daniel Ferreira (theiostream)" <bnmvco@gmail.com>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 2, 2017 at 11:25 AM, Daniel Ferreira (theiostream)
<bnmvco@gmail.com> wrote:
> Why exactly would it not be applicable to read_directory_recursively()?

Because that function is a beast (and probably should have "beast" in
the function name).

The function is supposed to read .gitignore, index file and whatever
else needed, traverse the directory and return the list of untracked
files, or ignored files. It even has options to return a directory
path, if all entries inside is ignored/untracked, instead of the list
of files inside. On top of that, it has "untracked cache" to skip
traversing directories to speed up.

Using dir_iterator might be possible but we'll need to improve it a
lot. read_directory_recursively() needs really fine control over
traversing: it can decide to not recurse in a subdirectory, it can
decide to ignore the rest of the entries in a directory and go back to
its parent, and in the case of untracked cache, it can switch to
traversing the cache instead of on-disk directories.

It's possible, probably, but it's going to need quite a lot of work
(and care, since I think there are corner cases that have been abused
in real world and we just cannot change those behaviors). Using
iterator interface would be a good improvement to clean up the "on
disk or on cache" directory traversal there though.

>
> On Thu, Mar 30, 2017 at 8:08 AM, Duy Nguyen <pclouds@gmail.com> wrote:
>> On Thu, Mar 30, 2017 at 1:39 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>>> * DIR_ITERATOR_RECURSE -- recurse into subdirectories
>>>
>>> would make the set of possible options complete. If this option is not
>>> set, then the iteration would be over the entries in a single directory
>>> without traversing its subdirectories.
>>
>> And would make it possible to use dir-iterator everywhere (except
>> read_directory_recursiveky). That would be really nice :)
>> --
>> Duy



-- 
Duy

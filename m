Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71A691FD09
	for <e@80x24.org>; Wed, 31 May 2017 14:10:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751639AbdEaOK1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 10:10:27 -0400
Received: from mail-it0-f41.google.com ([209.85.214.41]:37979 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751546AbdEaOKZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 10:10:25 -0400
Received: by mail-it0-f41.google.com with SMTP id r63so12078493itc.1
        for <git@vger.kernel.org>; Wed, 31 May 2017 07:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ZjLuThbHjUd2liIA3qwv62IPXWuf4S7dwc/OYYc/q7M=;
        b=dxEnFWPLUMXyuZUVJshvSRotVkIVjxAwd0fQ7SR0NkQfZXwhfHS5VOeliljvBPwlme
         GYC6v6Rp8xDs3EMVoxLV4GNXqBZIA9zFmIpgPA61MK25X4dxMP5MI0QAqfVHxUQx13o/
         w3HTakLCsnvNx2uZ0ojzaHWdljgT3vQs01PcvFK+HcDmgdXk+su0Rm6DCRYgDw0QayXQ
         zdte77iuneMa/uQoXFS01XztHasR55EhszBi8lob8y4X4oPU+4AzUvCWcojDnR/H1ygt
         FNjf/mB1ogRIjaxqCN+sY/2Y3pw55vC0jROOLs69/bKD3s9iDpM9qwfA58mrDRndePnc
         vIEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ZjLuThbHjUd2liIA3qwv62IPXWuf4S7dwc/OYYc/q7M=;
        b=h8RMt8VAhkofS59JmTzUMnlM3n0bHMWaN+k9JwVpfId64GhfBjdNRqtZFO11ZZOfpK
         mOJ9qWwt0J8b8fmc6PLpCMu4HPBVrtLoPHQa+e9GPxEjD8HEP7PsqDDlsCwSISyg/MJT
         3DRRbYDXcB8md99IBzee0vdin/BjW5mVtljpljnkFOntd9jFIa48aB7QaiP11noSgM9a
         2zY2KyWw8gdZSTcDqUl333XJ9ddu1jhNXazp8B/kbjdnBfWUHeX+AAWOp6tdzFNhBUDR
         wlDSsWpmi0vT9JIihDS+1X9cpjkdmftrReUDaaJjTVPXJwfiBAiG66pkW5CIenakxb2F
         wi/g==
X-Gm-Message-State: AODbwcB5C5zVOExCcTw+MGnCHf2TQHfW1LW2Y6i/xo42j2ydzwM4c/W/
        5W9qayAVq0W/cemDkNFgC9vXcYRNdg==
X-Received: by 10.36.53.79 with SMTP id k76mr7009315ita.71.1496239824108; Wed,
 31 May 2017 07:10:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Wed, 31 May 2017 07:10:03 -0700 (PDT)
In-Reply-To: <f2c21d3e-9892-bdcb-2686-341de87ee15d@gmail.com>
References: <20170518201333.13088-1-benpeart@microsoft.com>
 <CAP8UFD20gvTZqCOcpd1iozNDHOZR1sUKRwi062wL52FNHWNC3w@mail.gmail.com>
 <ab37d437-2a4e-b6ed-621f-5978083cd15b@gmail.com> <CAP8UFD3R0dEsX7BtzYoSmvaKTZYsm9=bpQsu0jEk2aKm83z-2A@mail.gmail.com>
 <f2c21d3e-9892-bdcb-2686-341de87ee15d@gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Wed, 31 May 2017 16:10:03 +0200
Message-ID: <CACBZZX6x914+XHcxQzTUnjk6yjgr-QTi+1L6oE=_2hWjvXDbpw@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] Fast git status via a file system watcher
To:     Ben Peart <peartben@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Ben Peart <benpeart@microsoft.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        David Turner <David.Turner@twosigma.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 31, 2017 at 3:37 PM, Ben Peart <peartben@gmail.com> wrote:
> On 5/31/2017 3:59 AM, Christian Couder wrote:
>>
>> On Thu, May 25, 2017 at 3:55 PM, Ben Peart <peartben@gmail.com> wrote:
>>>
>>>
>>> On 5/24/2017 6:54 AM, Christian Couder wrote:
>>>>>
>>>>>
>>>>> A new git hook (query-fsmonitor) must exist and be enabled
>>>>> (core.fsmonitor=true) that takes a time_t formatted as a string and
>>>>> outputs to stdout all files that have been modified since the requested
>>>>> time.
>>>>
>>>>
>>>> Is there a reason why there is a new hook, instead of a
>>>> "core.fsmonitorquery" config option to which you could pass whatever
>>>> command line with options?
>>>
>>>
>>> A hook is a simple and well defined way to integrate git with another
>>> process.  If there is some fixed set of arguments that need to be passed
>>> to
>>> a file system monitor (beyond the timestamp stored in the index
>>> extension),
>>> they can be encoded in the integration script like I've done in the
>>> Watchman
>>> integration sample hook.
>>
>>
>> Yeah, but a hook must also be called everytime git wants to
>> communicate with the file system monitor. And we could perhaps get a
>> speed up if we could have only one long running process to communicate
>> with the file system monitor.
>>
>
> In this particular case a long running background processes isn't helpful
> because refresh_by_fsmonitor() already has logic to ensure the file system
> monitor is only called once per git process.
>
> The overhead of that one call isn't significant as demonstrated by the
> performance numbers I sent out in the cover letter.  Even with the cost of
> the hook and all the associated post-processing, this patch series still
> results in a nice performance win (even on Windows where spawning processes
> is typically more expensive than on other platforms).
>
> I appreciate the close look at this patch series!  Even when I'm pushing
> back, I'm glad someone is asking questions and making sure I've thought
> through things.

I think where this series is going for now makes perfect sense.
Looking forward to the next version, need to get watchman compiling
though.

I think what Christian may be getting at here (correct me if I'm
wrong) is that David had a series 1-2 years ago that went a bit beyond
what this is doing, i.e. it had a persistent index-helper daemon
talking to watchman, so "git status" would stream the index state over
from this daemon, and it would consult watchman.

That's an interesting *additional* optimization, but a huge change on
top of this, so it makes perfect sense to start with something simpler
as this series does, and my hunch from having tested/looked at both is
that just talking to watchman is going to be by far the biggest win.

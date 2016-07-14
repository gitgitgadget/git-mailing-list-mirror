Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E85920196
	for <e@80x24.org>; Thu, 14 Jul 2016 15:57:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751265AbcGNP5B (ORCPT <rfc822;e@80x24.org>);
	Thu, 14 Jul 2016 11:57:01 -0400
Received: from mail-io0-f175.google.com ([209.85.223.175]:33110 "EHLO
	mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751149AbcGNP5A (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2016 11:57:00 -0400
Received: by mail-io0-f175.google.com with SMTP id 38so79613178iol.0
        for <git@vger.kernel.org>; Thu, 14 Jul 2016 08:57:00 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/Mw8v7j8nTkCFJcP0/0YnTjC5ko5mMpTjD3Niukzeck=;
        b=cujoZWYWH1OQx9i7fMInFN76TBu6AgShKc3rlxWcXD2BGC7taI1hbv0fltIGeT6O7l
         WEg+Tp6N/iVx7gLkEqsr6QEtSr/CdB8KBnYUN/uPGDWJZD7kTouef7Mc4ZWXTYggE3hs
         EzjfELa+IGwafK5Y91op+ufhxp6E15uHuaP5+4BR2yI5ZWtrfxjf7lt6kjpTj+bBvTV/
         bIrfqEqRLbMNy6fnzEgM4ZjEWWoSI6+kVgeA+5NyfflDC5ez/28XgvxIq6aE2oL6rRsk
         wgFkH1rVEgWgH7xcZB2bZ5rpncGy4maJQvuwhXNbe8RlyurHzNBySk2fgZD3XFgTbtBx
         gvNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/Mw8v7j8nTkCFJcP0/0YnTjC5ko5mMpTjD3Niukzeck=;
        b=hkao54WtxfD8GAZ22jEtZP/q7LgOm8LmvdEfEGRe9DCS6bolZCe4h0jJkybK9D0ozR
         rMaqA+ib2Ykvnt4jIj70ZlyOQ0ESi4zA09TRHrxyYd0Fm8ssBm0UGx0tj0Wj/fodRQjQ
         vYra2cjUU2GxXXsHgNsCvrXdoSZs1dYOk9R1E3L44hnCyzWl3R9tP4jrmpOEY2A+zla7
         WuOtapWn8bZhBZitkhSPya7pf+ArOk5gVmVnMuf2kuUIEA2WHxiikfngN/hjh8EsU2G8
         eBYL7CBn5bCv01D+aP7TDIL2cEaXhVyFSJwtzCwteHP1t0ilc6chmNMTrsh56rkG+SEU
         0+0w==
X-Gm-Message-State: ALyK8tLUBTX+SdHvhVPXbf0fFDuw2tAIyC0nzSdYz6FLoriVcnctTak8NsXjHzqfcRChe2VXVG61iDzJN2ywmw==
X-Received: by 10.107.22.6 with SMTP id 6mr15334646iow.128.1468511819727; Thu,
 14 Jul 2016 08:56:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Thu, 14 Jul 2016 08:56:30 -0700 (PDT)
In-Reply-To: <5786B9CE.6010703@novalis.org>
References: <1467532693-20017-1-git-send-email-novalis@novalis.org>
 <CACsJy8Br-rSTKjpt2ykn8YyFruy8CZoXWm287BtTRcAYY2DjVw@mail.gmail.com> <5786B9CE.6010703@novalis.org>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Thu, 14 Jul 2016 17:56:30 +0200
Message-ID: <CACsJy8BRg6ej1ZWeAY0yaV3Zmk+UqW4YN+yt-FTOYihTC19PqQ@mail.gmail.com>
Subject: Re: [PATCH v14 00/21] index-helper/watchman
To:	David Turner <novalis@novalis.org>
Cc:	Git Mailing List <git@vger.kernel.org>, kmaggg@gmail.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Jul 13, 2016 at 11:59 PM, David Turner <novalis@novalis.org> wrote:
> On 07/12/2016 02:24 PM, Duy Nguyen wrote:
>>
>> Just thinking out loud. I've been thinking about this more about this.
>> After the move from signal-based to unix socket for communication, we
>> probably are better off with a simpler design than the shm-alike one
>> we have now.
>>
>> What if we send everything over a socket or a pipe? Sending 500MB over
>> a unix socket takes 253ms, that's insignificant when operations on an
>> index that size usually take seconds. If we send everything over
>> socket/pipe, we can trust data integrity and don't have to verify,
>> even the trailing SHA-1 in shm file.
>
>
> I think it would be good to make index operations not take seconds.
>
> In general, we should not need to verify the trailing SHA-1 for shm data.
> So the index-helper verifies it when it loads it, but the git (e.g.) status
> should not need to verify.
>
> Also, if we have two git commands running at the same time, the index-helper
> can only serve one at a time; with shm, both can run at full speed.

We still have an option to send a (shm, possibly) path to git to pick
up and skip verification. If we can exchange capabilities then sending
the index some way else is always possible.

>> So, what I have in mind is this, at read index time, instead of open a
>> socket, we run a separate program and communicate via pipes. We can
>> exchange capabilities if needed, then the program sends the entire
>> current index, the list of updated files back (and/or the list of dirs
>> to invalidate). The design looks very much like a smudge/clean filter.
>
>
> This seems very complicated.  Now git status talks to the separate program,
> which talks to the index-helper, which talks to watchman.  That is a lot of
> steps!

I was suggesting this because I think it would simplify things, not
complicate stuff further. Yes the separate program plays the role of
our unix client, if we keep the index-helper. But we don't have to.

Do you remember Junio once suggested to put the index on tmpfs? That's
what I imagine in common, medium scale setups. We don't need an extra
daemon:

1) when git needs the index, the script looks at its tmpfs mount, if
found, pass the path back
2) when git announces the index has been updated, the script reads the
index and saves it in tmpfs
3) when git refreshes and asks for watchman support, the script simply
runs "watchman" command, post processes the output a bit and send the
file list to git

Because there is no separate daemon in this case, we don't need
--kill, we don't need --autorun. We still need WAMA extension but it
can contain just an arbitrary clock string, this is completely opaque
to git. If we can get rid of the index-helper (with an example script
probably landed in contrib folder), that's a lot of less headache down
the road.

For giant-scale repos, you probably want something more efficient than
a script like this. And the good thing is you have freedom to do
whatever you want. You can run one daemon per repo, you can run one
daemon per system... In some previous mail exchange with Dscho, it was
mentioned that something other than watchman may be desired. This
opens up that door without much headache from outside.

> I think the daemon also has the advantage that it can reload the index as
> soon as it changes.  This is not quite implemented, but it would be pretty
> easy to do.  That would save a lot of time in the typical workflow.

A script has the same advantage, that is if git notifies it (like we
do now). You can also do it using watchman trigger, which does not
need any special support from git.
-- 
Duy

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 212B31FCA9
	for <e@80x24.org>; Sun, 11 Sep 2016 16:05:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755961AbcIKQFn (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Sep 2016 12:05:43 -0400
Received: from mail-oi0-f44.google.com ([209.85.218.44]:34101 "EHLO
        mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755606AbcIKQFn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Sep 2016 12:05:43 -0400
Received: by mail-oi0-f44.google.com with SMTP id m11so257598741oif.1
        for <git@vger.kernel.org>; Sun, 11 Sep 2016 09:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=piD3iTRbZEiZES0AIkvk/vAS8rWGpSCtvwhxe6fvyw0=;
        b=Ufg7iwuBk8/ogMXxdk+9a5y2qi64iuGIEMzQ/p8KBloO6nqAj8pYFxo+nXY6z+l/35
         Cf55ybOFJhj4HFWBdkvzf99GfYOmaSp8Ds0I5w0eRpQeswmJpxwGphYVdQjVQPzqkU5T
         LFRMc6CTgqip/V9EDa2qWFr0I/O8G4fh9mJsBuKxkRdtLEA9cFYIZLYSt76YtIHtA8ND
         /cnzUpflJGw5DgE+dJ149SOEY8ZSLew7eYrbTAfaMuvl/D9wuT+Ht4jlDuiWILQUCe62
         AKjysSV7lYjvK3uV4Bdu94WlQEVmqOmdj7bUBmOCV9gm6yC/ApVcTkqrvaLyU0lGE3j4
         K7CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=piD3iTRbZEiZES0AIkvk/vAS8rWGpSCtvwhxe6fvyw0=;
        b=cH7R2HVWIzeDWvypmjMfbWyQUwchKqWVVj7TJG5zfNqNKPnHC4HU3ZyrUVtysweWmd
         3lKPCeoq7u0A2sBKuUqn2icyafMqZowX7wxfKpHnbTiYVqqIC1ZUYnwRReVdOsTqQ6gT
         vhFqsFBAftPCfUHUTWS+ALegpK9rS7gtTmkjaNSPpoR5PnaqKRWhEzcHj7V0LD8P0Y1W
         V1dvUFShEUQe7odrQ9D8Uv86JW7yWLCL7Cgun4m4OQOkKbt0xaaO1jQI1h8m6Skfw+dv
         PEErTguFUIxQHIpW2gLGCAPREPAeX6mfOHcaYJQ5po91JUaRYsBKE1Vry4/nOrRQQYqR
         jMiw==
X-Gm-Message-State: AE9vXwMaTZZm1fJboualG+fwRcIFRf1IJRYtEcj1ktmSbQWAcCPApnc8aH7yKZqRy9U6zcJgUMfc4gIpmbTaAmO4
X-Received: by 10.157.6.197 with SMTP id 63mr19163733otx.190.1473609941961;
 Sun, 11 Sep 2016 09:05:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Sun, 11 Sep 2016 09:05:41 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1609101014530.129229@virtualbox>
References: <4c42a1f4-4f03-0fdf-8bd2-8a7f1f978073@accelya.com>
 <CAGZ79kYu=0ik9W9g5yCbc5142_a2fb1er45TFEZ6RrekZRZM9w@mail.gmail.com> <alpine.DEB.2.20.1609101014530.129229@virtualbox>
From:   Stefan Beller <sbeller@google.com>
Date:   Sun, 11 Sep 2016 09:05:41 -0700
Message-ID: <CAGZ79kYZuiY5Nzuxgs0Yz41NM1xQprL6YjiJaWCMg1szv=fssA@mail.gmail.com>
Subject: Re: Missing RPM spec file in tarball
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?UTF-8?Q?Sergio_Mart=C3=ADn_Turiel?= <sergio.martin@accelya.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 10, 2016 at 1:15 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Stefan,
>
> On Fri, 9 Sep 2016, Stefan Beller wrote:
>
>> On Fri, Sep 9, 2016 at 9:19 AM, Sergio Mart=C3=ADn Turiel
>> <sergio.martin@accelya.com> wrote:
>>
>> > Can you tell me what I'm doing wrong?
>>
>> Not crying out loud when that commit was discussed on the
>> mailing list. ;)
>
> Umm, I think it would be more: "Not stepping up to maintain the RPM
> specs"...
>
> ;-)

You are right of course.

Thanks,
Stefan

>
> Ciao,
> Dscho

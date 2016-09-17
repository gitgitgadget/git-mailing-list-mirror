Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D48FB1FCA9
	for <e@80x24.org>; Sat, 17 Sep 2016 19:21:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754536AbcIQTVw (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Sep 2016 15:21:52 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:38290 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752226AbcIQTVv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Sep 2016 15:21:51 -0400
Received: by mail-wm0-f50.google.com with SMTP id 1so94438560wmz.1
        for <git@vger.kernel.org>; Sat, 17 Sep 2016 12:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9zN81gnKZ1v8CzAEnl2JaRPrVJt8d+6jq4CpZ1ZWuy0=;
        b=zaZ3wclDM6G0zIrtSThsO44bMe2bhVg8u7/q48Vdk4w+hvpyKm650SRzuCWrbK38XM
         cJ+LSyWF55QB9d9MAzOArQHLOcSoUIuML8KIFnsxHLwdAkEW1G1L0BdlyNB+sFBaiX5/
         WHBv3zY7tZiwhVzXWXTLFUX5W3kX7pJ+RjEpv6NIqiHT3+AVVPozPf0HvipQfcjgmpIL
         byROALaQh3E/XnMKwMsX7t/H3E8aAB31i5Giad3015Ch44RhkdqyAFZz9FiCwQBYbk5T
         f/7c4b+IVM41XsrU/VfNnKfJB8Ttj2wNLmSFgzfjUEaCxxD448J2p6lyd5bsgduFdhvG
         MmJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9zN81gnKZ1v8CzAEnl2JaRPrVJt8d+6jq4CpZ1ZWuy0=;
        b=Lwthlcy4NjtSsBmsojS7RCeU5wjUqWz9wcoYoTgQIgq7AecpkrSPRrjvvaeH0gvhSa
         FMfaxy8F4r/SV72Jb64lqG4iz3QqrQc2hbQzTF1nNq0PhPuvyWluyLD4HmfEuuFvZIbG
         Ufinul2hUnoXo8IUhuaklpHuWb/7i7O2EfSi5pGZUQb1T+eG8s/l7JFgzpodxZalytPi
         J0PTKgC/mDxzn/rBvjBi5hQEPvOJ2RqtfD9HR9zc0kR5bETY1qOY0/nMqv+ZqfO2N/rU
         y/DtUQ5ra9M7Bp0ZQoIrGWKOK8srtV3NXHrIrjblkAFBhDZBv6Co3S5Fz54FnSB0YaVZ
         ESaQ==
X-Gm-Message-State: AE9vXwPH+mm+T7zEAU3+DWMx3qjEJUP2lgIY1ZeDJ48o/QCJPSwuVP0JNUiCyvwM+9mPhADru1mF9+exmgq30g==
X-Received: by 10.28.22.138 with SMTP id 132mr2666261wmw.7.1474140109698; Sat,
 17 Sep 2016 12:21:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.38.132 with HTTP; Sat, 17 Sep 2016 12:21:48 -0700 (PDT)
In-Reply-To: <20160917183919.GJ20666@paksenarrion.iveqy.com>
References: <CAM_5GX48gDAZSvAWnxO5n8uhYf8vmfAJ88_31_ewsQxyPfF7iA@mail.gmail.com>
 <20160917183919.GJ20666@paksenarrion.iveqy.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 17 Sep 2016 21:21:48 +0200
Message-ID: <CAP8UFD3TPeqY_O-Rc0rvLMO=XVxRMTMwq3gftpnx5LJh6WOZ1A@mail.gmail.com>
Subject: Re: Why are there multiple ways to get the manual in Git?
To:     Fredrik Gustafsson <iveqy@iveqy.com>
Cc:     Andrew Johnson <ajohnson388@gmail.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 17, 2016 at 8:39 PM, Fredrik Gustafsson <iveqy@iveqy.com> wrote:
> On Sat, Sep 17, 2016 at 01:47:52PM -0400, Andrew Johnson wrote:
>> $ git help <verb>
>> $ git <verb> --help
>> $ man git-<verb>
>>
>> I tested all three to confirm they were equivalent.

Maybe it will be easier to understand if you try:

$ git help help

or

$ git help --help

or

$ man git-help

:-)

> While I'm not able to answer your question, I can shred a little light
> about them not being equal. For example using a windows machine
>
> $ man git <verb>

(It should be "git-<verb>" above.)

> does not work and
>
> $ git help <verb>
>
> opens a webbrowser instead of a man page.

Yeah, it is one of the reasons.
There are systems where "man" is not the standard ways to get help,
and text on the command line is not the prefered format for help
content.
So the "git help" command has different default depending on the OS to
better suit user expectations on each OS.
This way people can just be teached to use "git help" and that will do
something sensible everywhere.

> Using a unix system I would
> however assume that
>
> $ man git <verb>

(Again it should be "git-<verb>" above.)

> would work since it's the standard way of getting help on those systems.

Yeah, so we need that to work to make people happy on unix systems.

Another reason is that "git help" provides more configurability and
more features like its -a and -g options.
It could provide even more in the future, like options to search in
the documentation.

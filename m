From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v9 2/3] t7507-commit-verbose: make test suite use write_script
Date: Fri, 25 Mar 2016 19:06:20 -0400
Message-ID: <CAPig+cTFCB-FMqKPApJw2z8ZWZaE7zJ70kod_kQHvLv2U4=DXA@mail.gmail.com>
References: <01020153a7ba4eae-9b88e119-0505-418f-a137-595250edaa9d-000000@eu-west-1.amazonses.com>
	<1458817259-11675-1-git-send-email-szeder@ira.uka.de>
	<CAPig+cQJ1yK8WhXE0sxSmDenMt1DMZCoJypTu_wkDsDyuBsAWg@mail.gmail.com>
	<20160325154638.Horde.LzlsD6cZcQfmt894cll_0Tl@webmail.informatik.kit.edu>
	<CAPig+cQLOwAimmHeUmi5+KScgOP0hr9-MiX8gyGcEk6Zj0U_jQ@mail.gmail.com>
	<CAFZEwPPRYBjdDabLJHsXTtzD2y=vqSZM4OiY4G=BtEF485JP_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Git List <git@vger.kernel.org>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 26 00:06:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajaoE-0008Bf-DR
	for gcvg-git-2@plane.gmane.org; Sat, 26 Mar 2016 00:06:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751475AbcCYXGW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2016 19:06:22 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:34617 "EHLO
	mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751127AbcCYXGV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2016 19:06:21 -0400
Received: by mail-vk0-f66.google.com with SMTP id e6so8954839vkh.1
        for <git@vger.kernel.org>; Fri, 25 Mar 2016 16:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=VIaxzbDwjtnsEG0fQk5IRiBkdjJMACSYZ5/nGqjE1rI=;
        b=VO5REXRS7YOylnrjlVm2aE9MazsneLp59w6TFz5ct1CMSyGG/uFWI9lqghNZOmTa7x
         AQI79sL0VOgbIjVQRTKdjKljG0Z6AYcxuQS1FrzYuJREvBz10P+ZIQwnh63H37UvAOGg
         FmSdpc4HGtdt10NHkq1+XG+wtHTe5UMWoEuWfzCAGHGZBJrfGcsvpLlZUgWVjjt1j/fk
         /gM4z0vBYYnOMOhCDG6BHPaCJ3ntxYck6WmaMjk4wQOKACrA+SEckK6ZqBR5NQTRsx1C
         1gw7L1yac7wvN2f3gw1OMsTjLf9PvGjNiI+ZUbE+xok5rq4cJ5NRSSegnVOPic6nMC+K
         gxRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=VIaxzbDwjtnsEG0fQk5IRiBkdjJMACSYZ5/nGqjE1rI=;
        b=dd9jIgeiABibgT9zzp1lE4G/KOYQu6FPp25jWKA0Rw9joKBLIo/2w5lcDzlimMc5zA
         M3KaP1feCp/8knvL3W77wjmLP8jeWBvs4IBFg8+VohXsBMkMagLXopOBktuI8mxMz4J1
         Md/qs0/6MafSuOn7NN9TvVTtFYlCuX6wM3vF68m5TwqbgisyQwqw33A81Zwg6/3BND6W
         R+2OJsqry23hWx0UTWKZLf9zxDGi24kmNnPYYoGjKBiSWZqBAMqt/vbO3EXkW3gSTxi2
         SpH+kapRPvpKMR+KlSPskJTWBlP7bRFMaAvFcWZNjMoa+tXO/6r6qXNyWBxg2DVXxxCF
         UE8w==
X-Gm-Message-State: AD7BkJI7yOCE4alO8Vv7KBjKyC/mCaZhmnpqW/JnLCDkFUIKPqwf1+1JEYlyLwwGyp/I+L5iOTlMMNo2L3eA8Q==
X-Received: by 10.31.146.5 with SMTP id u5mr7431741vkd.19.1458947180615; Fri,
 25 Mar 2016 16:06:20 -0700 (PDT)
Received: by 10.31.62.203 with HTTP; Fri, 25 Mar 2016 16:06:20 -0700 (PDT)
In-Reply-To: <CAFZEwPPRYBjdDabLJHsXTtzD2y=vqSZM4OiY4G=BtEF485JP_A@mail.gmail.com>
X-Google-Sender-Auth: sejQF4aLZTKnfeznTyscomPoFu4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289965>

On Fri, Mar 25, 2016 at 2:15 PM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
> On Fri, Mar 25, 2016 at 10:34 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> That works too, simplifying the overall implementation, and
>> eliminating the need for the introductory patch which moves
>> 'test_set_editor' into each test.
>
> Wouldn't it be cleaner if the introductory patch contain:
> 1. using write_script()
> 2. grep the output to a file
> 3. test for no of lines=1 in required tests
> ?

You could do that.

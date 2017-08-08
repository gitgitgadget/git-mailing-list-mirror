Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47C9E20899
	for <e@80x24.org>; Tue,  8 Aug 2017 17:21:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752212AbdHHRVK (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 13:21:10 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:34117 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752162AbdHHRVJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 13:21:09 -0400
Received: by mail-pf0-f169.google.com with SMTP id o86so17121540pfj.1
        for <git@vger.kernel.org>; Tue, 08 Aug 2017 10:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iGMRBY+tRzuER43rHAx4UDcbqV84VG4vTJQ5sD2Ppvc=;
        b=haJRRPcKq4swr5b9i0XRMa7yoYNvpwA+D0kawyp623eiSyqn9u2xVAIjItVN5cuAqY
         PEIKriJun2i3KYaZgeujsJiTbYRwKgYDcGjIkJGq3ZTxZFtZ5d4kxtCgy73u8P5olV3k
         8L/vfviPVdzev92/qqTaiwxK5DxLjwTcjVZh7SrxQ3W0+CEVHtOI1JgXRtx0d83pg4it
         ko7oj5nwdor9IZoQibLY32hxYq/6R4r1sXfDs9OtwIPU4nhXNQtdfAVHtKVORqOM4M86
         g4GnwpPYdSivzG+qbyijqIeZYYcgUbj+lDT8YF42jV72slv6pB+cfVoM3TatMJf3yQwW
         ru1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iGMRBY+tRzuER43rHAx4UDcbqV84VG4vTJQ5sD2Ppvc=;
        b=tDWLtH7Ch2gxeyDvWLxTZJp41onwoP/VT0b/HsUOOeISRlu42ekfewOsPTOhcKlhMl
         gv4T2fZcNQFWcTa6133tQfHxcHHIY6FZ71RhuHtX3LKE2JnV60niH3uiu132DTIbflYo
         StP/SNDkpTB7w1Y4M6O8x8BJOGFD/mCRPnt4BT0SjEoVz1bAx/XbXmQaRGivgnnQ3+qZ
         4N8gZ0MQapY3l0ib8UF+9tdPqhpioCQugFX6pZN3BT0QVzUcZKvyfsbyl1Y6va4iEbKl
         LnoYS2NGImDgp3i5PlIYpnAV9qMsfemRT55zaLdAfz7R2DS8MSutlBH2O8BSTHW9w4XJ
         H1VQ==
X-Gm-Message-State: AHYfb5glq6giPHUAqp6WFu+BKyQV9xye9FMkurR+9ur3h6Nm5fuUk+tN
        t3WtF/gaN0kVC7uHA6EUAyaR28lO3w==
X-Received: by 10.84.224.77 with SMTP id a13mr5490693plt.43.1502212868999;
 Tue, 08 Aug 2017 10:21:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.165.238 with HTTP; Tue, 8 Aug 2017 10:21:08 -0700 (PDT)
In-Reply-To: <xmqqbmnqc7od.fsf@gitster.mtv.corp.google.com>
References: <cover.1502128418.git.martin.agren@gmail.com> <CAGZ79kaEA7DRm4inO=XPCVvA3mJioV_yckAVEUbCo5DEwoxbUQ@mail.gmail.com>
 <xmqq1sonozdx.fsf@gitster.mtv.corp.google.com> <CAN0heSqbi-2VzhXtFO--v2+kMKuUbt4Z3QgtjW6WLEFP+VeoTg@mail.gmail.com>
 <xmqqbmnqc7od.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 8 Aug 2017 19:21:08 +0200
Message-ID: <CAN0heSrRP-FsGjyhp5WNM7u+SAgBtRb-dkPcX52Ay6j3hakGLg@mail.gmail.com>
Subject: Re: [PATCH 0/6] clean up parsing of maybe_bool
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Dave Borowitz <dborowitz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8 August 2017 at 19:04, Junio C Hamano <gitster@pobox.com> wrote:
> Martin =C3=85gren <martin.agren@gmail.com> writes:
>
>> Thanks, both of you. I could wait a couple of days to see if there are
>> other things to address, then send a v2 with a more aggressive patch 5?
>
> Sounds like a plan.  If there aren't anything else, I personally do
> not mind using what is already on the list without v2, though.  That
> would be less work/churn for me ;-)

Sure. I'll try to remember to send a patch to kill git_config_maybe_bool
some time from now. (At which point you'll get more work.. ;) )

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F3D81F6C1
	for <e@80x24.org>; Wed, 17 Aug 2016 10:50:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752632AbcHQKt7 (ORCPT <rfc822;e@80x24.org>);
	Wed, 17 Aug 2016 06:49:59 -0400
Received: from mail-io0-f174.google.com ([209.85.223.174]:35748 "EHLO
	mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752378AbcHQKt6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2016 06:49:58 -0400
Received: by mail-io0-f174.google.com with SMTP id m101so132191729ioi.2
        for <git@vger.kernel.org>; Wed, 17 Aug 2016 03:49:57 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=wNr3klkIWTa2xPyUkBFRYHeyK1rQfOxD6u50anConTM=;
        b=qqbi5R4Qv7VH6L2U/thsRSVcTV5fJzce2NQFnq7urJcDA/EAhBJ5T3ktZeBirlzphi
         crua0jFyqCDhuMZ++uGwi2oK6Vs28bkc421nJpTdglbXPE0pJ7xu/1ZkuRjTcVebttCh
         YSZnpQyW96bkmFU8edWucZFQ1QQmb2s2j1bNm2emeAiRbXFjOYxu0jh9x1145nehcc5y
         Btric8eyMFBMwcWMD+HY3tgyAZJq2WtwmVvvwELV7F5HedE0Sy9YhWTvbMrv4Iy6Hcus
         rQofVacgWMnAxq2apEtd4PPRRMRu304OzJB3w2dMw6jBiXfeBDwquk9/gfo+vgVM8lj5
         Voig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=wNr3klkIWTa2xPyUkBFRYHeyK1rQfOxD6u50anConTM=;
        b=HWWMc5GQaxpimWRpicFo7TFfneiS1+G5WXu84CFzy4Jba27zbVQdL5dSmOUpNBJkPg
         L1xCeCOtBmiJDOLREqfA39NECEHWP8mJskIPgUgnJKPkUdXwCWdkLz/FsFIAA6K4sglw
         0BgZIdr2nTz3W9eLXWuUyWEdOD6QHzM0imXjjrFJqMRAuqGVMWv2toW4NP+8+VWTQFZD
         QkzltrWPaHB7dVYmLozr6POof6hZJkliMlZoUdIy6OKlXoEcG/9ED2JhSkJAFrzSBKmR
         0xP9ydP5yN+cGie/T0e9TNbTmw/xDhu0AtWo5rNQ2gpl+ZCfueGMjiZErtS1KoRJ5IZT
         2kbA==
X-Gm-Message-State: AEkoouvRymhXUOnBnpVERrkXkabo1Fgi9hcJgoH2siXHNLt/bP2kbFDcQRKvRyVSPqrNPzexplU4ssJs/SJ9Dw==
X-Received: by 10.107.2.78 with SMTP id 75mr46082701ioc.128.1471430997377;
 Wed, 17 Aug 2016 03:49:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.125.199 with HTTP; Wed, 17 Aug 2016 03:49:26 -0700 (PDT)
In-Reply-To: <xmqqmvkfj7dz.fsf@gitster.mtv.corp.google.com>
References: <xmqqmvkfj7dz.fsf@gitster.mtv.corp.google.com>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Wed, 17 Aug 2016 17:49:26 +0700
Message-ID: <CACsJy8BYk1t5cfN_dgc8o3HCi8Rqz9aM_5XFWMUkMTKXu2R7=A@mail.gmail.com>
Subject: Re: What's cooking in git.git (Aug 2016, #06; Sun, 14)
To:	Junio C Hamano <gitster@pobox.com>,
	David Turner <novalis@novalis.org>
Cc:	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Aug 15, 2016 at 5:46 AM, Junio C Hamano <gitster@pobox.com> wrote:
> * dt/index-helper (2016-07-06) 21 commits
>
>  A new "index-helper" daemon has been introduced to give newly
>  spawned Git process a quicker access to the data in the index, and
>  optionally interface with the watchman daemon to further reduce the
>  refresh cost.
>
>  Not quite ready yet, it seems.
>  cf. <alpine.DEB.2.20.1607061016330.6426@virtualbox>
>  cf. <CACsJy8AiER_=5aJ65r+GPCE_nXbrPTAMKJi=FuJgT8zzV2-NFw@mail.gmail.com>

David I can take back this series if you are busy or no longer interested in it.

If so, Junio, since I may try some slightly different direction first,
it may take a while before I resubmit, feel free to drop it if it adds
work to you.

> * nd/shallow-deepen (2016-06-13) 27 commits
>
>  The existing "git fetch --depth=<n>" option was hard to use
>  correctly when making the history of an existing shallow clone
>  deeper.  A new option, "--deepen=<n>", has been added to make this
>  easier to use.  "git clone" also learned "--shallow-since=<date>"
>  and "--shallow-exclude=<tag>" options to make it easier to specify
>  "I am interested only in the recent N months worth of history" and
>  "Give me only the history since that version".
>
>  Needs review.
>
>  Rerolled.  What this topic attempts to achieve is worthwhile, I
>  would think.

I guess I can't do anything to help speed this up?
-- 
Duy

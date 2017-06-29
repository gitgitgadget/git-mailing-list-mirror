Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 392BA202B5
	for <e@80x24.org>; Thu, 29 Jun 2017 11:47:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752403AbdF2LrZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Jun 2017 07:47:25 -0400
Received: from mail-ua0-f171.google.com ([209.85.217.171]:33235 "EHLO
        mail-ua0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751729AbdF2LrY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jun 2017 07:47:24 -0400
Received: by mail-ua0-f171.google.com with SMTP id w19so34354912uac.0
        for <git@vger.kernel.org>; Thu, 29 Jun 2017 04:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Nz9leQOz/A8goYkFcba0zMUnGzjznTpHW3nOLFi4ZjA=;
        b=iIYeRV9Jf5eYs5WdJaUKeXDPUYNBuMRc0T8E9+Fl54TU1VYqWLOtW7IolVr3fXnmOW
         +dx+rWBzKHT39GHcxeH17RGrOBYdFYRXlTU7VAoK9yTMidsYHSr165IRI+BaqYhaobBB
         mdhCOEc1nHSRQteV1NLoPaCIlmE5eax8u9R89kMKXodn6LuoVoG1TA9g7HTWRgvpBa8w
         b3pvIcX5ZfdfwzrGf7hIqHvtTsCZRaXn+VNVQBZu4YTtaSWnl9K++jqZsvW8hppO9ROy
         ZAENENTTlymA5vqWd7NHa38KxNLwGkgU0fuE10kLUfKwao2wBZlyV+fo8k3giby2x/p/
         +u2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Nz9leQOz/A8goYkFcba0zMUnGzjznTpHW3nOLFi4ZjA=;
        b=tAjduxj61U2e+qtHTc3yvBJL23C+aBANDBEExGvrqjTqfrDx05h603JGqeBkQnkfKG
         xjhhMt32EPKbLZwc1Z3jnCNgXoy/VJHrOgDfO3gBht8WzeNOe9OWd9oT3wNOCE3It7W0
         OO+QTIRNIjZZ9R0oLoxtjjSHyhBWAPD6S+6TXClUMMRp+f6QqVD+CQ1mNDzvl4jfxPz7
         IOHYaM34penjZagajjiloRmN4W/3RbXqfDKWHSn8ae9xlNKJn6S+m5QgT2HwESAZmrED
         H2bH2RKyX2fwkbfext0k7YgRbJirZmDPlSbgrkypRwThZlsOy++P+1qatKCY+84k8cI6
         RmOw==
X-Gm-Message-State: AKS2vOyIU72IxrysAP7WII3OQ71lRxvJ9eBtxW5XkvhZdeUinnlfd0FA
        VM3mrnfcJ7a9fIYhq/cHhGFvzvroOw==
X-Received: by 10.176.24.172 with SMTP id t44mr9536744uag.16.1498736843217;
 Thu, 29 Jun 2017 04:47:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.77.139 with HTTP; Thu, 29 Jun 2017 04:47:22 -0700 (PDT)
In-Reply-To: <xmqq60ffx51d.fsf@gitster.mtv.corp.google.com>
References: <CAME+mvUrr8EA-6jbCZdpB7dMZ5CN3RyY7yoRoUBoiZw=sH6Ysw@mail.gmail.com>
 <20170626231108.23640-1-pc44800@gmail.com> <xmqq60ffx51d.fsf@gitster.mtv.corp.google.com>
From:   Prathamesh Chavan <pc44800@gmail.com>
Date:   Thu, 29 Jun 2017 17:17:22 +0530
Message-ID: <CAME+mvUbkT-QSbnU62nsfT1SEKFi7OQ4OeUQZYfJ3R=xb3cceg@mail.gmail.com>
Subject: Re: [GSoC][PATCH 1/6 v2] submodule--helper: introduce for_each_submodule_list
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>> This series of patches is based on the 'next' branch.
>
> The reason not to base on 'master' is...?
>

The reason it wasn't based on 'master' was that it depended on the commit:
dir: create function count_slashes(),
which was merged to 'next' a few days back.

> The thing is that a topic built on 'next' cannot be merged down to
> 'master' until _all_ other topics in 'next' graduate to 'master',
> which may never happen.  If you are depending on one or more topics,
> please make sure to name them.  Then we can
>
>  (1) create a branch from the tip of 'master';
>  (2) merge these topics you depend on into that branch; and then
>  (3) apply these patches.
>
I'll soon be updating this patch series and will create the new patch series in
accordance with the above routine.

> The topic still needs to wait until these other topis graduate, but
> at least you would not be blocked by unrelated topics that way.
>
> You _might_ be building on 'next' because you want to make sure that
> your topic works not just with master but also want to make sure
> that there won't be any unexpected breakage when used with topics in
> 'next', even though your topic does not depend on anything in 'next'
> in particular.  It is a good development discipline to pay attention
> to other topics in flight and I applaud you for it if that is why
> you based it on 'next'.  But the right way to do it would be to
> build your topic on 'master', and then in addition to testing the
> topic by itself, also make a trial merge of your topic into 'next'
> and test the result as well.
>
Thanks for making me aware about this as well. And will be following this
before sending out the updated patch-series.

Thanks,
Prathamesh Chavan

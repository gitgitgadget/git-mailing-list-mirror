Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E505F1FA7B
	for <e@80x24.org>; Thu, 22 Jun 2017 18:54:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752669AbdFVSye (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 14:54:34 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:33891 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751221AbdFVSyd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 14:54:33 -0400
Received: by mail-pf0-f169.google.com with SMTP id s66so12632733pfs.1
        for <git@vger.kernel.org>; Thu, 22 Jun 2017 11:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6H2GCFHpxPco8UbFyONUUDQ1w4XNy2Fa+hzj0JIWUdo=;
        b=X2uJLgWi//sqXlVCHFVMYc+0eHKbQPhN04yA2FKyUl4qdfm2F05no66VEuiR3phW8T
         Is089/qcdZBL57ApqvJneahBI6xqrXwZv+2jlYURtZVHz0mYFaNqWHY7ehjz/l1QtXcL
         4n1yLADYL5M9VKEFTdPp1X9LcXB0HoI81c1FIxLIqWTqAmf5pUqnlIG1WNsqg+6fftqx
         iMEI6SO/YYbR7ciZoqjtIECKkZ4ZT/YvUkVael5zvI3+diujM83lO2SMcppjcNOoUQbj
         XuB66XFpRoa4Jy1vSj9VLR9Fqcz1hrYZUmil84jbmz4FRfu/eQbCHwllQM4iEZdhFYmD
         yI3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6H2GCFHpxPco8UbFyONUUDQ1w4XNy2Fa+hzj0JIWUdo=;
        b=OKoffq0ii4T8oETdUjMPdZqD+PONEdRyQ/9+DPrlXwKnrMtmt2XtbMFAplNC3FGWyr
         yTq4V4H1xERBKSr5WskP+JjflImOSiqni3kOlFXYvxHtx6/7sEAL9wbMjDStUEOB4LE3
         3ZtvR3XXEbgM3gnKIX3ZPIuISMNcPC8JyZF/1sKs2LzHc1kB8ACvvdo70MnF7kR99qFs
         S5lnI+FHzlIrTQ3s17y/7Fhf3NWZo/0610fxgW3OkbEtR1vfWpuSGMQjK58vt0Q7/dh/
         U5044JRINeVxi2LXbv7sVcn1OEkcsYxXsWd+1XUhBkpQglOjiepYawc/ykUOkz8laPdF
         T+IA==
X-Gm-Message-State: AKS2vOzD6dI3djZVoy3DHvwMBV90a4fGM8z+lk0jX8ees9w+haPmW/+B
        Sca++dFidB5EVY1helYeUmhL+6RX5qVr
X-Received: by 10.99.120.199 with SMTP id t190mr4146495pgc.176.1498157673017;
 Thu, 22 Jun 2017 11:54:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.161.227 with HTTP; Thu, 22 Jun 2017 11:54:32 -0700 (PDT)
In-Reply-To: <20170622174659.GA124061@google.com>
References: <20170607185354.10050-1-sbeller@google.com> <20170620225650.7573-1-sbeller@google.com>
 <20170622174659.GA124061@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 22 Jun 2017 11:54:32 -0700
Message-ID: <CAGZ79kbSwwDKh9TH0XUiXzJgPxb0OzVPBSNkjGfSB+uOGmOgUw@mail.gmail.com>
Subject: Re: [PATCHv2] submodules: overhaul documentation
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>> + * the `.gitmodules` file inside the superproject. A project usually
>> +   includes this file to suggest defaults for the upstream collection
>> +   of repositories.
>
> I dislike this last point.  Realistically we don't want this right?  So
> perhaps we shouldn't include it?

Well, it describes the current situation accurately. In a resend
I'll de-emphasize it.

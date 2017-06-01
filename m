Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1FC320D0A
	for <e@80x24.org>; Thu,  1 Jun 2017 22:21:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751122AbdFAWVi (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 18:21:38 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:36206 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751105AbdFAWVh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 18:21:37 -0400
Received: by mail-pf0-f172.google.com with SMTP id m17so38918439pfg.3
        for <git@vger.kernel.org>; Thu, 01 Jun 2017 15:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+lcCAmkVv2IqB3Ti2uaMXiRs/AZKXJa93c9Ap+dKESw=;
        b=lID5LD9iXk/0XGbsmTAdaT3bb50TodIhAUZInNxwVdhZLzfotjxs6KmyOU4G3GD0lu
         PY1ULYXtQA79ouXnYFusNNkvTUnEmYb55VyTWCBZr/WEXmdwTYCRose8kf1JKIuAtgIV
         mb/RjGP/PTHeDc0QDOrs+KSttE0h5QZkwAC3v9n7cttS6Fi+k4hGL4VjbkqcQcOsxWMV
         1THZZD36B6qN+Mg10cGw7DPpRzcQFZkS0TqYJLX0p1s077IX6JoINvtzDVVu0i7PJN/n
         Qc8DWzZbUjUk8NUc59S+d9Zy3rB+CrVSeJE6XDaNKwhLDlhtz243WhCrGVnRsW8MWB2x
         EM8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+lcCAmkVv2IqB3Ti2uaMXiRs/AZKXJa93c9Ap+dKESw=;
        b=W9s0wkHXtzRix5KqCnBCkT5EiW0nOC4Y6pFdxz/HwNUzWWhriXJntbnHwD0umMOvGk
         +pcOMvlnpo4DyIJvu0d4OBLIsykKiLySmp+q6NlNgNUnGltiJJZVw0393zBQCyWKhVT0
         RDVyGgQkMX4DpHbkY7eb1nRGTJEUtsKeOv3Q72obz767DOm1NX/R7gDku1BKHVkenurj
         ve1ejRuwfIN6TrpuDRfqh+Qb8QimDJ6tOe3KlJh+eRFCETyjsPMRxkF2Jdk5H2J5/PZU
         OJvUPzlI+sVv6ju030Hx182gZ9jUZWliYG3znFAiqVhNrjbeyH0/z5IpolamjN484jc1
         iX7g==
X-Gm-Message-State: AODbwcBd1CpvhheXzaJNGo00j+KpL+lEQ0gT/sjIfx/FbLx9DKQR5HWp
        CCY1sr85HHbAmSFsvHBJ+rPZSJonGkRAUntA3Q==
X-Received: by 10.84.174.3 with SMTP id q3mr39386304plb.52.1496355696140; Thu,
 01 Jun 2017 15:21:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.170.200 with HTTP; Thu, 1 Jun 2017 15:21:35 -0700 (PDT)
In-Reply-To: <CAMOGhM+6wyKMN-XtMNSopjy399_CS7gavgvgybswXeQ1uxtrKQ@mail.gmail.com>
References: <CAMOGhMJyO=+EZz6qCejxeTe5FdE=RheJX9A5g3U6eKhUKj8_BQ@mail.gmail.com>
 <CAMOGhMLMo82RgH0HareB78KVWz2gMGzhB1i5s3SobW9wHk0zbg@mail.gmail.com>
 <20170601152624.GA29442@alpha.vpn.ikke.info> <CAMOGhM+6wyKMN-XtMNSopjy399_CS7gavgvgybswXeQ1uxtrKQ@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 1 Jun 2017 15:21:35 -0700
Message-ID: <CAGZ79kaG3r8hMyswPO7sPpjYw2V37ThubhuxDYnF-bLeCRVBBg@mail.gmail.com>
Subject: Re: wrong language translation part7
To:     SJR <haltekx@gmail.com>
Cc:     Kevin Daudt <me@ikke.info>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 1, 2017 at 3:08 PM, SJR <haltekx@gmail.com> wrote:
> So when v2 will be translated to Polish?
>
> Regards,
> JanR

When a volunteer shows up to do the work.

https://github.com/progit/progit2/blob/master/CONTRIBUTING.md

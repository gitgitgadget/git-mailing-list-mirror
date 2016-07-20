Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2CAD1F744
	for <e@80x24.org>; Wed, 20 Jul 2016 20:40:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755006AbcGTUkf (ORCPT <rfc822;e@80x24.org>);
	Wed, 20 Jul 2016 16:40:35 -0400
Received: from mail-yw0-f172.google.com ([209.85.161.172]:35041 "EHLO
	mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752313AbcGTUkd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2016 16:40:33 -0400
Received: by mail-yw0-f172.google.com with SMTP id j12so49252486ywb.2
        for <git@vger.kernel.org>; Wed, 20 Jul 2016 13:40:33 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=gqo40VB+LEYvE3m0yOpedI/fI69dJtRHxEBfhjJqgqA=;
        b=KqJE6amdy3zXGLP1+hyBgaMUmpUOFgCj62wbSLl7dDBY0xJXOFFlMTwtR6IXvCnDzV
         gDR6NzW69x2ymUyU1QEeGvAPw63DpuG26GtFDCOSZ1w6TXTvfHN6JxYgIhYbvAXjKbGG
         uGVx4/Hh3x67fD8x3JSRNg6BNeJXjb5WqOvcYRPXV6vFU8unOp48wgJ9JGWMMlEQ+6Ye
         dfakhBVPlmUiMNCjvuomi5tPGpeFYbk72tgDdZULxyaSVKOTSvqzT9ks4ltgnr3qP07m
         VrRybUkA3tFKOBvRiZkwQT/LVe6tD/DZ3xKAInSeHxZH7cji7cMtBl+eSwlfbyo7UHD+
         S0mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=gqo40VB+LEYvE3m0yOpedI/fI69dJtRHxEBfhjJqgqA=;
        b=ZMr/2602f7LxLUwu+yZ2fOAQ5V55sLiuaPCtWFro9crV4P71eEV6hQBzKRZmGdBqvi
         lIiQS9bm3Kma8Z+wH7tYr1/CFzWjreadoAR6/0t6OSPUcStVtxOkETE5yTuxwolDWcq8
         /dZBEchViNlvoPR6pHlzH/cotsmAEr9dGJaUkeqxg28gC/774ZHRLpgjmbRMv3r+n0sW
         6F48zxha99H+KU02D1T3ClAu24q1DK3TuihZv+SDniMWb5rUk93Nt1KalKFvViJSuC+e
         pt7QbYLMhb1KrbrVa2291D63ADLrUae7c26oqi0iSVHMUF9BeSIoqpuq/i/Msgym2XZL
         TI4w==
X-Gm-Message-State: ALyK8tLcThw0v+4H9iVjQyCZJIJgCVFkfCAPlacjA/K42ZQ+875NM/I0cG3wwNnr7sa+xgxXPi8iNJ95fHExBg==
X-Received: by 10.37.22.85 with SMTP id 82mr31026877ybw.123.1469047232753;
 Wed, 20 Jul 2016 13:40:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.13.250.4 with HTTP; Wed, 20 Jul 2016 13:40:13 -0700 (PDT)
In-Reply-To: <CAP8UFD1TWYct7OJDcP+w8AYNTroquZ++T_1ovt-Z7SrBtn_S+Q@mail.gmail.com>
References: <CAP8UFD2PjKHkcs-EWzDU6eWF9ar7BzOxRB838iFr6iDAaGnkeA@mail.gmail.com>
 <CAPc5daXoL+v-YWy-EQ=d-8m9o8twv6Cs5U_NL14KGzPMVNQUPg@mail.gmail.com> <CAP8UFD1TWYct7OJDcP+w8AYNTroquZ++T_1ovt-Z7SrBtn_S+Q@mail.gmail.com>
From:	Junio C Hamano <gitster@pobox.com>
Date:	Wed, 20 Jul 2016 13:40:13 -0700
X-Google-Sender-Auth: k8-B3GKQMKg1CQKVc81lETVRt0U
Message-ID: <CAPc5daVyjuTquUbYixTNj3hkwNeGd0fsTBe7OmxnEfoa_S1dnA@mail.gmail.com>
Subject: Re: [ANNOUNCE] GitRev News edition 17
To:	Christian Couder <christian.couder@gmail.com>
Cc:	git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Jul 20, 2016 at 1:38 PM, Christian Couder
<christian.couder@gmail.com> wrote:
>> Micronit. 2.9.1 (or 2.9.2) would not be a "major release". 2.9.0 was,
>> and x.y.z (z > 0) are "maintenance releases".
>
> Yeah, I wondered about that when I saw :
>
> https://github.com/git/git.github.io/commit/d2eb8fbbb30594d19fcda731c309ad03229dc5d5
>
> but forgot to ask or do something about it...

As long as it gets fixed quickly, no harm is done.

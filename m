Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF0A91F40E
	for <e@80x24.org>; Wed,  3 Aug 2016 16:09:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753408AbcHCPsK (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 11:48:10 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:35109 "EHLO
	mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751501AbcHCPsJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Aug 2016 11:48:09 -0400
Received: by mail-yw0-f195.google.com with SMTP id r9so17114717ywg.2
        for <git@vger.kernel.org>; Wed, 03 Aug 2016 08:47:22 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=TLIb5xS0vQgDOBSdHxtqLjAaUKetc7qJh7+AIa5q/+8=;
        b=AQ5w069C5FdCbg+HKSZLtu/50Lf3e9bENxwLxXGL7Ie/t6m6AQ/uz6UCbOxODlPkdd
         w+nqgka4ZGyfYt7n4Imu9nDay3ncw93I/AVlaScbkf5Rlw+/0Y88FgHBFcUMb5wB70p2
         e03cjRhUsdmY3dru8cqKzhjDW8KSj6G0iolqVbPNguRgDB+xnwu0eEV2NwR9ESNfXIkr
         vex4FkWPP6OEll+JZE8Q+DeoB/y6gMwR9zKAAvLQnvedjb15HQRi0HaC9KAPDOMp2IDu
         rtxF/gIPl+dPeml7IpzX98WFD4L+A50Yo4FdIDgDm1QTd/8iSqQ53NrmiZnCduBAJSr/
         oAgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=TLIb5xS0vQgDOBSdHxtqLjAaUKetc7qJh7+AIa5q/+8=;
        b=WS2i7kQq+xA221Nknw/9rreKcNgaOjZ+btqudXFg29ZrOf8CkDubbSLS+z+VJalJ5A
         oVqLZvz3y/MbNt6EvzGsuMF8DSPRgXBky89j4SW1Ve0X2XKymR0/TcZe6E9aOeUO06gn
         cEI2FR45aXrWMpSas+ci/hkT501EkMYVJm/fJImHR5YvOu9YCy5jIQZpBFVapXmVohQL
         pqppWvHxFH/DBrDbHaoMZyUiC9XbImlBEvXAr8jOmTS9oVv8bjjWtVqAka1j5re79bUe
         NU4E5B6B3Xgx2sY4tFrMI/VHMQWuCyKkFXMh8/aVsTyyTapxXUl/XRMtKwkOgiD68kz3
         fR0g==
X-Gm-Message-State: AEkoouuQ+633z8uqN9UAkwPbaPumoX8rtqT2whlChMS5FhYyViwERo4qjBtdLxHeafbrRyE6lOAKw2rGvgk2pA==
X-Received: by 10.13.215.145 with SMTP id z139mr52895329ywd.275.1470238199145;
 Wed, 03 Aug 2016 08:29:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.13.250.4 with HTTP; Wed, 3 Aug 2016 08:29:38 -0700 (PDT)
In-Reply-To: <d3fccd33-1aa2-7e91-9389-df6507861522@gmail.com>
References: <xmqqlh0ebyhn.fsf@gitster.mtv.corp.google.com> <d3fccd33-1aa2-7e91-9389-df6507861522@gmail.com>
From:	Junio C Hamano <gitster@pobox.com>
Date:	Wed, 3 Aug 2016 08:29:38 -0700
X-Google-Sender-Auth: GO0Nf8lvMRw3FldSTKHpQZN3IhE
Message-ID: <CAPc5daU_-MYk7vDm4+Ceah_iseJa2SJnGq9=UmCoX-kri+kdow@mail.gmail.com>
Subject: Re: What's cooking in git.git (Aug 2016, #01; Tue, 2)
To:	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Cc:	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Aug 3, 2016 at 5:24 AM, Jakub Narębski <jnareb@gmail.com> wrote:>
> Could you apply the first part (the first patch) of the series,
> namely:
>
>    - clarify %f documentation

Thanks. That's a good idea.

> P.S. I guess that filter.<driver>.process series is considered
>      pre-cooking?

Yes. I've been waiting to see that the amount and quality of
comments from others indicate that the series passed
the phase that goes through frequent rerolls. Having a
serious review in the thread that demonstrates and
concludes that it is well designed, well implemented,
and ready to go would help, of course.

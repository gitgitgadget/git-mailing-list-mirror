Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CE9D203E1
	for <e@80x24.org>; Tue, 26 Jul 2016 09:15:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751918AbcGZJP4 (ORCPT <rfc822;e@80x24.org>);
	Tue, 26 Jul 2016 05:15:56 -0400
Received: from mail-qk0-f178.google.com ([209.85.220.178]:36801 "EHLO
	mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753229AbcGZJPy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2016 05:15:54 -0400
Received: by mail-qk0-f178.google.com with SMTP id x1so602527qkb.3
        for <git@vger.kernel.org>; Tue, 26 Jul 2016 02:15:53 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6xnyfpOE2E3muKrENgSAu0CIroalTnPuzK5CDy3vG0M=;
        b=sOODq1ukQqqS5uqGuTBWGx0CkMPJYSTbArEq2pEUeAZpRwwCC4P+MgLk0TjwLrR2Ef
         YeFKdT3uc6YfrErZOIXFJs8NtqjR0KS7KqrA/thx2hUNfpqWVVWiFTfo+6/lk9WVTYE6
         26VjxlmVC62rYb/i1vObGsqXlR/JxvWIjs1PIoal1H6TsFowKonGnbzYihHZ42nJyKna
         LEUCVLlrPn21dg9oeXyibFNdYK9fgQrU6bGzb4l6aeMRc0oAgiF+eio/8QgjN0lhvTgG
         ccsJvTsHKIMrza6odnyR6NBInYe2B0pkaQz9OHAKzfu+2B1TkDP/8u7SQKq6r9iOBhXj
         qu+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6xnyfpOE2E3muKrENgSAu0CIroalTnPuzK5CDy3vG0M=;
        b=RNwUadWBzL8CvKEs5RzZAxHhtQaq7R2is/oILaHDznwuXLr1kH9ceOZv5O/1++wsOc
         MMv46BCzESGKwktAc1TuIxc37vlvVZF/KEL2gStZeYCssgAb3VYaNqzHsOG5FxMbyKEz
         5ZLeZoeEjG6ozHA1RnJPBtz5WugjlWPIsC/1RRYnkMMgetnRfwqMGjlcVBX2XSnypaO4
         ox2gaOupSHn7c4oRGsXSINRXtj/8s0uuacouPmzqLVR64KUGwpbEmZ1ZlNXchtWSq8Wu
         hpBOp7mYOE9dagXi58vc3h/RdvYhftKGs2xTK7O8ZxIM71bFvMzZLlkHZq5f4GHqT1w8
         92DA==
X-Gm-Message-State: AEkooutS4f8hwFUaEwB8VTddB/8fR2Nv/7CATqzg+wDt7EsVciCRVMaS5tGyXxEJ0w+HySeroutrLhnrWJyNOw==
X-Received: by 10.233.220.133 with SMTP id q127mr28852638qkf.33.1469524553341;
 Tue, 26 Jul 2016 02:15:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.200.49.164 with HTTP; Tue, 26 Jul 2016 02:15:52 -0700 (PDT)
In-Reply-To: <nn1euf$h6q$1@ger.gmane.org>
References: <nn1euf$h6q$1@ger.gmane.org>
From:	Manlio Perillo <manlio.perillo@gmail.com>
Date:	Tue, 26 Jul 2016 11:15:52 +0200
Message-ID: <CAAToxAFuyzjf1-W4J5v1hpeyn_N4T086nb--+i0dS4QmarW5dQ@mail.gmail.com>
Subject: Re: [ANN] Pro Git Reedited 2nd Edition
To:	Jon Forrest <nobozo@gmail.com>
Cc:	Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sun, Jul 24, 2016 at 6:07 AM, Jon Forrest <nobozo@gmail.com> wrote:
> This an announcement of Pro Git Reedited 2nd Edition, which is
> a substantial edit of Chacon and Straub's Pro Git 2nd Edition.
> I spent a lot of time tightening it up and maybe clearing
> up some explanations.
>
> The pdf is downloadable at:
> https://drive.google.com/open?id=0B-Llso12P94-Ujg5Z1dhWUhhMm8
>

Thanks for your work.

I have noted a problem when reading the PDF with Chromium: the
anchors/links do not work.

I don't know if this is an issue with the conversion to PDF or an
issue with Chromium.


Manlio

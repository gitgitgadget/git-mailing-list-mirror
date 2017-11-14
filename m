Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 666601F43C
	for <e@80x24.org>; Tue, 14 Nov 2017 16:13:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751391AbdKNQNo (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Nov 2017 11:13:44 -0500
Received: from mail-qt0-f173.google.com ([209.85.216.173]:52581 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750714AbdKNQNm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Nov 2017 11:13:42 -0500
Received: by mail-qt0-f173.google.com with SMTP id 31so26160511qtz.9
        for <git@vger.kernel.org>; Tue, 14 Nov 2017 08:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/5tzutJwCpktrJPjLCyf0UdGG51flxJowpno1UkSCig=;
        b=BKrGp1WhHGCEcHMwTjBE7qwuBWHtwj43QAQHaggq/y9tjQa9BpjPZS2BSWMmBGXmKO
         ndJ1Iuph3qhDo6RtlinvFpnCffzWRTX/sa1mZXlqGliFvV5RR4ExAa5AuC+uVhyZvBdY
         EIhtLGxdmJmtl0L/AN8iEOklLTEoABF4vq62u0N14v2kKF1pKaQoeOeJ6y7m5Fakttwc
         yU96QAvHUyPaUD6num6tOeT4y7mKi+l2EkHzoyDi7X9caa5H21j2urF2FAbd9mYG1zD9
         gY5TALySGnFQ01S8BgPbC0KbDMG0qNFybQa2DYwQfWIhWPhUBQURCsJdpLOLcubYNCH8
         g40w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/5tzutJwCpktrJPjLCyf0UdGG51flxJowpno1UkSCig=;
        b=Yujd/CyM2omXsqGuGwtCYPE1NxoNGWGkCdS01MeRJLGFyc0I9IhrWM20nzoycwIZ4Q
         x9EI/IiLlobqtMCbgHLKH7p6B0cdcs0DlQanV3Mn5TB9re8hjEYUtMCX5YV0twTnj8L6
         VSQ4KYvMoLHRz3FfI7EBO41k0+7hZQuPnelFFa4vqxmwbabVkyzrllMRtR+q1IyGy1Va
         7m5/k6Q8ZCaADPZ0ukGZdZh0+MM58x9+OMuDq243UXZtNZfooNzym16Hi9W9d9IdUBfL
         YlVPmSIeqbfkeb6zAsdxs6O0l3crZEDz8mqIeUK4ehDV3RKmmmjtHHT3aNlWzPvO6HhP
         O3Wg==
X-Gm-Message-State: AJaThX5cenpK08chH2ZMoH3oL9DK/I/10FR301MOTxrVtbwbgYGXpnLW
        DeeN9fj0kr363i295shJ9chAW0eZkUeSCq/XtCs=
X-Google-Smtp-Source: AGs4zMZsfZGsXsVpSIQmstBOaPu+ntNwWUsnaV+zMp4CA8IrshATLFn+FtzIF+ooA+Py+0d1u4jWTAu+MzYWSXm1it4=
X-Received: by 10.129.133.131 with SMTP id v125mr8063683ywf.442.1510676021805;
 Tue, 14 Nov 2017 08:13:41 -0800 (PST)
MIME-Version: 1.0
Received: by 10.13.203.85 with HTTP; Tue, 14 Nov 2017 08:13:41 -0800 (PST)
In-Reply-To: <8b3225ce-a4aa-56ee-5296-6cc7528556d1@web.de>
References: <CAJ_+vJ6FXXda4fe7=1YxtDGR2d8CqP4KXN+YR6+mdQ+5jQQXug@mail.gmail.com>
 <8b3225ce-a4aa-56ee-5296-6cc7528556d1@web.de>
From:   Ashish Negi <ashishnegi33@gmail.com>
Date:   Tue, 14 Nov 2017 21:43:41 +0530
Message-ID: <CAJ_+vJ5J250CtzVg4QwEusddviDSYuJhubsbTJyv5Nc2conAfA@mail.gmail.com>
Subject: Re: Changing encoding of a file : What should happen to CRLF in file ?
To:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Running the command gives me :

      git ls-files --eol file_name
      i/-text w/-text attr/text=auto          file_name

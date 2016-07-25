Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC3DD203E3
	for <e@80x24.org>; Mon, 25 Jul 2016 10:49:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751297AbcGYKta (ORCPT <rfc822;e@80x24.org>);
	Mon, 25 Jul 2016 06:49:30 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:35039 "EHLO
	mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751015AbcGYKt3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2016 06:49:29 -0400
Received: by mail-lf0-f67.google.com with SMTP id l89so10931765lfi.2
        for <git@vger.kernel.org>; Mon, 25 Jul 2016 03:49:28 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:user-agent:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jqdxLpdKAafik8x7hm5rxlZsL/rxUoeedTEHucX0eHw=;
        b=gDRyv7Ie2NhH07EnsKbWU76xyl5vP3Ip+jSQEKSJ7YX1NeJ6YAfSiRlenBWYfoyuZP
         qim0ef5Cz71lF+rQoOzGqOgNstpCMHfWrh25Wso2psdORNFYB0aonGbC57FshBjyYRVr
         ZWMrBG/sP0hwN3jI7kVDOxnO4HU9hEkIKjbWZpUUgIltg1mXhCVZZa0Cu5gEMHRBa0rB
         RkoHdUtrM5J3SzjtzmKE4Nrn+/h6j8fz5LrPRtPIITnyQG39wCcuaFmzIURIimxhO1Ah
         Vunvgivzda6yfodjMXnoKT//bYcuewUofXb0QuLoTYKryHKegS7qRbOAV/7nvsNgas25
         aCOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:user-agent
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=jqdxLpdKAafik8x7hm5rxlZsL/rxUoeedTEHucX0eHw=;
        b=f/uvceXdjt93YQtF7T4mFMUJHaiCQKS5kvVRwyYXZczVE+AJdKM1K/KT0Ok6rbAx7W
         Oe4S9gQIiPaMC/qrquX8Q+SJYhUZYKtDfF3cb/S19eVjfQjloXsN1qyDsGJxwKDTGsji
         GcSiL2NAFPrwwxUQ+WcARjucg5bb2sjAR449YqkaZhjGpZ1TnXfqs93hnC17CCnNlNyI
         Z4TFZ4Mo5jzSMRC+ehud/t7y3cCqOV/uP8pD8akGjk81R8oTPXRlXFme79kEh/PXDqWk
         NTiBG5quVJRx1B0nLWfK6wX2EtqizwOCYXr+tuyb4WlJ0VXRwQkymxh14JuCu98mYK7W
         EAxQ==
X-Gm-Message-State: AEkooutZo8D8QY2VxYfVZytLsnXEr/4YQ2aKG50t8idk1Mon4eYyS4GLucHZTyqRo/6PBw==
X-Received: by 10.25.33.79 with SMTP id h76mr6347134lfh.82.1469443767240;
        Mon, 25 Jul 2016 03:49:27 -0700 (PDT)
Received: from photon.localnet ([81.177.127.104])
        by smtp.googlemail.com with ESMTPSA id 85sm5471800ljf.6.2016.07.25.03.49.26
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 25 Jul 2016 03:49:26 -0700 (PDT)
From:	Ilya Tumaykin <itumaykin@gmail.com>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	git@vger.kernel.org
Subject: Re: Bug: "git log --format='format:%+s%+b'" doesn't insert newline before body
Date:	Mon, 25 Jul 2016 13:49:25 +0300
Message-ID: <2082892.BZVOcV7i8n@photon>
User-Agent: KMail/4.14.10 (Linux/4.7.0-ACER-1830T; KDE/4.14.22; x86_64; ; )
In-Reply-To: <alpine.DEB.2.20.1607251003360.14111@virtualbox>
References: <8915446.47C9zkNvuX@photon> <1693749.WYZjdcdZj5@photon> <alpine.DEB.2.20.1607251003360.14111@virtualbox>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Monday 25 July 2016 10:06:28 Johannes Schindelin wrote:
> Hi Ilya,
> 
> On Mon, 25 Jul 2016, Ilya Tumaykin wrote:
> > On Monday 25 July 2016 09:33:00 Johannes Schindelin wrote:
> > > On Sun, 24 Jul 2016, Ilya Tumaykin wrote:
> > > [...]
> > > 
> > > > $ git --no-pager log -1 --format='format:%+s%+b'
> > > > 
> > > > Actual results:
> > > > ```
> > > > 
> > > > This is subject
> > > > And this is body
> > > > ```
> > 
> > According to 'git-log' man page '%+b' should insert linefeed "immediately
> > before the expansion if and only if the placeholder expands to a non-empty
> > string." Here "%b" expands to a non-empty string, thus I expect a linefeed
> > before it. Or am I misinterpreting man page somehow?
> 
> The line break is there: after the subject. The misinterpretation is most
> likely the assumption that the new-line "character" is part of the commit
> subject; It is not.

I see. Thank you very much for the explanation. This does help me.

-- 
Best regards.
Ilya Tumaykin.

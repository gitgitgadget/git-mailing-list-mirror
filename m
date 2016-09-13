Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79DEE20984
	for <e@80x24.org>; Tue, 13 Sep 2016 17:27:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755062AbcIMR1C (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Sep 2016 13:27:02 -0400
Received: from mail-qk0-f175.google.com ([209.85.220.175]:33562 "EHLO
        mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752337AbcIMR1B (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2016 13:27:01 -0400
Received: by mail-qk0-f175.google.com with SMTP id w204so182597584qka.0
        for <git@vger.kernel.org>; Tue, 13 Sep 2016 10:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3DqJV7ZeMkOft3+jMyBy+Mwe6UHio5qLLgMw+0NPfQM=;
        b=yz1pn4mvNJE4cuEHuFvzHKxiQGG2zALVNIEyVQDWv93ZaEeAp7fWMI9wwQRjohAqbT
         BHm5jCKSaxzDGmdMiwaOZKhmX/DSg8WJZyh84ab6cxl2YkisNJgFMvsQEj/z7160b1T1
         jER0C2abbw6Evv1xcDEBJMpiUfZOC2W+VsR+XM0JP3avTzTLoqYhgfLxHNHny8EL74Dr
         7Zjl8JH6Is+3wOAfrqGbUVi/bHf2FY/HHzdooZMplNKgno8Gvp/SYRs3V5ZvGh5WVRRS
         WrCeOBM89QMMVBgrAUT3OQEE+7YbITIb60mfE/eR7j8e0A9OGKjZofOAAnGt95xpnvLE
         gItg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3DqJV7ZeMkOft3+jMyBy+Mwe6UHio5qLLgMw+0NPfQM=;
        b=TDuy5slso3K9m7s03w06sBCvzx+kjXladPLrfyL2iyv1CQHNisSFu0d6L9tf2Qofze
         0iWosg3zH+m7iiOESMXuUnhZSweJO3UoBr+gcYsCmZjmHm0JecqpcQ/wmPhTKrQilIL1
         eRSLO/9q9MjZmvjkb2OPGvjvkRaI7vG0G18SZSsa3Mx5ehvnFcbxOTH3yjakOnfIKtvE
         YlEcxXQBoNVT1by3QdZcdJ6LVyR/Q5eA1Ao0YOTq4YcCWojJg9vqjGrLn6waYORV19Os
         gSUouqV2PeytgWesZFPNQ7Q0y+Vq2wPiOhb9u4VqVv/QsABBh+McM9HG4C9A3IzbfTsW
         2vRg==
X-Gm-Message-State: AE9vXwP18dOoejZU0iTtq6Bl5zUqDFk0TG2SFv5wIOfYp25POMczmjkocJrXs5nZr5AEE/eK
X-Received: by 10.55.167.67 with SMTP id q64mr2355232qke.97.1473787620869;
        Tue, 13 Sep 2016 10:27:00 -0700 (PDT)
Received: from LykOS.localdomain (NYUFWA-WLESSAUTHCLIENTS-11.NATPOOL.NYU.EDU. [216.165.95.0])
        by smtp.gmail.com with ESMTPSA id h25sm13981027qtc.38.2016.09.13.10.27.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Sep 2016 10:27:00 -0700 (PDT)
Date:   Tue, 13 Sep 2016 13:26:59 -0400
From:   Santiago Torres <santiago@nyu.edu>
To:     Mike Hawes <mhawes24@gmail.com>
Cc:     git@vger.kernel.org, mh351681@wne.edu
Subject: Re: Bug
Message-ID: <20160913172658.7s4rhxjwp7j76zp4@LykOS.localdomain>
References: <B1BB8E37-C36E-4F4A-BC5F-FDA32CE162AF@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B1BB8E37-C36E-4F4A-BC5F-FDA32CE162AF@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, Michael.

It would be helpful to get more context on what triggered this bug. I'm
not a 'core' dev, so there may be a better way to send this. In general,
you want to state the following:

0) Information about your git installation, host system, etc.
1) Information about your repo (was it GitHub? local? self-hosted?)
2) What did you do? (git push origin master? git push?)
3) What happened instead of working? (the error message would be
   helpful.

Hope this helps.

Cheers!
-Santiago.

On Tue, Sep 13, 2016 at 01:18:52PM -0400, Mike Hawes wrote:
> To whom this may concern,
> 
> I found a bug in git while trying to push my website.
> 
> I redid the process and it happened again.
> 
> I also tried it on another computer and it happened again.
> 
> I was wondering how to claim a bug?
> 
> Thank you,
> 
> 
> Michael Hawes

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FA1420954
	for <e@80x24.org>; Thu, 23 Nov 2017 01:12:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751692AbdKWBMb (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 20:12:31 -0500
Received: from mail-it0-f42.google.com ([209.85.214.42]:46772 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751241AbdKWBMa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 20:12:30 -0500
Received: by mail-it0-f42.google.com with SMTP id 187so6620233iti.5
        for <git@vger.kernel.org>; Wed, 22 Nov 2017 17:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=V69Sh0ypy6YZFvM7mXOwugaEN1XQS9XVdGU9QiFlJg8=;
        b=JtEu262dwtFjkTl+9UmABtC6n5qWum6x06ImM9o4F3wGlLzXth3tRSfTdJlyVUAHvK
         pF0LjAs7W6ZQJ6UmP2lZ0rmgPs2vOSKJPjrZXI0hOMV5r7YHI9WKHiUlEp8MUucgWh1b
         Y7FPiJqLE839op9hlTDsfpMVMNODIG0wMqQm+RPo+KaU6EC0Mu3ez41rtH7YSYPw1YWM
         lW9UcSKsfoEoU00CKmKdhXML+S887HjkXzs/P9Al3acVgjp6+NmMLPuZwXAdJOuwVQw+
         0D3hZYiUCqXQ9awB0UBBhVFdXYBbcFj1rw4wXEa/nkIa2zSZXZDoaxr0wqfwKfwQhFne
         fSmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=V69Sh0ypy6YZFvM7mXOwugaEN1XQS9XVdGU9QiFlJg8=;
        b=QSBran9dfHMUf+oRD4JDZw7Yt7CpS1d+xazdnfdMXrsR8rm+gm96L94YD5MwZr+R4J
         jDsNcQDkuZCj6cPSOPW414Z6wEhhZTzWe+4deso9FDM8QYDSU+VP+UzIkb1XMI8YXFva
         1kFL/81P8pDhoOw1IDzH+3ZxXKDYmfpYpaXEvsbUMJAhoGjGwqkHB+zekJdrB8sdFcGF
         jJFkedk+Io1mnth90NoJ+Ku7wZpqUwlLnGRsKm4WtsWynlUiEtY/+tj9A1WLDoXzZj/Y
         WDHg6Qnn79jlMhNY1eKhQqugXAMQUH8kVbDf6plGVWUH7Wh4PTX8qWXygFYOeP6H/Ag7
         vZcw==
X-Gm-Message-State: AJaThX5Bf2Ik2nw2KVXTqYhU6bfGysRNxjqusMrzOnsvAwFI4Sd1W0tP
        T5luFhGlU7a2mZvG+7Ip8oHHeDwZ
X-Google-Smtp-Source: AGs4zMb9ekYCJ3pmrVhwjtUjkGlwdKasDKDDeQVjGbPWFi6zc0pAhuvMw8OCctpOSrcFDqJGaDfLoQ==
X-Received: by 10.36.249.134 with SMTP id l128mr9656032ith.12.1511399549813;
        Wed, 22 Nov 2017 17:12:29 -0800 (PST)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id 80sm7420348ioz.54.2017.11.22.17.12.28
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Nov 2017 17:12:29 -0800 (PST)
Date:   Wed, 22 Nov 2017 17:12:27 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     git@vger.kernel.org
Subject: [ANNOUNCE] Bug tracker for Git
Message-ID: <20171123011227.GM11671@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

As discussed at [1], I've occasionally wanted to have a place to keep
track of bugs I'm working on in Git.  Some kind people on the Chromium
project helped me set an issue tracker up, so now we have one.

 https://crbug.com/git

Feel free to file bugs, feature requests, and leftover bits there.
I'll be happy to triage them to keep the list of bugs meaningful.
Anyone else wanting to help with bug management can feel free to
contact me and I'll grant you permissions to edit issues.

This particular implementation of an issue tracker is Monorail
<https://chromium.googlesource.com/infra/infra/+/master/appengine/monorail>.
It is similar to the issue tracker that used to run at
code.google.com.  If you find things you don't like about the way it
works, they accept patches. :)

It accepts replies to the emails it sends.

This uses Google accounts to authenticate people filing a bug.  If you
would like a Google account for your existing email address, you can
get one at https://accounts.google.com/SignUpWithoutGmail.

There is an API for programmatic access to the issue tracker: [2].
One thing I would appreciate help with is using that API to make
regular backups.  The chromium project has their own backups using
database dumps but I would be happier if multiple people are making
backups independently.

This is an experiment --- I don't know whether it will stick.  The
configuration will likely change as we get experience with it.  I
expect to be using it to track my own work for the forseeable future.
I'd be happy if it is useful to others as well.

Thanks,
Jonathan

[1] https://public-inbox.org/git/20170919160753.GA75068@aiede.mtv.corp.google.com/
    https://public-inbox.org/git/vpqiovpubmh.fsf@anie.imag.fr/
    https://public-inbox.org/git/7vhay9tqs6.fsf@alter.siamese.dyndns.org/
    https://public-inbox.org/git/7vehzjugdz.fsf@alter.siamese.dyndns.org/
    https://public-inbox.org/git/4A1FB1DE.3070904@op5.se/
[2] https://chromium.googlesource.com/infra/infra/+/master/appengine/monorail/doc/api.md

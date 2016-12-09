Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 873391FC96
	for <e@80x24.org>; Fri,  9 Dec 2016 16:20:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753837AbcLIQUP (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Dec 2016 11:20:15 -0500
Received: from mail-io0-f196.google.com ([209.85.223.196]:34305 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933823AbcLIQUJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Dec 2016 11:20:09 -0500
Received: by mail-io0-f196.google.com with SMTP id y124so7804849iof.1
        for <git@vger.kernel.org>; Fri, 09 Dec 2016 08:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:content-transfer-encoding:subject:message-id:date:to
         :mime-version;
        bh=NVUJU8maPi9q+srdIBaTGdatO/MZ78QnC8/5enbhaxg=;
        b=rsZ6SDF0L1KB1kWMTQ30o5vPq6BIVf89QhuU1k2+0syfD3z84MNZgqXM2KxWFxHoNb
         1UxGYf7Hc4PBREYwAPYFPKZ+YpWKkjNPhzZ+HQtMAIa8S0z/C7vaVLQqIvvRB4/l1Zcc
         246if8h24QUzB+R6Q1KZEApVI1leHSHO7YYJ7IX7vEygz+pxKHd7ZmF0pL6AYoBPDbtv
         AhYD10RypOtkq9N2+lFejo+newbv5wdHyT4CspXoFd4TF9hZyKJnGt9JRYiZTM3vMlBC
         CqltqdK47vVLOK/1WpH62Qy8qRWsKbB1pVGW9gEpoHRPryTlKWpn/h5jlWaByo2hD5sL
         KsDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:content-transfer-encoding:subject
         :message-id:date:to:mime-version;
        bh=NVUJU8maPi9q+srdIBaTGdatO/MZ78QnC8/5enbhaxg=;
        b=fbvvMiUIB2nxLyG8ipv7Wzv+ZHt2PTR/XBKbN9N/I6vmfja6c7hY0pByiHvR4FgFqC
         s87PLtTLGdonuRTMXPrDLiKPW1KlmctxyLnjhL9BheM1pP3dBpXGZURfUhxz+1Z/xk5t
         I0SyjOBDNfLaH6Z4+9ezxEAfHvB6qQkST3MsQrQGgYO9981IKFEMQ7jaahrzZa1KSqGU
         evj5YlWg//26q6MEuWm11ufz6iFgigietav8pC3EaJktFt4kGsgXbfueFfCTk/tv14jn
         yAKx3vK3JeK6rTFUReJISCfY1z7WsdvhLzn1Ofgv5ZIDx3ko2OocJfK9yu2esKwRnAnb
         GJwg==
X-Gm-Message-State: AKaTC01LyH9NJKqm5otI1M3ATU33ZwZB2rLtWJFtNMKxNzMbzgXM5ORwbLpthAoLlPMdLw==
X-Received: by 10.107.34.8 with SMTP id i8mr64915264ioi.132.1481300408476;
        Fri, 09 Dec 2016 08:20:08 -0800 (PST)
Received: from [192.168.1.4] ([208.157.186.52])
        by smtp.gmail.com with ESMTPSA id m83sm14951721ioi.11.2016.12.09.08.20.07
        for <git@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 09 Dec 2016 08:20:07 -0800 (PST)
From:   Kyle Flesness <flesness@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Subject: Git 2.11.0 on OS X El Capitan 10.11.6
Message-Id: <4F041053-81EE-4EB3-BA96-F5E10D51A12C@gmail.com>
Date:   Fri, 9 Dec 2016 10:20:07 -0600
To:     git@vger.kernel.org
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello! Thanks for taking the time to read this bug report, I am =
operating a mac book pro with OS X El Capitan 10.11.6 and attempting to =
download git 2.10.1, the installation appears to finalize with no =
problems but Git is not at the download destination from the designated =
path. Will 2.11.0 be compatible with OS X El Capitan 10.11.6? Any other =
solutions you might recommend?

Thank you for your time and hard work!!

Cheers,

Kyle=

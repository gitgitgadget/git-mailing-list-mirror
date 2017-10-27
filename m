Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22C0D1FAED
	for <e@80x24.org>; Fri, 27 Oct 2017 14:51:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751298AbdJ0OvR (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Oct 2017 10:51:17 -0400
Received: from mail-qk0-f226.google.com ([209.85.220.226]:44334 "EHLO
        mail-qk0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751199AbdJ0OvQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Oct 2017 10:51:16 -0400
Received: by mail-qk0-f226.google.com with SMTP id r64so8667494qkc.1
        for <git@vger.kernel.org>; Fri, 27 Oct 2017 07:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brannerchinese-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:user-agent:mime-version;
        bh=UYo+1BxVRPJRKp09B15BKoc9qr6BiHuUhSX0oMzjWd0=;
        b=QwAQ8zSARS9IM3c/jiTPo3zqOI5tb3oDtA8jDnKOx5lMWVB7TU7SnaHR/bJKEuzsNV
         oT64AON3SXeebrWahZ3IYhbUZxIuV5bRNPE0XWaMr52+NP4PEsM/sAyHTUZtWNBbiOk6
         aEUyYWkZQJtcEw7cUX5IqQrvzFHbaYJMuYkV5ALaOgjl4DkP1cRHXhccjKcFGKJMMPc7
         FziK9CdQg49eqsjDbSxFfE4usra9bVipTnV2U5SIgPn2C2GNs03QWZpmRbuJIndfzI37
         spAuYZapks/naAVfmoUIHV/yQHJzT0jaeHBGQ/InPJvhpddYn0Q2Lx9UmyWoM6Uj0dh3
         Wulw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:user-agent
         :mime-version;
        bh=UYo+1BxVRPJRKp09B15BKoc9qr6BiHuUhSX0oMzjWd0=;
        b=akirhMzeesuolyOkuZWO426sXUOrwnvvkIQZgZZYAvS9PAeOAwoCBDqoRcsUTvhMdg
         BcaScRZijUH7YbohzECQhw3nPj+C4TI9ic6hOr2Mjp5gESyzMetGUgJDRsWkEppcGTJj
         rgi6ZDlMoX2Q0+H52ybjGEAZVzIdrUv0ps5ql8Y+e/+BuFo7Kwob/CT74bpLfqN9bCxO
         169JR/Qc7alv7DsgUh4L4d9PHIs9sKc8XmH4of5YZjN+rHfRPwV5G8baIMTF5DzwYyUN
         r18fBXgmRotNuwdlZL0wwOIijlLcdMUyUZSSN8CcYGB5QsIqFKLYqHcPXQChNkSxEIXH
         Qhuw==
X-Gm-Message-State: AMCzsaWjyxoniFS35WK8HeEfizAWrQgfzTI5IylF7xFPd6+3TN1eKdpF
        If/okYu7dtrQWla2wk4zPJ25NSd0v2DlzqAlPoI2IKfWKdWNGA==
X-Google-Smtp-Source: ABhQp+QIkM37CAjg3Gd0PMdM+eNoOND3LUwZgbVXSOuZQsVc6ew8BtU5mDAlpYUYcD3FIU6f83/xvh9uEySV
X-Received: by 10.55.207.20 with SMTP id e20mr1182123qkj.1.1509115875219;
        Fri, 27 Oct 2017 07:51:15 -0700 (PDT)
Received: from [104.236.53.145] ([104.236.53.145])
        by smtp-relay.gmail.com with ESMTPS id q74sm1403034qki.12.2017.10.27.07.51.14
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Oct 2017 07:51:15 -0700 (PDT)
X-Relaying-Domain: brannerchinese.com
Date:   Fri, 27 Oct 2017 10:51:14 -0400 (EDT)
From:   David Prager Branner <dpb@brannerchinese.com>
X-X-Sender: dpb@brannerchinese
To:     git@vger.kernel.org
Subject: clarify documentation of leading "**" in gitignore(5) man page
Message-ID: <alpine.DEB.2.20.1710271043190.1400@brannerchinese>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've long been confused by something in the man page for gitignore. I think it's unclear and I'd like to propose a change. The passage is this (source at https://git.kernel.org/pub/scm/git/git-manpages.git/tree/man5/gitignore.5):

> Two consecutive asterisks ("**") in patterns matched against full
> pathname may have special meaning:
>
> o   A leading "**" followed by a slash means match in all directories.
>     For example, "**/foo" matches file or directory "foo" anywhere, the
>     same as pattern "foo". "**/foo/bar" matches file or directory "bar"
>     anywhere that is directly under directory "foo".
>
> ...

In the first paragraph, it would be clearer to specify:

> Two consecutive asterisks ("**"), in patterns matched against a full
> pathname, are a wildcard representing some arbitrary number of nested
> directories within that pathname:

In the second paragraph, I suggest removing the first pattern, "**/foo", since it is completely redundant. There are no circumstances when "**/foo" is necessary in place of plain "foo", and its presence muddies discussion.

Leading "**" may represent nested directories in a pathname, but is useful only before a _pattern_ containing nested directories. I suggest making that explicit. Here is how I propose to rewrite it:

> o   A leading "**", followed by a slash and a pattern containing nested
>     directories, means match that pattern in all pathnames.
>     For example, "**/foo/bar" matches file or directory "bar"
>     anywhere that is directly under directory "foo". It would match
>     "foo/bar", "other/foo/bar", "src/foo/bar/scram/gravy".

Thanks.

- dpb

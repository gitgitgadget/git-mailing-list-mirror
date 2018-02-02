Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FF101F404
	for <e@80x24.org>; Fri,  2 Feb 2018 18:46:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754465AbeBBSqH (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Feb 2018 13:46:07 -0500
Received: from mail-pf0-f176.google.com ([209.85.192.176]:36011 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753826AbeBBSqB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Feb 2018 13:46:01 -0500
Received: by mail-pf0-f176.google.com with SMTP id k5so1761682pff.3
        for <git@vger.kernel.org>; Fri, 02 Feb 2018 10:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackthorn-media.com; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=9Kixi7QZHlUIpQi7oHonMco3fgLoAWIO+3bjNrLdWvs=;
        b=BI0xnrkpxXXN4+/42pvupkuFNn3ZOYZlHuyCfaFn6pzJ1z6aqP9l7F1zVQkhxcBEC6
         DbjK/rpyjgvz/l2J2g9fQJFimO9bW1Fl93k1t2brksmLi68xxlFguu9+nZBODXbd1fPI
         Un2Z88ZW55DD3fMtP/6cCdPffiHWHZz17mjlc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=9Kixi7QZHlUIpQi7oHonMco3fgLoAWIO+3bjNrLdWvs=;
        b=bMlvfQujN8RztrTT6fQwqoajfQO02MCSRB8drSSGx47SHmS4OaEFXVhjuFtOl2LcIL
         tIZouTXgJevSLl/JMqxq0ss3yeRzR8F25Q32xqnZUZRE6JDTl0MV9dvcDu7XugArK79F
         vhgoZJByNEZm5xM4peNVZtUrBvwQ9mjmHh/ihIEg8jk2Apd29zVhgq8JHqc7s4XmI2uK
         tYGFcGBJEjIGixPa+WMBscErUmpPOySJplFbt3E1H1XRuK7Fc9gG14Lsa+xOPLo3o46P
         R2AA8cwHDJE4824pXAApMjfbvcCKb7WbkV2a8+oZy5IzSeiHZNlt0nbE5hj7FmWng1Gx
         tNfg==
X-Gm-Message-State: AKwxytfpK4DqLv310pYJpq65T+4k7zFTOzhiwotRQs+mC4xTvybjZ3L2
        KVTX4EsHD5u7wc0QYqs9C6n5oUywaj8=
X-Google-Smtp-Source: AH8x225USA7w4wVyoBv5SJ18hgzfrFvEszkas6xcDnZgtr3a6BNErb6MbxLr7LDt+VtL6TP83s4snA==
X-Received: by 10.99.37.193 with SMTP id l184mr22660533pgl.30.1517597161166;
        Fri, 02 Feb 2018 10:46:01 -0800 (PST)
Received: from [10.10.2.117] ([38.88.196.250])
        by smtp.gmail.com with ESMTPSA id j11sm3889690pgq.86.2018.02.02.10.46.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Feb 2018 10:46:00 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: Git on Windows maps creation time onto changed time
From:   Keith Goldfarb <keith@blackthorn-media.com>
In-Reply-To: <c1e419ae-feae-5a31-ead6-20b25fa92f85@kdbg.org>
Date:   Fri, 2 Feb 2018 10:45:59 -0800
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <040E3C3E-BC8E-4658-A882-5149D10AD408@blackthorn-media.com>
References: <CCB76F06-DBA9-4342-8830-402F8AF9854A@blackthorn-media.com>
 <c1e419ae-feae-5a31-ead6-20b25fa92f85@kdbg.org>
To:     Johannes Sixt <j6t@kdbg.org>
X-Mailer: Apple Mail (2.3445.5.20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> The purpose of these values is to allow to notice a change on the file =
system without going through the actual file data. Duplicating st_mtime =
would be pointless.

Well, I agree with the first statement. I disagree with the 2nd. It=E2=80=99=
s not pointless to fix a problem, and in theory the creation date of a =
file can never change.

> Don't do that then. Use core.trustctime.

I am. Unfortunately, my problem isn=E2=80=99t solved by that alone. =
Perhaps this deserves its own thread, but on Windows the st_ino field is =
set to zero. This can also trigger a false positive, causing the whole =
cache to be rebuilt unnecessarily.

K.=

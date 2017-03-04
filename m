Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CF2C2023D
	for <e@80x24.org>; Sat,  4 Mar 2017 17:33:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752262AbdCDRdC (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Mar 2017 12:33:02 -0500
Received: from mail-wr0-f182.google.com ([209.85.128.182]:34766 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752209AbdCDRdB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Mar 2017 12:33:01 -0500
Received: by mail-wr0-f182.google.com with SMTP id l37so91981814wrc.1
        for <git@vger.kernel.org>; Sat, 04 Mar 2017 09:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ypK29Arh0y7SGKTyJkAxjMNUzzB2+BGfpCxB/rsE5jk=;
        b=IVmn0onvtOLBg8Q/x/wSHfMcOG9Q0OrSjnUNRJ7RMtHPqNVI8S27sFFHzKWrfL4JPc
         yK+i4+8tgFDXnsvSLQB6c7i7P2RA26+CmwiLz0DkygBCqYKndghx9SMcYOSS+eAJC/De
         6q/hijqkZu1UI+zZQs9dI3ywcT1KQOk6i7QtOtoPRjO2r1LLbSRVgFDkfEo4UYG0sM8y
         7EOtLdFHvg0mLBYqMo7VOD2u9Lpxy5mwf7QrpEITqRckp1kTg2DGSn1OSW3c84HypuvM
         kSshwtM7DbRWMiq2DGDaA/p3am+CiI6qX1PsWBLJaK5SQk2u+fj8uKd1MAsz5Vif1v1v
         xJlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ypK29Arh0y7SGKTyJkAxjMNUzzB2+BGfpCxB/rsE5jk=;
        b=i9eiswnENC7bJ9b9N6HAjLGBGzdkhLR0W9sRPZdCcn6NX4UMR00Q2jZYDVGDVjWBE/
         Z8niMdpOtlP3ZpPoJ+CiX0tBiw+zDuI6XIQhx7Ser8XxJB4GbZtj9qALHvEOIJLig16g
         XfXGh6Xpdi20Ixi8LkzLb5LzD2xWhcON1tfjCNfecH6twSYGayxm+cx+U3/cOI5X+ZNG
         8vcQSeWeEqjIx9F99grcYN9RhqFoHc9nG8l4pTOMstzamruYIqhuGazosfisSmXLh+or
         4unt6mhIBJ26SkzirD9YW/+qg9v+EJnqrnW9iEQ5oaa89Alh41zZ0SN2cmYb594NUAVn
         540Q==
X-Gm-Message-State: AMke39nB3YZ5pZcqPcWQt+D68Q3Dxvy1MOjV84MC/PAd+vJqElCyy2E4n5wDs0iagfWtjA==
X-Received: by 10.223.152.83 with SMTP id v77mr7621855wrb.109.1488648755876;
        Sat, 04 Mar 2017 09:32:35 -0800 (PST)
Received: from slxbook4.fritz.box (p5DDB4C60.dip0.t-ipconnect.de. [93.219.76.96])
        by smtp.gmail.com with ESMTPSA id j12sm11374079wrd.6.2017.03.04.09.32.34
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 04 Mar 2017 09:32:35 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: What's cooking in git.git (Mar 2017, #02; Fri, 3)
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqh93a6iy6.fsf@gitster.mtv.corp.google.com>
Date:   Sat, 4 Mar 2017 18:32:34 +0100
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <5C8A09B2-0C99-4BD9-A82B-B333EF1F155E@gmail.com>
References: <xmqqh93a6iy6.fsf@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 04 Mar 2017, at 00:26, Junio C Hamano <gitster@pobox.com> wrote:
>=20
>=20
> * ls/filter-process-delayed (2017-01-08) 1 commit
> . convert: add "status=3Ddelayed" to filter process protocol
>=20
> Ejected, as does not build when merged to 'pu'.

I send v2 [1] where I tried to address the points in your feedback [2].

v2 not the final roll. My goal for v2 is to get the interface
to convert.h right. Could you take a quick look at the changes=20
in the following files and tell me if this is the right direction to go?

entry.c
builtin/checkout.c
unpack-trees.c

Thanks,
Lars


[1] =
http://public-inbox.org/git/20170226184816.30010-1-larsxschneider@gmail.co=
m/
[2] =
http://public-inbox.org/git/xmqqa8b115ll.fsf@gitster.mtv.corp.google.com/


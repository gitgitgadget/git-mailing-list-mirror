Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE3EA1F404
	for <e@80x24.org>; Thu, 15 Mar 2018 23:00:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932537AbeCOXAu (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Mar 2018 19:00:50 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:44025 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752794AbeCOXAt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Mar 2018 19:00:49 -0400
Received: by mail-pf0-f170.google.com with SMTP id j2so3418110pff.10
        for <git@vger.kernel.org>; Thu, 15 Mar 2018 16:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=xNrp0ranO7LXfmQrGHSisVdUkjuaXRYmWbCeEJ+9Xb4=;
        b=tr6UI06TDBLvYbtomHUB931aUaB+waPOvL+SCJPs2c5WOajg0E0qIcF+wwLW3WMwvw
         v5oTPqxEduGC1f9vc3kGT21VN5GemhX1Fdz30+j9K16SsuZe8xdaEnsZwhKesAgYJ6tS
         J9KNWgh8rrNhhuJEtNkiRRwp0E8YdcF7O05qJVBlzlHbckDJU8CTND5RoCYCP9U7L3X0
         5X770wYo3zgB5pAf/BIiRmRtpIhTkTMTOX97iU3YVDT1ppCLm9dcAEY6GXL8saWqAYL9
         z1e1bj9/7kStxhsvNO0Xv8icwhP0Q5tep6dk6r3Ebac79LwVK4vPmRID+i46UC/wNCEG
         UcOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=xNrp0ranO7LXfmQrGHSisVdUkjuaXRYmWbCeEJ+9Xb4=;
        b=Pw+4xDh84Avb5DzuY1l/rtjBe0wF50aDMQsRhwWBvQNGUPxKLOryoIncx8Ai6xjDmp
         hIbSJdTQzxufxo2sbdB9UNjdab10FxcktCdX3d1JrgzuiHcU532nz0uvqy6nJFuPlH6O
         W00BbTKvKVfwwOCjlNZiPGinGtcVd1nsngox1g+buYFLi46EPIH/3fB07HJ5NEzJud/7
         Vwyt2GcDGIcbl+rIpGaLoKWWDe3QDrhaQ7dh9tqyW7o/DzDlyWaTGhQi8WMz3/UrMcXi
         IYGjBEpmkW0Xh15l2Z/sBEVK2ae5WM5Vc183NBSjvaiJwRWSBtyX65cSBeN484PefElW
         LvNw==
X-Gm-Message-State: AElRT7GcjU4KlbFamIYbpA4ICQQh5n9AhRE94UnhoN15B4I5WQKh03Q6
        eXdSpiDD1ZpqqEd9tRoSwTeSKFV2
X-Google-Smtp-Source: AG47ELsX0KuBsZuSosyf+oEmZ0/7vyyC1TUZmEoLw4Du3axfpGEHibpwGsK3Qa1ZxQ3561+mQUxjGA==
X-Received: by 10.98.18.143 with SMTP id 15mr9179465pfs.104.1521154848940;
        Thu, 15 Mar 2018 16:00:48 -0700 (PDT)
Received: from rem2ua0031cfw.ads.autodesk.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id v8sm11666905pff.38.2018.03.15.16.00.47
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 Mar 2018 16:00:48 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: What's cooking in git.git (Mar 2018, #03; Wed, 14)
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <7D05D553-D914-402F-8AE1-C49C1E1D64AB@gmail.com>
Date:   Fri, 16 Mar 2018 00:00:45 +0100
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <13DCA899-54E1-49C9-A90D-E0A24C9F7D10@gmail.com>
References: <xmqqefkm6s06.fsf@gitster-ct.c.googlers.com> <7D05D553-D914-402F-8AE1-C49C1E1D64AB@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 15 Mar 2018, at 20:18, Lars Schneider <larsxschneider@gmail.com> =
wrote:
>=20
>=20
>> On 15 Mar 2018, at 02:34, Junio C Hamano <gitster@pobox.com> wrote:
>>=20
>> ...
>>=20
>> * ls/checkout-encoding (2018-03-09) 10 commits
>> - convert: add round trip check based on =
'core.checkRoundtripEncoding'
>> - convert: add tracing for 'working-tree-encoding' attribute
>> - convert: advise canonical UTF encoding names
>> - convert: check for detectable errors in UTF encodings
>> - convert: add 'working-tree-encoding' attribute
>> - utf8: add function to detect a missing UTF-16/32 BOM
>> - utf8: add function to detect prohibited UTF-16/32 BOM
>> - strbuf: add a case insensitive starts_with()
>> - strbuf: add xstrdup_toupper()
>> - strbuf: remove unnecessary NUL assignment in xstrdup_tolower()
>>=20
>> The new "checkout-encoding" attribute can ask Git to convert the
>> contents to the specified encoding when checking out to the working
>> tree (and the other way around when checking in).
>>=20
>> Expecting a reroll.
>> cf. <66370A41-A048-44E7-9BF8-4631C50AAE63@gmail.com>
>> Modulo minor design decision corrections, the series is almost there.
>=20
> If I hurry up (IOW: send a reroll tonight), would this topic
> have a chance for 2.17-rc1 or is it too late?

I just send out a reroll in case the series is still relevant
for 2.17-rc1.

=
https://public-inbox.org/git/20180315225746.18119-1-lars.schneider@autodes=
k.com/

Thanks,
Lars=

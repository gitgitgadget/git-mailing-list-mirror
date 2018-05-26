Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89D071F42D
	for <e@80x24.org>; Sat, 26 May 2018 06:15:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031142AbeEZGP0 (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 May 2018 02:15:26 -0400
Received: from mail-oi0-f45.google.com ([209.85.218.45]:33710 "EHLO
        mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031051AbeEZGPZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 May 2018 02:15:25 -0400
Received: by mail-oi0-f45.google.com with SMTP id k5-v6so6384529oiw.0
        for <git@vger.kernel.org>; Fri, 25 May 2018 23:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=lV91KQtEulo7hPP+1dkpmN1CDi+fHJvT2Spj4oHDUvE=;
        b=o68hwRsl/F26mK34nxI9Ifq/pip8JAEnZm1YPnnG4Jp8nkBy1lEtKdcpY1Mz6Pqkpv
         3hnNJTIyygD8wTECkXyL3d1Ohi1SjRb4oPRVgSmhWktBHUdm3aXpl131gvRdP9ZYgWue
         USSS8smKi61KDKjh1gz40kweha81GdjHq6R+9oC5vwMkLCirw9b4RWjxVL+avZ6zyh+y
         JYE2tjmMc5V6MPwa/UqwOuNXukZR4BXAaFuqOozaW66X/3rjbOJB+otn4Q1Ji2f8yfOV
         ymFcslHblpn3EdmVW34ARrfzpVhQvhCK5U9hLK8IZMxtbkX40bprp/AWoqOcJBIfwc8N
         8HKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=lV91KQtEulo7hPP+1dkpmN1CDi+fHJvT2Spj4oHDUvE=;
        b=MjjGrsrIlE0YvTiRDZjAwvf0nqfTbopoKer6K9ZOIxTiCvGaVnBt4M+rKIA1qiIGOq
         BPzlr+EVZS9PjXl4ZdRXT1ehgNU8nPIox8eV1PlzC+V7vLZ/nRY4VfRT4oCPfBwGZnIX
         fm+F4T96fA+5oNeAT1s0BAobRvvoO6/uPHpxeKq0WKlK/J5MP/a2FqTxcmeAsXJvEnuH
         hlxct8pFDD8Jjhtqx8c7FAb/Vo4qcnIpIeQpqQsJuA54KXZwpALTm8zPMFPzxE6cqA34
         /xCgWm2Kl4s9+cuBQZXm28fYOt0SyKhS9w+546WgkHn0ZopY7IFDWKkLwDJrd7RhkaVJ
         Z/1g==
X-Gm-Message-State: ALKqPwfR+zi8SEEiXlhut3exPHvXlt8GylxlAl4dmGP/x1ZiTm8PXFtr
        I/idGtAkWB9TL4PAh74wBafgdQG0UGqV7Eh0D7eGSi2p
X-Google-Smtp-Source: ADUXVKIW6NmYO5XbE5FBj1WMnKwgml+WA6qORTSqIa5l7v19ZG0Wi7zHb/pzp+wrhcW1YmVQTeN11AgSDaSmMxvN2mM=
X-Received: by 2002:aca:a9d3:: with SMTP id s202-v6mr2986339oie.318.1527315324754;
 Fri, 25 May 2018 23:15:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:24ca:0:0:0:0:0 with HTTP; Fri, 25 May 2018 23:15:24
 -0700 (PDT)
In-Reply-To: <CAA8fPEkNjy+ETz4Mx+C2kUfLjLzR9uuOmO3GfN48ZH1SwyfE1A@mail.gmail.com>
References: <cover.1525448066.git.johannes.schindelin@gmx.de>
 <a1ea0320b64527ee6ce9856dcf359513d13052b7.1525448066.git.johannes.schindelin@gmx.de>
 <20180505182631.GC17700@sigill.intra.peff.net> <nycvar.QRO.7.76.6.1805052355190.77@tvgsbejvaqbjf.bet>
 <39282590-576f-1ac1-6a16-80ad317ec7ed@gmail.com> <nycvar.QRO.7.76.6.1805061408150.77@tvgsbejvaqbjf.bet>
 <e0db15c5-e897-5b03-20ff-d83f38496e61@gmail.com> <nycvar.QRO.7.76.6.1805062124470.77@tvgsbejvaqbjf.bet>
 <3b4591cd-6dde-31ee-f0b1-42b5353086e5@gmail.com> <CAGZ79kZbRCH2OiTW1Ge31R9JN+vWD6tcjNWVGSzkSBcYZvwDjw@mail.gmail.com>
 <20180508034429.GA7242@sigill.intra.peff.net> <87in7f9aym.fsf@evledraar.gmail.com>
 <CAGZ79kZg-24OtWp-qk4gAyU3O8vJBdDH_maTERqzqHSE86_fqg@mail.gmail.com> <CAA8fPEkNjy+ETz4Mx+C2kUfLjLzR9uuOmO3GfN48ZH1SwyfE1A@mail.gmail.com>
From:   =?UTF-8?B?w5h5dmluZCBSw7hubmluZ3N0YWQ=?= <ronningstad@gmail.com>
Date:   Sat, 26 May 2018 08:15:24 +0200
Message-ID: <CAA8fPEk+49A=MFpOAL1Y+TLdX9twx1SGdNqGk5a3DSEL7t3BQw@mail.gmail.com>
Subject: Fwd: [PATCH v2 02/18] Add a new builtin: branch-diff
To:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Just want to throw my support in for range-diff since ranges is what
you pass to the command.

Alternatively, diff-diff since that's how I've crudely tried to
accomplish this before.

git diff A..B > diff1
git diff C..D > diff2
winmerge diff1 diff2

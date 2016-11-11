Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D8ED2021E
	for <e@80x24.org>; Fri, 11 Nov 2016 09:01:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936567AbcKKJBo (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Nov 2016 04:01:44 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35449 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936249AbcKKJBn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2016 04:01:43 -0500
Received: by mail-wm0-f68.google.com with SMTP id a20so7973756wme.2
        for <git@vger.kernel.org>; Fri, 11 Nov 2016 01:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=qe9iz05N7J+09JYo0SvJpb1CxZfIY/vthRqarcq7WgA=;
        b=EejoE5fBaqRdjA4LxpXomuF1h/PLNsGAp6oKAdcWCzv0zYXH9mlf8zTEzu843yaiLh
         M45tNIb6bjSkpHvWbjT02gA3PmAdRh9UK3yRzYjWQeSozN9G/Nlee+J4NkWh6xpcRT+F
         ec6jH7JQPpzEkCBNmt/b9JoALWTet/R57LpC5llX8MylgJDFAJx8Y7YKycC61uKdz+oI
         LsnIsCJqZ87ycahg6fomh6v3/sWj0AaMG2KPSBbrpANbYVGHzEshEEmJc/0mErCA/GE7
         a00BMToaq7cf1iHLdyTR8pftOQDvpWY7pko35vopJ5d7jsih6bB8l1DZs3oQaFXiLhOg
         gqxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=qe9iz05N7J+09JYo0SvJpb1CxZfIY/vthRqarcq7WgA=;
        b=Z7LDO8CQS+wNpJWqaE2pboV+iy1ObWMN3KKZvJmDkkuKSFSII+UfTdNOACp+8or3o2
         DNs0ka5yUBhRFk9639IdGh3hkC6cbPqocqtphTGIOwT+gzbjyNVzu3dOdx42+Vo+FWQU
         vzJMy01tRhK9xKwB5VmUuyUJBJV+zseTBMiZYUd+lkk/PU49QklvkPE80y6rk/25yhrR
         1nrZuvVkVe2/x2nFdpXQs9g5ZRveI9b79X4hyV8dLL7elK6c6FQNU1tzkKlT/RPTweNH
         nZPfBrnCYpVWGNFud6NteP5gNobQf7qinJ3+jhmz4oy1h5BNI5/zz12duV1OK3TkZILX
         tQJg==
X-Gm-Message-State: ABUngvfSldMo1JHNZYE9Zb3tRx+jz6iSoMclZL8Z1k2sO2Wo+65TlaYE+MEseHJr0GP6Ew==
X-Received: by 10.28.9.131 with SMTP id 125mr25787308wmj.22.1478854901760;
        Fri, 11 Nov 2016 01:01:41 -0800 (PST)
Received: from slxbook3.fritz.box (p5DDB4736.dip0.t-ipconnect.de. [93.219.71.54])
        by smtp.gmail.com with ESMTPSA id y2sm10233052wjx.20.2016.11.11.01.01.40
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 11 Nov 2016 01:01:41 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH v1 0/2] Fix default macOS build locally and on Travis CI
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqwpgb58ab.fsf@gitster.mtv.corp.google.com>
Date:   Fri, 11 Nov 2016 10:01:39 +0100
Cc:     git@vger.kernel.org, tboegi@web.de
Content-Transfer-Encoding: quoted-printable
Message-Id: <C596D508-8F95-451A-ADF0-8A41BEE9842C@gmail.com>
References: <20161017002550.88782-1-larsxschneider@gmail.com> <xmqqwpgc6x4t.fsf@gitster.mtv.corp.google.com> <584C7DBA-71FE-4E66-85DC-EA22A6D2BB80@gmail.com> <xmqqwpgb58ab.fsf@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 10 Nov 2016, at 22:34, Junio C Hamano <gitster@pobox.com> wrote:

> Lars Schneider <larsxschneider@gmail.com> writes:
>=20
>>> I've followed what was available at the public-inbox archive, but it
>>> is unclear what the conclusion was. =20
>>>=20
>>> For the first one your "how about" non-patch, to which Peff said
>>> "that's simple and good", looked good to me as well, but is it
>>> available as a final patch that I can just take and apply (otherwise
>>> I think I can do the munging myself, but I'd rather be spoon-fed
>>> when able ;-).
>>=20
>> Sure! Here you go:
>> =
http://public-inbox.org/git/20161110111348.61580-1-larsxschneider@gmail.co=
m/
>>=20
>>=20
>>> I do not have a strong opinion on the second one.  For an interim
>>> solution, disabling webserver tests certainly is expedite and safe,
>>> so I am fine taking it as-is, but I may have missed strong
>>> objections.
>>=20
>> I haven't seen strong objections either. Just for reference, here is =
the patch:
>> =
http://public-inbox.org/git/20161017002550.88782-3-larsxschneider@gmail.co=
m/
>=20
> Thanks.  Picked up both of them.

Thanks! This makes "next" pass, again:
https://travis-ci.org/git/git/builds/174946111

BTW: If you want to learn about the build status of "git/git" branches =
on the
command line then you can use this snippet:

$ branch=3Dnext; echo "$branch: $(curl -s =
https://api.travis-ci.org/repos/git/git/branches/$branch | perl -lape =
's/.*"state":"(\w+)".*"sha":"(\w{7}).*/$1 $2/g')"

Cheers,
Lars=

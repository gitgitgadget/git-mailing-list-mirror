Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED2011FEB3
	for <e@80x24.org>; Wed, 11 Jan 2017 09:51:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760346AbdAKJvg (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jan 2017 04:51:36 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35823 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752160AbdAKJvf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jan 2017 04:51:35 -0500
Received: by mail-wm0-f66.google.com with SMTP id l2so35781791wml.2
        for <git@vger.kernel.org>; Wed, 11 Jan 2017 01:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=UTYtPZZvTdfoNRMWzXFdR8vd+39eMq44zhFP33U1pWI=;
        b=eVeCYXJ9NHGpJLYV2dXpe0XCnXOZByQS/oljnXwPbHf6HSn7ccSTyHrwkQ0BxnJ9/A
         ph6WpEqIaQBQIwY2FnNQERzda10Ldsl+IsDljOsWaXCnBHU6R2OFqflqUyk6RL2S7YHt
         0Z8R21WMoBMm82s8azDZ1S3RzGtk0sDHO71E9V86Fw/V6KsAQrwp/GmovvSk1zVJnsN7
         6ncOkN0O21GnijlD8OSI8rvvhS/5WJbuANiF65OTWsONuewg+j0tbu6TpFT+q+XsiUul
         rA+wfpbfkjPH0B9OvPRgZGTcwkypygGwt8p+bx49u3b2b6LrnrX7uAFhiWEl0upHVl8N
         KRgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=UTYtPZZvTdfoNRMWzXFdR8vd+39eMq44zhFP33U1pWI=;
        b=B3STS2rPn3MrQarp1hfWSUWCJuE2wJqaiRICEjOSH31ywdsvXVAGiRaEY11s14PCjG
         atlUmgx2zvMRKnYFip+Vb4zPa4BoI9C9NXo7u65QyZL3VupJir1JtFpixcCxswI+e2Z/
         /4CwjD272pik4o1pEjbpYFsK7AOCrYWduJOzsCOlJDt48JWsqHKJxXiFk/LvfBBwaOgb
         LzZQ4c7dyfkKm8BVoT6J/RPXJy7257PU2g7MAml3oH8vpe2vxlIqQpYCuOhIpuPC1/EH
         kR2032NX9HUDmBG6mIFddBwmzjL8y+47OiGqGZUKiqVF7v7HF1bU2f0/UvwYAs2dCBSw
         tjcw==
X-Gm-Message-State: AIkVDXKHPngl5Ust+lQxHr1CEpKnG4VctYmInHZkDlcHx61lMcL6JKpc1Sv+raudj18INw==
X-Received: by 10.28.203.6 with SMTP id b6mr2368460wmg.2.1484128293561;
        Wed, 11 Jan 2017 01:51:33 -0800 (PST)
Received: from slxbook4.fritz.box (p5DDB5866.dip0.t-ipconnect.de. [93.219.88.102])
        by smtp.gmail.com with ESMTPSA id k11sm8067866wmb.18.2017.01.11.01.51.32
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 Jan 2017 01:51:33 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v1] convert: add "status=delayed" to filter process protocol
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20170108204517.GA13779@starla>
Date:   Wed, 11 Jan 2017 10:51:32 +0100
Cc:     git@vger.kernel.org, gitster@pobox.com, jnareb@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <AE35779E-5FE3-4F50-A168-C7316A146C09@gmail.com>
References: <20170108191736.47359-1-larsxschneider@gmail.com> <20170108204517.GA13779@starla>
To:     Eric Wong <e@80x24.org>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 08 Jan 2017, at 21:45, Eric Wong <e@80x24.org> wrote:
>=20
> larsxschneider@gmail.com wrote:
>> +++ b/t/t0021/rot13-filter.pl
>=20
>> +$DELAY{'test-delay1.r'} =3D 1;
>> +$DELAY{'test-delay3.r'} =3D 3;
>>=20
>> open my $debug, ">>", "rot13-filter.log" or die "cannot open log =
file: $!";
>>=20
>> @@ -166,6 +176,15 @@ while (1) {
>> 		packet_txt_write("status=3Dabort");
>> 		packet_flush();
>> 	}
>> +	elsif ( $command eq "smudge" and
>> +		    exists $DELAY{$pathname} and
>> +		    $DELAY{$pathname} gt 0 ) {
>=20
> Use '>' for numeric comparisons.  'gt' is for strings (man perlop)

Still learning Perl :-)


> Sidenote, staying <=3D 80 columns for the rest of the changes is
> strongly preferred, some of us need giant fonts.  I think what
> Torsten said about introducing a new *_internal function can
> also help with that.

OK!=20

Thank you,
Lars

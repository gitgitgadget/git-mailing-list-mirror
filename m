Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CE9820229
	for <e@80x24.org>; Fri, 21 Oct 2016 04:14:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751212AbcJUEOx (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Oct 2016 00:14:53 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:33124 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751091AbcJUEOx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2016 00:14:53 -0400
Received: by mail-pf0-f169.google.com with SMTP id 128so49260023pfz.0
        for <git@vger.kernel.org>; Thu, 20 Oct 2016 21:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:content-transfer-encoding:subject:message-id:date:to
         :mime-version;
        bh=xWCfH/ThY2b/sCykm8feaOukofdkVumyCFvNEYQJmYY=;
        b=A/GZupFmYjDsozxamlcC5jpDs4cw9BDYMySk7uDDRMAKq/96D8kKtUEuCb8jsK1aE7
         luJFA/fL6i71Wk05JzEfGWcM8BFAL/xVbJ6sHnND2fIyEfUpnSrkShh7vKh6Rjkjh3+7
         e+Sh1uZFVkDl5M2/ghzbxgrVByuo3mL9sz1m5FNAHIIjbAozjCRnPdBAWgBn+hhhc0BH
         J/WFFNWlgUSWM7JsoYRneph0v6jgBimGhoLPA+oCxGQzkUG018e5PVtO8pAGzsQfoLI2
         SdgFG2c55b5ochZKW0PxoljkAgKt88by5F0fIcncNeHAeIF1Irg4VNVYup+jXjG5UaB1
         /Ycg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:content-transfer-encoding:subject
         :message-id:date:to:mime-version;
        bh=xWCfH/ThY2b/sCykm8feaOukofdkVumyCFvNEYQJmYY=;
        b=Igi7Aivb1H4ZxImDxmMqgKyW3F+ST7SU1FHsyF48fMAYsB0iCCuctIx2hr6eF+CtIc
         R8eotOCefRxO2328+n3hab74Ch4kaJjC5GaSqRr6taD/7eOO1YBDMvlAj9TI0F9Ms4NP
         gRiVFi3zVlzNP950tmCg6RbCabgJYQbPHa8W3jsIoknIUZeZu75JkbS6E0Kd9yNhGCuY
         0OQWLo6f/QZRvSMmZpPIxtpaQxPRC7S81Wti7GeyOGizBP1K5klEEX1mXhykcVAVT1+P
         I0aJb5JFmBfAQHuPFJ15NqGawQ1FudKC9RDxqRpCIz2GJZB1CLygQyuZPlo+3WncJdMo
         +S0A==
X-Gm-Message-State: AA6/9RmkZFPrXWJyFxOMhhl36xl9+rXTtn6gydRx6DD6EP6VObnFwy94RAEOzl5boTMsbw==
X-Received: by 10.99.157.75 with SMTP id i72mr6291839pgd.147.1477023291831;
        Thu, 20 Oct 2016 21:14:51 -0700 (PDT)
Received: from [10.71.30.182] ([12.237.194.226])
        by smtp.gmail.com with ESMTPSA id xv9sm696002pab.36.2016.10.20.21.14.50
        for <git@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Oct 2016 21:14:51 -0700 (PDT)
From:   Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Subject: Prove "Tests out of sequence" Error
Message-Id: <D9C1E13F-88A2-483E-A549-1C2294EACFEB@gmail.com>
Date:   Thu, 20 Oct 2016 21:14:48 -0700
To:     git <git@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

on TravisCI I see these weird "Tests out of sequence" errors with prove
and they seem to not go away. I assume the reason that they not go away
is that the ".prove" file is carried over from on build to another (but =
I can't=20
look into this file on TravisCI).

Has anyone an idea where these errors might come from?

------------------------------------------------------------------------
t5547-push-quarantine.sh                         (Wstat: 0 Tests: 5 =
Failed: 0)
  Parse errors: Tests out of sequence.  Found (2) but expected (3)
                Tests out of sequence.  Found (3) but expected (4)
                Tests out of sequence.  Found (4) but expected (5)
                Bad plan.  You planned 4 tests but ran 5.
Files=3D760, Tests=3D15109, 679 wallclock secs (21.91 usr  1.78 sys + =
320.79 cusr 529.13 csys =3D 873.61 CPU)
Result: FAIL
make[1]: *** [prove] Error 1
make: *** [test] Error 2
------------------------------------------------------------------------

Example:
https://s3.amazonaws.com/archive.travis-ci.org/jobs/169385219/log.txt

Thanks,
Lars=

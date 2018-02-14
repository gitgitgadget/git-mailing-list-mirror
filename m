Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C0DB1F404
	for <e@80x24.org>; Wed, 14 Feb 2018 14:53:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031136AbeBNOxG (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 09:53:06 -0500
Received: from resqmta-po-03v.sys.comcast.net ([96.114.154.162]:34366 "EHLO
        resqmta-po-03v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1031003AbeBNOxC (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 14 Feb 2018 09:53:02 -0500
Received: from resomta-po-09v.sys.comcast.net ([96.114.154.233])
        by resqmta-po-03v.sys.comcast.net with ESMTP
        id lyQ5eorJbKVVzlyQfeu2vB; Wed, 14 Feb 2018 14:53:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20161114; t=1518619981;
        bh=u+bTujUnmTXkdRsFagYbw3gXzrVd5vnoBF/1+/9IVMY=;
        h=Received:Received:From:To:Subject:Date:Message-ID:MIME-Version:
         Content-Type;
        b=PtWabxRei5yiB42wpNJTBM4woNTZISr0Mr5UwBe/dMNDI3OrxA746ongmsS8Uj3qK
         olpQzB7B5UNHQggheUoA0eV2/hnf3/3Sjhytamuvj1Kg52xgSwTEPueG7mp2IzJpyb
         uig9Ot1s3k80MDLXKJGUI2E34nFdbqKRRKh0b7As2EVeQEFXcY5J6NY1DmWf8lxfK0
         fAOI262bEo7uxhEpAwByQD4DqM98shH6ejM9XziNX9nq4zwd1BJSSY6GajDZHreZN0
         LL+l9RIqPWW2x2PliIMMFXCM5JmDD1C7IZGLixzBDWQcA7h/No1uuqV5CDrrQVP0C/
         vqoiEkKESKsSw==
Received: from jjlt2 ([IPv6:2601:648:8400:5992:ccba:8df6:759a:6e31])
        by resomta-po-09v.sys.comcast.net with SMTP
        id lyQeexwqkfjk5lyQfejl7f; Wed, 14 Feb 2018 14:53:01 +0000
From:   <greenwood9@comcast.net>
To:     <git@vger.kernel.org>
References: 
In-Reply-To: 
Subject: RE: git-bashe.exe fails to launch
Date:   Wed, 14 Feb 2018 06:53:00 -0800
Message-ID: <015801d3a5a3$82bea1e0$883be5a0$@comcast.net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGrfzFasiwJxvm8YCH7rBZg3YAaOaP0R6oA
Content-Language: en-us
X-CMAE-Envelope: MS4wfDIDg4GRIsuOgp7MDbWl5yPPqTFAkDzgVfyi30tUIvDrESi2DcCm4gkH/Ychbp/drZHtN576It47RLU/RAC43nlKTCFplwVRQoEJuZZ2IYQQz0/FCMv6
 e/c1lK/N/mOhM6fN/sUBY48ttdGGwPm0smQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This appears to be covered by =
https://github.com/git-for-windows/git/issues/1473.  In particular, =
avih's comment about git-bash working without a .minttyrc file applies =
to me.  Apologize for the noise; should have fully reading bug reporting =
instructions.

-----Original Message-----
From: greenwood9@comcast.net [mailto:greenwood9@comcast.net]=20
Sent: Wednesday, February 14, 2018 6:45 AM
To: 'git@vger.kernel.org' <git@vger.kernel.org>
Subject: git-bashe.exe fails to launch

Resending as Plain Text.

After upgrading to 2.16.1.windows.4, I have been unable to launch =
=E2=80=9CC:\Program Files\Git\git-bash.exe=E2=80=9D from installed =
shortcut or from command line (cmd).  In both cases, the bash console =
flashes and closes immediately.

I am able to invoke =E2=80=9CC:\Program Files\Git\bin\bash.exe=E2=80=9D =
from the command line, in which case I appear to have full git =
functionality.

I have tried uninstalling and reinstalling a number of times to no =
effect.

Comparing a failing launch to a working launch on another computer using =
Process Explorer, the problem may be related to HarddiskVolume3.  This =
error shows up near the end of the failing launch.  Note the odd quote =
and =E2=80=9CI=E2=80=9D at the end of the path.

High Resolution Date & Time:     2/14/2018 6:14:13.7853585 AM Event =
Class:       File System
Operation:         CreateFile
Result:  INVALID PARAMETER
Path:     \Device\HarddiskVolume3=E1=BC=BD
TID:       13904
Duration:           0.0000095
Desired Access: Generic Read
Disposition:       Open
Options:             Synchronous IO Non-Alert, Non-Directory File, =
Complete If Oplocked, Open By ID
Attributes:         n/a
ShareMode:      Read, Write, Delete
AllocationSize:  n/a

This is my first post to this mailing list.  Please let me know if I =
need to register somewhere to see replies.


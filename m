Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7AF601F404
	for <e@80x24.org>; Wed, 14 Feb 2018 14:45:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030909AbeBNOpU (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 09:45:20 -0500
Received: from resqmta-po-09v.sys.comcast.net ([96.114.154.168]:54654 "EHLO
        resqmta-po-09v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1030798AbeBNOpS (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 14 Feb 2018 09:45:18 -0500
X-Greylist: delayed 372 seconds by postgrey-1.27 at vger.kernel.org; Wed, 14 Feb 2018 09:45:18 EST
Received: from resomta-po-18v.sys.comcast.net ([96.114.154.242])
        by resqmta-po-09v.sys.comcast.net with ESMTP
        id lyIbeydvyPnc7lyJCe6Qcx; Wed, 14 Feb 2018 14:45:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20161114; t=1518619518;
        bh=QruuiVN0S4tJU4PTm1VTT2pc7XWX15HrJTeOV1IHJQs=;
        h=Received:Received:From:To:Subject:Date:Message-ID:MIME-Version:
         Content-Type;
        b=EFRx94IVdJIYvkq3tPWwi9OQ46PnG6scNF6fV1tuduYfF4ZVvIJP+L3wH+jDle70L
         +PmBAybIsK3mTNAUIMd/t4hRvY6IbMB2bfXuPu3aPmoHpaCWLAZcLTP0B2z6KiFP3h
         jcv6ly1NB87BQZtb4tnJjewiBXxIM17Tevl353wUYNr0PmogtEcFj6MOLa/JLIcHJE
         KeO7qpBaHxM7k/M59kHj8bFqfcFJnhGWW3F1I2f2Sauj0uAt/iXMKoCK2WGdziN5Ms
         YCa555uQh/7ogInKee0Fn7SnRsB2K1jBlJl0wE/+RiETPm4VJXjCyEQdYTXfkU0Anf
         +G1ijOUz2JIJg==
Received: from jjlt2 ([IPv6:2601:648:8400:5992:ccba:8df6:759a:6e31])
        by resomta-po-18v.sys.comcast.net with SMTP
        id lyJBevdeolEGclyJBeK0Cb; Wed, 14 Feb 2018 14:45:18 +0000
From:   <greenwood9@comcast.net>
To:     <git@vger.kernel.org>
Subject: git-bashe.exe fails to launch
Date:   Wed, 14 Feb 2018 06:45:17 -0800
Message-ID: <015601d3a5a2$6e894050$4b9bc0f0$@comcast.net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdOlokIhBXS4N0WUTROI7kL8UlkIQA==
Content-Language: en-us
X-CMAE-Envelope: MS4wfKHdQ492vbtDp7LffEHa2lfETOaN9QmymclBbKrjTVpYZFoUATheUiPsjfJF064sUvLf6Va15DqBKWbpr8LMAEiJ25/T+j4Yc50eYTS3sNCVI6hawP4B
 8XdOjEyVWVuwrhxMi32KEqBCojgsC5HDXdQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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

High Resolution Date & Time:     2/14/2018 6:14:13.7853585 AM
Event Class:       File System
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


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEFBEC433EF
	for <git@archiver.kernel.org>; Thu, 16 Jun 2022 13:33:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376631AbiFPNdQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jun 2022 09:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiFPNdN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jun 2022 09:33:13 -0400
X-Greylist: delayed 334 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 16 Jun 2022 06:33:08 PDT
Received: from mail.efind.com (mail.efind.com [143.244.179.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 427D6175B9
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 06:33:08 -0700 (PDT)
Received: from localhost (mail.efind.com [127.0.0.1])
        by mail.efind.com (Postfix) with ESMTP id 5AC40DC20EDE
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 08:27:34 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.efind.com 5AC40DC20EDE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efind.com;
        s=20210531; t=1655386054;
        bh=J8A03RP2O0vUnlEtrSeOs0DY2+nJ+6K/gBKdTqxHJtU=;
        h=From:To:Subject:Date:From;
        b=wU8DY+RhafweE6SolE3jKAn8WTk3ipsLhANvo/+LiYzZDYZYm390nhay0DFSPRb1r
         h7OCXfp3D6Qk79MmjnqBsbHBPGTtcJINIdDkWUAsFLfuiOgwzANAuehg54aAs8FLkS
         ptQvT8YIi/LBIhZ5on1wIpmDrcq5ivyQjUrrhsWIHzjCGTycPypgACtraC/szU1WnT
         XygcpCV0migcUBrRAoVAvNgf0YkIiPioT36rSEsJ+OBZURJZ1zJIRJbrpA3bVLaL4h
         yYKgkbQmOONFLl49ERbsTwOSlJEjrI7H4D84Phyq15KxOLEJ+04KOSuJPZ9MP8FihJ
         vPP/qJC2ishDg==
X-Virus-Scanned: amavisd-new at efind.com
Received: from mail.efind.com ([127.0.0.1])
        by localhost (mail.efind.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 4Vqi1PRxb_Gg for <git@vger.kernel.org>;
        Thu, 16 Jun 2022 08:27:33 -0500 (CDT)
Received: from efind.com (unknown [105.112.212.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: efind.com/jswcon)
        by mail.efind.com (Postfix) with ESMTPSA id 14349DC20ED6
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 08:27:31 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.efind.com 14349DC20ED6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efind.com;
        s=20210531; t=1655386053;
        bh=J8A03RP2O0vUnlEtrSeOs0DY2+nJ+6K/gBKdTqxHJtU=;
        h=From:To:Subject:Date:From;
        b=Q4j1AzJ8hfEcjg1Aq8teH2s53BU9/KVM7ldFiNIbKzJt9Q3lAstg+VcM4+ZPKRp5J
         rU5lNh9imckEBTqmJD+0DAnxFy6jps5paZ1+G+LTNFQaag3Ni9O/O6ZnF2h09F4vzP
         ebL/xfJZeaPo2qSwewocgFtGAo7fUTcRDTYQOYSkhgafrGxgv3IyyI/ASJ9AU2xCzr
         y7AcAOpW24iiGCJvmOFTHeakMG8DesZEnkJpr9+DE6l9GO78fpNx5pw9TJZJhzDNMb
         srkdBPq0oaX6VEZEq7KPkPn95lfjD1nuSQrRsAzIGfAifWo4czpYM9F8e82atGsN97
         kVio4lgLqoWWA==
From:   Iulia Moraru <jswcon@efind.com>
To:     git@vger.kernel.org
Subject: FYI PO Attached
Date:   16 Jun 2022 21:27:30 +0800
Message-ID: <20220616210425.83CD0621AC5EDAE7@efind.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
        boundary="----=_NextPart_000_0012_8F877F94.18E77699"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0012_8F877F94.18E77699
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Dear Sir,

As per attached please find the revised PO (Signed & Stamped) and=20
let me have your signed & Stamped one, also I need to have your=20
PI to proceed the advance payment to active the PO. Please sign=20
and stamp the technical DS accordingly. I will send you 100%=20
payment as soon as I receive your PI.

Best Regards
Ms.Iulia Moraru,
Jam Petrochemical Company
N0.27, Nezami St,Tavanir Ave.,
Tehran 14348-43145 , Iran
Tel : 88654545  Ex: 384
------=_NextPart_000_0012_8F877F94.18E77699
Content-Type: application/zip; name="attachments.zip"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachments.zip"

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


------=_NextPart_000_0012_8F877F94.18E77699--


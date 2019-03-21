Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18E1A20248
	for <e@80x24.org>; Thu, 21 Mar 2019 14:17:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbfCUORv (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 10:17:51 -0400
Received: from smtp.synchrotron-soleil.fr ([195.221.0.33]:36404 "EHLO
        brouette.synchrotron-soleil.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725985AbfCUORu (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 21 Mar 2019 10:17:50 -0400
X-Greylist: delayed 390 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Mar 2019 10:17:49 EDT
Received: from localhost (unknown [127.0.0.1])
        by brouette.synchrotron-soleil.fr (Postfix) with ESMTP id ED40D7000E7
        for <git@vger.kernel.org>; Thu, 21 Mar 2019 14:11:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 brouette.synchrotron-soleil.fr ED40D7000E7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=synchrotron-soleil.fr; s=email; t=1553177476;
        bh=1ztTTT1+W8C5+3ZqvhK5xTHetCQERbj2L4u4qilUleg=;
        h=From:To:Subject:Date:From;
        b=FlCGCb4v8VogBAVadhVXbTJGsPgH3tsmEdRmdW5p6YpBeK72FJQS02RvhFiXRYZhf
         nrDwcKCGFTY9kPJFdDzLCfVcvWih1sPyb/heH8i7GN1UpZL2h/fjiXPvXhqBEr1SSZ
         Z9EWZYVh/MFo+Ya15ByBYCeBhV0aE8H6kc00LTL4=
X-Virus-Scanned: amavisd-new at synchrotron-soleil.fr
Received: from brouette.synchrotron-soleil.fr ([127.0.0.1])
        by localhost (brouette.synchrotron-soleil.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id kbZ4tWRCuJHE for <git@vger.kernel.org>;
        Thu, 21 Mar 2019 15:11:15 +0100 (CET)
Received: from SUN-DAG4.synchrotron-soleil.fr (sun-dag4 [195.221.0.186])
        by brouette.synchrotron-soleil.fr (Postfix) with ESMTP id 3719A700096
        for <git@vger.kernel.org>; Thu, 21 Mar 2019 15:11:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 brouette.synchrotron-soleil.fr 3719A700096
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=synchrotron-soleil.fr; s=email; t=1553177475;
        bh=1ztTTT1+W8C5+3ZqvhK5xTHetCQERbj2L4u4qilUleg=;
        h=From:To:Subject:Date:From;
        b=c4uRhBLvVWFH4q8wDbJOkUI3YKtbfbn0Xgpsa7sOTqk/6YHGlRBoP254k1iNTGTiP
         cZkRr1A7yeUp7Yp6YWvpYwtTV8Vu2j3x66b3BZiDSiqnVB/rYLa3STcyHXSF6ug275
         BR8NLmtKtv5oyugh9Ors0DhwyaDY0xKvwN/nb2oQ=
Received: from SUN-DAG3.synchrotron-soleil.fr ([fe80::d9b:188b:4893:f07f]) by
 SUN-DAG4.synchrotron-soleil.fr ([fe80::1b5:8a84:6569:cfff%16]) with mapi id
 14.03.0123.003; Thu, 21 Mar 2019 15:11:15 +0100
From:   MARIE Alexandre <alexandre.marie@synchrotron-soleil.fr>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: [New to the mailing list] Searching for help
Thread-Topic: [New to the mailing list] Searching for help
Thread-Index: AdTf7/GYSonLEW8gQrO+p9va43HfTw==
Date:   Thu, 21 Mar 2019 14:11:14 +0000
Message-ID: <7EF15309FAA2EA4FAB1643CB55D93ED8DBD411@SUN-DAG3.synchrotron-soleil.fr>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [195.221.0.171]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I am searching for help as I made two mistakes, I think.
First I fetched origin in a 'branch' called temp that is in a 'detached hea=
d' state.
But I can't delete temp by checking out master.
I don't know how to get rid of this temp detached head.

Second, the detached head causes one issue :

It splits my commits in two, I mean that all the new commits I do are on to=
p of temp detached head but they are not linked.
I can't get through these two issues with google, I don't know why.

Cheers,

Alex=

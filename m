Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,URIBL_SBL,
	URIBL_SBL_A shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C5101F453
	for <e@80x24.org>; Thu,  1 Nov 2018 11:32:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbeKAUew (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Nov 2018 16:34:52 -0400
Received: from smtpoutz22.laposte.net ([194.117.213.97]:35461 "EHLO
        smtp.laposte.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727507AbeKAUev (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Nov 2018 16:34:51 -0400
Received: from smtp.laposte.net (localhost [127.0.0.1])
        by lpn-prd-vrout010 (Postfix) with ESMTP id BC3B84AF311
        for <git@vger.kernel.org>; Thu,  1 Nov 2018 12:32:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=laposte.net; s=mail0;
        t=1541071936; bh=0FuXG9mqkfX5JBfbKhYYTLj4MfzwaQe88nEKv0FtiN8=;
        h=Subject:From:To:Date:In-Reply-To:References;
        b=hSgVURzbD0bYNR7PwfEYA5CVNonsCXPC/+086EgkS3H8h1hqBPB1AVB/PzeFCc6Dy
         DLE10MU2Q0VSbA9X3otoKE7GSJFAnqVYGQzTQc6/KnsDVb6HM1twfEgkV2xVW0maKc
         ibmiwR7gsn/Vhx4tFW3m4FqZe1s/OTLsRNPAZrYHxY2IZvSfSaH6xgKr3Ely8PzgiU
         fvt8fIEWsmZ2ZyJPozgRzDYCYMeYtKNmHCCdP3orsJMkPCUnkMMviwBHZ6VrpYVjlE
         SV898+Sx4IOyi4boxiCjZA14TtY3zCyCrjmffRz83eg5ndAgxR6Ew1M1VlnIyXntfN
         6n5k8ayKRKyEA==
Received: from smtp.laposte.net (localhost [127.0.0.1])
        by lpn-prd-vrout010 (Postfix) with ESMTP id AD9474AF749
        for <git@vger.kernel.org>; Thu,  1 Nov 2018 12:32:16 +0100 (CET)
Received: from lpn-prd-vrin004 (lpn-prd-vrin004.laposte [10.128.63.5])
        by lpn-prd-vrout010 (Postfix) with ESMTP id AC8F64AF311
        for <git@vger.kernel.org>; Thu,  1 Nov 2018 12:32:16 +0100 (CET)
Received: from lpn-prd-vrin004 (localhost [127.0.0.1])
        by lpn-prd-vrin004 (Postfix) with ESMTP id 9B9997289C6
        for <git@vger.kernel.org>; Thu,  1 Nov 2018 12:32:16 +0100 (CET)
Received: from arekh.ddns.net (unknown [82.64.49.105])
        by lpn-prd-vrin004 (Postfix) with ESMTPA id 878677289C5
        for <git@vger.kernel.org>; Thu,  1 Nov 2018 12:32:16 +0100 (CET)
Received: from cerebro.okg (box.okg [192.168.0.1])
        by arekh.ddns.net (Postfix) with ESMTPSA id 69ABD220057
        for <git@vger.kernel.org>; Thu,  1 Nov 2018 12:32:16 +0100 (CET)
Message-ID: <b2895479becfa9213935804aceaf4881c49073e8.camel@laposte.net>
Subject: Re: [RFE] Please add name and email to git credentials
From:   Nicolas Mailhot <nicolas.mailhot@laposte.net>
To:     git@vger.kernel.org
Date:   Thu, 01 Nov 2018 12:32:16 +0100
In-Reply-To: <6d8ef01ad9eb08d90cb9848eeaeabe6784b7b3e3.camel@laposte.net>
References: <6d8ef01ad9eb08d90cb9848eeaeabe6784b7b3e3.camel@laposte.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.31.1 (3.31.1-2.fc30) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-VR-FullState: 0
X-VR-Score: 0
X-VR-Cause-1: gggruggvucftvghtrhhoucdtuddrgedtkedrieehgdeftdcutefuodetggdotefrodftvfcurfhrohhf
X-VR-Cause-2: ihhlvgemucfntefrqffuvffgnecuuegrihhlohhuthemucehtddtnecunecujfgurhepkffuhffvffgj
X-VR-Cause-3: fhgtfggggfesthekredttderjeenucfhrhhomheppfhitgholhgrshcuofgrihhlhhhothcuoehnihgt
X-VR-Cause-4: ohhlrghsrdhmrghilhhhohhtsehlrghpohhsthgvrdhnvghtqeenucffohhmrghinheptghorhhprdgt
X-VR-Cause-5: ohhmpdhfvgguohhrrghprhhojhgvtghtrdhorhhgnecukfhppeekvddrieegrdegledruddtheenucfr
X-VR-Cause-6: rghrrghmpehmohguvgepshhmthhpohhuthdpihhnvghtpeekvddrieegrdegledruddthedphhgvlhho
X-VR-Cause-7: pegrrhgvkhhhrdguughnshdrnhgvthdpmhgrihhlfhhrohhmpehnihgtohhlrghsrdhmrghilhhhohht
X-VR-Cause-8: sehlrghpohhsthgvrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghen
X-VR-Cause-9: ucevlhhushhtvghrufhiiigvpedt
X-VR-AvState: No
X-VR-State: 0
X-VR-State: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Le jeudi 01 novembre 2018 à 10:59 +0100, Nicolas Mailhot a écrit :
> Hi,
> 
> A dev persona is not just a username, please add email (and probably
> also name) support to git credentials so the correct set for a repo
> url
> is automatically picked up by git

So, just in case it was not clear enough, allow things in .gitconfig
like

[credential "https://pkgs.fedoraproject.org/"]
username = doe4ever
name = John Doe
email = foo4ever@fedoraproject.org
[credential "https://gitlab.corp.com/"]
username = jdoe56874
name = John Doe, Snr Engineer
email = john.doe@corp.com

Instead of just

[user]
name = John Doe
email =  john.doe@corp.com
[credential "https://pkgs.fedoraproject.org/"]
username = doe4ever
email = foo@fedoraproject.org
[credential "https://gitlab.corp.com/"]
username = jdoe56874

and drat, I've commited to XXX with the wrong name/email again

-- 
Nicolas Mailhot


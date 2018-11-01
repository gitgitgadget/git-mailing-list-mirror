Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,URIBL_SBL,
	URIBL_SBL_A shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE9521F453
	for <e@80x24.org>; Thu,  1 Nov 2018 12:34:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728546AbeKAVhO (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Nov 2018 17:37:14 -0400
Received: from smtpoutz24.laposte.net ([194.117.213.99]:52543 "EHLO
        smtp.laposte.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728326AbeKAVhO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Nov 2018 17:37:14 -0400
Received: from smtp.laposte.net (localhost [127.0.0.1])
        by lpn-prd-vrout012 (Postfix) with ESMTP id 6FB6716342F
        for <git@vger.kernel.org>; Thu,  1 Nov 2018 13:34:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=laposte.net; s=mail0;
        t=1541075664; bh=vNkhzzHX2RQy5Us5g/jtVG7YKbhnkPJvOzp9W+CRtrA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References;
        b=NBnf7WSfiAsuEovd6R5dNForGd4sxDmFDskcETpmuwFq3kY+10ulvvLV7qfLq1TAt
         dotJgmYoKJ4D22LmGyWH89idU7kJODLgMJkQ4/eaw57V1UexrMjvxsMTIEBKnlP9Vp
         CiVgHPZsSZawtotOjOL+i03/cUMQehakmWqEIJB0VgnZ9HE7TZDKG0GloQV7BMLhMp
         TyT2ewDFVfygkVyHlYEzIbBh1WwFYMsQeO32GDkJcHF5Kqsfr9AbjiI0U3SIJaH40z
         /5sLH8bnQVo0QZEL+/qJAB+3yT15F4fOVOIeauDsNMi8j4jkUR/1PU4z6Znd7z+gEj
         vDgWeF1Au4FAA==
Received: from smtp.laposte.net (localhost [127.0.0.1])
        by lpn-prd-vrout012 (Postfix) with ESMTP id 6209F163457
        for <git@vger.kernel.org>; Thu,  1 Nov 2018 13:34:24 +0100 (CET)
Received: from lpn-prd-vrin002 (lpn-prd-vrin002.prosodie [10.128.63.3])
        by lpn-prd-vrout012 (Postfix) with ESMTP id 5D3C616342F
        for <git@vger.kernel.org>; Thu,  1 Nov 2018 13:34:24 +0100 (CET)
Received: from lpn-prd-vrin002 (localhost [127.0.0.1])
        by lpn-prd-vrin002 (Postfix) with ESMTP id 4D8255E82E0
        for <git@vger.kernel.org>; Thu,  1 Nov 2018 13:34:24 +0100 (CET)
Received: from arekh.ddns.net (unknown [82.64.49.105])
        by lpn-prd-vrin002 (Postfix) with ESMTPA id 3979B5E82D6
        for <git@vger.kernel.org>; Thu,  1 Nov 2018 13:34:24 +0100 (CET)
Received: from cerebro.okg (box.okg [192.168.0.1])
        by arekh.ddns.net (Postfix) with ESMTPSA id 1D2A022008E;
        Thu,  1 Nov 2018 13:34:24 +0100 (CET)
Message-ID: <6f3d8c49e1d44ab20d4169e5254364cba707f1af.camel@laposte.net>
Subject: Re: [RFE] Please add name and email to git credentials
From:   Nicolas Mailhot <nicolas.mailhot@laposte.net>
To:     =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason 
        <nicolas.mailhot@laposte.net>
Cc:     git@vger.kernel.org
Date:   Thu, 01 Nov 2018 13:34:23 +0100
In-Reply-To: <87zhutjb3t.fsf@evledraar.gmail.com>
References: <6d8ef01ad9eb08d90cb9848eeaeabe6784b7b3e3.camel@laposte.net>
         <87zhutjb3t.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.31.1 (3.31.1-2.fc30) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-VR-FullState: 0
X-VR-Score: 15
X-VR-Cause-1: gggruggvucftvghtrhhoucdtuddrgedtkedrieehgdegudcutefuodetggdotefrodftvfcurfhrohhf
X-VR-Cause-2: ihhlvgemucfntefrqffuvffgnecuuegrihhlohhuthemucehtddtnecuogetfedtuddqtdduucdludeh
X-VR-Cause-3: mdenucfjughrpefkuffhvfffjghftggfggfgsehtkeertddtreejnecuhfhrohhmpefpihgtohhlrghs
X-VR-Cause-4: ucforghilhhhohhtuceonhhitgholhgrshdrmhgrihhlhhhotheslhgrphhoshhtvgdrnhgvtheqnecu
X-VR-Cause-5: ffhomhgrihhnpegtohhrphdrtghomhdpfhgvughorhgrphhrohhjvggtthdrohhrghenucfkphepkedv
X-VR-Cause-6: rdeigedrgeelrddutdehnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhinhgvthepkedvrdei
X-VR-Cause-7: gedrgeelrddutdehpdhhvghloheprghrvghkhhdruggunhhsrdhnvghtpdhmrghilhhfrhhomhepnhhi
X-VR-Cause-8: tgholhgrshdrmhgrihhlhhhotheslhgrphhoshhtvgdrnhgvthdprhgtphhtthhopehgihhtsehvghgv
X-VR-Cause-9: rhdrkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-VR-AvState: No
X-VR-State: 0
X-VR-State: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Le jeudi 01 novembre 2018 à 12:22 +0100, Ævar Arnfjörð Bjarmason a
écrit :
> 
> Where would we get an E-Mail to lookup to pass to the helper? Are you
> just asking that the helper git the result of $(git config user.name
> &&
> git config user.email)? If so why can't it just look this up itself?


So, just in case it was not clear enough, allow things in .gitconfig
like

[credential "https://pkgs.fedoraproject.org/"]
username = doe4ever
name = John Doe
email = doe4ever@fedoraproject.org
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
[credential "https://gitlab.corp.com/"]
username = jdoe56874

and drat, I've commited to XXX with the wrong name/email again


-- 
Nicolas Mailhot


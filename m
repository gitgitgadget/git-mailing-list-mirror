Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PI_EMPTY_SUBJ,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CAD8520248
	for <e@80x24.org>; Sun,  3 Mar 2019 13:29:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbfCCN3d (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Mar 2019 08:29:33 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46625 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbfCCN3d (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Mar 2019 08:29:33 -0500
Received: by mail-pg1-f194.google.com with SMTP id 196so1208125pgf.13
        for <git@vger.kernel.org>; Sun, 03 Mar 2019 05:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1BTP6Tog/+a7IhnpaLcYGyJVzpB22lRiBjAaEwXl0Uk=;
        b=HfYqCs9QpGdDvEqwoalcC2ChJzbaoZswq+z1anpouJgKbRGDLcJuYMrjyS5g4n6gz1
         Uqn6f18Q7UFZYnV+39QLBT4eWtLQKvuvAvl/oNZKw54eZffwDdiq/lroP3ta3fPcbgTh
         RFpMDRBTp7TokWxeMuJTBomg2VrdmqZDqTpkHZJdesBU6dJk5Ty+5R3rscLTanB17mPD
         OIYgSEsRKO4XUV5y7KM8N5t3uGEQ4LpavpBryJnBMga8JmQn2Ndw8kvCLi1pNYeS6lcY
         JacVOedxdI/PdR0UZVq9QBpwrJ26Gw0LZZQKYV/J+irNkNUDAuwUHxhN1mp/EHLIlXXr
         QAzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1BTP6Tog/+a7IhnpaLcYGyJVzpB22lRiBjAaEwXl0Uk=;
        b=c7+kf2HpzaJhCsd0k96Ajnls++LE6OPEjncdstPT3KcGPOVBO0oklSfdQyN4cLuhRM
         RJXg6GQxKoodp6gfHnDUYTMvCd6ctbtoIbVDekoqs6MAioROoI0owHSGV7wC1lTleB98
         lOfQRu+Kv74ak0lsIe3XI0CdcS5Tf8rMfoU2lGsEQuVymNwfeVMsL+oiC5Swd/Snw/He
         pnbGU1tvQlxNfAyJJaKPNWQ47R4CwIgtCMvKYH5V08wkeHk5Zm4sac11jLhV3ix5Q0xh
         pNJIjHovfvEC3jwucXNPilJallgOlh1wa3nldNINTBSQyy8k3IaHbL+9bsJ7/z7SZYs+
         vghQ==
X-Gm-Message-State: APjAAAV8c21ZgOkLTbjNnGxYzBRt8OvKcN16gAopOb6M5abr2pTkoOdw
        r4HWnz7BUckkpQ4VbaXnJDM=
X-Google-Smtp-Source: APXvYqwBXOyeZPS3BIl8uxuYN/Un2NQpzsXToS/oO8GJxTAeMq536QmJH+l54BMeCRz/cidTGURvug==
X-Received: by 2002:a63:b0b:: with SMTP id 11mr14030245pgl.187.1551619772758;
        Sun, 03 Mar 2019 05:29:32 -0800 (PST)
Received: from ar135.iitr.ernet.in ([103.37.201.80])
        by smtp.gmail.com with ESMTPSA id f65sm5137178pff.21.2019.03.03.05.29.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Mar 2019 05:29:32 -0800 (PST)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     gitster@pobox.com
Cc:     Johannes.Schindelin@gmx.de, christian.couder@gmail.com,
        git@vger.kernel.org, rohit.ashiwal265@gmail.com,
        t.gummerer@gmail.com
Subject: 
Date:   Sun,  3 Mar 2019 18:59:00 +0530
Message-Id: <20190303132900.4618-1-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <xmqq5zt014du.fsf@gitster-ct.c.googlers.com>
References: <xmqq5zt014du.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Junio

On 2019-03-03 13:20 UTC Junio C Hamano <gitster@pobox.com> wrote:

> s/Add/add/.  Strictly speaking, you do not need to say "new", if you
> are already saying "add", then that's redundant.

Oh, my mistake, I will change in coming revisions.

> "test -s <path>" is true if <path> resolves to an existing directory
> entry for a file that has a size greater than zero.  Isn't it
> redundant and wasteful to have test_path_is_file before it, or is
> there a situation where "test -s" alone won't give us what we want
> to check?

Just to be clear of what caused the error:
	1. Path not being file, or
	2. File not being empty
I am checking for both.

Regards
Rohit


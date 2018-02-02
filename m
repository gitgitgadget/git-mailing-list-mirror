Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E16F1F576
	for <e@80x24.org>; Fri,  2 Feb 2018 09:49:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751554AbeBBJtd (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Feb 2018 04:49:33 -0500
Received: from mail-wm0-f45.google.com ([74.125.82.45]:54127 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750795AbeBBJtb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Feb 2018 04:49:31 -0500
Received: by mail-wm0-f45.google.com with SMTP id t74so11302376wme.3
        for <git@vger.kernel.org>; Fri, 02 Feb 2018 01:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-transfer-encoding;
        bh=HJ667W5CEh3O5ICzF5lZYagRHXbk4m+9n9lDJt/cCvI=;
        b=W5NWAk0ncTxMJ9qGEU7H9qsBbqBTlFp1b/6EiSE3DWhrl/qySInU+JH2RE7FXWkqyq
         wSInrdzwH7ExEo9kb13ofXvPho1KO5vNhix/6I89Ztpbjk/LbL4liBYfKCSuWtMdF99k
         wot4Z1YvYvGFj64ZTJ3HlJNFV8pyNQiEmtR7E2NSqYReMndyJ9KqivjcY3ku9qK06KrJ
         Ibk3zVy8/SHe6mP20pGGVDw0rHbxRbmygdly5HdSxlmsCEY8HDeo2BETrV23LvGZ1/tX
         Dav0p4E8z17gsHTYM0KnRF6jTeVRmWLk0DoikwYh0bCb4foKdJnTPpgxBdCR+mxreuEs
         L5mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :subject:references:in-reply-to:content-transfer-encoding;
        bh=HJ667W5CEh3O5ICzF5lZYagRHXbk4m+9n9lDJt/cCvI=;
        b=hm43PhDoG5qgAfgPjlXEXT9KDjYK4+pf0JTZO5qpmxOTRtZr0SY5HNt84pI25NONCt
         NvlyRu3r1ocIDMPNHm4WjocORmvGhxdr8IAbRSh418PQ6l3QaJQyc69pO/acArsIeSmo
         5QaT4neM+r/qIAt8Mhr9PEPJjOGzaWQQOGFWpWLhousWxDNRWxF4rkAD2+kB6MT+PerH
         krIjYsBT7c7a7uwHTYn2tlR+HNpus7BdMstAxxxS1u4SzHsfNOwpF8Hv68Y4nXfRy3VR
         xE94bKj4nUQ/FlhwIZA7LEZJjhZw7FJtDdrGO2HFK6BiCa6ecQlk1ZIwex8WoWzoKTxr
         m3AA==
X-Gm-Message-State: AKwxytc4nAEDpwb/h4dCS13YfG0QUtIlTria/Q2qtQhGcWcDCK319Ylw
        zBnMGnOdoWd4bjZ/KGc1xeA=
X-Google-Smtp-Source: AH8x225uXRk0HCSUuMqW7TDT/iiQBEbryBi6Jv+Ui9g5QIrWpOiAA+Fp2HlaVzD+ZrnJZtaLn3fecQ==
X-Received: by 10.80.144.169 with SMTP id c38mr67223064eda.210.1517564969792;
        Fri, 02 Feb 2018 01:49:29 -0800 (PST)
Received: from [192.168.0.104] (d8D86700B.access.telenet.be. [141.134.112.11])
        by smtp.gmail.com with ESMTPSA id s23sm1336756edm.15.2018.02.02.01.49.28
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 02 Feb 2018 01:49:29 -0800 (PST)
Message-ID: <5A743428.6040804@gmail.com>
Date:   Fri, 02 Feb 2018 10:49:28 +0100
From:   Mark Nauwelaerts <mark.nauwelaerts@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:25.0) Gecko/20100101 Firefox/25.0 SeaMonkey/2.22
MIME-Version: 1.0
To:     Hareesh Rajan <hareesh.rajan@gmail.com>, git@vger.kernel.org
Subject: Re: Git remote helper's fast export options
References: <CAPm4vtnDdF31wx2VrarGk_uX9zQOubiD+LA7gsP_9qKFpqt28g@mail.gmail.com> <CAPm4vt=oAa848JqVHeOK28+qf6KoM56_JEWzZjou7X_-fFsk3w@mail.gmail.com>
In-Reply-To: <CAPm4vt=oAa848JqVHeOK28+qf6KoM56_JEWzZjou7X_-fFsk3w@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/02/18 00:14, Hareesh Rajan wrote:
> Hi,
>
> I use git remote helper to export/import repository content. Git
> internally uses fast-export command and it seems like the options to
> detect move and copy (-M/-C) are not being used.
> Logging this issue requesting a fix to the remote helper to generate
> rename and copy commands in the output dump.
>
> Git version: 2.14.1
>
> Thanks,
> Hareesh
This may have to do with a few changes that happened there recently; see 
https://public-inbox.org/git/1514112729-31647-1-git-send-email-mark.nauwelaerts@gmail.com/ 
for a few patches addressing that.

Mark.

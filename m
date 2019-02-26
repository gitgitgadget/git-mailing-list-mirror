Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4EA4920248
	for <e@80x24.org>; Tue, 26 Feb 2019 18:19:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729152AbfBZSTE (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Feb 2019 13:19:04 -0500
Received: from mail-qk1-f202.google.com ([209.85.222.202]:37240 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728736AbfBZSTD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Feb 2019 13:19:03 -0500
Received: by mail-qk1-f202.google.com with SMTP id b6so11173738qkg.4
        for <git@vger.kernel.org>; Tue, 26 Feb 2019 10:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=RPsAxPGezWYp+cSVaF5EySTlD2w44H/oZDIFNFWJeKY=;
        b=jmH0qxOVAuEJ8mdBWp78cjfhPrNJnM4g8VS7GaN4sLx02syC8/81fVV3KLrEgPpAl9
         TYFSzPU0FKRuEkcMaOImVyVfsKjGPq0slnUZM5GWEl50vhEkabbZ95tuNLJaiUxwvX2+
         e3ouAL91YD8rSIpuI47XyIavG91H73ij3uQ8i+fxVKc95+Rgh2WAiSfnV+CK12VTDKwr
         OMKQn6uAvY27oVUyql/P1VS52mEyoK/YFWWzp1cbKUHCv0QoGcO2M8Go7dpYuj9grumg
         zfMCB5y/BrNLw4yayiw12uSLiBimpOE2OIqnro5vICWBOjaQV78m4Qt4CNHEdOK9YGKS
         u7Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=RPsAxPGezWYp+cSVaF5EySTlD2w44H/oZDIFNFWJeKY=;
        b=frYDADaQ6TJ7yZm8LZ21Ew2l4gWmgUTKSjZYHvb/StBRH6pcXy0F/krmROUbhVXCw4
         sjvWULfd4zsJ8FUffE3ICfmH5QVCZwwwrux9y4710zhHzi/dBYEW6hw8bf21V0ThOlDU
         eT2nxA6TWdobTeYxtQ2WLod0yJMrpaW6jKusnNy9zbIldaz1AWAGBWupPBwhWCmA68Bg
         CtQp2zlwTbE03EVwlihzp+ZJ3us3D0ZOjNk4k3H2po1GRJw5sjEaNrH6/USMbG+Eo3HT
         DQ34V4aMNeoTfLw5EEbnc4ANb+HJTMK5Q7d0++N1wOcNAiDJ4xM7xK8Kr//tlit9mBR/
         K1Hw==
X-Gm-Message-State: AHQUAubvR9Or9te/C01hVBoAMZeKGaK8gh6m9+CCsxoIPPvEZJlCmJtv
        OTpoVtjZPFp/N0Kl/sPeK2CRhjpxnz5mijBDl12Y
X-Google-Smtp-Source: AHgI3Iam//HCZe0XGWuPJBGsn2aqjIzVQVOImfjZc0t/DfcHLq7IywOFlSisDGbf41uFoh86IhXhJoI0GrUGA3TsH2qZ
X-Received: by 2002:ac8:2e17:: with SMTP id r23mr14317415qta.24.1551205142866;
 Tue, 26 Feb 2019 10:19:02 -0800 (PST)
Date:   Tue, 26 Feb 2019 10:18:59 -0800
In-Reply-To: <20190226070408.GA117495@google.com>
Message-Id: <20190226181859.65894-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20190226070408.GA117495@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: Re: [FIXUP] Fixup on tip of jt/http-auth-proto-v2-fix
From:   Jonathan Tan <jonathantanmy@google.com>
To:     jrnieder@gmail.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org, peff@peff.net
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Thanks for fixing it.
> 
> Is there a particular patch this should be squashed into, or does it
> stand alone?  It the latter, mind writing a commit message for it?

Not sure if I'm using "fixup" correctly in the subject, but this is
meant to be squashed onto the tip of jt/http-auth-proto-v2-fix -
specifically, deb7d2094a ("remote-curl: use post_rpc() for protocol v2
also", 2019-02-14).

I don't think it should be a standalone commit, as the tip is buggy -
which might break bisect. But if we really want a standalone commit,
this commit message should work:

remote-curl: handle consecutive flushes correctly

When the client, using protocol v2, sends two consecutive flushes and
then an EOF, remote-curl dies. This is because, at the start of a
new request, stateless_connect() reads, and if no EOF is found, then
stateless_connect() calls post_rpc() which reads until a flush is
encountered. This is a problem when stateless_connect() reads the second
consecutive flush (hence, no EOF), and then post_rpc() reads, not
expecting an EOF at all.

Teach stateless_connect() to inform post_rpc() to read only if what it
read isn't a flush.

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BA371F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 22:22:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725902AbeJLFv0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 01:51:26 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:38927 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbeJLFv0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 01:51:26 -0400
Received: by mail-pg1-f202.google.com with SMTP id i189-v6so7684501pge.6
        for <git@vger.kernel.org>; Thu, 11 Oct 2018 15:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=8UK0cE6AnIBmpY93IJqmhLvWY3mHUto/xY7aaVXkOBs=;
        b=n1c9KMtXGUlfCSAPwwNNDSlbHcNeS0KVFuP5jZCv4yOR3Z06/Ai5MMW1dTsIAR5oHc
         xuT2tn7tDFXmqmn50+o//Gz+NdkcWW+2BG2vzU8UD3jUNfwBoB17a/172W9C9oybGNpf
         YHIFJqWL+Gjpox/RuMgX+uhTMbbm1JILCedlVLiL5ARRWUcI1dzxDecl7W8vKXd+ghcr
         LL8o4Zq59S2zhfYToqVBPYq3upFA5JGU7agIUyf5KdtIqYGKvXo9hrCx8OS+kmYfubkf
         OGp32jxpiVzGktXmE52jcpQ/UNIUGKfC829EEmuTYbM/28Pt6KSi8u1e2KrRQAEU4vv0
         xhGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8UK0cE6AnIBmpY93IJqmhLvWY3mHUto/xY7aaVXkOBs=;
        b=bSaU6/be2gdhwXd1JeAASVwtsMdm3MaI4pk7Wmcgf0B6HDcop20Sl8xk2ee63RNOgi
         TlGM9YxolgrxxeDMWHmbxq1KhHDJ9jz4Pugft+QDSzaVdzua1Tr5pCnw0DsTPWCG1V2I
         0rwmujugCYyhtODAJBT6u/FRO/alCijmtsmTCpP8HUgcqe+SSpZMJm3rRJ+bmjrqwnCQ
         2uvPrzvDVl3NGaZI8jhosCj0sFKPl9UsN/TbQOnNyd05yqW404/F+t37XUJJ9RYzZh0I
         P0iNET0UJel8k0f9CCAQxNEDT+y5F13UxU1GAaT5df6j6ziK3xZnMWYaoVHmROZHc/jR
         57Kw==
X-Gm-Message-State: ABuFfohHx4L0XHvfowz4pUhgnnAjLZ1dZ3FTetpRUppOH5jH7exBsFAL
        sia3HmgLue2mXdBzUCg5yxq1UEzWWYOIqfCtaWzX
X-Google-Smtp-Source: ACcGV62Q+QRI1Mk7INUDdKtuhPVCkbMRF+UBpB1uJOF0npplnJUsDM7j2biyHm8vOID8tgNRjY/lpisNCWd1i8Y3yS81
X-Received: by 2002:a63:6844:: with SMTP id d65-v6mr1840296pgc.17.1539296528050;
 Thu, 11 Oct 2018 15:22:08 -0700 (PDT)
Date:   Thu, 11 Oct 2018 15:22:04 -0700
In-Reply-To: <20181011211754.31369-17-sbeller@google.com>
Message-Id: <20181011222204.187928-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20181011211754.31369-17-sbeller@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: Re: [PATCH 16/19] pretty: prepare format_commit_message to handle
 arbitrary repositories
From:   Jonathan Tan <jonathantanmy@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patches 6-16 are all quite straightforward, and are reviewed-by: me.

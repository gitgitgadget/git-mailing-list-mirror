Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BAAE211B3
	for <e@80x24.org>; Tue,  4 Dec 2018 19:29:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbeLDT3J (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Dec 2018 14:29:09 -0500
Received: from mail-pf1-f201.google.com ([209.85.210.201]:35774 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbeLDT3J (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Dec 2018 14:29:09 -0500
Received: by mail-pf1-f201.google.com with SMTP id l22so8451857pfb.2
        for <git@vger.kernel.org>; Tue, 04 Dec 2018 11:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=RX+cp6fdQ44HNqlLQI6JN1Mm/ZtQtBdqxCHcCEl3qK8=;
        b=spvxuEk1eKXb1b48mUoXgEIyS/WA0o9k8k2pZt8sB9kfQUBAS+RaDilj+nys1gAa2N
         S/mV8QfaWI2uNKuaE4LMdBXXIldeRpP5gkUdF+T9LebHwAcDXr3Sf1asWrvUy0J1fINr
         48mRwtG0cqInC3QHxKsX0ImJiepkUfnTfDDq2q4AzRnciiVc3Xo0maaoXe++xGpbyHyU
         pSgRlpa/ri0Z5VlgegHPz99EPgad386oLxSoVj5RdtO0tx6gJdZRllD1ZSquHezomJmf
         Ajc6jcZ+GbD2H/TPsOBSQBt7abfR8c3W8XvVJwxmCg0aGn4CH1fMtkZQiFUELai+xKgL
         SJqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=RX+cp6fdQ44HNqlLQI6JN1Mm/ZtQtBdqxCHcCEl3qK8=;
        b=s9XchpoK2ytjEO2L/T9IzP7td5SGWvtKGTdyI8WfcK4ayPQ3CVyk8BSL7Ta3yeVVmi
         SUxMM0kKoOp/tP5HfJz+Tdv/FscLy9X+Y90pV2/Ni29RX2o1LueMcs/8Jgg5/rRl0esH
         InSCuNubNz6fkJS57yWfSvz8oJQH+8G8kwjNMEtz2rNO5XFJis9Yx6IfdT0OnC8eQFHJ
         04liS8qwl2ahiPS1AF5UG0un28TBefQKru40hiy5REmY3XwEevESKO3eSpEa9xAyy7Tk
         GFQT7HPBmQ1TxQwogS19pNdKqo/LT5HGgpdj1pBXhaviDv23ul9uWmBKSw5d2TYZyQI2
         T5/A==
X-Gm-Message-State: AA+aEWZReIKaxEhG0N9LOXkygaU75XMid4AlUlDcLTe7zJESERxxryqE
        JS5R+dBQQi/JWBfvkvIv9VKFuqh9wsKgqjEAl0sp
X-Google-Smtp-Source: AFSGD/WJWkVvvqZdx1Y01LA1xp1vhqPN94IG1Rc9j+qVxA7pN8/Poiugmm8bdZqJHaZT/6q2G7+zxGeG7BPn5nQ0hbwO
X-Received: by 2002:a62:6989:: with SMTP id e131mr10088395pfc.95.1543951748450;
 Tue, 04 Dec 2018 11:29:08 -0800 (PST)
Date:   Tue,  4 Dec 2018 11:29:04 -0800
In-Reply-To: <20181204015446.GX890086@genre.crustytoothpaste.net>
Message-Id: <20181204192904.40409-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20181204015446.GX890086@genre.crustytoothpaste.net>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: Re: [WIP RFC 2/5] Documentation: add Packfile URIs design doc
From:   Jonathan Tan <jonathantanmy@google.com>
To:     sandals@crustytoothpaste.net
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Some thoughts here:
> 
> First, I'd like to see a section (and a bit in the implementation)
> requiring HTTPS if the original protocol is secure (SSH or HTTPS).
> Allowing the server to downgrade to HTTP, even by accident, would be a
> security problem.
> 
> Second, this feature likely should be opt-in for SSH. One issue I've
> seen repeatedly is that people don't want to use HTTPS to fetch things
> when they're using SSH for Git. Many people in corporate environments
> have proxies that break HTTP for non-browser use cases[0], and using SSH
> is the only way that they can make a functional Git connection.

Good points about SSH support and the client needing to control which
protocols the server will send URIs for. I'll include a line in the
client request in which the client can specify which protocols it is OK
with.

> Third, I think the server needs to be required to both support Range
> headers and never change the content of a URI, so that we can have
> resumable clone implicit in this design. There are some places in the
> world where connections are poor and fetching even the initial packfile
> at once might be a problem. (I've seen such questions on Stack
> Overflow, for example.)

Good points. I'll add these in the next revision.

> Having said that, I think overall this is a good idea and I'm glad to
> see a proposal for it.

Thanks, and thanks for your comments too.

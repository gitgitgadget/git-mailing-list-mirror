Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BF5820248
	for <e@80x24.org>; Thu, 21 Mar 2019 20:24:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728711AbfCUUYk (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 16:24:40 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:36760 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728460AbfCUUYj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 16:24:39 -0400
Received: by mail-qt1-f202.google.com with SMTP id q12so114126qtr.3
        for <git@vger.kernel.org>; Thu, 21 Mar 2019 13:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=vR9e+ofLppWMGbyvcAY7Ws6eOy/KN1hDka1nLjoyzSo=;
        b=YiafVKSC2Nt8elWpSrTD632yWoMcpnM49N7Uxt4iDbXHk4R0Fi9f3p1dJarasVZk8w
         ZCyIHh4Espem6TdBbAo4oFlOkcWyQDjQOK2dCK3hJ4A4g0+L6fpMoYZ9eyf/7HjGcQSc
         jR7xk9wG8/zkQZ3XdDVtpNSEe593kp4J9CWoenoQ4lqmjIpx7PyhTtkxmiu2+wHa/c38
         sZ4REMMlLyz9xSg12DAnbLu2SEqv/Sfpt5WiLwqP9+avpHV0FYTkqmWdpfGh1u19BI77
         mwjKzn19z0Lois+A5ICCt8DtdC6ypjv4tdB2wN0qzppbAi4Ddjpg/hUalM7YUltA94Qz
         DfzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=vR9e+ofLppWMGbyvcAY7Ws6eOy/KN1hDka1nLjoyzSo=;
        b=bNNFjW+0b//f+TqrtgFEM+AvpB4uzUVl65sRd2M0qgivHPj5/xI5kAqqJoZ3fwtGAk
         zxR2EJzQgUnqwVLM+oE6gatdZZivwi0eXOGaP3mrLqiDxnxbSc9TJk9vWLBADL645t6c
         MI6NLR0Oxr/FRHeeCZL8Cn+LhVhkeKpbItRuqC0OvdDT2n2Pr2zJL594TncfiHKNx7Vd
         m3q9JijHISvL1uNaQ2j1kDnvG5abni5ttiF8l51DvlM3cVpm3iEKViljuz6ZwrBa5S4e
         P8G9u84B3PDezU9fAXZAtCoJc1U1pZpRqn2ReN+OojFsT8z81R7unP+QjyRZtCzFWnt8
         sDeQ==
X-Gm-Message-State: APjAAAWCA/xBO0vMXT67Hgzc50Fn7+4zobdfVdbpW75BI06MtJlcvsQl
        GCogedAFVGJIsNKEkThARSf6AgPjgs7VLzmoHVnQ
X-Google-Smtp-Source: APXvYqxMAfI+gPyBgRN+k8wWkBhSKpmpA2E1qq4iAFsNJrgDMSCD/tMYWegkqHX40pVUqwbKPHgpFOxQVraFjg1iqnwB
X-Received: by 2002:ac8:3feb:: with SMTP id v40mr4903314qtk.102.1553199878879;
 Thu, 21 Mar 2019 13:24:38 -0700 (PDT)
Date:   Thu, 21 Mar 2019 13:24:35 -0700
In-Reply-To: <20190321200231.GD19427@sigill.intra.peff.net>
Message-Id: <20190321202435.19140-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20190321200231.GD19427@sigill.intra.peff.net>
X-Mailer: git-send-email 2.21.0.155.ge902e9bcae.dirty
Subject: Re: [RFC PATCH] t5551: delete auth-for-pack-but-not-refs test
From:   Jonathan Tan <jonathantanmy@google.com>
To:     peff@peff.net
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On Thu, Mar 21, 2019 at 03:55:37PM -0400, Jeff King wrote:
> 
> > I am a little confused about v2 here, though. It should hit the initial
> > info/refs endpoint the same as usual. If it's a noop fetch, then it's
> > done. Otherwise, we'd hit the git-upload-pack and expect to require
> > authentication. That should work after your switch to using post_rpc,
> > shouldn't it?
> > 
> > And I guess it does, because you did not delete the test before "clone
> > from auth-only-for-objects repository", which would actually do the
> > second half of that conversation, and require authentication. You're
> > only deleting the part that does the noop fetch.
> > 
> > Puzzled...
> 
> Ah, nevermind. I forgot that v2 really will make two requests for this
> noop case. The initial endpoint hit only returns the capabilities and
> nothing else. And that's inherent in the protocol.

Yes, you're right.

> I'm OK with dropping this test, but I think my reasoning is slightly
> different than what you wrote. The interesting bits are actually
> happening in the test _before_ this one, which are exercising the
> gzipped auth-retry code. And that happens in both protocol v0 and v2.
> 
> The test you're deleting is basically just verifying that our apache
> config is indeed "half-auth". Because in v0, the server is never even
> going to ask for credentials, so no interesting code paths in the client
> are triggered. So it's not actually testing anything of interest.

If both of us want to drop this test, that's great :-) but for
clarification: in addition to verifying that our apache config is
"half-auth", this test also verifies that in a no-op fetch, we don't hit
the path that is guarded by an authentication requirement. This seems
significant to me in light of the link you provided in your prior email
[1].

[1] https://public-inbox.org/git/20190321195536.GC19427@sigill.intra.peff.net/

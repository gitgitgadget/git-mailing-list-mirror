Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87AE1211B3
	for <e@80x24.org>; Thu,  6 Dec 2018 22:54:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbeLFWyf (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Dec 2018 17:54:35 -0500
Received: from mail-it1-f202.google.com ([209.85.166.202]:56269 "EHLO
        mail-it1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbeLFWyf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Dec 2018 17:54:35 -0500
Received: by mail-it1-f202.google.com with SMTP id j3so2532420itf.5
        for <git@vger.kernel.org>; Thu, 06 Dec 2018 14:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=gSnvRGc1k8VcKdlMlvIUzV3g01ATsU9aBWkadDxho9k=;
        b=pghbs28zRODtMtZ4xauLdlpMa8hK5kumtabHkgBuyyr+5vAvXR8b15NnVPrrH3G6mX
         lNqsUVRpWcD2OTEqYzY8OQsVvD/2y4DG24cGIjouL7d31Julptzo1cubSO6Hj0dAdGww
         ht9qsLFeVzzmYs1K3teXj23IzKZgQlY+bbVhBrqP2+x6MwoU7nUP6xrLKbPkE/mlIdqk
         j3yrC+DlgL6yLDMoy8FatcYcEmXltnOXaCRu/jJu8PO9bIzD9gw55JQ1MN/AoVLpWvzA
         hKF7vwnnaHXg/+YvqBoa7YmwrGR5S8ua3aqjHut10PHSKxMn/H19UBnENCzCGPasvBcy
         5ryQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=gSnvRGc1k8VcKdlMlvIUzV3g01ATsU9aBWkadDxho9k=;
        b=Ycvr0HWOQL42jmUAJjWS7wo45lYoZBpJsUTddF17EOy1YQ6+jSz2oC63CP63O1A3Uf
         S7IUSwDTpAbtsbFcl2EwO0lalVc+Khm5VzTPPiUIpSXWO66G3ZvDrJFC3FTn2a2b5yBI
         kOnGdyXbh/eDsGYZmOJRwMWnt1AfJA+127/dxC/c4fhrW7gFTOPRko9OqWYGZ389VYoD
         nB/HE3CP8es72DvDE9aht15elUHREhZxc0qbr9RJlTx3i+nyDKsZAKE4Y7EQKs+wx9rQ
         VK7yMVI2yXpZiq25nkqevLSwl8wuQ0LQG60n79/3sQ7RWVBW8Qgb9V8tNLovn1SwNs/K
         Gk5A==
X-Gm-Message-State: AA+aEWZCs3eVKAHwWk1qTTAt4XbtuaxjFwGH5c135PTOhahEXKqxXDkD
        PMqZZ6/X8VLZSoANqmKRcUUaC2fhtH5A9dXeLaoL
X-Google-Smtp-Source: AFSGD/Uq83bJWVLGruuAO2jWDUhINqv4kAPQAnpEfLSDoBTviCF7BnLWjGfGdD1bm/7EnviAhThLL506cv9+zGVScHkc
X-Received: by 2002:a05:660c:7ca:: with SMTP id e10mr176611itl.16.1544136874257;
 Thu, 06 Dec 2018 14:54:34 -0800 (PST)
Date:   Thu,  6 Dec 2018 14:54:31 -0800
In-Reply-To: <xmqqin08d36k.fsf@gitster-ct.c.googlers.com>
Message-Id: <20181206225431.135449-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqqin08d36k.fsf@gitster-ct.c.googlers.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: Re: [WIP RFC 1/5] Documentation: order protocol v2 sections
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > The git command line expects Git servers to follow a specific order of
> 
> "Command line"?  It sounds like you are talking about the order of
> command line arguments and options, but apparently that is not what
> you are doing.  Is it "The git over-the-wire protocol"?

I meant to say the current Git implementation, as opposed to what is
written in the specification. I'll replace it with "The current C Git
implementation".

> Earlier, we said that shallow-info is not given when packfile is not
> there.  That is captured in the updated EBNF above.  We don't have a
> corresponding removal of a bullet point for wanted-refs section below
> but probably that is because the original did not have corresponding
> bullet point to begin with.

That's because the corresponding bullet point had other information.
Quoted in full below:

> 	* This section is only included if the client has requested a
> 	  ref using a 'want-ref' line and if a packfile section is also
> 	  included in the response.

I could reword it to "If a packfile section is included in the response,
this section is only included if the client has requested a ref using a
'want-ref' line", but I don't think that is significantly clearer.

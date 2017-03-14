Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 764F820373
	for <e@80x24.org>; Tue, 14 Mar 2017 18:17:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750915AbdCNSRN (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Mar 2017 14:17:13 -0400
Received: from mail-pg0-f52.google.com ([74.125.83.52]:33307 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750819AbdCNSRM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Mar 2017 14:17:12 -0400
Received: by mail-pg0-f52.google.com with SMTP id n190so5627023pga.0
        for <git@vger.kernel.org>; Tue, 14 Mar 2017 11:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=gMzcUOJPdxnfeK3N+yTHFF5xPDl9nc3ksgZNWRHdKWc=;
        b=XWbukGvo9SwVg5vyNgpOxrttAMM8y7yiDgyP7Rk3cZ+fX+d0SNxCy6WkSEUseFA2zV
         Dt4ulLAP9MKbXDgZaVO80iXWmMDOZlnIcaeSIwWWZUBjFF+mHlscQ2SwLmoyjG6AIuaG
         2H4jxsOErOZSOg/Ijq7tMNOQ/NjxZQZi0kvopbgPs6o5mCAcijcp4wJf6+rowC8sWojN
         i0QARXqChsviMhLQqv34qI2OJFvK/LOpyY8xS4vteMIacG21/8KVj6Hj4JM9BRVfzBTi
         UmFrOp608Yvu7dxCaU7raCAKsjEQ60CKqb50eaVrhXWrFTvFJXuydifLVQ+fWElY4dpG
         0PYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=gMzcUOJPdxnfeK3N+yTHFF5xPDl9nc3ksgZNWRHdKWc=;
        b=UnrcmmD/p5uIxasTj+t2FatN/0YFudgnUpvI8OoXT8QBYpnmki1xs90w0V/5tRCQkv
         n7hWP+ZA46M6Z3ri4LnQskV053hscONuYrEufZKQfqrFNIdc4Xfusq61y/LQMhj30VrD
         PZ2Of8fU85hWh7HB30gVgQ3z5iUTOkpyFBpdwpJb/eEte/XMV0rjZ1L9RXAbPsS/vd0G
         iu0LSsTrieMcI2f4bOcTcO+cd/Xpk+W9+pewSuAoVyYmPwIWdqIkRyO4VxleTr5gY5t0
         7zEPXMVpYBQpp8DMgHMdalvvcXmDY5GuaE8hDYsz63BAxM4unpV3azJICv4h0HOPshyM
         88fA==
X-Gm-Message-State: AMke39k7td0Plcx7M2xcr+wSpgM23zCLSR0KTFhQFBvZ+PR3Lx03yKnZdp+zIriRontOoHr2
X-Received: by 10.84.229.10 with SMTP id b10mr57665198plk.148.1489515430430;
        Tue, 14 Mar 2017 11:17:10 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([2620:0:1000:5b10:4ccf:4726:3691:3d8a])
        by smtp.gmail.com with ESMTPSA id r89sm39953369pfe.6.2017.03.14.11.17.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Mar 2017 11:17:09 -0700 (PDT)
Subject: Re: What's cooking in git.git (Mar 2017, #05; Mon, 13)
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqq37egn6fs.fsf@gitster.mtv.corp.google.com>
From:   Jonathan Tan <jonathantanmy@google.com>
Message-ID: <660cc8fe-6386-11e5-8827-8acfe6644397@google.com>
Date:   Tue, 14 Mar 2017 11:17:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <xmqq37egn6fs.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/13/2017 03:43 PM, Junio C Hamano wrote:
> * jt/mark-tree-uninteresting-for-uninteresting-commit (2017-02-28) 3 commits
>  - upload-pack: compute blob reachability correctly
>  - revision: exclude trees/blobs given commit
>  - revision: unify {tree,blob}_objects in rev_info
>
>  The revision/object traversal machinery did not mark all tree and
>  blob objects that are contained in an uninteresting commit as
>  uninteresting, because that is quite costly.  Instead, it only
>  marked those that are contained in an uninteresting boundary commit
>  as uninteresting.
>
>  Retracted?

Yes, this is retracted.

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8F7D201A9
	for <e@80x24.org>; Wed, 22 Feb 2017 00:53:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753027AbdBVAwO (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Feb 2017 19:52:14 -0500
Received: from mail-it0-f47.google.com ([209.85.214.47]:34892 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752298AbdBVAwN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2017 19:52:13 -0500
Received: by mail-it0-f47.google.com with SMTP id 203so129550183ith.0
        for <git@vger.kernel.org>; Tue, 21 Feb 2017 16:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rodarmor-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=X75+yCmf2+L8AtGP7+Vk2lVwPqaw+NcFU9fR+9Z1BDI=;
        b=ng/z6IpZ9jZlUzGF6c8Cdzw8LpP5wOf0Xp9LTxPVGET8eSrvAe8mkqjaXOl9JSuiEn
         d7hcvef4NlueBy4qsKYpkTdQ81KAUnr7HnVy0OHNv5osh0Jlu4uLND91k1nvniXtataI
         xi3I0fvOkpH8IdE3rzfIS4p8K+O52RPHmz2pHeKqHGX/SFjrneE3PI9U0P8XKSdYxNJN
         h25y2illPK4nsTgegFvLrkkzktOvARfWIdJ+legh941Uk3Tj6Fi31gtrnS6PqqKv8e/9
         yNGzY74g+k4gOCZCSSwIhIPux44rAzNhTSo7Csr3kIHslY1J8Alv+hnG0zmgAiiPVnxA
         z/Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=X75+yCmf2+L8AtGP7+Vk2lVwPqaw+NcFU9fR+9Z1BDI=;
        b=QzCgCJ6fwbnW65eiHY0cy3lcxmmwh7RLwlLjFLsTSz/nwKdlM1HMrNT/teOlcVbkeV
         z6dLs+4tDjcoQNH7L5JfK3vZ/htcbxme1asUgKVjCpLtPKsxbuCNNhEN2isOiE+e7GMj
         uM0+U1qj1tLcZ6uhAX+u7T8z5XZEEnndkrzWxk1VNCToGF8JHzMsvbzmzh3b4wTa7vM+
         2yIapgToAqn1lzfgrIx+7gEZ2VZiSnt2GITsTqSrp3NrwNdAD3rJsXJeFAH+1t2KQggo
         9PffkVlAw4GQcbSjeC9lWz4TciuGQdPPXawfcBpBdaCzOQd9pFh5PYWbF2TIuTKDR2xA
         84Hw==
X-Gm-Message-State: AMke39m6pwpMGRa0bDQ9GhiUJtGyi+mmWu+MtxaC3l9y5FhKhalQbWxsjcho2A4RW6JonV7CvaNETSsS6J0F+A==
X-Received: by 10.36.192.214 with SMTP id u205mr3751itf.8.1487724732059; Tue,
 21 Feb 2017 16:52:12 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.104.1 with HTTP; Tue, 21 Feb 2017 16:52:11 -0800 (PST)
In-Reply-To: <CANLPe+NVs9sJ7XQqvMabPBLg3DxS2Fyrrg3AzvZPBoWTPpnFzQ@mail.gmail.com>
References: <CANLPe+NVs9sJ7XQqvMabPBLg3DxS2Fyrrg3AzvZPBoWTPpnFzQ@mail.gmail.com>
From:   Casey Rodarmor <casey@rodarmor.com>
Date:   Tue, 21 Feb 2017 16:52:11 -0800
Message-ID: <CANLPe+OaSnNb1jhAnFtMsOCfho0H7mHVHiXs7rqo6ZHNvRe3-w@mail.gmail.com>
Subject: Fwd: Typo in worktree man page
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi there,

The git worktree man page mentions the `--detached` flag in the
section on `add`, but the flag is actually called `--detach`.

Best,
Casey

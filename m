Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81531C433B4
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 23:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57FA6610D0
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 23:39:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235205AbhDIXjU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 19:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235151AbhDIXjT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 19:39:19 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37AF9C061762
        for <git@vger.kernel.org>; Fri,  9 Apr 2021 16:39:06 -0700 (PDT)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cmpwn.com; s=key1;
        t=1618011542;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xqxC0ruTbui7eCmLz2oZ0UXpnxIONH0J6v6oOwPAj0c=;
        b=nzPSph6Tu6Dnr70oOQKtMcaOwAe8xDi0/8F80W0/12GMNhjecQYxmHEOMun/cA5WltsQ4+
        v4OZxe/nKxPoAH2Qkk15X92rxNqEsPeDrjb2QzXDO2tuGDCKxyabZUPIWOg0VFLUIZlFDV
        DWlOLgRf5QU+OhOrkJGuOoSiPPzma5hkfiiJOTRznnBAnCSOgA1c1091IuElG6ID4Yj0IV
        KmYQSoZ8f9NoJW+DnSONgE4t4mNDukJJXUh9yclKL0VUkKP5Q3mVUwLOkW4gB6wobsgnjS
        uxlRLHw5GIT8HGqOETpLBrD8FW54vTV/b9/neIs1JD01gclgn1EJcSDUq3Byvw==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 09 Apr 2021 19:39:00 -0400
Message-Id: <CAJL8038F7T0.8RC0YRP0G9ZQ@taiga>
Cc:     <git@vger.kernel.org>
Subject: Re: [PATCH] send-email: clarify SMTP encryption settings
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Drew DeVault" <sir@cmpwn.com>
To:     "Georgios Kontaxis" <geko1702+firehose@99rst.org>
References: <20210409211812.3869-1-sir@cmpwn.com>
 <07869D2B-1962-4602-915E-78AE931B34C2@99rst.org>
In-Reply-To: <07869D2B-1962-4602-915E-78AE931B34C2@99rst.org>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: sir@cmpwn.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri Apr 9, 2021 at 7:14 PM EDT, Georgios Kontaxis wrote:
> Weird that we fail open (no encryption) on typos.
> Any chance we can fix that in this patch?

That would technically be a breaking change.

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 151621F453
	for <e@80x24.org>; Fri, 21 Sep 2018 16:32:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390687AbeIUWVm (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Sep 2018 18:21:42 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46372 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390065AbeIUWVm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Sep 2018 18:21:42 -0400
Received: by mail-wr1-f66.google.com with SMTP id z3-v6so1620298wrr.13
        for <git@vger.kernel.org>; Fri, 21 Sep 2018 09:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=N4aR4DxbaBxRi4JsZCsM+MCKWUMVctP+cfXw8KhEaOE=;
        b=q6gQj2TzfCc2HCHRGi9ZtPko7ugfhjjH0qyDQoHm2yMAoqgdqIcc97vA5HzV6ZM1N8
         4FywPU2yuUMG9SRSDANnhgc30u1PncMi7qfHl1VV9EJ9tYxusey6fW7ZmVwILzu2tqj0
         O6vrnuXomBwIHxtOAdahohOU75m/JNfzyyzOHZZt5LEWpidTgJBPbO/XjMZSfjakPOkX
         a5inKT5ZfdURYzpT0b3WfRV0s88x5bvq9ceuIzcxUqk8UWJOVpFnKM/7DshWe1P2eSrm
         B3cZeoQ58Ng+8aV/nBoa/pp1sEYaK1c3GB6QL/MzDXYUuHz83RVet14f7Gi/3k8bNTyV
         P4bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=N4aR4DxbaBxRi4JsZCsM+MCKWUMVctP+cfXw8KhEaOE=;
        b=lZpRYtMMuUtGu4dbEtK9K4GfoLrstxPoZab28qGvzmmSbTu86te+Vk+Y04A3dxujIi
         LANunrrZDe25qgovJOewFnqaNqEB7hknqj0auaL1jDKN5hP4ENFwHKfT/bNHGtj0FdCK
         dNocYrUu7RwpuwohhmpsQcUcfVXVCJVwvaYla9hvnyiz3SAsRr/JFXY/0nTNzpjBVfgZ
         BEI5G9q50wHTeszGNjy0WTjn6ULxo/EK+VsJ9iowVukkTIRjnb8cuhsxp+8PCrCLwz2V
         tk3/tpq93nAZxqhPFGKUt/r3NsDnFOkD9agDEbMmv7EZvNL7fPCqxsHl8d7B701ilMyc
         6o6Q==
X-Gm-Message-State: APzg51BVMgPEziGu8OWXBKKEKwGnbciD9o9MY8C8kRXpaYyIO3afnXYu
        vzaKwUvO8JNlD4WVzPbUD1bOHZEE
X-Google-Smtp-Source: ANB0VdaxbFfB7tkI2M/SZ9c4//oSvIpTQzg75yNUMX61OLVDUst8x0N10kGKiSJcKNNYQPrr8IVgwA==
X-Received: by 2002:adf:de85:: with SMTP id w5-v6mr41642215wrl.270.1537547521866;
        Fri, 21 Sep 2018 09:32:01 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id z13sm29017900wrw.19.2018.09.21.09.32.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Sep 2018 09:32:01 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     frederik@ofb.net
Cc:     Duy Nguyen <pclouds@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/3] git-column.1: clarify initial description, provide examples
References: <20180919201231.609-1-frederik@ofb.net>
        <20180919201231.609-3-frederik@ofb.net>
        <xmqqo9ct2ivl.fsf@gitster-ct.c.googlers.com>
        <20180920162302.GB13379@duynguyen.home>
        <20180920174722.GH22921@ofb.net>
Date:   Fri, 21 Sep 2018 09:32:00 -0700
In-Reply-To: <20180920174722.GH22921@ofb.net> (frederik's message of "Thu, 20
        Sep 2018 10:47:22 -0700")
Message-ID: <xmqqsh22x14v.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

frederik@ofb.net writes:

> On Thu, Sep 20, 2018 at 06:23:03PM +0200, Duy Nguyen wrote:
>> On Wed, Sep 19, 2018 at 03:59:58PM -0700, Junio C Hamano wrote:
>> > > @@ -23,7 +26,7 @@ OPTIONS
>> > >  
>> > >  --mode=<mode>::
>> > >  	Specify layout mode. See configuration variable column.ui for option
>> > > -	syntax.
>> > > +	syntax (in git-config(1)).
>> 
>> I think we usually link to other commands with "linkgit", like
>> linkgit:git-config[1]
>> 
>> Other than that, the rest looks good.
>
> Thank you, then do I edit the patch and resubmit as PATCH v2 with the
> message ID and all that?
>
> Frederick

If this is the only change in the whole 3 patches, then I can just
squash in the following to save one round-trip.

 Documentation/git-column.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-column.txt b/Documentation/git-column.txt
index 5bbb51068e..763afabb6d 100644
--- a/Documentation/git-column.txt
+++ b/Documentation/git-column.txt
@@ -26,7 +26,7 @@ OPTIONS
 
 --mode=<mode>::
 	Specify layout mode. See configuration variable column.ui for option
-	syntax (in git-config(1)).
+	syntax in linkgit:git-config[1].
 
 --raw-mode=<n>::
 	Same as --mode but take mode encoded as a number. This is mainly used

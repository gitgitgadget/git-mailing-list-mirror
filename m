Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FBA6200B9
	for <e@80x24.org>; Fri,  4 May 2018 13:32:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751114AbeEDNc2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 May 2018 09:32:28 -0400
Received: from mail-oi0-f41.google.com ([209.85.218.41]:42786 "EHLO
        mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750820AbeEDNc1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 May 2018 09:32:27 -0400
Received: by mail-oi0-f41.google.com with SMTP id t27-v6so19122768oij.9
        for <git@vger.kernel.org>; Fri, 04 May 2018 06:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=XuS1wuSMG8MHgNMx962JwOCpmj8YrUwfQErScqlP4bI=;
        b=O0EofacOVAHFJZr0dNpAQHUTwLCoJ3Eay9nv/2ixcW2HqUeWp4MDe4umVFa7lpBmmT
         Ep4DEGE9zyJG7/4ADnSrjCkbaHzitM37MmtnG9KC/4obtS2/D/3z3LNMJC8Ph+IJTtZP
         SoEYHdv1IRAm9l3eRrmLNo2cejjy1fs+osI2Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=XuS1wuSMG8MHgNMx962JwOCpmj8YrUwfQErScqlP4bI=;
        b=mJNdkZg8wd7IA02xacTSA6IWWc6qdxXDyyZ5v4ZrzyHOBeZ4I9KGt56LkiMavM+Lxm
         m1Fv3LUVuUO2xW/FlKeQx1Dzn3wiwYRHxDlmukEpdQ8GAvf7ZnzuJyxynqeBtApNyiGf
         HUlJOfYlWAmf0rPZQVXVM2qjFDwfogengsTkeCkNdxiT6wlY95McJbiNJPgDYiB/siI8
         FGFY0mF0KOCahJkKUii9n62/4gknIT7iLC49EUbOgSEhY4VxwCain7zAZnQgYtCZlqxZ
         LzmNnTzTvj4DR9VWl6JlAXr/Lms78dv2Jak5aomqn3h00CmLwRaKJncMCOhjR0SvH/V5
         TaTQ==
X-Gm-Message-State: ALQs6tAP4mAgtIFtez6ymS/rpEK0JnsT50Hv4690zV8y7bLWbi5Bhi7r
        Zmc8g3ISe/EYrNEnlFyvHi/RXozrJWa55RrAodePww==
X-Google-Smtp-Source: AB8JxZpi2XMDueCu9gHi6UR4tkb9ZHlaHORGU9SiKarH7bWwxbE2W49RsiTJsmddmBvs/gO4YHQlHp6e+yFL1LHgCIE=
X-Received: by 2002:aca:4ac7:: with SMTP id x190-v6mr15648593oia.11.1525440746880;
 Fri, 04 May 2018 06:32:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:40fb:0:0:0:0:0 with HTTP; Fri, 4 May 2018 06:32:06 -0700 (PDT)
In-Reply-To: <20180504152658.3537707a.cohuck@redhat.com>
References: <1525376963-79623-1-git-send-email-mst@redhat.com>
 <1525376963-79623-61-git-send-email-mst@redhat.com> <20180504091007.55405a6a.cohuck@redhat.com>
 <be79d6dd-beaa-ba6f-2990-b5e91139411b@redhat.com> <20180504152658.3537707a.cohuck@redhat.com>
From:   Peter Maydell <peter.maydell@linaro.org>
Date:   Fri, 4 May 2018 14:32:06 +0100
Message-ID: <CAFEAcA_xZZ5=oa-rA0=qh2-wxrt14KqH38rdg_OVLrqoTfzA9Q@mail.gmail.com>
Subject: Re: cover letter cc's [was: [PATCH 60/67] hw/s390x: add include
 directory headers]
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     Eric Blake <eblake@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        QEMU Developers <qemu-devel@nongnu.org>,
        "Daniel P. Berrange" <berrange@redhat.com>,
        Kevin Wolf <kwolf@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Alexander Graf <agraf@suse.de>,
        qemu-s390x <qemu-s390x@nongnu.org>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4 May 2018 at 14:26, Cornelia Huck <cohuck@redhat.com> wrote:
> On Fri, 4 May 2018 08:07:53 -0500
> Eric Blake <eblake@redhat.com> wrote:
>> On the other hand, cc'ing all recipients for a largely mechanical patch
>> series that was split into 67 parts, in part because it touches so many
>> different maintainers' areas, may make the cover letter have so many
>> recipients that various mail gateways start rejecting it as potential spam.
>
> Yes, large cross-subsystem patch series make this painful.

My solution is to either (a) avoid them or (b) not bother cc'ing
people (except people I think might be interested in reviewing
cross-subsystem patchsets like Eric ;-))...

thanks
-- PMM

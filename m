Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C10D52018B
	for <e@80x24.org>; Tue, 19 Jul 2016 04:49:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752110AbcGSEth (ORCPT <rfc822;e@80x24.org>);
	Tue, 19 Jul 2016 00:49:37 -0400
Received: from mail-vk0-f44.google.com ([209.85.213.44]:35710 "EHLO
	mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752459AbcGSEtf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2016 00:49:35 -0400
Received: by mail-vk0-f44.google.com with SMTP id w127so9322038vkh.2
        for <git@vger.kernel.org>; Mon, 18 Jul 2016 21:49:35 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=YVFcW0jIXKjvRkzC4oH9hSY6uajWEAHNpWNeoEDnK0g=;
        b=U12Fgx95tNH7rQx0C2rDa7fkmUU9rM+P2NuiewvLE5QZJcsj2LOxl+PBxhjf/BoiCB
         q9TZxK0WrPawMqBr6NAN9F6E8OCS61jVJcaxnnMjf4figA4f7t9JbThVUnH7TkmvWCP4
         V5KSW7zwCXFqjizQlSPKBurh0ZV4rds0y4DCw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=YVFcW0jIXKjvRkzC4oH9hSY6uajWEAHNpWNeoEDnK0g=;
        b=kEuj8JVZR9gxVE3JBaYe6oGn6UsaIdF1V6i5Sb8n+CO+y5cFHERJ1eZAub67ngTUTq
         qixnUvKjbRdo5osVKth2f9afkiX+EOiR3dW+uAJ0f3ra9OyAlaLb6DMnKFeQwId2TrAT
         C387uWC8AiUAqhK4EMA9jVaLIOwhQvu5QKDXoVlZaDQYC8ZKuzovX2RSRsfUkyF9F5XX
         5tWqXaaAKEu//xdgaq2C7GLR9ltxDfr3IlCNoPPWOd2TuI4uDRG/W8ZHPLDlSFdHa03W
         nyO1CET6+acCJ/ABlaz5mN3OdFgG/PkST4RI6SBQWhYTBJemDNIbTVJMjxH2RBxqK3rg
         vhSQ==
X-Gm-Message-State: ALyK8tJG+NGpSVUd86sA8fTqoMeVMAKox0G68aMUU9YLpUfZPtS6jSGNWiWUyddjlucD8F7eA/uA7ELwCm6gZw==
X-Received: by 10.31.8.83 with SMTP id 80mr20139433vki.93.1468903774819; Mon,
 18 Jul 2016 21:49:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.49.207 with HTTP; Mon, 18 Jul 2016 21:49:15 -0700 (PDT)
In-Reply-To: <CAOiOGAfysmjBxcK-VwscLWBdun4rNsRs85p=foBxETvQw0J1Jw@mail.gmail.com>
References: <CAOiOGAcqsdMD0j_ZUdvvGiA9Bd6bUmfvxziN06Rw81f_pO7cgg@mail.gmail.com>
 <20160716051800.GA2845@sigill.intra.peff.net> <xmqqfur6isyr.fsf@gitster.mtv.corp.google.com>
 <CAOiOGAfysmjBxcK-VwscLWBdun4rNsRs85p=foBxETvQw0J1Jw@mail.gmail.com>
From:	Shawn Pearce <spearce@spearce.org>
Date:	Mon, 18 Jul 2016 21:49:15 -0700
Message-ID: <CAJo=hJviMd3tWe_HUmh0M0Y2TOCwwrZX14hdyivPSYQ1ck052w@mail.gmail.com>
Subject: Re: [PATCH] contrib/persistent-https: update ldflags syntax for Go 1.7+
To:	Parker Moore <parkrmoore@gmail.com>
Cc:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git <git@vger.kernel.org>, Colby Ranger <cranger@google.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Jul 18, 2016 at 9:32 PM, Parker Moore <parkrmoore@gmail.com> wrote:
>> The label does not even identify the version of the source in any way, so I am not sure how people are depending on that feature anyway ;-)
>
> Would it be a better solution simply to remove this build flag?
> Alternatively, if Git wished to support Go v1.5 and below, I would be
> more than happy to send a patch with a dynamic lookup in the Makefile
> based on the output of `go version`. I would be more than happy to
> submit either patch.

I think we could remove that BUILD_LABEL entirely. Colby liked having
a marker so he knows what "version" a user is running, but without any
correlation to source here it just isn't that useful.

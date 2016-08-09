Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23D702018E
	for <e@80x24.org>; Tue,  9 Aug 2016 04:22:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752209AbcHIEWx (ORCPT <rfc822;e@80x24.org>);
	Tue, 9 Aug 2016 00:22:53 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:34961 "EHLO
	mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752171AbcHIEWw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2016 00:22:52 -0400
Received: by mail-io0-f195.google.com with SMTP id q83so100522iod.2
        for <git@vger.kernel.org>; Mon, 08 Aug 2016 21:22:52 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=1GV4pImchvx80eHwgcGUIN10KR78kvRrJDtfXw2BApg=;
        b=gHSaX6+6zsj2ILHgYSBEp2LW4gRkYHgl8cTNsFqL5O3sxJ6zGxfsW7KWdh7ldfP2fq
         rCGXFnp+ws28YSRFKyL0dZzGQ040FRJhkglPI89SmIOIhvPlU7oCHOrATborPOYibj8l
         Ho94iUdkQyiexyISCfznd/dJjvF2ADKYZULmWZxkJf1xYNvDLj+8Ko30uVaZpP5oGOSk
         7xs4+ZGYdC2e+oSiUxDGcMGjcU9EeTc524C8ciq8Zm9XpWKlJeP8DzZei+4szdjInXDh
         LjWsYcYxYneeUL9Ir9weYvNJRirlb6InFQtepHOlpdKA2VduSouJqm8ioxFL+mmEQfTa
         RbdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=1GV4pImchvx80eHwgcGUIN10KR78kvRrJDtfXw2BApg=;
        b=T5KpIGD6QOuRlG7YLK5ky2KcGwWKuljCkREK4PoVrba1ijaJPfwFVNX3QE2W8XZ7k8
         URBlqwOIkC1jLA0XX5sZEhk0ZIT5bJTdxqlOLVDjwnyUfBHBu0NpC6Gk2y/PPT6bPOwt
         JYlg7c4UxdvS5e5y1LKYpHM+f/SIeIl6JDPazvavVu5hOKbTauBsKiIAIwbu754d4x1j
         S7r7VC2otCqZ7V4xWAyDXK8YBFpSxmLfY08Lsbh8FI68NkdNMncjkCLTmzjIJLmuHX5X
         mrnnghi6U+F4RgnqiCwLgB8Iyg3nQFZJHnEFSqZm0qe+g8rSu9MbSzuPl4XQzRx6FL6p
         kHag==
X-Gm-Message-State: AEkoouuGKS71U/yshHyGUJUbIjPYso7vFXMVES0bvxf3MKp7de/oTynl1m6GkLKTLyCjosQsvYdq02T0gFK1Rg==
X-Received: by 10.107.2.78 with SMTP id 75mr96976758ioc.128.1470716571710;
 Mon, 08 Aug 2016 21:22:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.125.199 with HTTP; Mon, 8 Aug 2016 21:22:21 -0700 (PDT)
In-Reply-To: <6c937f79-2b82-619d-51fe-adccbe09bd66@alum.mit.edu>
References: <cover.1469547160.git.johannes.schindelin@gmx.de>
 <cover.1470051326.git.johannes.schindelin@gmx.de> <8ff71aba37be979f05abf88f467ec932aa522bdd.1470051326.git.johannes.schindelin@gmx.de>
 <xmqqlh0gjpr6.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1608021004080.79248@virtualbox>
 <xmqqy44ec15p.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1608031021050.79248@virtualbox>
 <CAPc5daXJzMsJf5K84XBFuQ5=q_OwtYUW2FikZ2QsZWk8fa9jgg@mail.gmail.com>
 <alpine.DEB.2.20.1608031753431.107993@virtualbox> <CAGZ79kYWdZCNW_eBi5aLAacyBZJXQ9xyOWMBmjNsYT5NWjr-Og@mail.gmail.com>
 <alpine.DEB.2.20.1608041730130.5786@virtualbox> <6c937f79-2b82-619d-51fe-adccbe09bd66@alum.mit.edu>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Tue, 9 Aug 2016 06:22:21 +0200
Message-ID: <CACsJy8DeSv_ALHR+HrViEptgYCYhXu2ZczMmhzZfHGAwZumnzg@mail.gmail.com>
Subject: Re: patch submission process, was Re: [PATCH v6 06/16]
 merge_recursive: abort properly upon errors
To:	Michael Haggerty <mhagger@alum.mit.edu>
Cc:	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
	Richard Ipsum <richard.ipsum@codethink.co.uk>,
	Eric Wong <e@80x24.org>, Josh Triplett <josh@joshtriplett.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	Philip Oakley <philipoakley@iee.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Aug 9, 2016 at 12:20 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On 08/04/2016 05:58 PM, Johannes Schindelin wrote:
>> [...]
>> Even requiring every contributor to register with GitHub would be too much
>> of a limitation, I would wager.
>> [...]
>
> Is it *really* so insane to consider moving collaboration on the Git
> project to GitHub or some other similar platform?

In the very unlikely event that github is shut down, how do we get all
review comments out of it, assuming that we will use pull requests for
review?
-- 
Duy

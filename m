Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B33D2070C
	for <e@80x24.org>; Wed,  6 Jul 2016 15:34:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755253AbcGFPe0 (ORCPT <rfc822;e@80x24.org>);
	Wed, 6 Jul 2016 11:34:26 -0400
Received: from mail-io0-f181.google.com ([209.85.223.181]:32871 "EHLO
	mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754922AbcGFPeZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2016 11:34:25 -0400
Received: by mail-io0-f181.google.com with SMTP id t74so203145418ioi.0
        for <git@vger.kernel.org>; Wed, 06 Jul 2016 08:34:25 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=tdwzEsnaFLper5q1EfYJ/MFMW+AUhy+3S2P+DdQW/HU=;
        b=MYCV1Fxg+64foFN2LrrNb2j+/CC6V36yzJe5EMSwNINvvYxKZgAaY/CuYgJjqzyQq0
         8hZdlHw73VGL+aGbUlVCo7zfr8aYfLWgrnm8VXiMh1S//6Y648ZNFt8VBOAcVqIKo4mt
         a4IGhw5nUW3zn9ldsCIuuTQqDta16M61t/MkwhYb0uFWWiF9mcoF2wBAPIQxWNDZtlme
         YnPu9FRp9/+kCMyQfx6cw3r65IW29TWmNqhs1+juo5UfWn4bxQb/8FdfdDF7ONLmZ/ne
         v3IJvl8gB1KnvV8PNdXr+I6IznGdonn3o5ORnJ7k6xFLwQ5PvxAlf2bcZqVzWmwmqD3L
         zs5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=tdwzEsnaFLper5q1EfYJ/MFMW+AUhy+3S2P+DdQW/HU=;
        b=bml4W7Pd1bvBgIb6oZR/82QcdjJca0k48jwKfQUpSC/0B5kRDHKXqkpetIJx6LVeKE
         GtV7bgactjHLXUnk91AaPhVXtRWfGZWFQOT29liEzqn3Wg8MolZxZyHyIk7RQUCL627h
         OwhvaJt9MKcDMYwzX7uswQlOGQsWfx92WFVeEr9auo/AQzNTYV3kjIwktBc8VrWNYL9N
         /yC/J0MJHbEjSHD6sV4eHx/SLERNdTDPeZ0wv1EA7AV7RxQ8Zf9kw9SlB2cbPJxnKd8J
         zYRX5e9/x08m0HSBEXKzNldB2Ig5VHupdb7toS637nZqB3QdHlNIiV+SuoU4o5nLFr/g
         NK4A==
X-Gm-Message-State: ALyK8tKwQ3D6oe3r87fNNY8C1RRKCw0BoF+NmFR3HPObwGDVIZDmGLbUsLaEfTI6D1vZgW96bcIDUuuvB7c3bA==
X-Received: by 10.107.22.6 with SMTP id 6mr19209706iow.128.1467819259934; Wed,
 06 Jul 2016 08:34:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Wed, 6 Jul 2016 08:33:50 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1607061016330.6426@virtualbox>
References: <1467532693-20017-1-git-send-email-novalis@novalis.org>
 <1467532693-20017-16-git-send-email-novalis@novalis.org> <alpine.DEB.2.20.1607061016330.6426@virtualbox>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Wed, 6 Jul 2016 17:33:50 +0200
Message-ID: <CACsJy8APq+Wz0TDqRdo-MstRKt-ezROB4FhiN3d4UV6qNWrrKA@mail.gmail.com>
Subject: Re: [PATCH v14 15/21] index-helper: kill mode
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	David Turner <novalis@novalis.org>,
	Git Mailing List <git@vger.kernel.org>, kmaggg@gmail.com,
	David Turner <dturner@twopensource.com>,
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Jul 6, 2016 at 10:20 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> BTW I am in the middle of trying to abstract out a "simple server" that
> will allow me to back the inter-process communication by a pure Windows
> solution (named pipes) instead of the Unix sockets. It turns out to be
> much more difficult than I hoped: the code is really relying on Unix
> sockets currently.

Code can change :) Once we have a base line what works on both *nix
and Windows, I think we can adjust code logic so that it works on
both. Let me know when the code is ready (or even not ready, just
publicly available).
-- 
Duy

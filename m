Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A2722021E
	for <e@80x24.org>; Tue, 15 Nov 2016 17:57:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752823AbcKOR5B (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Nov 2016 12:57:01 -0500
Received: from mail-ua0-f169.google.com ([209.85.217.169]:33452 "EHLO
        mail-ua0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750998AbcKOR5A (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2016 12:57:00 -0500
Received: by mail-ua0-f169.google.com with SMTP id 20so94072151uak.0
        for <git@vger.kernel.org>; Tue, 15 Nov 2016 09:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=QVJr6msNimx/ktcGxu6dyT5is3JhbIrN1dAm9qSFCBY=;
        b=K1Q8N9cXolWP4Fc5DQkJRHL24WKEsTiTGzhM2zr3hib+IS/J5v5nAT2Nvp6dYxexn1
         9dfhpB7vax1uZ/E585nj6bODDoNeG6bU4t+msxvAOfWoHQgemamF9T47asFAJbLA1arr
         sT9RTFpnhyqO1XkTPKRpM9JJ5QhSsNbxDswOAfxb02S/P4/uKmyV4bmJpIsse3IWPuL5
         0AFTW4DPS0G2qMwsIoLOTnS2vzBqXoUInVhNPkPFVbFf7oC6oqWiic/i7fUCFqbDDVqV
         +HeZEU48Rd86LuIzuB0Ih888PEZzmmmwuqHM0gM30pZ2lQmQjHwMvobFny2FBRdSvH/X
         fjIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=QVJr6msNimx/ktcGxu6dyT5is3JhbIrN1dAm9qSFCBY=;
        b=E4F85nvluQKmNMlj3x44FB7RqIBBhqgeU9GZG5VkpelnlBBMXWgk09maZYv494ZwqE
         BI3N6o+emjL8dBwiYLUh/tlcRkga+ZtVrZoMy8FkvQXfTPh8A7mV3E5qqX0mS+F2lEOc
         q37Yh2mL9CZDR6lLsgX7U+2D/pgMSWvifhAmggqHXs7sFrHvYcNs5oUObJr10Z4oHzZV
         fcwOmZUmyDRAemL/zedlyggiilOWRa3XXSGlOK/P1qwEDvc1P9zakk6h8Nmvc0SM5/SX
         g9ZZeLzoGbAOGGEvcqO1Os72lzr7etxYwcWeokphRbcXkW7NVy6afz9RmoOIoxpLFL2Y
         Dn/g==
X-Gm-Message-State: ABUngvcA9do0scxsXuThe1bxiJsOQbFdeK+C8VWhm5IhpgHqCal4QlvSwRMgTIlTkhIC7U2gG8Bg7hTTaOCT3w==
X-Received: by 10.159.40.101 with SMTP id c92mr14013447uac.111.1479232619059;
 Tue, 15 Nov 2016 09:56:59 -0800 (PST)
MIME-Version: 1.0
Received: by 10.103.24.69 with HTTP; Tue, 15 Nov 2016 09:56:58 -0800 (PST)
In-Reply-To: <CALj-rGcSrbAiyxPOYD1KCacK_gqi3T5_R=e0H_UfBTqLb5VRmg@mail.gmail.com>
References: <CALj-rGcSrbAiyxPOYD1KCacK_gqi3T5_R=e0H_UfBTqLb5VRmg@mail.gmail.com>
From:   John Rood <mr.john.rood@gmail.com>
Date:   Tue, 15 Nov 2016 11:56:58 -0600
Message-ID: <CALj-rGdRDa0EU6AeMHWYketr5QBOnV7-3RKraiuPCk=Aepz=pQ@mail.gmail.com>
Subject: Re: ignore blank line removals
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Is there any push-back on this, or is there a backlog that we can add
this feature to?

On Thu, Nov 3, 2016 at 10:57 AM, John Rood <mr.john.rood@gmail.com> wrote:
> If the contents of a file initially are:
>   one
>
>   three
> and on branch A there is a commit, removing the blank line:
>   one
>   three
> and on branch B there is a commit, adding 'two':
>   one
>   two
>   three
> Normally, if you try to merge A into B (or B into A), git recognizes a
> decision needs to be made between removing the second line or add
> "two" to the second line. It would be convenient to have a merge
> strategy that defaults to the latter in cases where the removed line
> was a blank line (or a line containing only whitespace) ...something
> like -Xignore-blank-line-removals.

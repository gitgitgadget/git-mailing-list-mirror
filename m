Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 190B11F424
	for <e@80x24.org>; Fri, 27 Apr 2018 17:36:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758989AbeD0Rgn (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Apr 2018 13:36:43 -0400
Received: from mail-qk0-f173.google.com ([209.85.220.173]:40990 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758986AbeD0Rgk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Apr 2018 13:36:40 -0400
Received: by mail-qk0-f173.google.com with SMTP id d125so2007038qkb.8
        for <git@vger.kernel.org>; Fri, 27 Apr 2018 10:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=pD4i3f6nkNyGHMvFi9DP/GeBaChuo+u+7cdZIqWn9GI=;
        b=IwyGPTDXDhcHVbdbYzqNvqZzaUkV1GFKjMgifN1NSONhdLc+XIf5YjK0Xrl5rEfHII
         5mkXL85pduO8v6ucOR7VfSnHSVJNFjq+z9OWRXKHAEtSSTty7yjUwnXVkfrGFTK5jkqQ
         a1YmCYq71ULNSON7n2FRBv3yf/TOS5vaUfdU7k9kZDse62mZtln0au+tFXBoFIUNmAio
         vhZ2uz2nHb/MXPJQE+T2o7rdEry2UOiqvmnBmGY8XV4EIUh43Aq7ry8H1k0dYkcMGZ4y
         ccH0Sa+crlcAbaSMoVFQ4G1RPt50bPNn+hVsqzn90HYDT3EFoIjWjH9qfdTor0WTFde1
         H20Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=pD4i3f6nkNyGHMvFi9DP/GeBaChuo+u+7cdZIqWn9GI=;
        b=fPlJi5Ztwupg12Wi1Op4oA74Uh5TnDdzpl/VewlwJzkMnGMb8v6kD0HilCgFK86x7+
         L8dpDyJm7r8uDhKLbBKsfKRB26ljFxSpYNbOdpC5lYCxiR4NUPEzpB3QfYVUu4TlrCIy
         1M58+IwKWcveRv0kc/hwbrecnvKwADdKuiV/wBaLwSWfZlRdM36ubGJmyDeRScUghF9F
         P6stWuxYAZz8zwgiVXf0mAb4OGDFzv1CyLOQ4g3KRYkWi05kpQRBHkWMToSfmqtbKRzN
         pytToU62p+q++Fa9FqcjSDMvGR/yJwuIpnPozaU9rs2aa7KIloop/PuE9SerkpvjD3QC
         c36Q==
X-Gm-Message-State: ALQs6tAnNnpvT4zt9YImJwNhy2ggyT6j1grYKqJXgSaxOBIfqgxyQg/x
        cglQSu4AmVoE/GwH3/J884Qu9+0fYl5YlIJ+SOo=
X-Google-Smtp-Source: AB8JxZp5iOkEGPB4OORN66+fxEQ4tHJYAfFbVwGZ+0iIOGduio0gAwgY3Ggju54iCMy/4DbCGg1gLXJInaNniDF68ZU=
X-Received: by 10.55.190.134 with SMTP id o128mr2624143qkf.141.1524850599007;
 Fri, 27 Apr 2018 10:36:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.170.75 with HTTP; Fri, 27 Apr 2018 10:36:38 -0700 (PDT)
In-Reply-To: <20180427170440.30418-7-asheiduk@gmail.com>
References: <20180410183224.10780-1-asheiduk@gmail.com> <20180427170440.30418-1-asheiduk@gmail.com>
 <20180427170440.30418-7-asheiduk@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 27 Apr 2018 13:36:38 -0400
X-Google-Sender-Auth: ZvDBGp_O5-Wp6ajQB4lcR2G5PqU
Message-ID: <CAPig+cRWn66C6wcmYv5G3qjfZAux6pVCp1H+w9c4+CzevfXMRg@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] doc: add note about shell quoting to revision.txt
To:     Andreas Heiduk <asheiduk@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 27, 2018 at 1:04 PM, Andreas Heiduk <asheiduk@gmail.com> wrote:
> Signed-off-by: Andreas Heiduk <asheiduk@gmail.com>
> Reviewed-by: Junio C Hamano <gitster@pobox.com>
> ---
> diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
> @@ -186,6 +190,8 @@ existing tag object.
> +  Depending on the given text the shell's word splitting rules might
> +  require additional quoting.

s/text/&,/

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1CD481F404
	for <e@80x24.org>; Mon, 27 Aug 2018 15:53:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbeH0TkV (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Aug 2018 15:40:21 -0400
Received: from mail-io0-f177.google.com ([209.85.223.177]:46235 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbeH0TkV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Aug 2018 15:40:21 -0400
Received: by mail-io0-f177.google.com with SMTP id y12-v6so13180754ioj.13
        for <git@vger.kernel.org>; Mon, 27 Aug 2018 08:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5o52nTwie+JVZjI8c4tzIb26o7ZWSRmDsXwnaCR2iLg=;
        b=JVk/8KhhMPlkCduKviILXK2eE7w6ETptBQ6GWa4Nl67328VKGaWzQRyMohLFQPGPj9
         TaUvYNZRsozzoEVRa7YZcW1qzvGaCCNhcRZB+moOXpeCGafkQgoZ656+SsQGR9O1KvZR
         PNrfn450gxemTAa0NWnigniA3yl464Fy7+uo+qVanzOpzi8LNTfg0fHfpMoQ27QNk/ve
         I63b6ttLBMmSq3UchV5fW3NM4EADhYeunDK02gwHvrLhGxa1nAiku8JrdT7+fwOGcn0y
         QoTkBsHzFZQjlFdtvGe3Oc5yDmTuMmH7HAQbYmMYxzbcgvvyU/A4k/Q80PzGunD3sIOz
         LkYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5o52nTwie+JVZjI8c4tzIb26o7ZWSRmDsXwnaCR2iLg=;
        b=B071QXpvOLHLn1n9hRDfvjlZZCqpZzVozTNp4LRDfoqDJ1ju9DoZODa4KZcrXvjsLi
         FuXSQVHz4bSIQ5/GpHMop5kkIpijIjhvVBSte4yffEl7Wgg/lrO2ytBBLMch6C+l9wxk
         Tn5uMXNR1P32AP3Z3gmlOtKRi8Ls09v4FruP7G0N1DU+LxrLODubUtU6k55Ip+zQp9l3
         XJttR/QHddG41e+rd0RPKpkS/LUOnSUsLDkjNJ34OuKo5CDpcT6W0vG3zUorforpp4/O
         yDQ6fbEyZmlEQxmWnhO0YFJMz6wmDHPJOq7mX+Fe3GZQLT4LGWK5/lTLpSODBg9xNO+K
         p7sg==
X-Gm-Message-State: APzg51CB8AxkjyIE6WlkPBCp91oOZ5XTragAoFmDj8iqqEkD0SYHU0JG
        2JT4b88aCp8xcsy/lu5cLGQRj1agBl+9C1ACKPo=
X-Google-Smtp-Source: ANB0VdZnppE5eNHlQpIEM0jOz5N8EUTpCn2tXLuinBsBifk9x03hbf/T5VNfNYsrR3mAEEVYCBpmU9AffW0frkRy5sA=
X-Received: by 2002:a6b:9885:: with SMTP id a127-v6mr2393860ioe.282.1535385190987;
 Mon, 27 Aug 2018 08:53:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAHd499APYCH2r2=+M_AGKUzN0GDmrwDty4wK=Xy-utCdMrd56w@mail.gmail.com>
 <20180827153524.GA18025@tor.lan>
In-Reply-To: <20180827153524.GA18025@tor.lan>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 27 Aug 2018 17:52:44 +0200
Message-ID: <CACsJy8Bik2Hokgv46ifsFhhvGzdcB=FoWnWs6_k2361s15wOPA@mail.gmail.com>
Subject: Re: Automatic core.autocrlf?
To:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Robert Dailey <rcdailey.lists@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 27, 2018 at 5:37 PM Torsten B=C3=B6gershausen <tboegi@web.de> w=
rote:
> > In those cases, when it falls back to
> > configuration for line ending management, I want it to be
> > automatically configured based on the host platform.
>
> There is
> git config core.eol native

An alternative is supporting conditional config includes based on
platform or host name, but I don't know if there are more use cases
like this to justify it.
--=20
Duy

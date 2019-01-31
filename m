Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61CC61F453
	for <e@80x24.org>; Thu, 31 Jan 2019 07:29:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731367AbfAaH3k (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Jan 2019 02:29:40 -0500
Received: from mail-it1-f181.google.com ([209.85.166.181]:55012 "EHLO
        mail-it1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727308AbfAaH3j (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Jan 2019 02:29:39 -0500
Received: by mail-it1-f181.google.com with SMTP id i145so2327924ita.4
        for <git@vger.kernel.org>; Wed, 30 Jan 2019 23:29:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=KC0oi9ecdWFa+OFZSb1/uVQ9w8oK4iogF/Cb6LqKPxU=;
        b=TwM75CCnevRLTaEjbsCRSdYkmequj4rpDbiG5e/bT7DZA5GCAM6/8H8wTOk/CWH9aT
         OZrBrPCnTB+g/QTRiho4nyUi7xPoiZj+tSZ+ituM0p3WwkZNBhb2eJeCip2hcKKhrieg
         bEu4ypJMIOPY/bljh+PyLXQpgz+iPHk+iNVE/fOCrqpoWBFK56rHM40R+rgvpSLcCdtl
         dGqGU6exQJWMexUKnKkt4TZek/iGmAFsNTzX2gdtrXrMqDoEBqy79MA0mkgRu+3Uee/3
         FEt1gikze6eC3PPvv/fMqjyroXlcBsojujAT7nJXOroupUsXfXOGcdqVdKX0VtqrJG6E
         Pf+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=KC0oi9ecdWFa+OFZSb1/uVQ9w8oK4iogF/Cb6LqKPxU=;
        b=G3nADwc2yGI0tvFkfyXONWiocDD9dOdioRxLtHUk8MGdrQr7Dhk2ti5N9ZuClwfgj5
         BVFFnTW8ZO9XQMgFOHm8bNZxde79QoEVn2TcC5uUGXF4sL5GDqjkdY3NiVBru7ZQVbEC
         Fo3CY//HPSFylLw9iNOVm8SHkmCQ07exeRAjwOOu7C2Yvnq0inxlMn5nyuS/QiTFPD2U
         ZhxozxGyMmwM7SIcFIEzP8JGmEH3zjnESQJByJ+0NmU3vAWsUELXPyiE4xZUGx2PLoUV
         /ZYP7nC/aXt0EmZLhaiVYvLvVUoK/j5ok7hVXYhri0h4B4YUecSpZW7140OdfW55XU1G
         Yy9Q==
X-Gm-Message-State: AJcUukepxToMi9p3xVgi/5cKEuZRsp4g0kweUZuzykYJECT/2TNm12zG
        SPX42x9/ysjVzEsJsGFl5UM+5jJ6IoueTt/nuerlxw==
X-Google-Smtp-Source: ALg8bN4pVgHQBayyCrwZooRPr7prHL2h8X25MGc0GG6bcxNg5TbgGERzuUU4tMgroFWw7EyuxHyDBTx4y6QzebgYHaA=
X-Received: by 2002:a24:c456:: with SMTP id v83mr16707416itf.44.1548919778832;
 Wed, 30 Jan 2019 23:29:38 -0800 (PST)
MIME-Version: 1.0
References: <CAHYHVP+ty7i7a_abT-th_HR2X-8X6mLmpHPR_3VXv5LpWUsrhQ@mail.gmail.com>
In-Reply-To: <CAHYHVP+ty7i7a_abT-th_HR2X-8X6mLmpHPR_3VXv5LpWUsrhQ@mail.gmail.com>
From:   Angelo Melonas <angelomelonas@gmail.com>
Date:   Thu, 31 Jan 2019 09:29:28 +0200
Message-ID: <CAHYHVP+Dvbq_aOMy1_Kq0LHJsd4r+4GiP3N3R4A9ouAoJ4gw9g@mail.gmail.com>
Subject: Re: Possible minor bug in Git
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Just to clarify, I made a mistake above. Instead of "untracked", I
meant "unstaged".
I apologise for the confusion.

On Thu, Jan 31, 2019 at 9:01 AM Angelo Melonas <angelomelonas@gmail.com> wrote:
>
> Good day,
>
> I found a potential bug in Git for Windows. The bug can be reproduced
> as follows:
>
> 1. Modify a file so that it shows up as "untracked" when executing the
> "git status" command.
> 2. Attempt to "git add" the file, but change the case of a single
> letter. The command executes but no warning or error is displayed.
> 3. Execute "git status" again and it still shows the file as "untracked".
>
> Please let me know if I am mistaken. I also have a screenshot
> demonstrating the "bug" which I cannot attach to this email, but which
> can be requested.
>
> Have a great day.
>
> Kind regards,
> Angelo Melonas

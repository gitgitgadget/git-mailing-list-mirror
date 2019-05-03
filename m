Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8672C1F453
	for <e@80x24.org>; Fri,  3 May 2019 08:13:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbfECIN6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 May 2019 04:13:58 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:56102 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfECIN5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 May 2019 04:13:57 -0400
Received: by mail-it1-f195.google.com with SMTP id i131so7786677itf.5
        for <git@vger.kernel.org>; Fri, 03 May 2019 01:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=p0Kb4kKrTQyCDW/wNKz3utWoImc6jluWnyOQrSFVDeg=;
        b=blG/kkkVszz7+twqou2AN4suZy9yKSx0GMfXJ1xG86rm0heQikswY70pqLPQ5OXaHa
         Cd8dQtdS+GdLzmKK0jd88/OHKA5U3GKDzytCBXCgCuFg0zbkxtul9XNfhc3DH0RqxMrT
         R9L8pUh+cMzIbgMGyQSMiW+5RK5ZVoa9UuRO1q5qTbCG4WsczHcBfC8FrugOKzumxKyp
         OXbhfOv0A7usq/u5QQf3SOYIQEkJRSFzW/fcPa+XjO4wJMuQlZIsnSEQrLQkHdoT3738
         /hzcBm8WblzTtqfbhrahIGzbZQmkUFhAy/n00D4cN0vK0jPpWdelh1LAeM5sZQuOh27k
         Debw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=p0Kb4kKrTQyCDW/wNKz3utWoImc6jluWnyOQrSFVDeg=;
        b=mxVNZcM5g7kVz+YkM11ItMPXXCWyDcJXR8/tGRaqayI1f1gtumGuDy7CO8YHlNXH9w
         zBhYMDTWSsrJbO3h8kdAorruRLbTJVaq6so+PVeAsXdQ9/GcAZPLTMzKwCfjLR+66ARs
         Y9EDEDLcqyyb4bFIljfRWUn+ql0VSHf2gSVfnQINRr+N9PWlPNfy3O9BqWL+ZAFIKHQZ
         mqzq8AhfHh14JFYh+25/sX+dfEQetYe4T1SE27OvJvF83hFKjzuD9tYSc7BWpuc5WrCk
         nN+oiN0okXzPacr/ymottNkpx9GIUNtkIEkPSuo9Yz+wkMweuDAVha/D7EpbfedHZp2f
         P83A==
X-Gm-Message-State: APjAAAX2OJozcC4UwNwsHXSlDDgYAYJD1EBotGWlN8Z3SFwnCVfoWQyu
        /FcckL2f93Ut2oGBE17Rv78=
X-Google-Smtp-Source: APXvYqxaoGSvY9trQ/3opGtnDJFVVLEkWDlIjCec2oexU6LwcdcjkvvSCAGfGMTSG4Bavgphccsvjg==
X-Received: by 2002:a24:9b8b:: with SMTP id o133mr2101068itd.140.1556871236969;
        Fri, 03 May 2019 01:13:56 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.89.95])
        by smtp.gmail.com with ESMTPSA id 19sm746221itm.6.2019.05.03.01.13.55
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 03 May 2019 01:13:55 -0700 (PDT)
Date:   Fri, 3 May 2019 04:13:54 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Andreas Heiduk <asheiduk@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/3] cleanup revisions.txt
Message-ID: <20190503081354.GA23442@archbookpro.localdomain>
References: <18c8ed70602271a28c93df922eb3da8fb7563e2e.1555913472.git.liu.denton@gmail.com>
 <cover.1556367012.git.liu.denton@gmail.com>
 <7e9ab65d-aee9-b900-c294-8810e0109721@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e9ab65d-aee9-b900-c294-8810e0109721@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Andreas,

Thanks for the earlier corrections on 2/3.

On Fri, May 03, 2019 at 10:01:08AM +0200, Andreas Heiduk wrote:
> Am 27.04.19 um 14:15 schrieb Denton Liu:
> 
> While reading/reviewing I stumbled across another case for marking optional
> clauses. But the solutions is not a one-liner. @Denton Would you please add
> that one as Patch 4/4 to your series?

Will do.

Thanks,

Denton

> 
> ----------------- 8< ----------------------------
> Subject: [PATCH] revisions.txt: remove ambibuity between <rev>:<path> and :<path>
> 
> The revision ':README' is mentioned as an example for '<rev>:<path>'
> but the explanation forwards to the ':<n>:<path>' syntax. At the same
> time ':<n>:<path>' did not mark the '<n>:' as optional.
> 
> Signed-off-by: Andreas Heiduk <asheiduk@gmail.com>
> ---
>  Documentation/revisions.txt | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
> index 372b286755..f11d1edc57 100644
> --- a/Documentation/revisions.txt
> +++ b/Documentation/revisions.txt
> @@ -196,19 +196,16 @@ existing tag object.
>    Depending on the given text, the shell's word splitting rules might
>    require additional quoting.
>  
> -'<rev>:<path>', e.g. 'HEAD:README', ':README', 'master:./README'::
> +'<rev>:<path>', e.g. 'HEAD:README', 'master:./README'::
>    A suffix ':' followed by a path names the blob or tree
>    at the given path in the tree-ish object named by the part
>    before the colon.
> -  ':path' (with an empty part before the colon)
> -  is a special case of the syntax described next: content
> -  recorded in the index at the given path.
>    A path starting with './' or '../' is relative to the current working directory.
>    The given path will be converted to be relative to the working tree's root directory.
>    This is most useful to address a blob or tree from a commit or tree that has
>    the same tree structure as the working tree.
>  
> -':<n>:<path>', e.g. ':0:README', ':README'::
> +':[<n>:]<path>', e.g. ':0:README', ':README'::
>    A colon, optionally followed by a stage number (0 to 3) and a
>    colon, followed by a path, names a blob object in the
>    index at the given path. A missing stage number (and the colon
> -- 
> 2.21.0

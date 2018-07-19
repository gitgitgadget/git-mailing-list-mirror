Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 135AD1F597
	for <e@80x24.org>; Thu, 19 Jul 2018 06:10:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbeGSGvg (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jul 2018 02:51:36 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]:37829 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726857AbeGSGvg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jul 2018 02:51:36 -0400
Received: by mail-wr1-f43.google.com with SMTP id q10-v6so6779269wrd.4
        for <git@vger.kernel.org>; Wed, 18 Jul 2018 23:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=BLG6f+wGpqKFcqCGMhza4PsdUOBN0eUR619LJmOqj34=;
        b=f+86FaRc/KhZFYwLPaGTxv7f/19WiTIPXDqLKE2/0y3ivpOhV3ywkqxkT/Cu8jdhxn
         tblI/4TSoxsZ6NSKY8or2cZ2jB9qGx3uWpi1BsJ0wUL89LiFrDQ3X1GP7kn7tB9xSotN
         7P0SjTflCkYzxArBFPGXnrAeas9uDg4dQ9hMnMRUJ1rHlghwK60DlFCPqIo5lngaS+G9
         IjU2HZqEXvX5SDI1W+5umXKC3kEPkWZWwtXwzzh5eDgffeZwijaMysYznBQSO67T7o3P
         mWR1CDQa7po+LR8tTwy87hjEUiEh9r4WRlrTha7KxT3rTfbIfBvxMqrBCBkeE9i94wc+
         e/NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=BLG6f+wGpqKFcqCGMhza4PsdUOBN0eUR619LJmOqj34=;
        b=HaxmZN2xN6jOhuWCa4mitXADISPUYWDty9IR7vIcslcSfIyHMeiotTeR8xHb2j2Wes
         lCRrh5bbqLXp+B1scc5ylSmavpjyyCl19aN22MKfl9fPak8Si0FQXflTFVSVue8BmWsM
         ARW1jAuszamUUy7yv16hHqJHOH1L97mjBQpVw7kJoA0Q6U53LU3VYlahMxOL+fw8VHNk
         bilEHPavHKq+I4D4eMmXvKSjZFzBUV3blO6OdIEXjXHxIb9/tprc5grXg2xekxBb5sPh
         +v2JKBRlPuPVwiMmZ1nXrJ13WY5+vZqZiUXWhgtXzzYBAE6772lvUiu+ehv0wVn1EC68
         /IRA==
X-Gm-Message-State: AOUpUlGQain7YGwFJegsln1GmIwKcN2tKCu2WWiGnBmtB5oSomr4izuo
        SctXeE6ekqW4l2gOPFOzWK+Gfeb0VsfN4e9TJ0EyNA==
X-Google-Smtp-Source: AAOMgpdcxoJhOt3L/S88sGxlsPBRFd2dts282EwyQjET+U9ElZsnZC+KosigMZSDqDux0UONOEUNECasa6xUrWPVaCE=
X-Received: by 2002:adf:dd07:: with SMTP id a7-v6mr6634757wrm.2.1531980609296;
 Wed, 18 Jul 2018 23:10:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:e9c6:0:0:0:0:0 with HTTP; Wed, 18 Jul 2018 23:10:08
 -0700 (PDT)
In-Reply-To: <xmqqtvowi4l3.fsf@gitster-ct.c.googlers.com>
References: <xmqqtvowi4l3.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Date:   Thu, 19 Jul 2018 09:10:08 +0300
Message-ID: <CAL21BmmALPba5NEH-sq42mX5xS-CAPoupjftw390XWjJeQXoDA@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jul 2018, #02; Wed, 18)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> * ot/ref-filter-object-info (2018-07-17) 5 commits
>  - ref-filter: use oid_object_info() to get object
>  - ref-filter: merge get_obj and get_object
>  - ref-filter: initialize eaten variable
>  - ref-filter: fill empty fields with empty values
>  - ref-filter: add info_source to valid_atom
>
>  A few atoms like %(objecttype) and %(objectsize) in the format
>  specifier of "for-each-ref --format=<format>" can be filled without
>  getting the full contents of the object, but just with the object
>  header.  These cases have been optimzied by calling
>  oid_object_info() API.
>
>  What's the doneness of this one?
>

I fixed all known issues, I hope we can move forward with it.
Thank you!

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7D371F404
	for <e@80x24.org>; Thu, 12 Apr 2018 21:07:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753016AbeDLVHt (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Apr 2018 17:07:49 -0400
Received: from mail-yw0-f181.google.com ([209.85.161.181]:43128 "EHLO
        mail-yw0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751624AbeDLVHt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Apr 2018 17:07:49 -0400
Received: by mail-yw0-f181.google.com with SMTP id i187so2811336ywd.10
        for <git@vger.kernel.org>; Thu, 12 Apr 2018 14:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pT8leVPxNh6w3ob8aYUwH2u/BRDnhEEXZWgDH72KFTc=;
        b=oQAAUremss1+2TqLB4Sl/46KIOYSgTNfSZvjiNN81th3arguMgmzxRvi+Fl6EFMq5Y
         j1mPnl6Nv+M0VQucOFafjBLTHEIWrgOj63Kkifxgw/+D6h4zETZqVvhiZjOZ3G9nfHua
         /XkyyoZvYnAYQg7IpgTLtsJyWHo4dNModl5ubi62nC/N/+yuXZGN9vK+sWUzZrScepQ2
         AjzIiHXgsB1iVRV+6EIQonm9X1F7BeoKebdwgC6tFhHfMddYBxhHUI7N8pHKuN0UCnJY
         wh+5eRymKi8BFBTwHW6iMYe8XWZt3HfQVh83NHRp0VBUmo41Fq93RXQeo0aGrWp9wpp2
         LqKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pT8leVPxNh6w3ob8aYUwH2u/BRDnhEEXZWgDH72KFTc=;
        b=XdMJ7yNf3Vo6eWJ5Km28/ygaq54LwYc+j2500voqO4wWKesXBIZDtQJcelQt7fAmzt
         14aUBfoUxSp0hVp8vVCeFTAc5Fl7R+1eszmgX5ksjb4mMBTrd+oXeiZpQ7ANbMjOI3aq
         Ee2/EKk2baGHofQAsJf+OYoWGaa0rXwrdLo7xVQGsqFn7nA9OJilAAsm9SumlCz8NoW3
         /cXw0SloVwe1tuZjMBvUWn/QmauwQTVs750RbOPY5rBO8jFNc0f3tc0rjHjxutcCc2sl
         Xr3Z5ahXBvqsz+Q9uDEy5Y+cuayX+ZvLdEeQGftKQaU1mzJsWfuJzcIClsmxwUy/9MZD
         pOvg==
X-Gm-Message-State: ALQs6tCeqC2OkK/8bATA2OPAxgM5RH6iUZ9BciC+iDq+pkCKDDsatNIz
        fyreglaMylWqAJeDjIvyZ+8HkiupFWy7aDc0dG0=
X-Google-Smtp-Source: AIpwx497yotACL6otxCSI8lapIy9TvZ7OjbucgAcHM09vEQigQGEr5/uoZycTyPfS2tz82TalHifOH8lWVA7373rZGM=
X-Received: by 10.13.207.65 with SMTP id r62mr418008ywd.46.1523567268465; Thu,
 12 Apr 2018 14:07:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.173.50 with HTTP; Thu, 12 Apr 2018 14:07:08 -0700 (PDT)
In-Reply-To: <87k1tcf905.fsf@evledraar.gmail.com>
References: <hbf.20180412fvfi@bombur.uio.no> <87d0z4b6ti.fsf@evledraar.gmail.com>
 <4af21bcd-7a68-50df-4cce-0b050ccaeb90@usit.uio.no> <87k1tcf905.fsf@evledraar.gmail.com>
From:   Rafael Ascensao <rafa.almas@gmail.com>
Date:   Thu, 12 Apr 2018 22:07:08 +0100
Message-ID: <CACUQV592km3SaHiY9uZon4E3jhakmYmzwcejmsnExzaybNm3xw@mail.gmail.com>
Subject: Re: File versioning based on shallow Git repositories?
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Hallvard Breien Furuseth <h.b.furuseth@usit.uio.no>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Would initiating a repo with a empty root commit, tag it with 'base' then

use $ git rebase --onto base master@{30 days ago} master;

be viable?

The --orphan & tag is perhaps more robust, since it's "harder" to move
tags around.

--
Rafael Ascens=C3=A3o

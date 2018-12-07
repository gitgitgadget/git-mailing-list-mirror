Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73ECE20A1E
	for <e@80x24.org>; Fri,  7 Dec 2018 12:45:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726018AbeLGMpB (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Dec 2018 07:45:01 -0500
Received: from mail-qt1-f178.google.com ([209.85.160.178]:37272 "EHLO
        mail-qt1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbeLGMpB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Dec 2018 07:45:01 -0500
Received: by mail-qt1-f178.google.com with SMTP id z16so4276882qtq.4
        for <git@vger.kernel.org>; Fri, 07 Dec 2018 04:45:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=udRBb0cJldUY1LgfrX84fvEG1fY0KyUqCw/Ig/cjWKo=;
        b=YzskJRj0zsvu/oCvp9eYLS53JYO5Mu0+QxN35tS1dMh0c4E0XxSYVeaRMQQODcayWs
         ntD+/tzdz2Pirq1tIJ9KhSNenpIuFE9ornIZqkQszucvFxs7DDb+uRHEoJWQMKAEsuwd
         s3vWpOCyTpFHJxod7MLvWKKXmmWMISBv2ttmz1FvUW+UQz8EUPw7VnF8iR9Bfy6laNed
         cMB5s01FiqIT5NJlH/X7C7uNnGtwBNiMD/++AzoaosJOP0lEiiru/hqu57qDi1omk7ep
         yfrJiMHSwvxckGbMy3ekxM+kynXzQwyE7Vn1bCoI+mdGLX5FspwTDa7bECMIiUZPRTNb
         J9+Q==
X-Gm-Message-State: AA+aEWaizNp79v4wn3EpV0PI2f6I7no27W9lL5qNEk4oAHCuZBy0K4VV
        mhKRM/IwEuCsnu+Z47D8eHnvR+BRMmY+cRYQNQU=
X-Google-Smtp-Source: AFSGD/VTHOytWdLhREGc3O5FxKRWgPlz8M9gXBsJpwI2+C0jvkmkShetgaz21nhGVPqrqv5R9CBTT0RQI6JhndhBip0=
X-Received: by 2002:ac8:101a:: with SMTP id z26mr1884096qti.184.1544186700022;
 Fri, 07 Dec 2018 04:45:00 -0800 (PST)
MIME-Version: 1.0
References: <CAG0OSgeTqFYGqqOOBF0TbKpsWb70Bv_wQ6-b4Ke=LTg6Z0OUMg@mail.gmail.com>
In-Reply-To: <CAG0OSgeTqFYGqqOOBF0TbKpsWb70Bv_wQ6-b4Ke=LTg6Z0OUMg@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 7 Dec 2018 07:44:47 -0500
Message-ID: <CAPig+cRvJWhnm22Xyb9J1wz2sKLycRKbAg299QfTZu5Tq8F07g@mail.gmail.com>
Subject: Re: Get "responsible" .gitignore file / rule
To:     victor.toni@gmail.com
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 7, 2018 at 7:36 AM Victor Toni <victor.toni@gmail.com> wrote:
> I'm wondering if there is any way to show which rules (ideally with
> the .gitignore file they are coming from) are causing a specific file
> to get ignored so I could easily fix the .gitignore file?

Perhaps the "git check-ignore" command would help.

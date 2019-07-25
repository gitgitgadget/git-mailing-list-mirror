Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A00AD1F462
	for <e@80x24.org>; Thu, 25 Jul 2019 11:34:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391949AbfGYLeq (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jul 2019 07:34:46 -0400
Received: from mail-ed1-f44.google.com ([209.85.208.44]:35210 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388479AbfGYLeo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jul 2019 07:34:44 -0400
Received: by mail-ed1-f44.google.com with SMTP id w20so49891680edd.2
        for <git@vger.kernel.org>; Thu, 25 Jul 2019 04:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hd7Lb6peGVYwWMRiWn0yb7NrNP/05hdA/hlNnQfgJX4=;
        b=SxPbxjI0ljSE9kyaWWmTzaAZYEuiNl86nDcz9aT+rqrQvjrn8HTiUlS7BQfpqTA2uM
         7A49H4b5BqampC39vgIIv2SnZMBN1VwdrKudrU+OCItZjw41kduYqdHUx2PAvoMS/RWT
         L6zcafYKh6gzJMYKV4xGuey0TfZh5nPlUZUWPxJKc/Xo6W4mE8pQxTu4u6yJT3tiDfue
         JDG72axGKiuzYa9uhCBGNusWXXgeghmdItqgRYhqnZJMYec969OnXx8BvdOtIc9Qd/6t
         9k7c8jQN7q0LKffuuW5WQQNSlkx+Yi8eEsQYHezYEEO3ST0J6+mccqfgDprLgUuy43yR
         MBwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hd7Lb6peGVYwWMRiWn0yb7NrNP/05hdA/hlNnQfgJX4=;
        b=q5LtL7DEKn8OI43DMtAOGJ9Xgk36kteZVM6hfLFQ7JwMmREvzCtqVXO84GjaxOe1N5
         apsmO29ldTzYeCFkgMoKqNXO3Hp45ZAM1cyjfA4/2+WZ9jDmcL+jpdfS5sVJxY0ltJ2r
         tC7mXLpxz1/KBjtEHHGTJOZb8kHElhWEWLXG4GcmSl+pU1eKGBpKm0gbJ0TJGUVXvyfc
         6RedOiiexLfgB8gjkJypzrNUGeiztU14eQdtO85LNSTUJczhoBwNqlaLsZdDuYIcvZgD
         mOk2Y5FDHCQsFu5MG1Vnzsp0BVo5FFDUBpb3czu7PX4ETGVKkkvQhQdpuB8DbiTO4nh7
         t+Ew==
X-Gm-Message-State: APjAAAX6kCmKNY6sWjIJlSfeOsk8boPV3PwZ+1vXjRo/NCCj32fcndOi
        RAELUtVOr+R54N5kIHzRxjxZXcOfgn9CGUBuFz7LKs6Y
X-Google-Smtp-Source: APXvYqwOw4onseGCPpAUNyeVEXDQndHnH5/kieHY6SpWlYvok0Y9XrX1GZWfanAv07cb5o/hsAZkElAmhn4rkAgSN8k=
X-Received: by 2002:a50:9107:: with SMTP id e7mr77087020eda.280.1564054482094;
 Thu, 25 Jul 2019 04:34:42 -0700 (PDT)
MIME-Version: 1.0
References: <35506bd2-aae9-6608-ed4d-a408e0c831b8@yadavpratyush.com>
In-Reply-To: <35506bd2-aae9-6608-ed4d-a408e0c831b8@yadavpratyush.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 25 Jul 2019 13:34:30 +0200
Message-ID: <CAP8UFD1C_FD5TLz0oyn6QzGU2rdvvTe6PNhpK29vkMfuHim-qg@mail.gmail.com>
Subject: Re: Where do I send patches for git-gui?
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     git <git@vger.kernel.org>,
        Pat Thoyts <patthoyts@users.sourceforge.net>,
        Pat Thoyts <patthoyts@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Pratyush,

On Wed, Jul 24, 2019 at 11:43 PM Pratyush Yadav <me@yadavpratyush.com> wrote:
>
> I have a quick little feature to add to git-gui, and I'm wondering where
> should I discuss it and send patches. The git-gui repo [0] has no readme
> I can see that would point me in the right direction. Googling around
> didn't get me anything either.
>
> Should I send it here on this list or is it somewhere else?

It seems to me that people have been sending patches to git-gui to
this mailing list indeed.

According to the following discussions:

  - https://public-inbox.org/git/xmqqbm36w7hl.fsf@gitster-ct.c.googlers.com/
  - https://public-inbox.org/git/nycvar.QRO.7.76.6.1905272135280.28524@tvgsbejvaqbjf.bet/

Pat Thoyts (in CC) used to be the git-gui maintainer but we haven't
been hearing from him for a long time, so we are looking for a new
maintainer.





> Also, is the project even actively maintained any more? The last commit
> was in 2017.

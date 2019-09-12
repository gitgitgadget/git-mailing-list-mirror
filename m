Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E77B1F463
	for <e@80x24.org>; Thu, 12 Sep 2019 08:50:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730469AbfILIuL (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Sep 2019 04:50:11 -0400
Received: from mail-io1-f50.google.com ([209.85.166.50]:33523 "EHLO
        mail-io1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbfILIuL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Sep 2019 04:50:11 -0400
Received: by mail-io1-f50.google.com with SMTP id m11so52708329ioo.0
        for <git@vger.kernel.org>; Thu, 12 Sep 2019 01:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rug-nl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=69jyrLBnIkNE3/C1IIMRZT4fBAUHDquS2Kdwg7BeGsg=;
        b=Jhpc8lntnyjW9EAm02+x6/x+xh072kGwANW//pt+96SKX/1id7kXsdXtT4Gibb3gPN
         O1fA7SEtLUkBZLj+EIydzzGkq4nmS9uqt5AEGobopo6dfZgfuBdE5LFKHk5iAT6IKhCy
         KF2jqMkzSfyEJLXmyxh7KMFRbjBS3fYI4eGzbs7U00z8DvhyYtQ3fz+x/JoybEj8dlCO
         GCJy1vgg37QNcuNjIN5VkAeKFDMzmEbByN6JfYvtwIAJgbhYRCgj077q+Nt8SmeX+cKJ
         V5vsrFu5LX3IS8LeL35YmVfa2q1CL63PO6INn7CVGCwTDOSTO0k/ERO3CcxQp04+Hdyq
         CfOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=69jyrLBnIkNE3/C1IIMRZT4fBAUHDquS2Kdwg7BeGsg=;
        b=EiLxgSTpqzVyrktUuCn2p9aYjiM9vXK2BEO1YoUFUfIQ8U83EO+DIdZ7hQ4SDd7Mln
         NtS/F81HfcyAhqsL10tqbEIPWEpJe7BrbE+SZU497uczwjoFSIEyh3UqsDaOryzSiH5+
         PwaYo4OBXZsIZfI63zk9X0kolwT+4H9nTjxEydELtFLlexC5lfZFeAxCGUMCTM9z4oE2
         hyJkiPDoARsaqj/OU6EjUUe02hlr6jb2JASZq7lPqbgVwNo4OkU8ABEtol50PB8vaWAM
         7Bjo3A8c/D6Xc+HMxySBXTn6NdgRlxe97ya9cpncWvKWYZPYQwH3VZFV8VSbwVvzJKXy
         FQCA==
X-Gm-Message-State: APjAAAW92wLPdUxNaioHTUKwUzlZeNm0FTiK0Kr0J12WUUj3rYcoI/kI
        P8ng8ey/UOXiBvQj7X8ERMnau6LINu71gZb+sXfztw+asmE=
X-Google-Smtp-Source: APXvYqzAkVQbjHXefMmLfLlkQq2t3+MUlkV8HCtog2oGqM6WDCAiua5t8C+E4UG7KB4PiheZgS+FKd7CyjIGEmoNw2A=
X-Received: by 2002:a6b:4a11:: with SMTP id w17mr2920670iob.21.1568278210524;
 Thu, 12 Sep 2019 01:50:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAMr8YN58q94bnBkdfxrBR-Vw5Mk4akHzn4c1k2HjMQCXKWdWsA@mail.gmail.com>
 <nycvar.QRO.7.76.6.1909121044250.47@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1909121044250.47@tvgsbejvaqbjf.bet>
From:   "Castro Alvarez, Sebastian" <s.castro.alvarez@rug.nl>
Date:   Thu, 12 Sep 2019 10:49:59 +0200
Message-ID: <CAMr8YN7aa9yK3TSqVhQjn2DG7vU_zJs9SHvznPefay+Mxs_Qsg@mail.gmail.com>
Subject: Re: could not fork child process rebasing required
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

I have tried with both versions 32-bit and 64-bit, none of them work
for me, I still get the same error. :(

best,
Sebastian

On Thu, Sep 12, 2019 at 10:45 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Sebastian,
>
> On Wed, 11 Sep 2019, Castro Alvarez, Sebastian wrote:
>
> > I have recently updated my computer to W10. So, I reinstalled the
> > newest version of Git, and it is not working. It gives the following
> > error:
> >
> > Error: Could not fork child process: Resource temporarily unavailable (-1).
> > DLL rebasing may be required; see 'rebaseall / rebase --help'.
>
> This sounds as if you tried to install the 32-bit version of Git for
> Windows? If so, please install the 64-bit version instead.
>
> Ciao,
> Johannes



-- 
Sebastian Castro Alvarez
PhD student
Department of Psychometrics & Statistics
Heymans Institute for Psychological Research
University of Groningen
https://www.rug.nl/staff/s.castro.alvarez/

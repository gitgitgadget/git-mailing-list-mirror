Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 273F920387
	for <e@80x24.org>; Thu, 20 Jul 2017 07:58:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933997AbdGTH6u (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jul 2017 03:58:50 -0400
Received: from mail-it0-f44.google.com ([209.85.214.44]:37126 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932086AbdGTH6t (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jul 2017 03:58:49 -0400
Received: by mail-it0-f44.google.com with SMTP id v127so12289003itd.0
        for <git@vger.kernel.org>; Thu, 20 Jul 2017 00:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=tp/l3LGCWDgU/6yvTpuRUFHVD1Z5u9101Eeb6y8mnuY=;
        b=DLwOqBRKeqPEBFjStp+F4ieD2a27cEev22VEd2LNyjltRSFLXU07xQwGiMr9KCilBp
         Zqm0lY4XMUaD4Dyqv8+S0XnOIN0dS+6DBTTnkYsCjapJGsCHzgBZ2zOn+foqzpD/HUJV
         x2C+gpvtm/admva37kARMISnC2v6Uc3XwKSPrjAAn1Hrevj2W46bmVo4GOrCNp1o0Ivp
         5S7suoo7jYJp99GLBpCM0XkhEYfVQpFM/IsI3R1wfFLvxllynDbOfQftj/SXJdMhRusy
         GdlSPyHj4R2vN5Ne05sxyKjPAemg5b+PLIefCJYkeS20bKtwluqE9cIC8TcxdO9uJcDD
         kquA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=tp/l3LGCWDgU/6yvTpuRUFHVD1Z5u9101Eeb6y8mnuY=;
        b=nyDU6qoZW40cr72Z0oexn1Cp/UuGbZVm5/TTwpmVGVulaNDxQOyMJ1gTJ2HKyNZ6v+
         f6zFTCu2daMB4o4ABhSM2DD/v7qH25+t57PsrcWdzbpLMdYel8bz98gJVoS94LX+h3Oy
         EB+8tpk8LpT4se92u6ciVFzkZjcJApJdhsvicEvVndu/Zgd77k5L+gw9QKdRXt8mo5Jd
         ocCE//ccqH8h5HwDB1KaWAkmx9NCnru3pm2LrjwbIrNKetamzjP+g8fNCEwG2hzAbWSB
         kYSjiDzynSQhgSRYyCJX95M5ATFKVMu/stE6C/YreyHSzMj9p86ajXv6pUkzsHqZn/19
         /l/A==
X-Gm-Message-State: AIVw113txo7yFVkB/ra/MfHPyry+eVvOQz4nNh5NEg2KPlFJC+KCYbLP
        05JPsu3tJ1AfHvmJYKgc84i/1VQskCfa
X-Received: by 10.36.94.15 with SMTP id h15mr2480858itb.71.1500537528595; Thu,
 20 Jul 2017 00:58:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.196.153 with HTTP; Thu, 20 Jul 2017 00:58:47 -0700 (PDT)
In-Reply-To: <CAFc9kS_xYVyPsW7qogDxLugxBb1p2vEFAoP=W9Rdnfqs6XtWKQ@mail.gmail.com>
References: <CAFc9kS8L-JJoJqKi7bB90qwKVW8gB=EFk9D8c=4YShqnamwa2w@mail.gmail.com>
 <CAFc9kS_xYVyPsW7qogDxLugxBb1p2vEFAoP=W9Rdnfqs6XtWKQ@mail.gmail.com>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Thu, 20 Jul 2017 00:58:47 -0700
Message-ID: <CAGyf7-FFQir7tnyW3RZp4vk7Y1qD3m34iTb4xUeKtm8rOrdL0Q@mail.gmail.com>
Subject: Re: Binary files
To:     Volodymyr Sendetskyi <volodymyrse@devcom.com>
Cc:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 20, 2017 at 12:41 AM, Volodymyr Sendetskyi
<volodymyrse@devcom.com> wrote:
> It is known, that git handles badly storing binary files in its
> repositories at all.
> This is especially about large files: even without any changes to
> these files, their copies are snapshotted on each commit. So even
> repositories with a small amount of code can grove very fast in size
> if they contain some great binary files. Alongside this, the SVN is
> much better about that, because it make changes to the server version
> of file only if some changes were done.
>
> So the question is: why not implementing some feature, that would
> somehow handle this problem?

Like Git LFS or git annex? Features have been implemented to better
handle large files; they're just not necessarily part of core Git.
Have you checked whether one of those solutions might work for your
use case?

Best regards,
Bryan Turner

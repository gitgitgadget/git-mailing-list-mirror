Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BE3C1F461
	for <e@80x24.org>; Thu, 11 Jul 2019 20:25:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729010AbfGKUZf (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Jul 2019 16:25:35 -0400
Received: from mail-io1-f48.google.com ([209.85.166.48]:33432 "EHLO
        mail-io1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbfGKUZf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jul 2019 16:25:35 -0400
Received: by mail-io1-f48.google.com with SMTP id z3so15530979iog.0
        for <git@vger.kernel.org>; Thu, 11 Jul 2019 13:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=RgjuwyTtDG3jBXsCT6adEsZD7+6FsUZ3ifqo2sADZiI=;
        b=FHEXssNiJHCPZKc3ng2eBN5kv1ljcwIF+tNKgfqVa6kvdje4DYr+h1bJ2iBm3t3Pcp
         U+vMEN0jjAGJMEJ4XOsOiLvnONNgHHJzU7WzufC3uP3esahKKWB+g5M4al3NpVqaP4qR
         ikV2nwTwYHlH/QglDd0NG6KU49KnfAzTJiKgHyOMUA0MyBDHDd5AlYLddxd02YyuVHAv
         qg83WiYQxkL9E/CSE5nquBee4hwivqNyUxgJCszPjS1Fxqn5V1E0z3piPzx5lWqIwNio
         UDA8E28tw/J7+ty7VSPDe3AcbaJ0H6WMUotvW701Sgmc26iIy4yMjJDdV41cHY8NfHuD
         FwJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=RgjuwyTtDG3jBXsCT6adEsZD7+6FsUZ3ifqo2sADZiI=;
        b=kkcJqQwpAI2tRQkpXTH/ND0z7+cmxvWpsVJ8OQmbH8oe6JJclYhksKOti+Esu8KmM3
         8eGrMWpxxFMMjXquCBfzB4PzDl2C8K9HdALFbiIqKL0SQ8lYQzC7ZqGU/GqjXeh7QRBL
         DzbC+5eJzt48XqWgKMgvcOWfukcSJwv64D+wfwXWJ7CPTpziS+dmvIO41GzAcxQFQmCJ
         2feG+lLYLbFMIO7jXpp7Db8JkqX4oTnFCGAGzN4JIc+PSup/CnIuoyOyS3472+kVgSqi
         tey47iim1NVj/QhE320hRD+2YPuSgM2tHE70mRGUr/odjWRhNWRnOay9s8HZyac4b+D7
         NijQ==
X-Gm-Message-State: APjAAAV965HjfP97pEuEyFSQml7br5y6XBLCB2RJH2e+i6J0GuXUcFCD
        cMRriCWydarGoYbKrJFK5AmvjInl6Ky+4d68w2D2Hw==
X-Google-Smtp-Source: APXvYqxwllrjgnnTlnwF4QwLE+FWyIzJbNzf065/lvIxblV63hv5JIXnyOBTpp78+jFJm2kFIvhxIU+QxqbCJztHlN0=
X-Received: by 2002:a5d:8451:: with SMTP id w17mr6818490ior.226.1562876734063;
 Thu, 11 Jul 2019 13:25:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAMgm5nNRYQpjFeDA=tLZax_vdn4F1nxH4EgbbLY0or7dnYG2Hg@mail.gmail.com>
 <20190711201810.GE8180@alpha>
In-Reply-To: <20190711201810.GE8180@alpha>
From:   Robert Morgan <robert.thomas.morgan@gmail.com>
Date:   Thu, 11 Jul 2019 15:25:23 -0500
Message-ID: <CAMgm5nOJ2jYAKE38XwBMMbLUfryj_W=kUQn1iG4fgQQPR3wS0g@mail.gmail.com>
Subject: Re: your mail
To:     Kevin Daudt <me@ikke.info>,
        Robert Morgan <robert.thomas.morgan@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Apologies list!  Thanks Kevin.  That's what I get for troubleshooting
plain-text in Gmail and quickly sending a subscribe email before
walking out.

Robert


On Thu, Jul 11, 2019 at 3:18 PM Kevin Daudt <me@ikke.info> wrote:
>
> On Thu, Jul 11, 2019 at 03:11:33PM -0500, Robert Morgan wrote:
> > subscribe git
>
> You need to send this to majordomo@vger.kernel.org. Sending it to the
> git mailing list will not do a lot.
>
> Kevin

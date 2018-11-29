Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64ADC211B3
	for <e@80x24.org>; Thu, 29 Nov 2018 11:56:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbeK2XBs (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Nov 2018 18:01:48 -0500
Received: from mail-ed1-f49.google.com ([209.85.208.49]:40656 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbeK2XBs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Nov 2018 18:01:48 -0500
Received: by mail-ed1-f49.google.com with SMTP id d3so1641704edx.7
        for <git@vger.kernel.org>; Thu, 29 Nov 2018 03:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=loskot-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=K9RswnVqpTTYCsejoWDS3EewkWAqPCbPtdWbUTY9teM=;
        b=rwPt4SQ/4kI/Exf0VcrtzEuiYzAi/9kQgmdQj1+Fe/rfzHzz1Rwc6Yzng+DzBQAX6N
         fSjV8WWcALmdULzn+B8itS4JymZ/YbM6h95WzTTTBd1ocbWfgEXvam6N9sE0zWN5oF3v
         +cb8X67O5mDbYhF/cyQxwfSzPwcZFXtVXspZzPCBuMHd9tQv1axS8uGbk8CmNzMccK1a
         XzDud6NGeGHOZvJ0hLOERS3sUrQxcU/HrysKVdbmZm52eGYa6lKlXcDEySHh0itsO6MO
         5vXCxaaMN3bPC92iSZR5kKLbKwji3FvV5MEcPpOoOn4MjdXQGxzABh2MmHkjZNpjAx6p
         6Gbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=K9RswnVqpTTYCsejoWDS3EewkWAqPCbPtdWbUTY9teM=;
        b=OOulD+aSMPT2FkQSijbWQcnDyOL4Y5RQpbKeGvuVQCR+Au8gQnOYCQBCuyBjbfEE6g
         JAwQtZdhH42Y4T58bzKDngn//zipbCc5lzB384uK2MF/6ZO9QT4TsKInzr5jfPSrOGRN
         OIPnHMwzeDHO1b7TW6lFbRtGDgqlWkaxhoD+fGngi9dgJfD0CttXjmIf0weoHqSiiCMs
         mxBmLbb1av9A0fSwsN1xpDcbEoQp8MspJed06hD8Og9Um28sKV9oTywU+OIU44+aJa1H
         lNxyq4Z/6yeea3SwpCdgGmHHuU9qUt9omz9a8z0CCHmCWgiAHTmWXVbiq0n1lsEykPnR
         zEBQ==
X-Gm-Message-State: AA+aEWaGXerjpQUeFD7fLTRMrXb613IIDceWCU84m22/sniAK1I133gF
        oXCJ1KKR+i6GAB7YJ3Z+oy3ahFaai9ZWsvxCFjlsmySPdjkR5R6d
X-Google-Smtp-Source: AFSGD/WdKt8lkCgjujGw1VH2P/742fk1nk5U0w3Pj6CAPYa4EJweK+Jpnr/rXMjnucXd4WwwR2nrXOeT49T2hD4foHk=
X-Received: by 2002:a17:906:6c97:: with SMTP id s23-v6mr1356069ejr.79.1543492599874;
 Thu, 29 Nov 2018 03:56:39 -0800 (PST)
MIME-Version: 1.0
References: <c8fc0da2-c3ff-4985-e4a2-a066a3a6f2af@peter-speer.de>
In-Reply-To: <c8fc0da2-c3ff-4985-e4a2-a066a3a6f2af@peter-speer.de>
From:   Mateusz Loskot <mateusz@loskot.net>
Date:   Thu, 29 Nov 2018 12:56:13 +0100
Message-ID: <CABUeae_4yxtxFmi14+OivX-wFQq4Hd5uEV3_WhRMsMHbvSxy7w@mail.gmail.com>
Subject: Re: Git Tags
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 29 Nov 2018 at 12:50, Stefanie Leisestreichler
<stefanie.leisestreichler@peter-speer.de> wrote:
>
> git tag -a 0.9.0
> git push origin master
>
> In my local repository, when I run "git tag" it is showing me "0.9.0".
>
> Then I did (on box B)
> git clone ssh://user@host:/path/project.git
> cd project
> git tag
>
> Now git tag is showing nothing.
>
> Why is the tag only available in my local repository?

From https://git-scm.com/book/en/v2/Git-Basics-Tagging
"By default, the git push command doesn=E2=80=99t transfer tags to remote s=
ervers.
You will have to explicitly push tags to a shared server after you
have created them."

Best regards,
--=20
Mateusz Loskot, http://mateusz.loskot.net

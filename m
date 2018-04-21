Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E81E1F404
	for <e@80x24.org>; Sat, 21 Apr 2018 06:19:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751000AbeDUGTO (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Apr 2018 02:19:14 -0400
Received: from mail-oi0-f48.google.com ([209.85.218.48]:33259 "EHLO
        mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750816AbeDUGTN (ORCPT <rfc822;Git@vger.kernel.org>);
        Sat, 21 Apr 2018 02:19:13 -0400
Received: by mail-oi0-f48.google.com with SMTP id 126-v6so9910495oig.0
        for <Git@vger.kernel.org>; Fri, 20 Apr 2018 23:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=8Ypqv9YPg79MZ+Prtc8COXkLKfd8a0iDvp5SZgXy7v8=;
        b=Jgzl0nZb46z+9dn/1cmf2HwLvXqsywDhOk2jiVtYURbhrxu3m4sXhYH3+N6CKjnavi
         wrY7VZ3iNhRn2iC6ohHqz05RGrcWH/77V3cjhtu8wZTmh5jrSH0oQPuowftym2UsEqo7
         pT2WDznC+UtznrT/jd3STBlqYxjUYKIXOf43zUWmnfxxrq4xMTDWCyepn5vbDObWbBkH
         4NK5JAQiKKnstYAyp/nlglMUoZD8n7RWmSJ/6UAcsc6/g8MB7/SCq8cilQ6c4W8mi+XG
         1W5Vk7wqQQKAmKZvqgc/EMPe/xS3YtVpw9S5/sgyoxcNxofhU02K10+FTo51fCJPv9uH
         8FPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=8Ypqv9YPg79MZ+Prtc8COXkLKfd8a0iDvp5SZgXy7v8=;
        b=D8lorqjYpbtCw9uYVXDvWEeThMTeWV7RKK8lq0vHemLuwqIcmL0XoYpYy2biD9iDD5
         DKeS03PRUCZ9F3z4J0AwQFV0nR9ggTIIm8IF54Y80Fei4NXYOB4JZU37/03RL2vpLdIi
         AyEgPlPLUt4wgqbvhRmbp5nMkxXQsr95Chxdjc4pCX0Bt7Lkkslcer1iiUhnViKj0tun
         y7i9cA8ZzC0J4Wd/ipH5BGVoKEuBWetcGNfUfeR696iH8oc09j1ybdkoJXKeq64LRVEE
         VEuKwGfH52wIZxSoVMVMelX9HUP4iR/Q8oUenAXsZIs8at7pR/UbQhyA20B7LGLXpj7y
         Z2MQ==
X-Gm-Message-State: ALQs6tA1zpA2wr7RmwrgcPEYLbMsgK3rVXGpchgqxz9EfoJ8eCHvkGCx
        ZKJ5vcLtizkwzZR4dgpzzKq6AFKL6yueABNiS+k=
X-Google-Smtp-Source: AIpwx485T+d1QSJ6cgoX3ZkYAnf4WeiqmbSWVpxl34uuERRSmkHabEc36Ltb3N9oQveRuFYMWS9Vr7T/qPXPtNpMqO8=
X-Received: by 2002:aca:4d4c:: with SMTP id a73-v6mr7357267oib.177.1524291553192;
 Fri, 20 Apr 2018 23:19:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:6058:0:0:0:0:0 with HTTP; Fri, 20 Apr 2018 23:19:12
 -0700 (PDT)
From:   Vladimir Gorshenin <gorshenin.vladimir@googlemail.com>
Date:   Sat, 21 Apr 2018 08:19:12 +0200
Message-ID: <CAEbJ=SN0h_eO+0CJQGEnEafhzgAYdgXByUqb_vsC1rgGw7jNAw@mail.gmail.com>
Subject: Git archeology
To:     Git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

My team and I as well as millions of other developers are excited to
have such tool at hand as Git. It helps us a lot.

Now we challenged ourselves to be even more productive with Git
analyzing our usage history.

And there is a problem, which I believe is fundamental for Git (please
prove me wrong): how to find all overlapping commits, e.g. touching
the same lines of code?

I played with =E2=80=9CGit diff=E2=80=9D and =E2=80=9CGit blame=E2=80=9D bu=
t without a reliable
result. =E2=80=9CGit diff=E2=80=9D gives only relative number of lines and =
it=E2=80=99s not
easy to track these number through 1000+ commits. =E2=80=9CGit blame=E2=80=
=9D has nice
output but without any information about deletion.

What would you advice me to do?

Regards,
Wladd

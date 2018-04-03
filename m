Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5ABC71F404
	for <e@80x24.org>; Tue,  3 Apr 2018 17:35:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751760AbeDCRfV (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Apr 2018 13:35:21 -0400
Received: from mail-lf0-f47.google.com ([209.85.215.47]:40432 "EHLO
        mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751469AbeDCRfU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Apr 2018 13:35:20 -0400
Received: by mail-lf0-f47.google.com with SMTP id e5-v6so21388103lfb.7
        for <git@vger.kernel.org>; Tue, 03 Apr 2018 10:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bR5SlJ3Wjm7G9LhLhNbnjXygcQZnJOPf3FWWQnBnr/4=;
        b=MohgMjqVyy+60cHPcXCq1f51xYjofY6039UqpeIgODcQ+E7eYHO4iN4UQZE1GQ+9k9
         Dwcv/sceMszms/K9M9smZa/QQ1NgNrHBEUX6/zYRZ2/IDLmRCOGuforPDOdX/3rnnVvy
         Vi57NAQMB0tgc+SdV2JrU/sNlI1rgd+fVai1zAFZxhwhZpaYJbWujxv5c4w8wk0bpU5z
         s/kGKbkegDaTctgQjomqOgMvrHHIGebCaGFevS3TerEYmYtUgdB3baaSbBhPyTyOd1dF
         ekp7u62EWemqUfxPD+koKgvrUDkzI7cg+cLlqzCUJGyxf0F+jRdMCUqrY3fZa93o9CP6
         51Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bR5SlJ3Wjm7G9LhLhNbnjXygcQZnJOPf3FWWQnBnr/4=;
        b=D0Om9OcYJF8jyjQ7mUF59Ha+dMkLWJwsvdJmuj8AjKuURHrRqMu0kwFwnnpEvZaDGB
         Nf/jNCDrMVMFnMdpoS3EjAWGBT3cN1MQzk7lhHRG9D5AZw2ATu+wVOh+Jhdcm/cMTw4B
         8nNxp2P6smyuvp0697J1lbt9Ja9zC6QlH9j91O9alSmBbT/itCD+8CSY554cunBlbLo8
         CouknTHl1/wx4tbK+j0uPDR65pR3pgb3nF45wTXcM2Xp0pt0l5vd6dunIOtDINDqJ7rD
         lqpQc4a6iAuWAbcQuOdy39lHrIE4Jbo+iYVdQZ+/xCMty6BT8dC4skJmRjktVxOKBVRL
         y9Hg==
X-Gm-Message-State: ALQs6tA0bnMx8WnHcqI8JubzHL3StVv4jxktUW3VwEhA1swEzU08330/
        bC75mPKpF5iC4awEMqJP9+jQQPwRcZB2M2Eyb18=
X-Google-Smtp-Source: AIpwx4/0/T8GLW07K1XOA51CHKRDGCDh43l/Dh2G3b5Iuka0u6F8hhNRi8cQFKkK1EJxOM6F6In+4UqO+ZtOopSG9+U=
X-Received: by 2002:a19:9dc5:: with SMTP id g188-v6mr9268901lfe.95.1522776918856;
 Tue, 03 Apr 2018 10:35:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.46.157.19 with HTTP; Tue, 3 Apr 2018 10:34:38 -0700 (PDT)
In-Reply-To: <a2965f28-0db1-a560-38d2-fd7122e7137a@gmail.com>
References: <20180328055531.4769-1-ralf.thielow@gmail.com> <a2965f28-0db1-a560-38d2-fd7122e7137a@gmail.com>
From:   Ralf Thielow <ralf.thielow@gmail.com>
Date:   Tue, 3 Apr 2018 19:34:38 +0200
Message-ID: <CAN0XMOK2FFSc7smn7LYBGTV=Sf9OJx_H8+rOLHOaR7n8MG1k8g@mail.gmail.com>
Subject: Re: [PATCH] l10n: de.po: translate 132 new messages
To:     =?UTF-8?Q?Matthias_R=C3=BCster?= <matthias.ruester@gmail.com>
Cc:     git <git@vger.kernel.org>, Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?Q?Jan_Kr=C3=BCger?= <jk@jk.gs>,
        Christian Stimming <stimming@tuhh.de>,
        Phillip Szelat <phillip.szelat@gmail.com>,
        =?UTF-8?Q?Magnus_G=C3=B6rlitz?= <magnus.goerlitz@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2018-04-02 20:09 GMT+02:00 Matthias R=C3=BCster <matthias.ruester@gmail.com=
>:
> Hi Ralf,
>
> thanks a lot for your translations!
>
> I've only found a small issue:
>
>>   #: git-add--interactive.perl:1405
>> -#, fuzzy, perl-format
>> +#, perl-format
>>   msgid "Discard this hunk from worktree [y,n,q,a,d%s,?]? "
>> -msgstr "diesen Patch-Block im Arbeitsverzeichnis verwerfen
>> [y,n,q,a,d,/%s,?]? "
>> +msgstr "diesen Patch-Block im Arbeitsverzeichnis verwerfen
>> [y,n,q,a,d%s,?]? "
>
>
> "Diesen ..."
>

Hi Matthias,

Thanks for the review!

I'll send a fix for this since this version has already been merged.

Ralf

>
> Kind regards,
> Matthias

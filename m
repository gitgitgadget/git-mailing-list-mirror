Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A17BF20984
	for <e@80x24.org>; Tue, 13 Sep 2016 16:54:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759050AbcIMQym (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Sep 2016 12:54:42 -0400
Received: from mail-it0-f48.google.com ([209.85.214.48]:35414 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755003AbcIMQyl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2016 12:54:41 -0400
Received: by mail-it0-f48.google.com with SMTP id r192so5083439ita.0
        for <git@vger.kernel.org>; Tue, 13 Sep 2016 09:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8CIwARjWSYmDZWJ/soEDtib/CdHgnvU5WlfSXkABZio=;
        b=d0yckaOanXbIk+mvlxrxus7EiYldDl7VbZbGTU0qQuYJMfhyqsXzDvRiTpwblrpwEU
         ZkmEa8B8FvVyQUoT/+A4Wqes/eSxRNjTEN+XsgHoVn+Oiary9xFI96cwdeojWn/zK8NF
         U9qNNZXEc8u5bq+2/WC/gR/J5YQsR3Z6yh5hsuXwEyhWV+LixDz6qxmPSwU3VPzVrdn3
         ARHO1qyIhUmoylmV+fjl/0F/MihHPOuKY5zcZF0fRP1sc0zwmvMeVGKj8cm8XmU8U4W7
         AMILxzwK4E4M6Sj7nsO9PkB1M/8j4nyVV8mHQ82mAkfHh/5z7y2ZpAdlnl9CPWCTfR39
         zs+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8CIwARjWSYmDZWJ/soEDtib/CdHgnvU5WlfSXkABZio=;
        b=mA06KwCH8sthe285y2sIPpeLmsGJwpe9UNTPz4M88ZCpOyPV+CByz/O0MaDO2eJ/FI
         CaZvfjIw5j6RtLAC/4ceNk7Z4Sgo8XX0yQr90M+0jCjmwMmr1JYjbWn7N2j5tW6AzjB7
         yoh8S//ljexMrru5EhCZU9N0cADENAqCLdDe1VLbdXLtFbWy4h0CXeyHYINcLYsXSGYu
         jgVL1j6DWQvtCFWSvlAxGekXlBrSIDQUS89mIOnQPf4H6QfS7Ou7ospBCEt64IYbBBGy
         hfCxfZ4yKNgtB4Q7WYZ3kqzGgaZqSF5LeSYPScFA+IVyf/RkBkP3hU9NknfbfDFMn5ay
         0hQA==
X-Gm-Message-State: AE9vXwMWTJV0MJ8F6PEcyrG3UewtzUS1FVo8gIiuR0a7AWk+SqoX8x8iAv1EOD16d4ICaffsiUg5GT7g37jeDQ==
X-Received: by 10.107.192.193 with SMTP id q184mr3579721iof.170.1473785680369;
 Tue, 13 Sep 2016 09:54:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.226 with HTTP; Tue, 13 Sep 2016 09:54:00 -0700 (PDT)
In-Reply-To: <DB5PR07MB14487D7F217ECA53CD712D60E2FE0@DB5PR07MB1448.eurprd07.prod.outlook.com>
References: <de39c03d-e84e-8e45-69cb-a2e01fd25df2@gmail.com> <DB5PR07MB14487D7F217ECA53CD712D60E2FE0@DB5PR07MB1448.eurprd07.prod.outlook.com>
From:   =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Date:   Tue, 13 Sep 2016 18:54:00 +0200
Message-ID: <CANQwDwcLrfkj96pqOM8b=TUWCf-Ui6s9WFo75MoWKfGGvsvZmg@mail.gmail.com>
Subject: Re: [ANNOUNCE] Git User's Survey 2016
To:     David Bainbridge <david.bainbridge@ericsson.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Doug Rathbone <doug@dougrathbone.com>,
        David Bainbridge <david.bainbridge@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Andrew Ardill <andrew.ardill@gmail.com>,
        Eric Wong <e@80x24.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 13 September 2016 at 18:15, David Bainbridge
<david.bainbridge@ericsson.com> wrote:
> Hi Jakub,
>
> You said:
> P.S. At request I can open a separate channel in survey, with
> a separate survey URL, so that responses from particular site
> or organization could be separated out.
>
> Please can you open a channel for use by Ericsson?

Sent (privately to David).

Best regards,
--=20
Jakub Nar=C4=99bski

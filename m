Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3FD91FA21
	for <e@80x24.org>; Tue, 10 Oct 2017 08:20:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932158AbdJJIUU (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Oct 2017 04:20:20 -0400
Received: from mail-qt0-f172.google.com ([209.85.216.172]:43425 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932100AbdJJIUT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2017 04:20:19 -0400
Received: by mail-qt0-f172.google.com with SMTP id a43so42939623qta.0
        for <git@vger.kernel.org>; Tue, 10 Oct 2017 01:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=hfLnZsdb92tGsxXRtun2omOh6PRB8g1kBoXXtaYY71I=;
        b=kpYZLKTva7PswlRw1i0Z9otGGreeLqefRLFCvMgvVMU1BhiUgTqaFSIxAUI24w6Gb9
         qDIIiihH84ubC2bfuyD4H/DbPWJXAv7G45OYHHQaUWy00s8ajuEQfgZPLe2eJXSOJYEL
         n4xt6Tgd0/X9Z0RqZK0mwI5YNLTRoAnZWLaC07Wz9qmoz+BlDgVnuDdKmEpRrcw0GqE1
         Ywifb5UTGxoiS4Lc0sS2as37HCzG90dnq7SFbOGBCekXMoyzgV7POclHF0SPamucG3yz
         S1NJ5aGqplHDo88ymDfF3cqvQ4pV/7pEpkIFmSHCvX3Vyzm5PRt5c05ciPCUTGbZHPyT
         0S3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=hfLnZsdb92tGsxXRtun2omOh6PRB8g1kBoXXtaYY71I=;
        b=a9xgEVfzptbBPUbZrcslQnIWsbOJWrvfla/KXGcWPD9OZct8/mOySxzEJvbSY8keXm
         NxvA0t7wryPK6sB+uVbnNjSpQOP01mhv6wNYMh3VFmmryInUGRjmEICpkX7iNINHAsYe
         w81e2C8PwTC0XTCgJ50uiIetDrfo4X6UaTv0sHhwwWC4cl6LmbtpIn9FZ3LlwNVYGTah
         evYR8rhHLm1DxCx0RsiKzW8OlNez/OpRSPz4RJZ+QFLBW9Yf9a1wSQeZdkba21yfu3ac
         Tosm2NcsTM3OaL/10FqNuPPTsiIfiK3rAQhTCZeNcG4yyToYN6q6SeozMqUNzV0CVceq
         ZIkw==
X-Gm-Message-State: AMCzsaXgLre4bMiyi+ZejD+uBS2FyDbCfrb7MCNVEkNQSLI6Wq/H8PIF
        Ei2c5Il2pVujpdltQ4mDYJ8fg4Qf3vYUkT4J39I=
X-Google-Smtp-Source: AOwi7QCABrcCMNnCC94hKvcvTiZdkMQvozzDVsG2blM9y7YVBTweR+e9AoAbipRmlORnpphStGutxtlQ2Hn5DNatAX4=
X-Received: by 10.129.147.65 with SMTP id k62mr1576237ywg.237.1507623618499;
 Tue, 10 Oct 2017 01:20:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.129.43.214 with HTTP; Tue, 10 Oct 2017 01:20:18 -0700 (PDT)
In-Reply-To: <xmqq60bvfthv.fsf@gitster.mtv.corp.google.com>
References: <CAGb4CBUrozoz9iS5pd57VrnV2e6jkSn7N=POdeUFSkvvpPDSZg@mail.gmail.com>
 <xmqq60bvfthv.fsf@gitster.mtv.corp.google.com>
From:   Nathan PAYRE <second.payre@gmail.com>
Date:   Tue, 10 Oct 2017 10:20:18 +0200
Message-ID: <CAGb4CBWtc762b6w2udpZp5j+=0DqbeZmihd2_gjnge5jX5UAsw@mail.gmail.com>
Subject: Re: new contributors presentation
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>, matthieu.moy@univ-lyon1.fr,
        timothee.albertin@etu.univ-lyon1.fr,
        daniel.bensoussan--bohm@etu.univ-lyon1.fr
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

>First things first.  I suspect that you are trying to contribute to
>the Git project (GitHub is totally a different animal, even though
>they benefit greatly from our presence, and we theirs).

You are right excuse us for this.

>And if you are dipping your toes to the Git project's development
>community, then, "Welcome!" ;-).

Thanks we are enthusiastic to begin!


>I do not know about others, but I cannot quite tell what you are
>propsing from that three-line description to tell if it would be
>useful or not.  Let's wait to hear more from you guys.

Last year, another students group (Tom Russelo, Samuel Groot)
supervised by Matthieu Moy were working on git.
There goal was to create the --quote-mail=<file> option for git
send-email, this option permit to quote an email in the same cover letter.
All the metadata ("Cc", "Subject", ...) will be automatically filled.

For now the code contains a syntax error then our obvious first
goal is to fix it.

Discussion of the previous team with more information:
https://public-inbox.org/git/1464031829-6107-1-git-send-email-tom.russello@grenoble-inp.org/

2017-10-04 6:05 GMT+02:00 Junio C Hamano <gitster@pobox.com>:
> Nathan PAYRE <second.payre@gmail.com> writes:
>
>> Hi all,
>> me and my two other partner (Daniel and Timothee) have make the choice
>> to contribute to gitHub for a university project supervised by Mattieu
>> Moy.
>
> First things first.  I suspect that you are trying to contribute to
> the Git project (GitHub is totally a different animal, even though
> they benefit greatly from our presence, and we theirs).
>
> And if you are dipping your toes to the Git project's development
> community, then, "Welcome!" ;-).
>
>> The principal project is to improve the git-send-email function, for
>> example we will try to implement the possibility to answer to a email
>> by keeping the recipient list or quote properly the email body!
>> Do you think that it's will be usefull ?
>
> I do not know about others, but I cannot quite tell what you are
> propsing from that three-line description to tell if it would be
> useful or not.  Let's wait to hear more from you guys.

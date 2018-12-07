Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 688BE20A1E
	for <e@80x24.org>; Fri,  7 Dec 2018 13:17:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726015AbeLGNRk (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Dec 2018 08:17:40 -0500
Received: from mail-ua1-f47.google.com ([209.85.222.47]:38718 "EHLO
        mail-ua1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbeLGNRk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Dec 2018 08:17:40 -0500
Received: by mail-ua1-f47.google.com with SMTP id p9so1385645uaa.5
        for <git@vger.kernel.org>; Fri, 07 Dec 2018 05:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K/dhN+Xy0JGXeDGepTKkshzOW6F3rzwFOvp01ClxOHw=;
        b=iHM5fuVq5BR2AicNKWm4pTqv55yQOELr0ZJOTTkO/tKJJDPQ1n8OF8u/IPh9PpHmqi
         vfZj3LAJzrmbwTsFq51luA2UAhpzNiHwwSLGPPsUK++Rz/BSkFoBgFR42WjyOVpiegGD
         juREuyokUZJUoOyBhe945eil25VMCcMsWtpNkzDo9+WPnS4PydO27PDK6GkVLf15L00C
         8LviNZ6u+h+PtgrWNscIOI3wX6Gcq3ib0kugs3KC8o/QsjHfTwXDo3mfZXK1jLtRHUra
         wEV069Nl72dCRQXWHWffnduGzTgZo6QoFvo6V2xFcSFViH0cuRfbrjISn9Vv/UYoDzwu
         vFfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K/dhN+Xy0JGXeDGepTKkshzOW6F3rzwFOvp01ClxOHw=;
        b=W28pGioZb6OVREA1TQODoh6tXkyUg65VJXxItx5MZpmx9kkRZ6CY4o0r7UvmfyOuTc
         bTMhoiL5/UfGBAyJgt/oauLoXjq8eRUGKPHKpYlJmhypQPcC6PtCZclkBMZTUE2DlyZg
         8Ns8TilU7a0DHOpycdwCblxIHNXzzpadSNRa6hNBoZ7fqOy2rGlRnKtZj/K6UJ3XWNkt
         OXU2TCtOZjvq/5uzWQeSmYZE3lUTiifS2ze1hmTVb34qAzdW70v+yKHi0qVBFDYs66dn
         LF7hbXkkql+1F6y/d7HLQ8NTdqgyNNbhy+gwyzNTfAH3+XjYLnxa6TU6fqsG6xJvuuJx
         Xaww==
X-Gm-Message-State: AA+aEWbCiDAbxYbGQP2c4EVvQkhmX0uI2Fh2NIEwqKtIDer3npPGFzio
        afMOLMENQT/9/7A8Ik5+KmBzxCuUoQavZpd6xuvgxASC
X-Google-Smtp-Source: AFSGD/VnMAIEwuwa/X0znw5CCfMY053tTxqk0suF5Q0phH9zDjLnKWgBk/qDcMn1vxNGjd7wRdv4rDotRtBN3GBLn/s=
X-Received: by 2002:ab0:7618:: with SMTP id o24mr948567uap.110.1544188658434;
 Fri, 07 Dec 2018 05:17:38 -0800 (PST)
MIME-Version: 1.0
References: <CAG0OSgeTqFYGqqOOBF0TbKpsWb70Bv_wQ6-b4Ke=LTg6Z0OUMg@mail.gmail.com>
 <CAPig+cRvJWhnm22Xyb9J1wz2sKLycRKbAg299QfTZu5Tq8F07g@mail.gmail.com>
In-Reply-To: <CAPig+cRvJWhnm22Xyb9J1wz2sKLycRKbAg299QfTZu5Tq8F07g@mail.gmail.com>
From:   Victor Toni <victor.toni@gmail.com>
Date:   Fri, 7 Dec 2018 14:17:11 +0100
Message-ID: <CAG0OSgdSfxzB1L_hsu9kwHshwckhf+Ay9QiWTZt2d5mNT3ykKw@mail.gmail.com>
Subject: Re: Get "responsible" .gitignore file / rule
To:     sunshine@sunshineco.com
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am Fr., 7. Dez. 2018 um 13:45 Uhr schrieb Eric Sunshine
<sunshine@sunshineco.com>:
>
> On Fri, Dec 7, 2018 at 7:36 AM Victor Toni <victor.toni@gmail.com> wrote:
> > I'm wondering if there is any way to show which rules (ideally with
> > the .gitignore file they are coming from) are causing a specific file
> > to get ignored so I could easily fix the .gitignore file?
>
> Perhaps the "git check-ignore" command would help.

Thanks for the tip!
Works like a charm (had to use the --verbose option though, without,
it does not give much feedback)

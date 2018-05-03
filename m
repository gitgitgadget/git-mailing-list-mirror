Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7AFA0200B9
	for <e@80x24.org>; Thu,  3 May 2018 16:41:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751417AbeECQlg (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 12:41:36 -0400
Received: from mail-oi0-f49.google.com ([209.85.218.49]:35462 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751279AbeECQlf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 May 2018 12:41:35 -0400
Received: by mail-oi0-f49.google.com with SMTP id a6-v6so16671278oia.2
        for <git@vger.kernel.org>; Thu, 03 May 2018 09:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=H1/2oUx6s1dkMFLQHd513gsj1tU7Ika5Lcw6rYqbwcE=;
        b=IuYxMdfGRdVmPYK+S6D3ku6jSGTMUwVNqZMGpJZJv7PqjQVR1PSfcgAN0HaaOeCy4t
         +4PZOvRrSqw8jaWYYJO+6OmG/0dAXXIdCMblPgbSzade/rj2KRv4FkVV1ob+bZ7/qE3i
         zitHFmoPmnrott0h90srQZ+Hsjhn/J9VUmD4FCsm2N9yJ0X835jJOlogFy0XwfwrgreV
         3a90hX4WKmJGEzI2IUwafIVKYbvq/3p9DGv7RT6S2RlHhswdUdSbpDx5rwX8N/WNIOzR
         KRpYgQQI8Qh/u+M1CjRxYOnxhG5O++lduv8ZlJW1p2+2hMvY+e/R+iJ6vX05o+7x4Xrb
         LS6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=H1/2oUx6s1dkMFLQHd513gsj1tU7Ika5Lcw6rYqbwcE=;
        b=p4pQ9KohY86nX0lnoiFa1qWFpYljYI1suV0WBDiB+nwodIwVGYV+tKH9bQXanLvWTI
         2w9hmj59ZuzV6qAYvADWpyl7rb5qmJeTcDXEUf1q6R3B+uET/7gdUlGUXmqHM+5LQX98
         1IL0fEkRrLAi3hsEqnIpLTEVgUxKmEepBRReGSr0OhgDDxFgzyyAHODSPCfHAFBKhCK8
         jr0Fjh7+RKqg0ILl450DdomO94l6aHhe5KxdIBWFTM5ExUmDzXROQdZyZpeC0EdTCLAy
         ANI8AvJitJZZ6rtn8aP60tmUBCQ4UFrSp1LPxRoPXnCBk9R+k5b/hDLMa/ulHRILcFmZ
         q2Dw==
X-Gm-Message-State: ALQs6tC/PgakIdFx2O5CwGsPQVqgimndyvGjJTt4awVpjkQBZ86bK0Sr
        FE9+HiykeL2qFvA1KSGAocm0ncG4xhkXEe1CUto=
X-Google-Smtp-Source: AB8JxZoPzgCrZDsptuHDmtqWOH8gtwjbgqNfYY1w1eTiXZSmAVry8xDOMl+6ddin9F1X8lH+S+DnS8WkXe+glcj0rVk=
X-Received: by 2002:aca:1904:: with SMTP id l4-v6mr15376029oii.216.1525365694826;
 Thu, 03 May 2018 09:41:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.178.133 with HTTP; Thu, 3 May 2018 09:41:04 -0700 (PDT)
In-Reply-To: <8bc517e35d4842f8d9d98f3b99adb9475d6db2d2.1525361419.git.johannes.schindelin@gmx.de>
References: <cover.1525361419.git.johannes.schindelin@gmx.de> <8bc517e35d4842f8d9d98f3b99adb9475d6db2d2.1525361419.git.johannes.schindelin@gmx.de>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 3 May 2018 18:41:04 +0200
Message-ID: <CACsJy8DF8twvST0tcHfFqYWaV_0dVRCfJj-QuuCK=0h+gjJ0wQ@mail.gmail.com>
Subject: Re: [PATCH 02/18] Add a new builtin: branch-diff
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 3, 2018 at 5:30 PM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> diff --git a/command-list.txt b/command-list.txt
> index a1fad28fd82..c89ac8f417f 100644
> --- a/command-list.txt
> +++ b/command-list.txt
> @@ -19,6 +19,7 @@ git-archive                             mainporcelain
>  git-bisect                              mainporcelain           info
>  git-blame                               ancillaryinterrogators
>  git-branch                              mainporcelain           history
> +git-branch-diff                         mainporcelain           info

Making it part of "git help" with the info keywords at this stage may
be premature. "git help" is about _common_ commands and we don't know
(yet) how popular this will be.

(I'm not complaining though, I almost wrote "what witchcraft is this
and where can I get it" when I see branch-diff output mentioned in
AEvar's mail)
-- 
Duy

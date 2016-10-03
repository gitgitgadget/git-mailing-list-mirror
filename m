Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCDF820987
	for <e@80x24.org>; Mon,  3 Oct 2016 15:19:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751375AbcJCPTI (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Oct 2016 11:19:08 -0400
Received: from mail-lf0-f48.google.com ([209.85.215.48]:34563 "EHLO
        mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750991AbcJCPTG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2016 11:19:06 -0400
Received: by mail-lf0-f48.google.com with SMTP id b81so40053440lfe.1
        for <git@vger.kernel.org>; Mon, 03 Oct 2016 08:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=kYbfnXlolPd2qwQgwGPrqeFd+pGChYGHangNwCIemok=;
        b=a1IQr00H9z4JwqL0uA6y/1f0WbZFVqQlHZXzSMsFxRyeWQXL5pMqRoh7UvuAqK/7zN
         az6sSpO9qWW6f5apO+sT8iT6MYMsUAfa/M8pARipuV4VhWM2OVLiTJ5Y1nBiYwnoqsJ4
         RsYmlRMRH5QD+70vAq0OJ5oB/Kld4VQL85UTFZk9STpr7xrBRsnKgR9Cz7iMmp2WJHI6
         SXGnywZt2+Y9RQdT4esgzv7kYG1BGG/yT4gJmZ6MGY1+MSjOlUzTLdjW7VlrlSzRWNYY
         V7swbThQ50iL+OkDKQlcT0gzFjLRA/JYZMZh/v8Cw2EgtdMYe13XCzkZ9Dwo3rarty+i
         Stbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=kYbfnXlolPd2qwQgwGPrqeFd+pGChYGHangNwCIemok=;
        b=Lq2z29aCzbp2RLyf1va7PohDMTXgk1pn1We/NC44xPouNqe7nb1SdTQQuIyU/uaPzN
         KqYSjKzWC7HgxeelsqQQcvA3i+BXeCFLJ/aKYw/mCujSyXb0UKAgwFlxzPNF8LoJHKZ+
         H89ufDQj7+JVs3QZCgxhHTIOwoWy9AfOAHRmkAP2h609xQs6kJtjsetnqyLwwJhae6Gs
         id61ResaZ/9OKRKDu8/P+j7seH85RXpBfQ4EbLN/r6Mo4rofuVNUx6/DHP1PqkA/8tfO
         Vzm5dT0TsCCLMmLuv10hDLuJ2ivu7X2wKUmQYvlG9Gp3EvctFQmKnM3cJ7EfgDONG1tI
         PdEg==
X-Gm-Message-State: AA6/9RnRdPSQFT4XaQdizr/qqpz9baEvHlyMMlCq9MSAmcmJoFA9zjdJjHpTKGQVZQp/s5m2dPTZK2F8glMwyg==
X-Received: by 10.25.195.209 with SMTP id t200mr6063815lff.172.1475507944956;
 Mon, 03 Oct 2016 08:19:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.114.173.200 with HTTP; Mon, 3 Oct 2016 08:18:44 -0700 (PDT)
In-Reply-To: <1329039097.128066.1475476591437.JavaMail.zimbra@redhat.com>
References: <88486231.114620.1475474318974.JavaMail.zimbra@redhat.com> <1329039097.128066.1475476591437.JavaMail.zimbra@redhat.com>
From:   Anatoly Borodin <anatoly.borodin@gmail.com>
Date:   Mon, 3 Oct 2016 17:18:44 +0200
X-Google-Sender-Auth: XP9jDX6kdM_L2wfFLBbYKIEvJGo
Message-ID: <CACNzp2mANqmciMzvCahM_+=RnZYtU1SK9DRS2BmQru1fZY_wUQ@mail.gmail.com>
Subject: Re: Feature Request: user defined suffix for temp files created by git-mergetool
To:     Josef Ridky <jridky@redhat.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Josef,


On Mon, Oct 3, 2016 at 8:36 AM, Josef Ridky <jridky@redhat.com> wrote:
> In several projects, we are using git mergetool for comparing files from =
different folders.
> Unfortunately, when we have opened three files  for comparing using meld =
tool (e.q. Old_version -- Result -- New_version),
> we can see only name of temporary files created by mergetool in the label=
s (e.g. foo_REMOTE -- foo_BASE -- foo_LOCAL)
> and users (and sometime even we) are confused, which of the files should =
they edit and save.

`git mergetool` just creates temporary files (with some temporary
names) and calls `meld` (or `vimdiff`, etc) with the file names as
parameters. So why wouldn't you call `meld` with the file names you
want?

--=20
Mit freundlichen Gr=C3=BC=C3=9Fen,
Anatoly Borodin

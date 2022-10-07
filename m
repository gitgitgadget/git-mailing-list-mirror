Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46BB8C433F5
	for <git@archiver.kernel.org>; Fri,  7 Oct 2022 08:17:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbiJGIRx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Oct 2022 04:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiJGIRw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2022 04:17:52 -0400
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 921499D521
        for <git@vger.kernel.org>; Fri,  7 Oct 2022 01:17:51 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id s30so6015837eds.1
        for <git@vger.kernel.org>; Fri, 07 Oct 2022 01:17:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RdI2pCjK7H4BZ45kPk6jInLxlFWizMlCrGmKGtFeAUE=;
        b=MUwKvjF8dZCfXIEGe9Gw/rhnLJDB9F7kEFquJ8wx6HJkvWi0vs/amZ2m0hpvJwgoKv
         JHE+b9Bk1frA/eBeTWFAM7l7XM4hNPsJqAJLbtXTsXoqVIAD1Z/9WvYlq8HndHxu8lou
         kJOd4RvrcnKCyP2lSDCfSdxayoL47+ofkQ/zrvpHqxuR/yyEm0/jz1ajZnSySnI79pM5
         YVn4i7lVjTDYMlrWcyamsesiF/iqlfbxSNAYsJ/fFNNYhlbvjOoJ4V7WAtgiXBOvPWB+
         /wS0zrjRsfXVTaTZc5PtdY+ANkSjryCjMRvsyWoKbLPNMjOj5taiR3gDrQJpgVpoYtR7
         WiLw==
X-Gm-Message-State: ACrzQf1w4PM69eUVzdAAEgxs/f2qyb5K4MW3S+T0o1CbQrSJmxolwQNQ
        /JrBVWyUTzzEpmGFRkOcdMS1SEc8qbaEaSHpRKLJl9em+cU=
X-Google-Smtp-Source: AMsMyM4pJkfu9jOrrox4aXlbSrM3QbVqqfB1NXXRgq3cZwoljuboMUWHmn2KvWB592jCwKTnqezitZT0N0eAFALYvZs=
X-Received: by 2002:a05:6402:3786:b0:451:24da:f8c9 with SMTP id
 et6-20020a056402378600b0045124daf8c9mr3475666edb.250.1665130669938; Fri, 07
 Oct 2022 01:17:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAApTLm9DJW6zARsbJOCEcahkuLHA23tCF=rJ1Vy0J+kufBfTGA@mail.gmail.com>
In-Reply-To: <CAApTLm9DJW6zARsbJOCEcahkuLHA23tCF=rJ1Vy0J+kufBfTGA@mail.gmail.com>
From:   Erik Cervin Edin <erik@cervined.in>
Date:   Fri, 7 Oct 2022 10:17:13 +0200
Message-ID: <CA+JQ7M8c97GvNH6kXhjpF2BU=-5xFdcfaeLqtwBXX3nQn_J80w@mail.gmail.com>
Subject: Re: A possibly mistake on the "Git Commands - Setup and Config page"
To:     ddady <ddady1@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 7, 2022 at 8:12 AM ddady <ddady1@gmail.com> wrote:
>
> Hi,
>
> If i'm not mistaken, the path of configuring Notepad++ as default text
> editor 64 bit version is: "C:\ProgramFiles\Notepad++\notepad++.exe"

Curiously, if you look in the progit2 repository it appears it's
always been this path. This can be confirmed running
  git log -p --grep 'Notepad++'
in the progit2 repository. Perhaps the + characters are being eaten up
in the generation of the HTML? I haven't been able to try and confirm.

This is issue is probably more appropriately reported in the progit2 repository
https://github.com/progit/progit2/issues

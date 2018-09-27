Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D3551F453
	for <e@80x24.org>; Thu, 27 Sep 2018 16:29:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727587AbeI0WsE (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Sep 2018 18:48:04 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:47034 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727212AbeI0WsE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Sep 2018 18:48:04 -0400
Received: by mail-io1-f67.google.com with SMTP id y12-v6so2321610ioj.13
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 09:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Z66BLgaP1BG7aaSmtW4Ot0nMsPM46fpP7CN3YGL9d5s=;
        b=OQBvtEsOBfYd8ENjX7/tX6aNp0+nVerrVixAcM1lcxFRuM/I8i4iYR0N0EG/fYZmjk
         Blfo3esIsUcztOmjspsO5xi6JgWFVW1i9DSL1aRGAsv1nWawYzD/JlFjM6yMZ02dl/hQ
         ku9QMkOke0WudIXxLmLAG//UhHZzqefAno33KQKf3ZwW9xFkIuZes7Ho+2igy03Ft/Tb
         ugXIV9MjTf9sZ5vBeCEK/eJybJClz/C2G6ehaMplH2XYfL4CS0UpfZ0DyhAoglYD36t+
         pCIrTuc62URTqOLeFhtNEgoU5EmIMdr+sdUOLC5nQYtkTJpE5tQ2Xbez2Auy6dgIstGj
         Crow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Z66BLgaP1BG7aaSmtW4Ot0nMsPM46fpP7CN3YGL9d5s=;
        b=AUe8dI5bt4j/MfmZ4goO4r+OgKFvRU28Pkd07Qhwrmq3f9nZlixUBNnlQjg+eKmYX4
         DHG5SY2LTh6Pq8z9/fc+2cxpKzcGeHl4uE44ZEZGwIfV6Ax++0+0Fav9S1XkNh1hoSVG
         YuMDHUD6PU6U/vP+vtAR6+eIs8r+8JAbw/CrQjFxqJIj8JGTJJtHsor/gmluToOi09bd
         mMZR3CKoHdcO4E/QOJ9NnD9nMXC7+61g3CFsN/3zI4WaPpedIYcDz6fKavoZDNMJh6a5
         snBcCXzvM0fGA41aX3B6pot5e0z27xrxgP84LX6tK4zMPLFH0YxTlTFL0N0YkKZYNHU/
         e4tQ==
X-Gm-Message-State: ABuFfoggLRNnI2VcwCM3NcRZM9Rtgr/JhnSJYS91072sCXmHmOTDnkWs
        3diuHnODwW+wUhGoaE3SK+uom4832VsZbvNtUFk=
X-Google-Smtp-Source: ACcGV62ULhNJwup1CKWTaCoW6fAZp+i6RoxQdGN77NFj7EGQ+7MTRkfQBPvy/ybP8lOfZgGJqS4Ea1gsyqJ8DiGNA4Q=
X-Received: by 2002:a5e:d803:: with SMTP id l3-v6mr8602709iok.236.1538065740876;
 Thu, 27 Sep 2018 09:29:00 -0700 (PDT)
MIME-Version: 1.0
References: <87va6rhqup.fsf@evledraar.gmail.com> <20180927160523.GA112066@aiede.svl.corp.google.com>
 <87tvmaj4fq.fsf@evledraar.gmail.com>
In-Reply-To: <87tvmaj4fq.fsf@evledraar.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 27 Sep 2018 18:28:34 +0200
Message-ID: <CACsJy8BdqdRtCVHriniFhpFf0brESetZaFs_w3P3hZ+5xFBbdg@mail.gmail.com>
Subject: Re: Git for Windows for Unix?
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git-packagers@googlegroups.com,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 27, 2018 at 6:24 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> My only stake in this is I thought it would be neat to be able to "apt
> install git-for-windows",

That's what private builds are for (or "PPA" if debian has an
equivalent). I already largely ignore any Windows reports because I
don't know the differences in the fork. What's next? If a linux bug
report comes, will I have to double check with the reporter whether
it's GFW build or git.git?
--=20
Duy

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA56B1FC44
	for <e@80x24.org>; Mon,  8 May 2017 16:49:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752383AbdEHQtg (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 May 2017 12:49:36 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:35022 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752162AbdEHQtg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2017 12:49:36 -0400
Received: by mail-pf0-f179.google.com with SMTP id v14so35847237pfd.2
        for <git@vger.kernel.org>; Mon, 08 May 2017 09:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=HIZroZ+9AYLlVTez5ECx5PRoVtpwsfrvSP8FAWbYzbc=;
        b=TOTObIwMEe+XYeBxcvnyOTUSqHyVIeUzz+ojJaXDqt5ron8SeBa9HDsCLOCP6Wi/jV
         48ylNicwbAMMsTm/xQ+nLkGN6ZnBxzbzquQpbB3CrX831HViPVx2iU61cu9w1QpTw5HM
         PN5zA3f03d38GaRLrGPR8m8h4v2o3O8zxgNTjanptdg15AXfkkPCVcvSCqmQ5Gvnq57V
         Dd95LKGas3kbqs5OazQccdOnSzoxlnZpXnJBdnr+cDq6kh6LhNt1hl238AXKga0CrlpM
         TnFypjMV/FFJTn/UM8Ar9p8WzlVDAqCtAFxn55Kc645oCLmH3MKYOMFOOUh4A+El6IvN
         mOMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=HIZroZ+9AYLlVTez5ECx5PRoVtpwsfrvSP8FAWbYzbc=;
        b=JlbJ/OVKwYhjrgBirA6WmtoQrzxY/hkD4qmWkdbpay6fC/Who5pklBG5oyraFVZu0w
         4GqtnGy2gOl1ty9uRvAuNXIfIKmmvdTuT3bpMQnrGSRBwWTPy4/2uWut52FRzPCinDkp
         WPvBNlYgDSSCPMkLQr+jur88PYxJRapjZgGDWgOArIyBXBEu9SHxvWWoEcnMSDRI/Ozz
         1SOMebLcE3UPaxQvPMjq5WS9vVrkscdEz3B3TGQo5rF/0L969UzDz+Lm4/pPEYZeBFop
         VbbMs2QRxS4LZWssPznIOVM0UDf9CYMyn5Yfdt3RHJxjmopGuLlQkAQGeB/DqS9X02LQ
         GmqQ==
X-Gm-Message-State: AN3rC/6QAfqU/gFwGDrIUY00vQVrG/3VI/yUWZxAhDZcI2IqZqYbd3mO
        WxKdFESsMkwMtZxJRNfhsumxqlrYfxWCy0Y=
X-Received: by 10.98.213.194 with SMTP id d185mr32178654pfg.35.1494262175263;
 Mon, 08 May 2017 09:49:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.162.140 with HTTP; Mon, 8 May 2017 09:49:34 -0700 (PDT)
In-Reply-To: <f3bfb85c-1722-e720-3d36-40c29a692867@softcatala.org>
References: <f3bfb85c-1722-e720-3d36-40c29a692867@softcatala.org>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 8 May 2017 09:49:34 -0700
Message-ID: <CAGZ79kbtT6QCbd3-MpWiTm3r_cyBOLsa9kvd-KLNr8eEe+9v9Q@mail.gmail.com>
Subject: Re: Not translatable strings in Git
To:     Jordi Mas <jmas@softcatala.org>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 6, 2017 at 1:40 AM, Jordi Mas <jmas@softcatala.org> wrote:
> Hello,
>
> When translating git (https://github.com/git/git/tree/master/po)
>
> The following strings cannot be translated:
>
>  remote: Counting objects: 331, done.
>  remote: Compressing objects: 100% (213/213), done.
>  remote: Total 244 (delta 184), reused 34 (delta 29)

This is what the remote server tells a client, but the client did not
tell the server which locale it has.

Now consider we have hosting service that hosts projects accessible from
a wide range of users, all of them having different locales. Which language
should the remote speak? (Not knowing which language the client speaks).


>  27 files changed, 3399 insertions(+), 3320 deletions(-)
>  create mode 100644 build-aux/flatpak/org.gnome.Nautilus-stable.json
>  delete mode 100755 build-aux/meson/check_libgd.sh

These sound like they are done locally and could be translated easily.
However I wonder if we have issues with leaky plumbing in the user porcelain.

Thanks,
Stefan

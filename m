Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88DB61FF32
	for <e@80x24.org>; Wed, 18 Oct 2017 01:05:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758608AbdJRBFR (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Oct 2017 21:05:17 -0400
Received: from mail-qt0-f176.google.com ([209.85.216.176]:51615 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753044AbdJRBFP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Oct 2017 21:05:15 -0400
Received: by mail-qt0-f176.google.com with SMTP id h4so7560035qtk.8
        for <git@vger.kernel.org>; Tue, 17 Oct 2017 18:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=NHWplVQiT/iQJHp2nw5oXuw1+c4v8j3yQSvjoShaxTA=;
        b=SS8200FL6Cpb2ky4KdZKquY7zCmFwE7FbQMexPke31CL4R9NqTKZT5liskDERxd/yb
         Iv3/FKZlY9VBuMJHf5ZtltEFzJvF99BEP3trustoA9dDBwt3Ocg3eg++ZwUL0dEtxrtO
         Q69+a+BozLJEfMqkpxz4OrQLmgtpcAgS54HMfTDxOsMEn1JaanI3gz5u/YodyrkKCigm
         FQfAeOh2pOdHrWxWLWVkBlNbsCY11lR68VYY9xAVdSaPTQtosGgAgx7L1trbYuV+svFt
         GIlc8PO01nhxRkbjEvXEp5PWyXZFjhGIDPCJNDmTffdhEjogOCJRrtcRUnBiK+r5ugSe
         ZKqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=NHWplVQiT/iQJHp2nw5oXuw1+c4v8j3yQSvjoShaxTA=;
        b=MEY1BZzU7TMsYa3U/Rl+zkDBS1ON5WpJN1xs4rXt4ygnpS68PBxGsI9WVUPS9zuyDw
         7Hx2NpLwkItYtosk3YZ6CVGKO+ynwsfyh5GCcSbrKTnX8mlGEXYBgHu8wx2k0GkwA2M3
         SwT4kX9a0QVpVbPAucpEso9jDWpDhOtH9VjmjrjaugQbqeD8ppeF8W1M20AYimu8TY+a
         nIOap3YicBnnwmmjKiEsN83DiwGBFMF2xPCPWS8H9435n0sX4jEK8ObWXJPKtUNQ+X44
         O/UmkGW44KWF/G9Ef52D8ZawLieWMjQEiAmMbIOp1+7UdTylOt+z6BHCoPY46sT9HqVg
         83/g==
X-Gm-Message-State: AMCzsaXBXKVGBsS7tladcIcLhBGIhrmbWmMIGYdZyMcNrNFRrQjf1t6r
        nRQ58BcxDBbqrcuXs20399NSRyrauorjxMnC/w==
X-Google-Smtp-Source: ABhQp+QuvWQi+cbtHYrpnFtqLb35nE9K/GxMxaS59pqC3dT3L3VpMPtLApO/ywliM/WTnFIyaaXmNOPfOyLwat+DaYI=
X-Received: by 10.129.119.134 with SMTP id s128mr395346ywc.465.1508288714055;
 Tue, 17 Oct 2017 18:05:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.13.242.195 with HTTP; Tue, 17 Oct 2017 18:04:53 -0700 (PDT)
In-Reply-To: <xmqqr2u1l1ck.fsf@gitster.mtv.corp.google.com>
References: <CACjmu29CV_0HgmNaBmNLn-J4ZdUx+jRgweNSibBsB2SOZBWWEg@mail.gmail.com>
 <CACjmu28WBUZMyivR-uvttMURSEtVuCUaYHdtT0mpv4LAffOd5g@mail.gmail.com> <xmqqr2u1l1ck.fsf@gitster.mtv.corp.google.com>
From:   Gilberto Stankiewicz <kiewic@gmail.com>
Date:   Tue, 17 Oct 2017 18:04:53 -0700
Message-ID: <CACjmu28kdmBpe+0nrwWnMWV4fUkZgm3yvJjxsYwj61kq9CegVA@mail.gmail.com>
Subject: Re: Fwd: Has git-gui repo moved from location?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Weird, it was not working for me earlier today, but now it works.

Thank you,
Gilberto


On Tue, Oct 17, 2017 at 5:57 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Gilberto Stankiewicz <kiewic@gmail.com> writes:
>
>> I am trying to clone git://repo.or.cz/git-gui.git as described at
>> https://github.com/git/git/blob/master/Documentation/SubmittingPatches
>> but it seems the repo does not exist.
>
> $ git fetch -v git-gui
> Looking up repo.or.cz ... done.
> Connecting to repo.or.cz (port 9418) ... 195.113.20.142 done.
> From git://repo.or.cz/git-gui
>  = [up to date]            master     -> git-gui/master
>  = [up to date]            pu         -> git-gui/pu
>  = [up to date]            todo       -> git-gui/todo
>
> $ git fetch -v git://repo.or.cz/git-gui.git
> Looking up repo.or.cz ... done.
> Connecting to repo.or.cz (port 9418) ... 195.113.20.142 done.
> From git://repo.or.cz/git-gui
>  * branch                  HEAD       -> FETCH_HEAD
>

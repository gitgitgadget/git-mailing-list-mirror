Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30FE8202A3
	for <e@80x24.org>; Mon, 16 Oct 2017 23:02:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755409AbdJPXCe (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Oct 2017 19:02:34 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:50261 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932440AbdJPXCb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Oct 2017 19:02:31 -0400
Received: by mail-qt0-f195.google.com with SMTP id f15so35168154qtf.7
        for <git@vger.kernel.org>; Mon, 16 Oct 2017 16:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=i57onrr9LH9hrJFnVOESt96ZjHrw0WSzGluSw38K1D0=;
        b=gy+5qy6OWTHmm/cWnB8Gz9PJ0MeVabF14uksk/pWANdGno0sG0QqZWHCNGwWcbuUm7
         x4JmOiyrcg5jCdN5p2zhAMdK2OGOGp2XzqoSZ43fT9L3OA8ibKcUv9GCEGslJycnkRfW
         5oyngbCdOxyV9yg4efjByfh2agoUZhPRsET9XWBJS0k4KBH0m2mwC8NnX2UM8DxFMuQ5
         oF8sXZVnVwJ//qTPk8h5+GIpH5FNrNgjd06elg094u72V49MH1iAG4s88YYfsi6XAQGA
         UtFYKF8gvX7LFkTaGcGIC03rc5tIXeLp4YHM+14OdUtt/o8mv04vf18qrrpBNs+YBm5/
         Pvlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=i57onrr9LH9hrJFnVOESt96ZjHrw0WSzGluSw38K1D0=;
        b=fOn9ksiME7rcUkQfjHYcr+VmzH5uWTEATuSuSG8pTtSD/r13oreQ23lmPnAtny9CIO
         qqGkRH52H4p/1kz1UqBvetj+jx6xzL1OYh6a5ZlMc17EAEdUHt6ibgpWcLZpWYJuaI9C
         hw2jhMCC3EMoyK0ayT12f37KnCjqRK53UowdM79+dAsZOQWn8+Xgm7MAwRSimvf2RPN8
         HFljuHkkdz8adooDOqjOVMbScqC3zy8atQceQjfiMvpYZShHf+pPfPSUzqbzBhFQfn/m
         /Dy3zDIg/NoH72nyq7Cba33NDqsemgDuY1wTQlaKP3VsdP7q8aXnPGJ2nGPtADMos9U+
         9teA==
X-Gm-Message-State: AMCzsaUlA80LCFF97cxxEd685SIr/PX4UnujH/AAxi53Z7fdMvI4YcJ/
        X91CDQUqw31IYfvJGSXgqyh3dYLFfsRG2xuqt4s=
X-Google-Smtp-Source: AOwi7QCczvKCmab04UbL97Wf3pGlYf7gKdvu/t62S/clN1bdI0whjSwNXkFdT/kV2tyFsChOsrITedagfPfAslU0Bo8=
X-Received: by 10.200.43.252 with SMTP id n57mr16661858qtn.141.1508194950270;
 Mon, 16 Oct 2017 16:02:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.160.36 with HTTP; Mon, 16 Oct 2017 16:01:49 -0700 (PDT)
In-Reply-To: <33f7d379-126d-e27e-7dbf-616f5dfbc98a@kdbg.org>
References: <c6b52120-98bf-d685-6dc0-3c83e9e80d30@kdbg.org>
 <CAGZ79kbr=zBc5GEL7hYyCnBcbdE8ZRp65QwxKMUVsQ+qXvRAAw@mail.gmail.com>
 <3d362037-3eb6-83db-a17f-47a984135580@kdbg.org> <87wp3zs4la.fsf@evledraar.booking.com>
 <33f7d379-126d-e27e-7dbf-616f5dfbc98a@kdbg.org>
From:   Rafael Ascensao <rafa.almas@gmail.com>
Date:   Tue, 17 Oct 2017 00:01:49 +0100
Message-ID: <CACUQV593kzMrtc4ENgD=6bBQcn0DXGRcyB7teCvGWk_QNtS98Q@mail.gmail.com>
Subject: Re: [PATCH/RFC] git-post: the opposite of git-cherry-pick
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> This is worth discussing, though not my preference. The picture to "pick
> cherries" has become quite common, and now that we use it for the name of
> the command, "cherry-pick", the direction of flow is quite obvious and
> strongly implied: from somewhere else to me (and not to somebody else).

What if we borrow '--onto' from rebase and make it cherry-pick --onto
<destination>?

This would keep the "pick cherries" analogy, but add the "they're not
for me" intention.
It also carries a bit of the "transplant" meaning of rebase.

-Rafael Ascens=C3=A3o

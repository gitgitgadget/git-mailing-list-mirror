Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25CCE20387
	for <e@80x24.org>; Thu, 20 Jul 2017 11:50:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935394AbdGTLuj (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jul 2017 07:50:39 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35776 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934812AbdGTLui (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jul 2017 07:50:38 -0400
Received: by mail-pf0-f195.google.com with SMTP id q85so2276252pfq.2
        for <git@vger.kernel.org>; Thu, 20 Jul 2017 04:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=inba5GKFeCrpGd+wXiMvLbDpzGjzD00/dK8s3Tot+y4=;
        b=H3m+LIxPln//6+ZkYAP/1Lg9SlwqEA0kvxSODhwvKcYF0cgjAgWHj6EA9BgIfnTlEf
         1r+nM2vfAvP679vzyzq/InV/lZAV12wcAfCBVGMe/IPKfb54uuXieZSmqOd9fC+syJ/Z
         N8SljVrEx/PfWzB6TWmdZXSdRE7XTVc12W/JjAkdIpUNBhOFJUXOs2xJj3s0B8wF+Nlt
         nwOwcf6el7DqAv0XouR5qIz28cPi5MAkl3Rn0ArlZbZy+yRhTO+HqvWWODtkK0XY7dSC
         jhLz+RzBk4Da4oiXDpnoQ6psFG5J72f5tpejGmY/tWeH8INxTMjdPONfJ25/dfGKYmm8
         eRPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=inba5GKFeCrpGd+wXiMvLbDpzGjzD00/dK8s3Tot+y4=;
        b=YoaMYTaQ6/oK3FnDB4wBwFCcS5MoJDvyzZLiCkGRi9f3Y0aTIJbMNrnkjnafOC/sU2
         LdltiHZUKUadv/2dK4GvtDCPglDyBp9PZGY4q5kDjNIwtJCEyCtgalHKjbkpzOxlgKF3
         MEqVed7flr6n1SsD58E3CbpCyLA5gO6IC1klJfiCXbmGnGRD8M8ibPgjf5QVLXHJ6/DX
         cuM/TgYfAYgSqVmhUHDl0oDpgoXTKa8fRtMS/bY+RKhBucFNp3lP1NJZmF/RwFN9pFQr
         6ZEznUzcqVWdQOXeLp729ZY1RqE7vksNdnPgUbMAI7qAeUOJfg2TBztwkIrWG6WumFWA
         /7Dw==
X-Gm-Message-State: AIVw11175v9qeCChu3amUfFTw9DePnYKA4+drOQaAMGnY8RGTVymSjBh
        PBx7CwOLjaSXwtz3Kgn2fgOIvCp/HA==
X-Received: by 10.84.209.232 with SMTP id y95mr3897429plh.337.1500551438157;
 Thu, 20 Jul 2017 04:50:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.163.102 with HTTP; Thu, 20 Jul 2017 04:50:37 -0700 (PDT)
In-Reply-To: <59370040-020f-a5b0-fbd1-677e46d382b3@gmx.net>
References: <55629eef-537e-e5b6-c0dc-6e3372d00b33@gmx.net> <CAN0heSoJVf4A=92GPwFGUL0uoqWK3eY89+uCTirVzSYHHhfwwg@mail.gmail.com>
 <59370040-020f-a5b0-fbd1-677e46d382b3@gmx.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 20 Jul 2017 13:50:37 +0200
Message-ID: <CAN0heSqsn-XGgZFxc+kLiBPSdzrtqg6JR4_g9062F+jZmLu0Bg@mail.gmail.com>
Subject: =?UTF-8?B?UmU6IC0taW50ZXJhY3RpdmUgbW9kZTogcmVhZGxpbmUgc3VwcG9ydCDijKjirIY=?=
To:     Marcel Partap <mpartap@gmx.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 20 July 2017 at 11:20, Marcel Partap <mpartap@gmx.net> wrote:
> So the readline library powers the advanced line editing capabilities beh=
ind f.e. the bash or the ipython shell. Besides navigating with the cursor =
keys, it provides a history function accessible by the up cursor key =E2=8C=
=A8=E2=AC=86 .
> At the moment, git interactive mode seems (?) not to make use of it, so t=
here's no line editing at all. A typo at the beginning of a line must be co=
rrected by reverse deleting up to it, then retyping the rest unchanged. Wit=
h readline, the home/end keys for jumping to beginning or end work, as do t=
he left/right keys in a familiar way.
> The history function comes in handy when f.e. repeatedly using `git clean=
 -i` and feeding the "filter by pattern" command a string like "*.patch". L=
ike, that's the use case that prompted me to write to this list. : )

Ok, I see. When I saw your first mail, I was thinking about "git
rebase -i" and thought, "how could that possibly help?". :) I have no
idea what it would take to implement this (portably!) in git.

Martin

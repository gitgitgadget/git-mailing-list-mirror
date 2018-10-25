Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 868251F453
	for <e@80x24.org>; Thu, 25 Oct 2018 15:44:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbeJZASD (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Oct 2018 20:18:03 -0400
Received: from mail-ot1-f46.google.com ([209.85.210.46]:43829 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727350AbeJZASD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Oct 2018 20:18:03 -0400
Received: by mail-ot1-f46.google.com with SMTP id k9so9561042otl.10
        for <git@vger.kernel.org>; Thu, 25 Oct 2018 08:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=sBf8OIZWH7ZQkYkIK3wlAPb/Kn4J0GayjLw8qHea+Jc=;
        b=rH2aCRluIAPjqtBZST8exfYxkfp6ucC1Yynwx3CkRnWLnPsh618GCR35Csju8HnNU7
         t6Z0s1YtpFQT2thCYPlovx/6JKqwbkF91LlEqYALq0zK8cIle2lrd13I0oerBjKSehPm
         n+5sE5DZxVQYy4N3OUDK1JgxpFFvW3MnBdpx+mnGzNvPPs713/R3cIPr+9xZJ0OSJTUw
         vGwfGkaurdUXWD4Bi9d+81mRaC5vG8Zh9Fzri9y0bhhlpxvOWwdmcb2SI96H9T9QdFkz
         BYrUyjX/qo93aoHtAZmk6rq7CKbu7HNnYbP/hLm2bd6B/5VEOp+dpVb1pDihjkns9OBt
         dVjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=sBf8OIZWH7ZQkYkIK3wlAPb/Kn4J0GayjLw8qHea+Jc=;
        b=BrO3oeiliR3fD7xhZTkFsDc4ba6AQUQWO0kUm9PvjfvZiTjSaNfz3VHLinsckRCyJH
         3suAm8h1UojqYwmdFHiTm79hFeDZzVFPSyXZfZdlOG+/GosRz+3WVS16JlP2AfkErKc3
         foVDdsQYPd+25hrD/2RX8vxmWvfFCjqELRkNmBqtssYAwhLo5QeHX093rR9y9/gK3i9P
         JcdxPCXjizwABgi3VL4C0ngOPYHhzxZHDZ6KAelj+xzlulzx3R6rRolnPVw0Ns/fyVOu
         lB8gFrWgvcC+XBOd77cUboyFWn6VqU5QAuwjoskle4UipooNfI+3Egg27oZgd3NdcEnc
         feuA==
X-Gm-Message-State: AGRZ1gKnJol4lt5WXsMzmDaSgS8s1H4c6R22BFA/8BCgzcfZQlHK6Nu7
        J6zX5M3Jeudlhd4cDpa3GQOPDk+q2FyhSHlbuYLDoA==
X-Google-Smtp-Source: AJdET5eyS+FNqNAPvG7hECUT1c+IrmQiL3YsTgspODaXoknwYypi44ippNdSXkud6ncfPWV1uKfKmEaIPbBdbVSR8Fw=
X-Received: by 2002:a9d:4312:: with SMTP id s18mr1663523ote.347.1540482282906;
 Thu, 25 Oct 2018 08:44:42 -0700 (PDT)
MIME-Version: 1.0
From:   Matthew Orres <matthew.orres@gmail.com>
Date:   Thu, 25 Oct 2018 11:44:31 -0400
Message-ID: <CAKbB5OxCv6nxZJm+i+SjZK2LjBowLctxFhfo3vhO9mxfkVMa=g@mail.gmail.com>
Subject: Git Gui on OSX Mojave Dark Flashes on Repaints
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On the newest version of Git available via Homebrew (2.19.1), when the
gui tool needs to repaint the screen (refresh a file, change a focused
file, stage files) the window that is repainted flashes a dark gray
before returning to white. This was not occurring on High Sierra
yesterday, but has occurred today. I believe it was occurring on an
older version of Git as well, but I updated to ensure that it wasn't
something that was already solved (it was not).

I can provide more diagnostic data if needed. Thanks!

Matt

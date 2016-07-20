Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1154920195
	for <e@80x24.org>; Wed, 20 Jul 2016 04:16:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751924AbcGTEQH (ORCPT <rfc822;e@80x24.org>);
	Wed, 20 Jul 2016 00:16:07 -0400
Received: from mail-io0-f169.google.com ([209.85.223.169]:33693 "EHLO
	mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751596AbcGTEP1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2016 00:15:27 -0400
Received: by mail-io0-f169.google.com with SMTP id 38so37407421iol.0
        for <git@vger.kernel.org>; Tue, 19 Jul 2016 21:15:26 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=v0a+r2dp/JoU3RUtXJnYJQJxPhwxvuedi85MUJXLXyc=;
        b=Yr3UF4ITav2IlsBJblz3SmXnOkyL+okxMcuVO3Z9+Vwi7SWsP0VONB1S3HBjAT84tK
         p9yRoJvlLC8QGS1u5TYGsHcFJOp9ZSICikoQRlZDQNOK08G1XY8vmN5+JwjyYT8QqCBi
         jY13OchqDIEFFLOepqFIIhbBNH40T2XlZ/72WAOU7JEZe0QBDvoRDQX+oyyIpw54+WSJ
         T2GCaXOyo1bBhZw5xkT2nxzmZydVkaL3+mEgfjRJydvacaNZHb71nuio5x+QdJJTkIcm
         w5xnVEfFgvcrgsWsxGu4lQi29eGzkofWp69+97nGaE4AZjlhLfQjCl2FPCaSHTiuxiMv
         ikhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=v0a+r2dp/JoU3RUtXJnYJQJxPhwxvuedi85MUJXLXyc=;
        b=jcuACzxv/riTC0+Z8zHRFpawAK5ZcX2eRHpR25n8mDmxhh3qEPGIZ/MVIRGFCZIkPp
         CMDoon4SAyfJN+fHmCIKo3v78yfGRH8ilT9C1UHio4Cz8FTPIgCY0wOyfwcHomgdLyt7
         TYxVG/PA2gOKP9+raNEIMZgPsm9yc8wDwNk+6vLCMrwoRefedj5PuWbPO07NTEZ7Qy4q
         ozHdCUT5K9T1qo9y04cTXIpvtA8SyL6Rlc4D1OCmXtYjorSCfSBYRhS76XbxK2vfeaKU
         vfIG8P6l3ZhsN6LODEpBBKkMLMasDYiJnxr/vy3ZtiK5wKXIDKdfhWLobppDRK/TwaW6
         MBKA==
X-Gm-Message-State: ALyK8tIBxgNnUAlQhk/ZQYikIns4quNSgOR0EIol/eSw4NjQ3Ps9TdQnGcDhz8DnrfqhVbNnN0GcVihweCI5tw==
X-Received: by 10.107.8.140 with SMTP id h12mr44560499ioi.95.1468988126320;
 Tue, 19 Jul 2016 21:15:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Tue, 19 Jul 2016 21:14:56 -0700 (PDT)
In-Reply-To: <005DA57F-8976-43A1-B833-D5EFADC75BEF@gmail.com>
References: <005DA57F-8976-43A1-B833-D5EFADC75BEF@gmail.com>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Wed, 20 Jul 2016 06:14:56 +0200
Message-ID: <CACsJy8ADRWNL3FR2TtWShviT4Lc4m1xaY8VOPP26Foyq+_A-3g@mail.gmail.com>
Subject: Re: Current state of Git worktree used with submodules?
To:	Lars Schneider <larsxschneider@gmail.com>
Cc:	Git Mailing List <git@vger.kernel.org>,
	Stefan Beller <sbeller@google.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Jul 19, 2016 at 10:59 PM, Lars Schneider
<larsxschneider@gmail.com> wrote:
> Hi,
>
> some time ago Michael wrote in a blog post [1]:
> "It's not recommended to use git worktree with a repository that contains submodules."
>
> Plus "Documentation/git-worktree.txt" states:
> "Multiple checkout in general is still experimental, and the support
> for submodules is incomplete. It is NOT recommended to make multiple
> checkouts of a superproject."
>
> I wonder about the current state of this limitation. Is the statement still valid?

Yes.

> If yes, do you know if someone is working on this? If nobody is working on this, do
> you have some pointers for me what the main problems are?

The blocker is config file being shared (you do not want to share
core.worktree and submodule.*). I made some progress last weekend,
just needed to add some tests to see if submodule works as expected
and will post the series soon. Then you can take over if you want ;)

Note that I only try to make submodules work with multi worktree, not
work optimally. A more ambitious goal is sharing submodule repos, so
you can keep disk usage down...

> [1] https://github.com/blog/2042-git-2-5-including-multiple-worktrees-and-triangular-workflows
-- 
Duy

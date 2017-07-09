Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42DC8202AE
	for <e@80x24.org>; Sun,  9 Jul 2017 15:57:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752236AbdGIP5h (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Jul 2017 11:57:37 -0400
Received: from mail-it0-f42.google.com ([209.85.214.42]:35661 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752146AbdGIP5g (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Jul 2017 11:57:36 -0400
Received: by mail-it0-f42.google.com with SMTP id v202so14940140itb.0
        for <git@vger.kernel.org>; Sun, 09 Jul 2017 08:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to:cc;
        bh=c+NYlrrwbCq0LnVhqPwiItnxnAhszg2/NpZAIP6viq4=;
        b=NlnBAvjwJrvplFgV/ZDDhZSQJIOQs1qwwiU52RC2hGFZVEEWxrNpibLU2n1Y7/xm12
         KKfDz+V1t8oSIsmrjLvUEN6/gUI9KJQUshwF8rsZxtqkMGzmViIogs/9WSi/o4WUAIb7
         Eo39P7D1kA8Bca+25xP21cjVIexD0PO0EPkUqsZzLPJ/VM2dIQ8SRhQV/HlOjNjzHvE/
         Mc48GcwGfExs34mioiivt8tx/xnUsFD746NxRvLpihGA4uZ3n42KYHpfbELiI9EEkLqW
         GVG5WTsq0VjHv6IkE+G/iel7nDrrw6vpsSlh3qX/8BtAa2Xu+WJd6VMSjuDLmJfdzm9F
         l6fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:cc;
        bh=c+NYlrrwbCq0LnVhqPwiItnxnAhszg2/NpZAIP6viq4=;
        b=OeLQaCmX52mB1zlUOGUu0qbw77Y/7GTzR9zovSS512J5vhkD804BNWERn24nFG5h33
         WpUIfsuuLuMSZgTqwZDDUcffZ4jLoTeT8uY4duAB09f8kFqicH8Y9TmdPGtPMjX41lsH
         0qrzq31USD/ThAMdAInsao4f+xg7/1hDsta/oymE5LDe/Ykzu9mSjNj6bvtOOCDcseWn
         IW/TUReHWpvLZij5eg8AChag8vd1MuBsFeiI91vwIWzdlkk+LdPJOBdkQM+RpCIXisGE
         kGw6jHqwE2Kl6F0rEuwIpKHh/6oMYNlzCBnGThvgxWHbzTh6P5KPcnA4iCISLdB1E1Qg
         X+OA==
X-Gm-Message-State: AIVw112ciS+5tET56fi5/M8Yb61Kb/fkD+F4KWySW2AanidJIW3JoV2Z
        nWi7v8cjG4FpoyYcY/iasqC6fEtspw==
X-Received: by 10.36.181.16 with SMTP id v16mr7498542ite.6.1499615855608; Sun,
 09 Jul 2017 08:57:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.38.138 with HTTP; Sun, 9 Jul 2017 08:57:34 -0700 (PDT)
Reply-To: SLONIK.AZ@gmail.com
From:   Leo Razoumov <slonik.az@gmail.com>
Date:   Sun, 9 Jul 2017 11:57:34 -0400
Message-ID: <CADsUFkTgw5AGUafuBDEqRAUgzJeMZnQ1RL-_mz-QfiB=SV-xfA@mail.gmail.com>
Subject: Re: git-2.13.2: color.branch.local problem
To:     Jeff King <peff@peff.net>
Cc:     Karthik Nayak <karthik.188@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 9, 2017 at 5:57 AM, Jeff King <peff@peff.net> wrote:
> On Sun, Jul 09, 2017 at 05:28:34AM -0400, Jeff King wrote:
>
>> On Sat, Jul 08, 2017 at 03:13:04PM -0400, Leo Razoumov wrote:
>>
>> > When I updated from git-2.10.2 to git-2.13.2 my 'color.branch.local'
>> > config setting gets ignored. Corresponding 'remote' or 'current'
>> > settings are honored and work as expected
>>
>> Looks like this is a regression from the switch to ref-filter in
>> v2.13.0; it bisects to 949af0684 (branch: use ref-filter printing APIs,
>> 2017-01-10). It looks like we don't ever use BRANCH_COLOR_LOCAL. The fix
>> is a little tricky because of another nearby issue. I'll send out a
>> patch in a moment.
>
> Here it is. This is intended for the maint branch.
>
>   [1/3]: branch: only perform HEAD check for local branches
>   [2/3]: branch: use BRANCH_COLOR_LOCAL in ref-filter format
>   [3/3]: branch: set remote color in ref-filter branch immediately
>
>  builtin/branch.c        | 15 +++++++++------
>  t/t3205-branch-color.sh | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 53 insertions(+), 6 deletions(-)
>  create mode 100755 t/t3205-branch-color.sh
>
> -Peff

Jeff,
thanks for a quick fix!
--Leo

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54D8320188
	for <e@80x24.org>; Wed, 10 May 2017 14:47:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753019AbdEJOrU (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 May 2017 10:47:20 -0400
Received: from mail-oi0-f49.google.com ([209.85.218.49]:35408 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752037AbdEJOrT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2017 10:47:19 -0400
Received: by mail-oi0-f49.google.com with SMTP id l18so38180254oig.2
        for <git@vger.kernel.org>; Wed, 10 May 2017 07:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=L8vfPRaVXvORpUhRUEeUGCB3E+s9UsXXri+UpPpA+rs=;
        b=gPHdupypPzdhHSSZYKjsGR7PfLNzGJApefiGyTq4v156W50GdeSo5MQ39/8Kfa1LsZ
         fsM/WG29eEOPt4Kbs99kCAgU58sBilzDyaUusewMcXUv0n0jHCJsEYlTBxUeR6rEJ0MR
         0muAZo5DU4UP5a+3HaV+cKWuKeJY8rolRTS2VZriCZjtbigzlFzI38grXDDaIr/cB6xY
         4Rx+FMZYbjBkusiXI8eG/SCISjgH1yqZml3PfftWY/t3U8QnELcmRMOmeh3pKKMo4tC8
         +vlr6LD0fhZh+AMz1rVQccEnVvSU28PoEYRaARXdCB8odZTLb2NyBLosAlh357IqmA5U
         kRmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=L8vfPRaVXvORpUhRUEeUGCB3E+s9UsXXri+UpPpA+rs=;
        b=lJDbfPF7fITemgIQjLpuLQUV/yeK5LxVjggOx2kX8c7P8S/9DXAoF8m+EBXANy7TQ0
         3V3xWMOo/S4W8tibDh4oKfDraIyEZ40rnBUpm1Ne2afoBnJ1nlt0I/j+63tyU7yge3ZL
         ayo/mT5GGDJq/uwStTa69J0CsHsuwtn8g5fFu9+Nbd7k6G1gjiWBLeiP2pmw0GUwH4sf
         E+XqgDgPdjzu/sXG3ngTxPrhdFcJI7Ze3I3GC6h1x7RN3V/Pb1uCwxPojl71CEsL1ZKi
         3JswWfOnncw7BXQ8Hc24G+fqRyB2boV0A11w4POCjtyUbiNbWs5ko0hh4GnKrdsAH9Bc
         hmpw==
X-Gm-Message-State: AODbwcBoueU4ojwWXvG1ksD3qhbXwcgWAaDtbg34GjOr+xUN+LjHlMu+
        bYPgPMnAzzqSBrr0u9ABVxuUa/WZ7rkI
X-Received: by 10.157.82.87 with SMTP id q23mr2512346otg.52.1494427638752;
 Wed, 10 May 2017 07:47:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.202.90.85 with HTTP; Wed, 10 May 2017 07:46:58 -0700 (PDT)
From:   Jonny Gilchrist <jonnygilchrist@gmail.com>
Date:   Wed, 10 May 2017 15:46:58 +0100
Message-ID: <CA+qhfwO4=1X9fNCW2PeKSgqUHV-z26qhvr_yXfz1QGApJ_roRQ@mail.gmail.com>
Subject: git log --follow after subtree merge
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

After doing a subtree merge, using 'git log' and 'git log --follow' on
files in the subtree show only the merge commit in which they were
added.

After reading around I understand that the issue is that git log
--follow doesn't track renames that occur during a merge.

Has there been any work (or are there any plans) to allow git log
--follow to work in this case? I couldn't find anything in the mailing
list archives aside from a couple of threads from 2011 explaining the
issue.

Thanks,
J.

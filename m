Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7041A2023D
	for <e@80x24.org>; Wed, 17 May 2017 01:06:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751866AbdEQBGP (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 21:06:15 -0400
Received: from mail-it0-f52.google.com ([209.85.214.52]:35883 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751845AbdEQBGO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 21:06:14 -0400
Received: by mail-it0-f52.google.com with SMTP id o5so72811109ith.1
        for <git@vger.kernel.org>; Tue, 16 May 2017 18:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=i+a9+UCMbeHcPGlzNvYDjHAxytJtSDEsJ0PRFZGJVHk=;
        b=H5gQ0qS3ZxTURLxz9ttWQ1hqk1bOaEROG4QUVO6wOKrhxLzLBnh2RLv4U+caBktlRX
         i6mMBzjTXW6+kwR+ukN7XzL7a+DqTJ4y2mmB0OvbyJOai06zq9otSx75Io053hL7ints
         dtsXsXjisLXaQeCVwjYAnUyo0PvPFWFL7Ez8sJaHJvJNtEU3Ty740TeT/zUV7B8/6sw7
         Ub+I3AgzJ1YuvxRDn8UIcicfYVboOValJAngyYGFkCoYOgHFYaAoEBwEriOAJYVHvKg0
         nMeMk57UaSq1wrf4MERJp0PWr4OXb1Zrh+75D8IOofVMErzsauNoXH2P713L+gE5Bvce
         SG/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=i+a9+UCMbeHcPGlzNvYDjHAxytJtSDEsJ0PRFZGJVHk=;
        b=S1fQZ2gUoDAWa/Zg6nUXcvFZzIZZlsvslUN1YERwKRlIWee6Urt0f5UvJdzmKfACNq
         wqkZO0ykwO5SmKWMBSgz8w172GlC4fwOEnpUEpCreeJuxq+Q+48Fv63vjlfVz/S3P1W7
         6RMaX46htM2EBAxwgnh+yHaJaK6bJyMeG+03IJR4B7YSroNeDXdgmoviS07Qj6J9pxdC
         iuY9PHdvb2viFuUqt3h6g2PZ7WrU1bModFC6N04Elge+cAL/Xpobl9gylAdQJ+c2AeYD
         b49jOufEAGzOO8K0f1qcTeNH+TqJIQZFp8+l2lTOHauEuxbKGd90XNhaZ6K30P8HOjbL
         +j1g==
X-Gm-Message-State: AODbwcDdK/wJyDpVzhWyb6bwqb5lCV6DeluRmHitaHo6xhmlBLuBpbG8
        btExH3q5hokEkF/J97mO1gg0KtmMzQ==
X-Received: by 10.36.210.193 with SMTP id z184mr1634270itf.86.1494983174053;
 Tue, 16 May 2017 18:06:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.150.90 with HTTP; Tue, 16 May 2017 18:05:33 -0700 (PDT)
In-Reply-To: <dbbf2f82-8ef3-2411-d51f-63f94ba7e77a@gmail.com>
References: <dbbf2f82-8ef3-2411-d51f-63f94ba7e77a@gmail.com>
From:   Samuel Lijin <sxlijin@gmail.com>
Date:   Tue, 16 May 2017 21:05:33 -0400
Message-ID: <CAJZjrdUXoa8EXYfFzHqn2yrUdidwdPSoEJ8_AFwwAX3ORr59UQ@mail.gmail.com>
Subject: Re: [fixed] error using `git mergetool --tool=meld`
To:     Matthew Groth <mgroth49@gmail.com>, davvid@gmail.com
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 16, 2017 at 5:55 PM, Matthew Groth <mgroth49@gmail.com> wrote:
> I needed to use `git config mergetool.meld.hasOutput false`

Hm, that's interesting - the source code snippet you quoted from meld
implies it supports --output. What version of meld do you have?

David Aguilar seems to be the one who's contributed most of the meld
code, perhaps he might have an idea about why this is happening.

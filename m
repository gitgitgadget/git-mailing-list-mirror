Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 360C91F461
	for <e@80x24.org>; Thu, 29 Aug 2019 17:56:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727688AbfH2R4J (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Aug 2019 13:56:09 -0400
Received: from mail-wm1-f46.google.com ([209.85.128.46]:50605 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727228AbfH2R4I (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Aug 2019 13:56:08 -0400
Received: by mail-wm1-f46.google.com with SMTP id v15so4655607wml.0
        for <git@vger.kernel.org>; Thu, 29 Aug 2019 10:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=continuousdelta.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=aQCcF+AWkKg8iGo+x5/yMSzfP4dRugXArAUro+cBNmE=;
        b=EVccm4vmTtAz768liArJ6nTOrK0irrpqmFg/y9VgaYgYGhBLRNtjP2PuJhGoLRB6qa
         4MLemOEVI5m7n7hz8SOmIxoFNC/1kxloChX78kHqRdfGZ/TDD6Yup8ck9e9ZoVdgPDS8
         IIX1jgXdzXoyqIWuOMgsOQRXvds8uDIY6B2HnMuVL1J1MudXPkvZp33EZJk4YUvBVkPR
         bXXu9C0qCYp7TQgjJykWxSeSHUtKbqbJVpHwVOh1k9QIq4+z6e4AxXbba+hkMCdg8aY9
         2+aytWDaBI+AxxCE5tzGI4yi32FL8RmdG2DJTvhjhnG/npBQKb06gtVII5NXBvOdjyqo
         Pjjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=aQCcF+AWkKg8iGo+x5/yMSzfP4dRugXArAUro+cBNmE=;
        b=Qj7I9j9YgcywBkX83itv5nkyA6LoTaL+P5Ci8p9NMFJs8XkG1U7/mXHkSxPK50Ff87
         KLvMBqBtU6PlFnqET+sqpqLBvJ4tLrx/NIk2RcuGJroJvJMq60503sDCaTgU2AkWD678
         LVUgIqH/mGu5d06Ihcaj1GO2+E7RgQnpsRHf2r9jy82uFkF6rMPAVTpCjgYH4ke69L22
         PsCyihHlKdWVxIxvdsppv1riV8Cs1YVuFzqC6BjP1DMJCshY/WnPveM2pgzQbCKdfYyC
         LGpz35n6siXd8UsC0pIfYsWz5S5nFnS7suX5gtRhb7OEMZZHpUkl2i4jAkOqkxkz0XF8
         yROw==
X-Gm-Message-State: APjAAAUITiiLlfY7VbscyDB6s8yhVNFbm0QhXmzyfDfJeKiO9zU9xzWO
        dgtnJ+j3JzGYjS24DlQKiMuQIDAHJMtmUK0yz5ez+sdRKQI=
X-Google-Smtp-Source: APXvYqykInoCwf75E/Q7R8/GUPcbPkW2vp2p5yPTWp6R37BYHqSyWrwa7w/sa+ZP0pDIAoulYbYYl6OB/7eow4LRIzs=
X-Received: by 2002:a1c:a481:: with SMTP id n123mr12273798wme.123.1567101366180;
 Thu, 29 Aug 2019 10:56:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAEV-cEryZZarfz5SQsRphBXeYMPJW7tdSfY8NYnzb_-ra-pGHw@mail.gmail.com>
 <CABPp-BE0ij8zF22xbvjbcq3vG-VwWjUmjNo45Lsm0BEnH=iZ-A@mail.gmail.com>
In-Reply-To: <CABPp-BE0ij8zF22xbvjbcq3vG-VwWjUmjNo45Lsm0BEnH=iZ-A@mail.gmail.com>
From:   Matthew McClure <matt@continuousdelta.com>
Date:   Thu, 29 Aug 2019 13:55:55 -0400
Message-ID: <CAEV-cEp19ehfBwHxh7OGsvTxTchNJLSRZGZXqAsDjyQg-W3rFA@mail.gmail.com>
Subject: Re: How to track history of personal changes in a repository?
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 29, 2019 at 1:04 PM Elijah Newren <newren@gmail.com> wrote:
>
> Perhaps put all the changes in a specific branch and run:
>   git config branch.${personalBranchName}.pushRemote
> Do.Not.Push.Changes.From.This.Branch
> ?  (And make sure that push.default is not set to 'matching'.)

I imagine putting all the changes on a specific branch might be part
of a solution. I'm looking for ways to keep the changes in the work
tree as well, even as I switch among other branches I'm working on.

--
Matthew McClure
Continuous Delta
https://www.continuousdelta.com/

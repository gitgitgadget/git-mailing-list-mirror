Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D5C31F4BD
	for <e@80x24.org>; Wed,  2 Oct 2019 12:02:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbfJBMCU (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Oct 2019 08:02:20 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38386 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfJBMCU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Oct 2019 08:02:20 -0400
Received: by mail-pg1-f196.google.com with SMTP id x10so11726453pgi.5
        for <git@vger.kernel.org>; Wed, 02 Oct 2019 05:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=En5uH/bHG/K0zQX4an0EcM7n0Nzk5ZgB3ToRS7BfDe0=;
        b=qol4dWvIRvOqPOKmm7HK45GhxXkXxXgTZTNzJjGbwmGUlMIMhLuH0zaGrhL+SU1r2U
         J6bwB9k2nTF+hqWJqj3b1Ei3Pgf3AuZD9C+LJv1covZFZCfGTEhMDcKYFfIxqBxF8m6W
         jgu9lhfg4wVp4E0qv/mfRT7EVaJaAJsjrvLfKE00BxGI5/Bg9jA4OV++eXvL9UVjm6as
         uByIqR1YiUBwea1UtA+6AL9bmkjvevvdGuZzWVr60NLJqM0/+Jznac7/3Pf5MddG4sGC
         bWq64rjMTiGAyZIw0IaknZNmnEBu1OMYK9NH9MHSqaBt0VAcc4LdgScmz+yBrnSsiGtT
         5BSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=En5uH/bHG/K0zQX4an0EcM7n0Nzk5ZgB3ToRS7BfDe0=;
        b=PVccz+qvYQKBpQBj3UUB+w06LzwatUorH5zwLi3OHgvuP4X2kw3JcHLCYkV3P71il3
         l94iPIP3vxRAUN0hAEbwEIU1cKNyV3M51VCtRvs22tYelJBm5p2pYlbulq4bDeFJfFZ0
         hUBXs2oSD/dSk5Wz1e5CAj+tCN4EgVT5ZJeh3V9sQRVOpM06S8vPI8SbOOrjrECQv0Rs
         +ypRoxzIgGroE5IMqwalIYLnX+RI1pX0sn/bYs2M0Me2uIpVQ+hTcJy1fhkwrAiMpKpY
         d7JgqG+AmQNcqvqo0rWwyyCFf/zeSNLyVUJhCYjYGnFoNBq60csm1WW+tzHAOYa8gvH9
         KSFA==
X-Gm-Message-State: APjAAAW18aCge9pxlCsQJOqbMHGm59xUFBjcELk9KvSIHTgvbC7Yt8dE
        ke15Eqk/qFxIpy0u3RRFon9pnZ8ynHU=
X-Google-Smtp-Source: APXvYqx+dj1w03xQZBfgdmhoUVQXWLhRuMAwDp9zwxiSF+sMv5uiFDyTsQEC6XvHA1aYWdE7rlbJCA==
X-Received: by 2002:a63:545f:: with SMTP id e31mr3314083pgm.94.1570017739155;
        Wed, 02 Oct 2019 05:02:19 -0700 (PDT)
Received: from SARKAR ([1.186.12.91])
        by smtp.gmail.com with ESMTPSA id s18sm5302677pji.30.2019.10.02.05.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 05:02:18 -0700 (PDT)
Date:   Wed, 2 Oct 2019 17:32:13 +0530
From:   Rohit Sarkar <rohitsarkar5398@gmail.com>
To:     git@vger.kernel.org
Cc:     rohitsarkar5398@gmail.com
Subject: git checkout with an ambiguous rev
Message-ID: <20191002120213.GB5812@SARKAR>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,
I was looking into writing a patch for the issue [1] where if an user has
multiple remotes each with a remote tracking branch of the same name say
xyz, 'git checkout xyz' fails with "error: pathspec 'xyz' did not match any
file(s) known to git."

This can sort of be handled by setting checkout.defaultRemote so that
the ambiguity is removed. Although when checkout.defaultRemote is not
set or there are more than 2 remotes I think it would be helpful if git
gives a message listing out the possible revs instead of the pathspec
error. What do you guys think?

[1] : https://public-inbox.org/git/CACcTrKdzVCKUR8EfwhqBQR7vWzRqTLcwRJ_r-hx3VztD=xvNuQ@mail.gmail.com/

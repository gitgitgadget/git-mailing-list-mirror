Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54D711F463
	for <e@80x24.org>; Tue, 17 Sep 2019 20:50:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728821AbfIQUuz (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Sep 2019 16:50:55 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42863 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbfIQUuz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Sep 2019 16:50:55 -0400
Received: by mail-pg1-f196.google.com with SMTP id z12so2619513pgp.9
        for <git@vger.kernel.org>; Tue, 17 Sep 2019 13:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/TjbFsGfeEq89M/rTVmP+kS1Lb2h7j2uKdoGylWjm0s=;
        b=aljUbJnP4rtl99p8hvcLYFY6em06sEdQ1mCcWIBmAxItzvLEYA6KNisgJ2Q8wiUIMm
         XDusxK23xuzwsRwjM+UPngvjHKdxcTZAU7zRqhHKStR4AabIdBiPdtDiNcUab5cAwVuC
         JyBW7lnZFVLiQm21JeIxZofcMNVVHSO9Tslw+ExEAgStHmLMx8iw+AY/jog6q5KjpmQJ
         9acWqcTKEG2U7rS/xyfOnt8tbtsjaXmQcpjKYJaa1qhlYzjm9GCKWdnahSNx2cUno89A
         AQzXjNH49PAGmZ0C4Wq/gQxyZvVgbvawsSOs3RC/792w5C3ZwpeEfh+rQu0sjG8sXImk
         NfRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/TjbFsGfeEq89M/rTVmP+kS1Lb2h7j2uKdoGylWjm0s=;
        b=Su2TcJqlRqrA0xAUBA+r0uNqPNXOe0YDV73GX/lcJf6Qhs09AHyWyn0XXFW8xa5bls
         cwYaXFI8J7vXIzeFw1Ah+lpuMkM/CTNxM5dSloeEWujAuULPwXkyASewGdAqXdjs7E0H
         bH+5JKG3TfyJBUzzb60CWWtXkWEZXRISHLcJW8QNfKJZ9nvbYCYBRNluMpaEeaBsEonK
         pRrhtqWCKCt2Kx7eZpK4BdxUKam/kyGP9xtRBYRzNbVoMWo5odOH5HZay3HqfYirbb9g
         Un/+qCruMnVpJr5phvpjCOLwoO93NJQTPkgXKJ+sK2NE6WKK+FnuuG0B10R2yy+QJOx2
         j7VQ==
X-Gm-Message-State: APjAAAVAiINIQhL81/6mcqZaM8d+lBvZWmE6M8VwWVgT8scQj8gWMIjq
        itA/0Maup0tvaqQVgCI3Hj4=
X-Google-Smtp-Source: APXvYqzx3rbogn1XkyhWorQzwJY4x3zsNnO338MiXNIh5HRxkJ2riIXpGVajNyDxFAfg31OaVC7y0A==
X-Received: by 2002:aa7:998d:: with SMTP id k13mr314727pfh.134.1568753454273;
        Tue, 17 Sep 2019 13:50:54 -0700 (PDT)
Received: from dentonliu-ltm.internal.salesforce.com ([204.14.239.137])
        by smtp.gmail.com with ESMTPSA id r186sm4999248pfr.40.2019.09.17.13.50.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Sep 2019 13:50:53 -0700 (PDT)
Date:   Tue, 17 Sep 2019 13:50:51 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Birger Skogeng Pedersen <birger.sp@gmail.com>,
        Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [GIT PULL] git-gui pull request
Message-ID: <20190917205051.GA63601@dentonliu-ltm.internal.salesforce.com>
References: <20190917201334.hfbvuisdwkwgvwg5@yadavpratyush.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190917201334.hfbvuisdwkwgvwg5@yadavpratyush.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Pratyush,

Since you're the maintainer now, you should submit a patch to
Documentation/SubmittingPatches to change

	- `git-gui/` comes from git-gui project, maintained by Pat Thoyts:

		git://repo.or.cz/git-gui.git

to have your own information.

On Wed, Sep 18, 2019 at 01:43:34AM +0530, Pratyush Yadav wrote:
> Hi Junio,
> 
> There were some topics and discussion related to git-gui in flight. Most 
> of them have been stabilized, and merged in. So I think it's a good time 
> to pull in those changes.
> 
> ---
> The following changes since commit 
> 5ab72271e16ac23c269f5019a74a7b1d65170e47:
> 
>   Merge remote-tracking branch 'philoakley/dup-gui' (2017-03-18 15:35:09 +0000)
> 
> are available in the Git repository at:
> 
>   https://github.com/prati0100/git-gui.git 
> 
> for you to fetch changes up to f7a8834ba4aa20ec750833cf8d30d9a9fed5eade:
> 
>   Merge branch 'bp/amend-toggle-bind' (2019-09-14 23:23:12 +0530)
> 
> ----------------------------------------------------------------
> Bert Wesarg (2):
>       git-gui: convert new/amend commit radiobutton to checkbutton
>       git-gui: add horizontal scrollbar to commit buffer
> 
> Birger Skogeng Pedersen (2):
>       git-gui: add hotkeys to set widget focus
>       git-gui: add hotkey to toggle "Amend Last Commit"
> 
> Pratyush Yadav (9):
>       git-gui: allow reverting selected lines
>       git-gui: allow reverting selected hunk
>       git-gui: return early when patch fails to apply
>       git-gui: allow undoing last revert
>       Merge branch 'bp/widget-focus-hotkeys'
>       Merge branch 'py/revert-hunks-lines'
>       Merge branch 'bw/amend-checkbutton'
>       Merge branch 'bw/commit-scrollbuffer'
>       Merge branch 'bp/amend-toggle-bind'

Seems like this list is missing

	Pat Thoyts (1):
		  Merge remote-tracking branch 'philoakley/dup-gui'

	Philip Oakley (4):
		  git-gui: remove duplicate entries from .gitconfig's gui.recentrepo
		  git gui: cope with duplicates in _get_recentrepo
		  git gui: de-dup selected repo from recentrepo history
		  git gui: allow for a long recentrepo list

which should be in your PR but aren't in mainline Git yet.

> 
>  git-gui.sh          | 140 ++++++++++++++++++++++++++++++++++++++++------------
>  lib/checkout_op.tcl |   6 +--
>  lib/commit.tcl      |   4 +-
>  lib/diff.tcl        |  96 +++++++++++++++++++++++++++++------
>  lib/index.tcl       |   8 +--
>  5 files changed, 199 insertions(+), 55 deletions(-)
> 
> -- 
> Regards,
> Pratyush Yadav

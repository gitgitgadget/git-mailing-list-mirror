Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 913C51F454
	for <e@80x24.org>; Wed,  6 Nov 2019 07:37:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731123AbfKFHhe (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Nov 2019 02:37:34 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42099 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729878AbfKFHhe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Nov 2019 02:37:34 -0500
Received: by mail-pf1-f194.google.com with SMTP id s5so9941637pfh.9
        for <git@vger.kernel.org>; Tue, 05 Nov 2019 23:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fMGlg3e8HlenRtyP+H68pYDi/4BM8AkYh1Ykdy0q+wQ=;
        b=0pAItv4W09zCdgBcrRGPRyS4M5kxrLw5ZZuUrPaqxuFqtbGrv/VCiWGMR8be0H+CE8
         Q4FDv9sdccdlIO6yhr5cp8wlhDoh5M2zPjGQ5nk7G4zVtETXprqMo/PN1N+2ev2ogPOX
         UF4UpmSkuoUyc7nKCEt9hL88fdvfv5g9C5bmdyvdPAERagpPBr9hQvsRriUthqGV2aVR
         QVOG0rYzcGloavmIGI1XwONWDeTMjC25ozllCnGDGep7xwgjmkzwrb7wsjS8Zgt/XqcE
         dX7TbedSKrow+GwCZBvHBERUx0bmWhxINc3kIpnPJequWDIqCxIvM8v0mq2yuVxS9sxY
         r7Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fMGlg3e8HlenRtyP+H68pYDi/4BM8AkYh1Ykdy0q+wQ=;
        b=FZasv8Qywn/itnP+920cQtXJydP7aT6l4594pGBgI38o1Uxj7CRXD7sMKdDl67XEsf
         BMvScV1DSZJDEyienZKxx8uL03AFpDGcZlPPWbBmGZMV7lQ83H07UDdzsEEA08+Eji3k
         vRrgkB7Cx6gqvjtt1PJbFF81qEinkcc+lQ13EZzPzrtIG80jYGz3p6zKx81RstncwZtR
         I+6rGQN35inD4od/dklg8IxQ9uNf01MrYPh3GULFbYOG42q8KvfkkKvJAKm2VP4CjKSk
         5Z5yM7JIizAE0OLtlAqxAo0KUDEGhhL9ZhX/nGx2VTR6SYCIilr1rX5ohz0HoGbJahfp
         dMVA==
X-Gm-Message-State: APjAAAX8r3M4E1BSyvPcrgVZ6uMtiIeT6NNDVE8PDFhvU4mWPHfu+K5/
        lZrQFo9vpOzndTamwS/MlBvkxw==
X-Google-Smtp-Source: APXvYqwhOLZuuVAhev8X7sDk3aj+gbRzG1gHkJsmIU4stTjBH+uKuN5/3xMLClo8a0ZFy051BZ2r8w==
X-Received: by 2002:a62:e214:: with SMTP id a20mr1607161pfi.193.1573025853253;
        Tue, 05 Nov 2019 23:37:33 -0800 (PST)
Received: from localhost ([2601:602:9200:32b0:c8fe:d86b:bca8:7082])
        by smtp.gmail.com with ESMTPSA id hi2sm1485646pjb.22.2019.11.05.23.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 23:37:32 -0800 (PST)
Date:   Tue, 5 Nov 2019 23:37:31 -0800
From:   Taylor Blau <me@ttaylorr.com>
To:     Nathan Stocks via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Nathan Stocks <cleancut@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] t: fix typo in test descriptions
Message-ID: <20191106073731.GA86608@syl.local>
References: <pull.448.git.1573013889.gitgitgadget@gmail.com>
 <5729dd380708da7b40805f75c5d475ff4c0b28c5.1573013889.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5729dd380708da7b40805f75c5d475ff4c0b28c5.1573013889.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Nathan,

On Wed, Nov 06, 2019 at 04:18:09AM +0000, Nathan Stocks via GitGitGadget wrote:
> From: Nathan Stocks <cleancut@github.com>
>
> Fix two test descriptions which stated "git -ls-files" when the actual
> command being tested was "git ls-files".
>
> Signed-off-by: Nathan Stocks <cleancut@github.com>
> ---
>  t/t3060-ls-files-with-tree.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Nice find. I agree with your and Peff's conclusion about when these
might have been introduced, so that they have survived so long indicates
that this was an especially good find indeed.

Your patch looks great to me.

  Reviewed-by: Taylor Blau <me@ttaylorr.com>

> diff --git a/t/t3060-ls-files-with-tree.sh b/t/t3060-ls-files-with-tree.sh
> index 44f378ce41..52ed665fcd 100755
> --- a/t/t3060-ls-files-with-tree.sh
> +++ b/t/t3060-ls-files-with-tree.sh
> @@ -47,7 +47,7 @@ test_expect_success setup '
>  	git add .
>  '
>
> -test_expect_success 'git -ls-files --with-tree should succeed from subdir' '
> +test_expect_success 'git ls-files --with-tree should succeed from subdir' '
>  	# We have to run from a sub-directory to trigger prune_path
>  	# Then we finally get to run our --with-tree test
>  	(
> @@ -57,7 +57,7 @@ test_expect_success 'git -ls-files --with-tree should succeed from subdir' '
>  '
>
>  test_expect_success \
> -    'git -ls-files --with-tree should add entries from named tree.' \
> +    'git ls-files --with-tree should add entries from named tree.' \
>      'test_cmp expected output'
>
>  test_done
> --
> gitgitgadget

Thanks,
Taylor

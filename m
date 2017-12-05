Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEED620A40
	for <e@80x24.org>; Tue,  5 Dec 2017 19:48:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752065AbdLETsF (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Dec 2017 14:48:05 -0500
Received: from mail-yw0-f182.google.com ([209.85.161.182]:44300 "EHLO
        mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752036AbdLETsD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Dec 2017 14:48:03 -0500
Received: by mail-yw0-f182.google.com with SMTP id m129so618320ywb.11
        for <git@vger.kernel.org>; Tue, 05 Dec 2017 11:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kitware.com; s=google;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=vPNPPeop65qEwzPLjTGjG/5g7ItwKnOHYN3LtIj+eEE=;
        b=ZVp9fzMegHVkSnWi/SaAaysV0PpKEmxHf1K+An5qvDHM/pi3n8Mst78BjTAeTJ98XM
         VgAZWIMtihMvU3ynnZauVKPSHMLRVfvMt/DyPs/O+b4murnuH9R+7RnLD66m2nhsu9DD
         3pHqxqxBufMuGYB+LyXIsSwhe1Zyaq3gSBZKg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=vPNPPeop65qEwzPLjTGjG/5g7ItwKnOHYN3LtIj+eEE=;
        b=glZpZknmLahdOoImnx0ZemMzSw1Ue/5mhw2ENGQrPfRi1zxxJD9fUWqVK5GF0RucvC
         QhmBKfojHWpNcxvbJqFtfsZJEna94Rmf+kPWVKKZl7NfhOMiMF5AtKfS827Nwm6KQmWv
         VooobXINMbf9zlsA3TPHLrXFj1D5EoqzF+Gyao+GWy7blj0AHyz+QBQvtAPHSwdENW5D
         QUMiBjpnqee0w0oIWrIeR/8Ctw4yF0E3A+Gu/n6WPu7f1/PRNuNhUGoJzkPojO9HAVCf
         7Ep6EylBXL1Eh8GFp+dficvWp8Z3VJTSvlV1Xn83mWy0gRJwV3/URBFMObAyfxQwd8Ys
         TBAA==
X-Gm-Message-State: AJaThX5kmPtuj4EAgY6CfZWchuySE+gxWy2HzjhvqARAe8Bmj8JGrrpf
        ManfAjXlJ8tvNIaE/UMZTuVO/g==
X-Google-Smtp-Source: AGs4zMY6cQ/mxWnh6EPK4JE7oQg6VgKfBMwWXqDloSqrnJqHJwznOl9G46WtX7UmkoHIatHwJySuUQ==
X-Received: by 10.13.229.193 with SMTP id o184mr13457458ywe.256.1512503283200;
        Tue, 05 Dec 2017 11:48:03 -0800 (PST)
Received: from localhost (tripoint.kitware.com. [66.194.253.20])
        by smtp.gmail.com with ESMTPSA id t19sm438343ywg.105.2017.12.05.11.48.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Dec 2017 11:48:02 -0800 (PST)
Date:   Tue, 5 Dec 2017 14:48:01 -0500
From:   Ben Boeckel <ben.boeckel@kitware.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, brad.king@kitware.com
Subject: Re: gitattributes not read for diff-tree anymore in 2.15?
Message-ID: <20171205194801.GA31721@megas.kitware.com>
Reply-To: ben.boeckel@kitware.com
References: <20171204212255.GA19059@megas.kitware.com>
 <20171204230355.GA52452@google.com>
 <20171205154244.GA16581@megas.kitware.com>
 <20171205181645.GA159917@google.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="PNTmBPCT7hxwcZjr"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20171205181645.GA159917@google.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, Dec 05, 2017 at 10:16:45 -0800, Brandon Williams wrote:
> Perfect, thanks!

OK, attached is a shell script which recreates the issue. I haven't been
able to get it to happen without the `GIT_WORK_TREE` and `GIT_INDEX_FILE`
setup involved, so that seems to be important.

I reran the bisect using this script and came up with this commit:

    commit be4ca290570f9173db64ea1f925b5b3831c6efed
    Author: David Turner <dturner@twosigma.com>
    Date:   Thu Apr 20 16:41:18 2017 -0400

        Increase core.packedGitLimit

        <snip>

which seems even less relevant…

Thanks,

--Ben

--PNTmBPCT7hxwcZjr
Content-Type: application/x-sh
Content-Disposition: attachment; filename="diff-tree-break.sh"
Content-Transfer-Encoding: quoted-printable

#!/bin/sh=0A=0Areadonly testroot=3D"test"=0Arm -rf "$testroot"=0Amkdir -p "=
$testroot"=0A=0Amkdir -p "$testroot/repo"=0Apushd "$testroot/repo"=0A# Make=
 a repository.=0Agit init=0Agit commit --allow-empty -m "root commit"=0A=0A=
# Create a whitespace error that should be ignored.=0Aecho "* -whitespace" =
> ".gitattributes"=0Agit add ".gitattributes"=0A=0Aecho "trailing space -> =
" > "trailing-space"=0Agit add "trailing-space"=0A=0Agit commit -m "trailin=
g space"=0Areadonly revision=3D"$( git rev-parse HEAD )"=0Apopd=0A=0Aecho "=
Create our 'workarea' setup..."=0Amkdir -p "$testroot/workarea/worktree"=0A=
export GIT_WORK_TREE=3D"$testroot/workarea/worktree"=0Aexport GIT_INDEX_FIL=
E=3D"$testroot/workarea/index"=0Aexport GIT_DIR=3D"$testroot/repo/.git"=0A=
=0Agit read-tree -i -m "$revision"=0Agit update-index --refresh --ignore-mi=
ssing --skip-worktree >/dev/null=0A=0A# Run diff-tree.=0Agit diff-tree --no=
-commit-id --root -c --check "$revision"=0Aecho "exit code of diff-tree: $?=
"=0A
--PNTmBPCT7hxwcZjr--

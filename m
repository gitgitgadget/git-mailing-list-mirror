Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ECD241F404
	for <e@80x24.org>; Fri,  2 Mar 2018 04:44:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1422796AbeCBEoO (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Mar 2018 23:44:14 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:45975 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1164277AbeCBEoN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Mar 2018 23:44:13 -0500
Received: by mail-pg0-f67.google.com with SMTP id i133so3277213pgc.12
        for <git@vger.kernel.org>; Thu, 01 Mar 2018 20:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2kiV2sN5hHISEIrMk7l7gQAKORGsj8gZaOEsd50uEPk=;
        b=blaxdi+N142Q/f8RMLxFJeBbDDcVhmlNuF+owB8LkDnM+jVX+2M+8Wi8HqvSzFTFq5
         QVf5kexfEgiguaU7xLwLic5oeC5enXLzEsOUnIM0vIFAyBua2L3fFJMOosod/R0H8TUU
         vFZnGz4MN/5smhSn2LiTCR7YEkYmSkKDBBZiwSvvY8m75/nYLB8nhvOLwnovE44Ataer
         4HsDzYmTCXKUrmGzFvraiYWB2ocTkbWU8gvLvL0ZSf4zWy7T+saX35P/rUdmRUJSUtXS
         eRy7Pk+sz0jcScInmJsngSUUvlrfm1lrF/v9jWy3g7hHwVy+m+z774++uaNxSeMluoi7
         ZG8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2kiV2sN5hHISEIrMk7l7gQAKORGsj8gZaOEsd50uEPk=;
        b=rB60OPVAO36/E+tMRX7AEg+yhUxGhs8iuGBGpbxszuu8Ps4QW4tLWEutz8yAnLgbK+
         j3ka20sPLv51zJYKS449+fhmq589fp1OhZ4MGFejd7iqax6T+Mko6LfAc/quM+N6vO4/
         aU4OeadjWgXTD3xCekCaKo9P+dTu/WERRgFSKZw6jkODRZyKTG+5xrYno5kbCYPoI3GR
         +WUOpm/lxzgUNbuq8FgZTyJPKisyfmYgW/lHZoPHtFoJQLl0Wr0MdL5Knb/0JzsyNOA9
         Ww7D9ShkWQwdJC3MDJlbRhziFxSk7EYSiS2XIZlVQRN0rkWdMGaYx9RedVSk/Zp7dXIi
         N5EQ==
X-Gm-Message-State: APf1xPBIbgolRKwcxmFItf1ziT37MhMc0Hsk9Et7JRmLtEVXNeAfIHbH
        Yp9GeAPZhf95BjkSCA2qV+4=
X-Google-Smtp-Source: AG47ELuASylGlHyRq621trkIZ3FuyamAT7qQMBFF9vBriggDeH14WVQvO28p6vy7av+3gFxDgvC9DA==
X-Received: by 10.99.117.10 with SMTP id q10mr3513224pgc.423.1519965852701;
        Thu, 01 Mar 2018 20:44:12 -0800 (PST)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id 75sm11722783pfl.169.2018.03.01.20.44.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Mar 2018 20:44:11 -0800 (PST)
Date:   Thu, 1 Mar 2018 20:44:09 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [RFC] Contributing to Git (on Windows)
Message-ID: <20180302044409.GC238112@aiede.svl.corp.google.com>
References: <176408fc-3645-66d3-2aa3-30ca3fa723e7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176408fc-3645-66d3-2aa3-30ca3fa723e7@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Derrick Stolee wrote:

> Now, we'd like to make that document publicly available. These steps are
> focused on a Windows user, so we propose putting them in the
> git-for-windows/git repo under CONTRIBUTING.md. I have a pull request open
> for feedback [1]. I'll read comments on that PR or in this thread.

Thanks!  I wonder if we can put this in the standard Documentation/
directory as well.  E.g. the Windows CONTRIBUTING.md could say say
"See Documentation/Contributing-On-Windows.md" so that the bulk of the
text would not have to be git-for-windows specific.

[...]
> +++ b/CONTRIBUTING.md
> @@ -0,0 +1,401 @@
> +How to Contribute to Git for Windows
> +====================================

Would it make sense for this to be checked in with LF instead of CRLF
line endings, so that clones use the user's chosen / platform native
line ending?  The .gitattributes file could include

	/CONTRIBUTING.md text

so that line ending conversion takes place even if the user hasn't
enabled core.autocrlf.

[...]
> +    The SDK uses a different credential manager, so you may still want to use Visual Studio
> +    or normal Git Bash for interacting with your remotes.  Alternatively, use SSH rather
> +    than HTTPS and avoid credential manager problems.

Where can I read more about the problems in question?

[...]
> +Many new contributors ask: What should I start working on?
> +
> +One way to win big with the maintainer of an open-source project is to look at the
> +[issues page](https://github.com/git-for-windows/git/issues) and see if there are any issues that
> +you can fix quickly, or if anything catches your eye.

<shameless plug>You can also look at https://crbug.com/git for non
Windows-specific issues.  And you can look at recent user questions
on the mailing list: https://public-inbox.org/git

[...]
> +If you are adding new functionality, you may need to create low-level tests by creating
> +helper commands that test a very limited action. These commands are stored in `t/helpers`.
> +When adding a helper, be sure to add a line to `t/Makefile` and to the `.gitignore` for the
> +binary file you add. The Git community prefers functional tests using the full `git`
> +executable, so be sure the test helper is required.

Maybe s/low-level/unit/?

[...]
> +Read [`t/README`](https://github.com/git/git/blob/master/t/README) for more details.

Forgive my ignorance: does github flavored markdown allow relative
links?  (I.e., could this say [`t/README`](t/README)?)

[...]
> +You can also set certain environment variables to help test the performance on different
> +repositories or with more repetitions. The full list is available in
> +[the `t/perf/README` file](https://github.com/git/git/blob/master/t/perf/README),

Likewise.

[...]
> +Test Your Changes on Linux
> +--------------------------
> +
> +It can be important to work directly on the [core Git codebase](https://github.com/git/git),
> +such as a recent commit into the `master` or `next` branch that has not been incorporated
> +into Git for Windows. Also, it can help to run functional and performance tests on your
> +code in Linux before submitting patches to the Linux-focused mailing list.

I'm surprised at this advice.  Does it actually come up?  When I was
on Mac I never worried about this, nor when I was on Windows.

I'm personally happy to review patches that haven't been tested on
Linux, though it's of course even nicer if the patch author mentions
what platforms they've tested on.

Maybe this can be reframed to refer specifically to cases where you've
modified some Linux platform-specific code (e.g. to add a new feature
to run-command.c)?

[...]
> +When preparing your patch, it is important to put yourself in the shoes of the maintainer.

... and in the shoes of other users and developers working with Git down
the line who will interact with the patch later!

Actually, the maintainer is one of the least important audiences for a
commit message.  But may 'the maintainer' is a stand-in for 'the
project' here?

[...]
> +* Make sure the commits are signed off using `git commit (-s|--signoff)`. This means that you
> +  testify to be allowed to contribute your changes, in particular that if you did this on company
> +  time, said company approved to releasing your work as Open Source under the GNU Public License v2.

Can this either point to or quote the relevant legal text from
Documentation/SubmittingPatches?  It feels dangerous (in the sense of,
potentially leading to misunderstandings and major future pain) to ask
people to sign off without them knowing exactly what that means.

The rest also looks nice.  Thanks for working on this.

Sincerely,
Jonathan

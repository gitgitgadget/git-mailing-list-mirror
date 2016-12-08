Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE3641FBB0
	for <e@80x24.org>; Thu,  8 Dec 2016 13:57:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751987AbcLHN5t (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Dec 2016 08:57:49 -0500
Received: from mail-wj0-f169.google.com ([209.85.210.169]:34578 "EHLO
        mail-wj0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751534AbcLHN5s (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2016 08:57:48 -0500
Received: by mail-wj0-f169.google.com with SMTP id tg4so133809816wjb.1
        for <git@vger.kernel.org>; Thu, 08 Dec 2016 05:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ti1UIsWdE+vRp18BEBFy19yT4aGr6KjmQAeDVXFut4Q=;
        b=wRdolJBzD543kW+Ud0HlRvWUaDYY6a+Vjf63MstQUgZWeQKixHV3hezkzsfdg20i7z
         nR4tT8IZiVBBKopj6C5tn0V6t1nS1gJsyAXUgrtpWq+YlScD9LUEhz6kl+ydeJqKF/Lr
         llXW03/ACKnBmlpb9qSXk/1pPmIiEXBvnud31W0rI/6a0U+iemcFNLqJHZnwxV6KZetg
         jZkX+6PZ8vGJ72nh+CQghpxifch0x9kJlUKYGKuUKmnFQhHxh2BIMoCcyDilwJgmTutH
         991Jd4hB+iVtH09IqiPSAJOWNaz7r4PKY8fepSk5BEwCG09UQXszpe72ul2YXxdbFZz6
         sAmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ti1UIsWdE+vRp18BEBFy19yT4aGr6KjmQAeDVXFut4Q=;
        b=Fy2rqqOkPf2r5tKLNHzZAjfe1ZlrY9bTqr9KFhdFsywoiPMmOF8SabsLXoab2bLHz0
         kn/R2MVKHWj7+W2XO9n8etJxFIfuNJcO8dv/zM12F4G4aOD6Nj59sP0N4t6hEySHGEyQ
         W9GsnGLcUPo36wWgUJD7ufRTaoXS8sGaGdayctUY9X/a4M1ef6SFm8vc4hlnFempFBjv
         2doOK7Hv+BHqSBJEgfATfif3TYZ2PGIeVwBOu/KP63hLIOFKWiqtAYMyd13sGQua8TW5
         eY5Te0JoGVRHmYBgBsua6CHdLQ3BaUucWWMWCF91Twgrnhy5Tu9GEdlFHPZ3N+w0sI5G
         XnDQ==
X-Gm-Message-State: AKaTC03yxUJP2e/4TDg0xG6WSf4+Lz6Jk6H+ZLAK91LCD59wCamIZakAy20kS1qD/EM7MQ==
X-Received: by 10.194.158.100 with SMTP id wt4mr77466599wjb.148.1481205467282;
        Thu, 08 Dec 2016 05:57:47 -0800 (PST)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id w79sm15409480wmw.0.2016.12.08.05.57.45
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Dec 2016 05:57:46 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: Serious bug with Git-2.11.0-64-bit and Git-LFS
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <CABW+60x0PSw7uNQZg4SeN7EAbNpraR_HWvnVFz1-fVLYX=B8RQ@mail.gmail.com>
Date:   Thu, 8 Dec 2016 14:57:57 +0100
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <06520F42-BD49-4349-83B3-74DCA1E260CD@gmail.com>
References: <CABW+60x0PSw7uNQZg4SeN7EAbNpraR_HWvnVFz1-fVLYX=B8RQ@mail.gmail.com>
To:     Nick Warr <nick.warr@bossastudios.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 08 Dec 2016, at 12:46, Nick Warr <nick.warr@bossastudios.com> wrote:
> 
> Using Git-2.11.0 with the latest git-lfs 1.5.2 (also tested with
> 1.5.3) cloning from our locally hosted gitlab CE server via HTTPS.
> 
> When cloning a repo (large, 3.3 gig in git, 10.3 in LFS)  for the
> first time the clone will finish the checkout of the git part, then
> when it starts downloading the LFS parts it will reliably finish with
> a smudge filter error.
> 
> This leaves the repo in an unstable condition, you can then fetch the
> lfs part without issue, but checking out the lfs files or trying a git
> reset --hard will continue to spit out the same error. As you can see,
> the actual error is not particularly useful.
> 
> fatal: workers/unity/Assets/3rdPartyAssets/FORGE3D/Sci-Fi
> Effects/Effects/Debris/Meshes/debris_junk.FBX: smudge filter lfs
> failed
> Unknown command ""
> 
> Possibly it's due to the file extension being all capital letters, we
> did manage to change the error by recommitting the file with a
> lowercase extension, but it failed on the next file (which also had a
> capital letter extension).
> 
> This has happened on multiple fresh windows 10 64 bit installs,
> different machines and target directories (to hopefully remove the
> possibility of file permissions) where cloning is taking place.
> 
> The solution is to back level to Git 2.10.2 and the error disappears.
> 
> More than willing to provide any further information,

Hi Nick,

debris_junk.FBX is not stored properly in Git LFS.
I explained the problem in detail here: 
https://github.com/git-lfs/git-lfs/issues/1729

You should add the file properly to GitLFS to fix the problem.
However, I think this is a regression in GitLFS and I hope it will 
be fixed in the next version.

No change/fix in Git is required.

Cheers,
Lars

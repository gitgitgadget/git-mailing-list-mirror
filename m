Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F239D1F744
	for <e@80x24.org>; Mon, 11 Jul 2016 14:45:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933806AbcGKOox (ORCPT <rfc822;e@80x24.org>);
	Mon, 11 Jul 2016 10:44:53 -0400
Received: from mail-qk0-f175.google.com ([209.85.220.175]:34868 "EHLO
	mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759245AbcGKOoX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2016 10:44:23 -0400
Received: by mail-qk0-f175.google.com with SMTP id s63so58811779qkb.2
        for <git@vger.kernel.org>; Mon, 11 Jul 2016 07:44:23 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=394wmoFu9gGhFbnU9Hd/NyvCaLYrblmoXd8FdSf4Syk=;
        b=AjLMkESJQ3vvimtUlXlULkVRmIn/IsaxmzfvwZ1eCEouAgMSaPsbYyBev/Gkgh0YJG
         c/Ee7OESrY6SmeY8nQSL6+EX8e+b/lD24iANwJLpQhTgPt0L4dFucXhD+wUzyL/gNBxe
         EHUH72KC3t0ve/ayCczVbRYECTVGuxRV+c/q3i86HUxvvI4DK90fwCmTJ5wgesfLnXtT
         QNbDW89XPMf00wQFRF5Mhf35Jey+tvN2HGj1Bl22EOtff00TCDNied5FodB2waLoJWTG
         X5HVFx2HbFx/DHRmCBxmN+dizYyHXi2e3pnusNt0XiUXTPAMvVVg4aDlVHJnGooQGT7+
         J4xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=394wmoFu9gGhFbnU9Hd/NyvCaLYrblmoXd8FdSf4Syk=;
        b=ScJ3oLHk31qhqNKW2SHYAaC76M3KPs1gK+rYHlLWlpk7YaN7ldrseIR9V0PwgnGHrV
         /0GVZFAj0UYVQKEVk8geFuzXtk9ycPtiz7PP9vKRLC8fhGqDmvsAfQSw4BkYwA7OacCX
         HsAR3lobE/mlxRgfm5ZweyNDVW7sHbEkVjNSbj3NO3lMWo7Dzi2Ldf/M+oWYIV/LuSEi
         dUGjHuA0d/udCs09di1MfqjPvuIAomFoKiAuQsTHy3sgIVlxVrXZaAAkJXKdvp/WOzzQ
         YkHdvib1ubDPZ7xsfNJi5DD+UUTmEXakHHicN9YCDLtDcxwuoBm5ciQ/dAOo6oSkEerE
         Gb+Q==
X-Gm-Message-State: ALyK8tLNaYGquhSQAXHWeU9M8Npe9RjIgH/Ub6AOXieeAg/8l3OcyVx4mTOHNL2O3Jo3XjgK
X-Received: by 10.55.58.68 with SMTP id h65mr11374420qka.9.1468248262706;
        Mon, 11 Jul 2016 07:44:22 -0700 (PDT)
Received: from LykOS.localdomain (NYUFWA-WLESSAUTHCLIENTS-13.NATPOOL.NYU.EDU. [216.165.95.2])
        by smtp.gmail.com with ESMTPSA id m11sm2750529qke.36.2016.07.11.07.44.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jul 2016 07:44:22 -0700 (PDT)
Date:	Mon, 11 Jul 2016 10:44:21 -0400
From:	Santiago Torres <santiago@nyu.edu>
To:	Nils Fenner <nilsfenner@web.de>
Cc:	git@vger.kernel.org
Subject: Re: Commits are no longer gpg-signed in 2.9.0 when "commit.gpgsign"
 is enabled
Message-ID: <20160711144420.nsibnudjxvgdz7cl@LykOS.localdomain>
References: <57838306.5090505@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <57838306.5090505@web.de>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Nils,

I just checked and I have commits made in 2.9 with this option set and I
don't seem to have your issue. Here's what I did:

    santiago at ~/test-signing ✔ git init
    Initialized empty Git repository in /home/santiago/test-signing/.git/
    santiago at ~/test-signing ✔ hub create
    Updating origin
    Enter passphrase for key '/home/santiago/.ssh/id_rsa': 
    created repository: SantiagoTorres/test-signing
    santiago at ~/test-signing ✔ touch testfile
    santiago at ~/test-signing ✔ git add testfile 
    santiago at ~/test-signing ✔ git commit
    i[master (root-commit) 6de1ad2] TEST: tests git autocommit setting
     1 file changed, 0 insertions(+), 0 deletions(-)
     create mode 100644 testfile
    santiago at ~/test-signing ✔ git log --show-signature
    commit 6de1ad20237f042433f8b94a3bf8c7cc41711d90 (HEAD -> refs/heads/master)
    gpg: Signature made Mon 11 Jul 2016 10:40:41 AM EDT using RSA key ID 468F122CE8162295
    gpg: Good signature from "Santiago Torres <torresariass@gmail.com>" [ultimate]
    gpg:                 aka "Santiago Torres-Arias <santiago@nyu.edu>" [ultimate]
    Author: Santiago Torres <torresariass@gmail.com>
    Date:   Mon Jul 11 10:40:32 2016 -0400

        TEST: tests git autocommit setting
    santiago at ~/test-signing ✔ git push origin master
    Enter passphrase for key '/home/santiago/.ssh/id_rsa': 
    Counting objects: 3, done.
    Writing objects: 100% (3/3), 879 bytes | 0 bytes/s, done.
    Total 3 (delta 0), reused 0 (delta 0)
    To git@github.com:SantiagoTorres/test-signing.git
     * [new branch]      master -> master
    santiago at ~/test-signing ✔ git --version
    git version 2.9.0
    santiago at ~/test-signing ✔ 

You can check the github repository 

Do you have a mwe/.gitconfig so I can take a look at it? 

I wonder if this issue is similar to what happened in mutt, where gpg
doesn't show the password prompt using gpg-agent and it silently failed.

Thanks,
-Santiago.

On Mon, Jul 11, 2016 at 01:29:10PM +0200, Nils Fenner wrote:
> Hey Git community,
> 
> since Version 2.9.0, the configuration option "commit.gpgsign" doesn't work
> as users would expect. By committing via 'git gui' (or usual 'git commit'
> without further option), commits are not being auto-signed any longer, when
> "commit.gpgSign" configuration option is set. I also couldn't find a flag to
> "workaround" that situation in the GUI. To my understanding, I now have to
> pass the '-S' option to 'git commit' every time and GUI becomes "impractical
> to use". Surprisingly, nobody seems having noticed this behavioural change
> since the release of 2.9.
> 
> FYI: In the release log, there's a note stating, that this has been altered
> in the context of 'git commit-tree'. Maybe this interferes with "normal"
> behaviour.
> 
> Would be happy hearing from you soon. Thanks!
> 
> Cheers,
> Nils
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

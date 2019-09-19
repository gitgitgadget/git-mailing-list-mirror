Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DEB751F463
	for <e@80x24.org>; Thu, 19 Sep 2019 18:47:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404015AbfISSrN (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Sep 2019 14:47:13 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37587 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390701AbfISSrM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Sep 2019 14:47:12 -0400
Received: by mail-pg1-f196.google.com with SMTP id c17so2392036pgg.4
        for <git@vger.kernel.org>; Thu, 19 Sep 2019 11:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gLEDyBj24NACMyXha4S6784kAHTUU65bpYcTVfalHV0=;
        b=WhlxTmJDse5hDog0XykARfRlAnI0zguosrp+ELilx8ojjqW9tjYaBLAEdDVeTncasE
         DJAiwqEiFg+GcM32HHpV/agw7asJ6Gq2YnjdT1ym7bFf22jW6YBMptt7OOl/Ume0dwM0
         HokJd4fCZqTKAmC80k77lObUSB9E0tBWcjA8IOJ6wLl1Ii/emnuC34DIGtOc83/K3sWy
         YNKNIy9HE9nwun2l7LI93CExEUbR4lwfotYzmFURy9c0sKlhru/tmb2YWDHxKcfOoDyh
         ZqEfkjiG7XYsMHBlNy7wlL2nxX0TOpv8PZgCyqG4Tex7ET0Nhsjx6yNqIcR7KMUsDIBc
         t3Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gLEDyBj24NACMyXha4S6784kAHTUU65bpYcTVfalHV0=;
        b=fkxDjoH3AoE5j+QV6H2bgGAxa5p+zwIS4JuyDBygh7ySqu5bYutGkH5uL3Y79IFx9K
         yU9U7qsGmIpLzVQ2wvwP3wfhhne4kcskHCMXZWaoYqfEznYcKm61ckQHS0NasHFbZBNp
         Gq4ZN0P5MB95kJe2R961EfF0x9HhxXNc6EUuq72KI5082Mjqlc7hm13loncopaBmaWgn
         G98/Dl0UQm8omkdS+LruwKdlQpGjaK55HIFjzRRFtvenDpxBxKz3SuDfoXtDE+lvRgpl
         nWhw4sybJiYOrYV8Q26VPYOiXmfm8iF4fH9Gees6LwpMFVP7PzJn+uf+bv8JellvnHXt
         ZBqA==
X-Gm-Message-State: APjAAAXY8o0xu1hWvU27upPyejY9aN1Bz+Qh7y2J7+uYzSeOYFgcnwMz
        Rya3/xUQbHuLN8ZT6JsZFTiW7cJC
X-Google-Smtp-Source: APXvYqyRUi8BfsrGbOxi9pmoynbhp04TH3UscsY7223T8/uOKp05Hr2YMV539YGFPuVuiG5Vxk4W9Q==
X-Received: by 2002:aa7:93b6:: with SMTP id x22mr10046348pff.171.1568918831029;
        Thu, 19 Sep 2019 11:47:11 -0700 (PDT)
Received: from dentonliu-ltm.internal.salesforce.com ([204.14.239.53])
        by smtp.gmail.com with ESMTPSA id k9sm2097126pfk.72.2019.09.19.11.47.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Sep 2019 11:47:10 -0700 (PDT)
Date:   Thu, 19 Sep 2019 11:47:08 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Birger Skogeng Pedersen <birger.sp@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: git-gui: missing some patches from git?
Message-ID: <20190919184708.GA83166@dentonliu-ltm.internal.salesforce.com>
References: <CAGr--=KXqFbivuXHPNecb3dBR_hx8QqWoR4pBGXy7uOiT+ESbg@mail.gmail.com>
 <20190918092721.GA76617@archbookpro.localdomain>
 <20190918151404.rqjohdderwxfqtdm@yadavpratyush.com>
 <xmqqblvh5wbr.fsf@gitster-ct.c.googlers.com>
 <20190919183258.g7ae4u5nzuzwgu7b@yadavpratyush.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190919183258.g7ae4u5nzuzwgu7b@yadavpratyush.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 20, 2019 at 12:02:58AM +0530, Pratyush Yadav wrote:
> Hi Junio,
> 
> On 18/09/19 10:49AM, Junio C Hamano wrote:
> > Pratyush Yadav <me@yadavpratyush.com> writes:
> > You should be able to merge this (and all other git-gui topics
> > already in my tree Denton pointed out) to your 'master'.  If you
> > then make a trial merge of the result back into my tree with "git
> > merge -Xsubtree=git-gui", it should result in "already up to date",
> > i.e. a noop merge.
> 
> I pulled all the changes into git-gui. I had to manually backport two 
> commits:
> 
>   * 7560f547e6 (treewide: correct several "up-to-date" to "up to date", * 2017-08-23)
>   * 00ddc9d13c (Fix build with core.autocrlf=true, 2017-05-09)
> 
> because they touched other parts of git, that were not in git-gui.
> 

For the record, you could do a

	git cherry-pick -Xsubtree=git-gui 00ddc9d13c 7560f547e6

to bring them over instead of manually recreating the changes yourself.
Personally, I'd prefer the cherry-picked commits as it'd preserve
authorship information but I'm not sure how Junio feels.

From a correctness perspective, however, I compared my results after
doing that with yours and it's identical.

> I then did a trial merge into your 'master', and running a diff, 
> git.git's version of git-gui is identical to mine. So everything seems 
> to be correct.
> 
> Instead of doing this on my master, I did it on a separate branch just 
> to be sure I don't mess something up. You can find it on 
> https://github.com/prati0100/git-gui.git on the branch 'trial_merge'.
> 
> These are the new commits introduced:
> 
>   7435f916d3 git-gui: fix build with core.autocrlf=true
>   834e3ec31e git-gui: correct "up-to-date" to "up to date"
>   fecfccf9ff Merge branches 'js/msgfmt-on-windows', 'tz/fsf-address-update', 'jn/reproducible-build', 'ls/no-double-utf8-author-name', 'js/misc-git-gui-stuff', 'bb/ssh-key-files', 'bp/bind-kp-enter', 'cb/ttk-style' and 'py/call-do-quit-before-exit' of ../git into trial_merge
>   f7a8834ba4 Merge branch 'bp/amend-toggle-bind'
>   ec7424e1a6 git-gui: add hotkey to toggle "Amend Last Commit"
>   6c8ec8c30a Merge branch 'bw/commit-scrollbuffer'
>   acfa495519 Merge branch 'bw/amend-checkbutton'
>   da08d559b7 git-gui: add horizontal scrollbar to commit buffer
>   ba41b5b335 git-gui: convert new/amend commit radiobutton to checkbutton
>   c77abf0460 Merge branch 'py/revert-hunks-lines'
>   5a2bb62180 Merge branch 'bp/widget-focus-hotkeys'
>   e07446ed5f git-gui: add hotkeys to set widget focus
>   a4fa2f0a4c git-gui: allow undoing last revert
>   2ccdfb1c78 git-gui: return early when patch fails to apply
>   62bd99934b git-gui: allow reverting selected hunk
>   5f0a516de9 git-gui: allow reverting selected lines
> 
> The top 3 commits are of note. The top 2 are the manual backports. The 
> third is the octopus merge of all the topics not in git-gui yet. The 
> rest are just other topics that were introduced in my fork recently.
> 
> If it looks all good, I'll put all this on my 'master' and re-send the 
> pull request.

I took a look as well and the end result looks good to me too.

> 
> -- 
> Regards,
> Pratyush Yadav

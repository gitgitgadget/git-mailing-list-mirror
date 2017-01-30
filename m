Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 160BF1FAAD
	for <e@80x24.org>; Mon, 30 Jan 2017 17:52:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753936AbdA3Rvi (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jan 2017 12:51:38 -0500
Received: from mail-pf0-f174.google.com ([209.85.192.174]:36450 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753937AbdA3Rvf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jan 2017 12:51:35 -0500
Received: by mail-pf0-f174.google.com with SMTP id 189so92053214pfu.3
        for <git@vger.kernel.org>; Mon, 30 Jan 2017 09:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=G86KuH04rTPS/5Qcp8Dg4xoeAc+ExtmOtT6Ml16moXY=;
        b=nhlv1Qs6VSQ5Jr1yN/VnWVzfJrUDqcyKWui0fxV2/aanGVmrOTXya0ehIOBzvGHLS5
         ugcn0+P8le6sdk2j4/f0ThOerfMEmI3hUzlIL6Xk8IAclTqy2kCaDkpK4GMw9NaEXJMS
         eWXmiHuGUh3rAsfIR5uL+DofPwYy/wYxitN/G6Vv/8I7GZ0UqF95gld/5OFpERMNdQLW
         Aq+oKd1aVwDX/H9yQt322P2Glyala7k01obwEZ61CyAIp26wX7VVcPoXFsCmOfl0DQlz
         gXoeo3ozCtrwaeur/0VqRZ2ZFgI0+pKihCloenJP+CHaizrL3DBWiMZobkr/v+brcMgN
         KCzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=G86KuH04rTPS/5Qcp8Dg4xoeAc+ExtmOtT6Ml16moXY=;
        b=slIwDoTSlRh+r0DXg0fWMueA/KN8CO2wSCndwwbsZnfxaDbE7ow3KziC0+sPatRrme
         8Q+duZyuo3NdN7xAmRNhiDCpI9U6JtmP85gajuuJ0NldtGCSxEl8QYBEq/ZtADA3v/fO
         DMfzuhh8ak25AATyIdTxfnGaFM/M7aQljN1+XsqNNT/TpkYbxET/iAUGCRIko08oYheF
         Qs14dd2STS3o3KKDI178+hI1E9aMtCj4FZRFp/eE+X2gZiSZwK63wL8Xi/zJyHQfz/IU
         LsjqP5644z8BzftdaXr9yTnLbkloC9O1m+rW31l/7UMOcozZZouApcdb8PxKrTGJtkHg
         f3OQ==
X-Gm-Message-State: AIkVDXLPhcAVem5aS6CVJaJOShHeHNkpnIUTmvIWbBujT359hFQ1/3NV8hym8NOn/0dFgMz1
X-Received: by 10.98.100.69 with SMTP id y66mr24175438pfb.174.1485798681063;
        Mon, 30 Jan 2017 09:51:21 -0800 (PST)
Received: from google.com ([2620:0:1000:5b10:30e7:5087:4ef2:5616])
        by smtp.gmail.com with ESMTPSA id w125sm34388333pgb.11.2017.01.30.09.51.19
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 30 Jan 2017 09:51:19 -0800 (PST)
Date:   Mon, 30 Jan 2017 09:51:18 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Benjamin Schindler <beschindler@gmail.com>
Cc:     git@vger.kernel.org, sbeller@google.com
Subject: Re: gitconfig get out of sync with submodule entries on branch switch
Message-ID: <20170130175118.GA35626@google.com>
References: <0f14df64-1aa2-e671-9785-4e5e0a076ae6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f14df64-1aa2-e671-9785-4e5e0a076ae6@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/30, Benjamin Schindler wrote:
> Hi
> 
> Consider the following usecase: I have the master branch where I
> have a submodule A. I create a branch where I rename the submodule
> to be in the directory B. After doing all of this, everything looks
> good.
> Now, I switch back to master. The first oddity is, that it fails to
> remove the folder B because there are still files in there:
> 
> bschindler@metis ~/Projects/submodule_test (testbranch) $ git
> checkout master
> warning: unable to rmdir other_submodule: Directory not empty
> Switched to branch 'master'
> 
> Git submodule deinit on B fails because the submodule is not known
> to git anymore (after all, the folder B exists only in the other
> branch). I can easily just remove the folder B from disk and
> initialize the submodule A again, so all seems good.
> 
> However, what is not good is that the submodule b is still known in
> .git/config. This is in particular a problem for us, because I know
> a number of tools which use git config to retrieve the submodule
> list. Is it therefore a bug that upon branch switch, the submodule
> gets deregistered, but its entry in .git/config remains?
> 
> thanks a lot
> Benjamin Schindler
> 
> P.s. I did not subscribe to the mailing list, please add me at least
> do CC. Thanks

submodules and checkout don't really play nicely with each other at the
moment.  Stefan (cc'd) is currently working on a patch series to improve
the behavior of checkout with submodules.  Currently, if you want to
ensure you have a good working state after a checkout you should run
`git submodule update` to update all of the submoules.  As far as your
submodule still being listed in the config, that should be expected
given the scenario you described.

If I'm understanding you correctly, A and B are both the same submodule
just renamed on a different branch.  The moment you add a submoule to a
repository it is given a name which is fixed.  Typically this is the
path from the root of the repository.  The thing is, since you are able
to freely move a submodule, its path can change.  To account for this
there is the .gitmodules file which allows you to do a lookup from
submodule name to the path at which it exists (or vice versa).  The
submodules that are stored in .git/config are those which are
'initialize' or rather the submodules in which you are interested in and
will be updated by `git submodule update`.  So given your scenario you
should only have a single submodule in .git/config and the .gitmodules
file should have a single entry with a differing path for each branch.

Hopefully this gives you a bit more information to work with.  Since
Stefan has been working with this more recently than me he may have some
more input.

-- 
Brandon Williams

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2579F2047F
	for <e@80x24.org>; Tue,  1 Aug 2017 17:52:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751947AbdHARwk (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Aug 2017 13:52:40 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33446 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751890AbdHARwj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Aug 2017 13:52:39 -0400
Received: by mail-pg0-f65.google.com with SMTP id u185so3655431pgb.0
        for <git@vger.kernel.org>; Tue, 01 Aug 2017 10:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6RsqdFzkozOPZ1aVpnS6EiTEo5l6kIKGvFCkUM1k/0w=;
        b=PYn55IbPAygy69cbP//rsmA3fD5eEkSi9CbA604qnqjBf8xl/rA6xw8OMH1FIizxn0
         dj+vNRS2uXPVhrjcP0nSjv0m0N2iuBxhYSqPagkTqcvN4TR0mg5JYtfvpKG2JHNmASWK
         aN9c1Yec6LbFHDqvk/KStVCIw2VmyIXtABKfysuDa9Y8LZ4mpTYvyp0zWtpliwC1zyrD
         Phzkw+vb6VKzDQPtRhkSPBVHCgElrIXruFhEhkT1qGF483h11bPGEBqwpYBVn9yO+fY7
         eZdjVK5VlxwC7wbjwpFYAncYxd391/CpbvH2HGbMoHQFVUP/pxAl5Q9uE6RxiFGIyrF7
         7+SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6RsqdFzkozOPZ1aVpnS6EiTEo5l6kIKGvFCkUM1k/0w=;
        b=XNfXN0Cu0DoNXuWSqeE8/rBb9wb6Se4mS/YK2AiXentOSs86iwmwL6PvQq/2a2GOpr
         5qxD4tNCWJmIb/6QM5ugwnQYziJhTVNjwZi+6K3xyBWteOweu20XBz9wJBOYNxcECTNu
         /PdDD7v9GaztnnT9MnNbU/IwQan2wyrk9KqfhX31pkrF47vk79J3sD5NqCfcwZMJkJ6X
         DHfQyyVinLgg6jBf3tiQFV4DOvCUxuiwOCamf5VPYnVeK3MRn8DAd7uMsTsQ4QzbccMu
         BLBWLo5MEtqGo8z8mawO1uw+8umZf3oA64Jft7T8f3MjqqrWIv37JMt1mxxqtx7CmTHR
         66/w==
X-Gm-Message-State: AIVw110RsGfTAMZFvx0g8yy0npNTnqgzNB6G6ZAotDWV0p/XbmcAgdNB
        k8N023HMrMOdH4DqvtI=
X-Received: by 10.84.209.170 with SMTP id y39mr21771188plh.194.1501609958730;
        Tue, 01 Aug 2017 10:52:38 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:ec35:1dee:1562:dd55])
        by smtp.gmail.com with ESMTPSA id h8sm8224179pfe.81.2017.08.01.10.52.37
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 01 Aug 2017 10:52:38 -0700 (PDT)
Date:   Tue, 1 Aug 2017 10:52:36 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     "David A. Greene" <greened@obbligato.org>
Cc:     git@vger.kernel.org
Subject: Re: [RFC] Moving main git-subtree development. to GitHub
Message-ID: <20170801175236.GS13924@aiede.mtv.corp.google.com>
References: <87mv7kf369.fsf@waller.obbligato.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mv7kf369.fsf@waller.obbligato.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

David A. Greene wrote:

>                                                             Essentially,
> I would like to do a "beta" release of the new code while not impacting
> existing users of git-subtree in contrib.

Sounds like a sensible goal.  In-tree, you can do that by saying
"please merge this branch to 'next', but I do not want it in 'master'
yet".  But doing it out-of-tree is even more straightforward, since
you have complete control of the repository people use and do not have
to wait for git to pull in your latest changes.

[...]
> I believe keeping a stable git-subtree in contrib is valuable.

I am not convinced of this.  git-subtree is a well known tool, and in
its role as a separate project then I think distributors are actually
more likely to package it for easy installation by users.  The usual
benefit of contrib of providing visibility for a new project seems to
have already occurred and not be needed as much as it used to be for
this project --- by now it is a very visible project.

[...]
> Does this mode of operation work for the larger git community?  Are
> there suggestions of how to make this work as smoothly as possible?

That said, if we want to keep it in contrib then I think the mode of
operation you described is a good one.

Thanks for your work,
Jonathan

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C238D1FADF
	for <e@80x24.org>; Thu, 11 Jan 2018 17:50:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935434AbeAKRul (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Jan 2018 12:50:41 -0500
Received: from mail-pg0-f53.google.com ([74.125.83.53]:46087 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932621AbeAKRuj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jan 2018 12:50:39 -0500
Received: by mail-pg0-f53.google.com with SMTP id s9so844644pgq.13
        for <git@vger.kernel.org>; Thu, 11 Jan 2018 09:50:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=iDRGYT9gYcf+2hKmWleZf3FH1Rf8oa7WTLEg7WWL1VU=;
        b=aUla850wjGPFeOFVBw+VpeOKSqgAjgit6BzXFlqirwMPXPwggVctpC1ZnYqrOhWI/P
         CGrMjOlLP6tHHAL+8kml0nSky/qQZ9w7WNFk7awLi5Wa4GbZtpC/KE/XxQgMs0Y8Lb5C
         HkPZmZIAsO6HqkuA2ZNeNOWOiIcjMgX3/IRltL6eft9kd/IS9rUpIOqqglhl5yCqRjGj
         qfw7k7f+shtUpN0CiOVXwkrh5lpPMVzW/XwPbncXBiXHBr1BsgE0S1Re4GYl+3aVjzlv
         iZJKoENX1sKbkBCGsb46nfB2rDQfEbMxMHE4lEjNbVTBb3uKnaJNSYJAv7KVQpy7HHFb
         YUcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=iDRGYT9gYcf+2hKmWleZf3FH1Rf8oa7WTLEg7WWL1VU=;
        b=S+BR3M6iXqH/7+dAvMUu+xnHAZ68fh90R+s+v4M1wgCZi9hSvOAEIKXYY6uU/JzvsQ
         p7IFM/adwDtG3IXifYZP0vKMUH3vyLSRk3FVS/SrmaGp5nURAD0fSnCTLyPwokfAV3ZU
         gCm1zOjnyLoXNDc54MEek8rPEaoi2PjJSYiU5CiqIHu/cCvyuNFJOqsG/wtCEHw7Gp6e
         8uA1SesJ+35llpRJhBpuoVk1xi78vuDXIMS4zwhyeoWLcym/kY8vGMpCmnNgE4uLdv+/
         bwtRLmtl+WVBkvGiDGXSmTYu+jOaDjUEjtifs0nQbU+3TzwLB4bbQCho6t2i/8xN5GcW
         VuFQ==
X-Gm-Message-State: AKGB3mJuRQgPnhabkJE3VuxVSmxLO8dsuOvT2F/q6ejIjo46GEP29wLc
        huL8YSv+tqGzqvzdrrp2VOTL+Q==
X-Google-Smtp-Source: ACJfBotM/hEyn0nQEXZQIZqaPOV4LOMOUYt6f/cOsAcNlt+4cKKRo6GWPFgh8/IN+CN/ZVj+r30VCQ==
X-Received: by 10.99.42.83 with SMTP id q80mr18120273pgq.183.1515693038130;
        Thu, 11 Jan 2018 09:50:38 -0800 (PST)
Received: from google.com ([2620:0:100e:422:3800:a714:ab3:b606])
        by smtp.gmail.com with ESMTPSA id y80sm42894526pfi.183.2018.01.11.09.50.36
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 11 Jan 2018 09:50:37 -0800 (PST)
Date:   Thu, 11 Jan 2018 09:50:35 -0800
From:   Brandon Williams <bmwill@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: Unable to de-init stubborn submodule
Message-ID: <20180111175035.GC91567@google.com>
References: <87k1woa3i9.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87k1woa3i9.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/11, Ævar Arnfjörð Bjarmason wrote:
> What if we wanted to drop sha1collisiondetection/ as a submodule and
> replace it with a copy of what's now in sha1dc/? I ran into this with
> another project, but here's a way to reproduce it on git.git:
> 
>     (
>         rm -rf /tmp/git &&
>         git clone git@github.com:git/git.git /tmp/git
>         cd /tmp/git &&
>         git tag nuke-before &&
>         git submodule update --init &&
>         git rm -r .gitmodules sha1collisiondetection &&
>         git commit -m"Nuke sha1dc submodule" &&
>         cp -Rvp sha1dc sha1collisiondetection &&
>         git add sha1collisiondetection &&
>         git commit -m"Now it's not a submodule" &&
>         git tag nuke-after &&
>         git reset --hard nuke-before &&
>         git submodule update --init && # skip this and the below won't fail
>         git reset --hard nuke-after && # Emulate someone doing a pull
>         git ls-tree HEAD | grep sha1collisiondetection && # OK, shows "tree" not "commit"
>         test $(git rev-parse HEAD) == $(git -C sha1collisiondetection/ log -1 --pretty=format:%H) && echo OK || echo WTF
>     )
> 
> This results in a really bizarre state where according to ls-tree
> sha1collisiondetection is a tree at the current commit:
> 
>     040000 tree 81583289d96bdde4b366c243ab524ea28d895ea5    sha1collisiondetection
> 
> But git still believes there's a submodule there for some reason, and
> shows the log for the upstream sha1collisiondetection project:
> 
>     git -C sha1collisiondetection/ log -1
>     commit 19d97bf (HEAD, origin/master, origin/HEAD, master)
>     Merge: 3f14d1b c93f0b4
>     Author: Dan Shumow <shumow@gmail.com>
>     Date:   Sat Jul 1 12:36:15 2017 -0700
> 
>         Merge pull request #37 from avar/fixup-pull-request-34
> 
>         Fix endian detection logic for Sparc, little endian BSD etc.
> 
> Doing:
> 
>     git submodule deinit sha1collisiondetection
> 
> Does nothing to help, then I thought it might be:
> 
>     git config -f .git/config -l|grep ^submodule
>     submodule.sha1collisiondetection.active=true
>     submodule.sha1collisiondetection.url=https://github.com/cr-marcstevens/sha1collisiondetection.git
> 
> But running:
> 
>     git config --remove-section submodule.sha1collisiondetection
> 
> Doesn't help either, neither does removing the index:
> 
>     rm .git/index &&
>     git reset --hard
> 
> If you then do:
> 
>     rm -rf .git/modules
> 
> You'll get this error:
> 
>     git -C sha1collisiondetection/ log -1
>     fatal: Not a git repository: /tmp/git/sha1collisiondetection/../.git/modules/sha1collisiondetection
> 
> But I can't see what's still referencing it.
> 
> This problem is avoided if, as noted with a comment I skip:
> 
>     git submodule update --init
> 
> But I shouldn't need to remember to de-init a submodule before moving to
> a new commit that doesn't have it, least I end up in some seemingly
> unrecoverable state.
> 
> Am I missing something obvious here?

One thing you could try is adding --recurse-submodule flags to the reset
commands.  IIRC reset ignores submodules unless you specify that flag.

-- 
Brandon Williams

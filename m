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
	by dcvr.yhbt.net (Postfix) with ESMTP id E9DB41F463
	for <e@80x24.org>; Thu, 19 Sep 2019 19:11:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392283AbfISTLJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Sep 2019 15:11:09 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42443 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391010AbfISTLI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Sep 2019 15:11:08 -0400
Received: by mail-pf1-f195.google.com with SMTP id q12so2906136pff.9
        for <git@vger.kernel.org>; Thu, 19 Sep 2019 12:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Kb+WZQszH7R2+Ltq1TdKWcvozYj9xIznIdFGNfuRhfw=;
        b=IV2EHsDuBTJXRQXYtmHkt7Lxvum/hltE7bMTdKaIpUcfxe9ogBco4deOZs5dNuGqrj
         x4RiTbHS5XhKec3kzykdJ77ktq0fkYHyHgE6AWTLhdAclmND/IeCBurxc4+Cwpk0FKsT
         Bvur60uDZGLzfqo7GrDKePYEopjnxqXLWq+aES199bY8L8784pqhb6z6ON2dZsBPyJFC
         0G449S2TLZSvBaCb1Tz9cBAR6cEQLJGTvdN4jH1dEbuyi3f31kQFd+XiSCmUGwkGwy5U
         vXKuPSLjqkdbZgdYeiAAHvfHCd0HbhJBZMGR8GSTTiua4OXgUm/jlCpd73D/eOTTOLFE
         xkYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Kb+WZQszH7R2+Ltq1TdKWcvozYj9xIznIdFGNfuRhfw=;
        b=G2bEFB5kp/Xffhlfpy3MuT+PlpeohWflm7gd6JN8/qdg96vakZAlWos2vDUsZvZDKt
         sktxgr+qwfS8ho3wJNAtj39RjJlpLyJ4d2ddYEGPiGweXsZaZhOSwZdouUQsuL50md38
         PP22srcGLdzeyj2XVC7Tkg5UxUatpXwbLxn8Y/GZRSIDu7wGpl23Xz8OoFu15HjYOw58
         mY/d+pQLmxKb+E1z7JGjKU1kfhiW2fEbKphjCExokFGs9bO/NS52r1al7H2rNwxWmzmw
         O1B4SxCdZY1K7lqocH6/+R7x0cOouK/3Q/3vDd6nM+BtKhgXcuddrpEOeEWsmEQW+mds
         ncbg==
X-Gm-Message-State: APjAAAUpJZ9N5RW4VN//fHzDNlCtPp4gPLBVuWXBqnaCW5r1le8No6dO
        FZJde2t7lAG8ohDEhI0ou8I=
X-Google-Smtp-Source: APXvYqzyB6u1gHmkWM8oKE1ry58IeyEw+I6YiurhqxgcOgHIEatheafSNq6B89nIVuozCzxa1IwZdQ==
X-Received: by 2002:a63:2157:: with SMTP id s23mr10943464pgm.167.1568920267884;
        Thu, 19 Sep 2019 12:11:07 -0700 (PDT)
Received: from dentonliu-ltm.internal.salesforce.com ([204.14.239.53])
        by smtp.gmail.com with ESMTPSA id d5sm16740179pfa.180.2019.09.19.12.11.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Sep 2019 12:11:07 -0700 (PDT)
Date:   Thu, 19 Sep 2019 12:11:05 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Birger Skogeng Pedersen <birger.sp@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: git-gui: missing some patches from git?
Message-ID: <20190919191105.GA85790@dentonliu-ltm.internal.salesforce.com>
References: <CAGr--=KXqFbivuXHPNecb3dBR_hx8QqWoR4pBGXy7uOiT+ESbg@mail.gmail.com>
 <20190918092721.GA76617@archbookpro.localdomain>
 <20190918151404.rqjohdderwxfqtdm@yadavpratyush.com>
 <xmqqblvh5wbr.fsf@gitster-ct.c.googlers.com>
 <20190919183258.g7ae4u5nzuzwgu7b@yadavpratyush.com>
 <20190919184708.GA83166@dentonliu-ltm.internal.salesforce.com>
 <20190919190359.cuvy5g3xangrkgim@yadavpratyush.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190919190359.cuvy5g3xangrkgim@yadavpratyush.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 20, 2019 at 12:33:59AM +0530, Pratyush Yadav wrote:
> On 19/09/19 11:47AM, Denton Liu wrote:
> > On Fri, Sep 20, 2019 at 12:02:58AM +0530, Pratyush Yadav wrote:
> > > Hi Junio,
> > > 
> > > On 18/09/19 10:49AM, Junio C Hamano wrote:
> > > > Pratyush Yadav <me@yadavpratyush.com> writes:
> > > > You should be able to merge this (and all other git-gui topics
> > > > already in my tree Denton pointed out) to your 'master'.  If you
> > > > then make a trial merge of the result back into my tree with "git
> > > > merge -Xsubtree=git-gui", it should result in "already up to date",
> > > > i.e. a noop merge.
> > > 
> > > I pulled all the changes into git-gui. I had to manually backport two 
> > > commits:
> > > 
> > >   * 7560f547e6 (treewide: correct several "up-to-date" to "up to date", * 2017-08-23)
> > >   * 00ddc9d13c (Fix build with core.autocrlf=true, 2017-05-09)
> > > 
> > > because they touched other parts of git, that were not in git-gui.
> > > 
> > 
> > For the record, you could do a
> > 
> > 	git cherry-pick -Xsubtree=git-gui 00ddc9d13c 7560f547e6
> > 
> > to bring them over instead of manually recreating the changes yourself.
> > Personally, I'd prefer the cherry-picked commits as it'd preserve
> > authorship information but I'm not sure how Junio feels.
> 
> I'm not sure how this will work internally, but won't this also pull all 
> the ancestors of those commits into git-gui? That is bloat I'd rather 
> avoid.
> 
> I tried creating branches for those two commits and then did a subtree 

Since those two commits have parents that are found in git.git, you'll
pull the whole history of git.git if you try doing this.

> pull, and that is what happened. The repo size went up from around 6M to 
> 72M. Will cherry-picking avoid that?
> 

Yes, when you cherry-pick, you're essentially replaying the patch from
the old tree onto the new tree and recording a fresh commit from it. The
new commit is completely separate from the one it's based on so you
won't end up pulling in any ancestry information and, as a result, you
won't pull the rest of git's history.

In any case, give it a try. It doesn't hurt to experiment and play
around with it.

> And if it won't, how about munging a patch created by format-patch to 
> get the authorship information without having to pull all the ancestors?
>  
> > From a correctness perspective, however, I compared my results after
> > doing that with yours and it's identical.
>  
> > > If it looks all good, I'll put all this on my 'master' and re-send 
> > > the pull request.
> > 
> > I took a look as well and the end result looks good to me too.
> 
> Thanks.
> 
> -- 
> Regards,
> Pratyush Yadav

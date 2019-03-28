Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 393B620248
	for <e@80x24.org>; Thu, 28 Mar 2019 21:05:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbfC1VFE (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Mar 2019 17:05:04 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45730 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbfC1VFE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Mar 2019 17:05:04 -0400
Received: by mail-wr1-f67.google.com with SMTP id s15so24649450wra.12
        for <git@vger.kernel.org>; Thu, 28 Mar 2019 14:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=vlxz3mMlchR2AaLXYhYOGLa6K3OmedaFMsyn/sE59GM=;
        b=NyDa8HqEMN/M9fBXa3Niuc16fD6gnpuigPByuHaKGwOKMT+ePXdf+72Z/cwZp6waqa
         atsLjpYTfdNE+crb+C72ermCuLQOzWIDiAGKd6FAhxDi5jEfm5nNA1DJyee6nDJyO6Qs
         XplSLAzMQ7mA9GJq10t05r6R9Kg1ow0qK1k2T+wBRcP+A8xUjmpPsM3HZOkxlYgzt4LQ
         G1ZmaHMUzHEp/Q/92eH5N0sUX7u9d1NWNaONCKR4/rHg6KOLfOWEgZNZu1Pq6078EINL
         cr0N+juKWreabtyNsbDcY3mAqxpHey7lKauVYZqVR+MWqTyfX9f732KdvxHGh1ra7y4z
         d5Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=vlxz3mMlchR2AaLXYhYOGLa6K3OmedaFMsyn/sE59GM=;
        b=WbuS3rbSuIYEic/uhKee8G5DoV65BoSyY7x186ELIBv/CASE7ARSUPRHbNPGdQc/WU
         dv0pvmaADeWjfe50LZGRraV6GqSPb9k2OY1HQ50zj/aOIm4o3k8ZGHBzxBx0iZ97BeTZ
         aSXfywLNgHd7lJ5Rih6TtbJhWBvT+fFG0j63G0CpldVsc2cKRJgzXR4oycPmqyDkWZeH
         HY4Rx2BElkO1jcoG5BXFnUU66v86VD/yPCOAk5c2Sh/H8KbVTGL/TCclYRDKe742gDsW
         5Bg2tw8f2hNZga0Od58v1ZwZ8frz5hKOZyac6B6mFcyAxhlEDArVgq7llUoXqRyVEq5S
         +CLA==
X-Gm-Message-State: APjAAAV4AiBce85+VlZxC0Kdll2Pk4NRiUIAQgZhHUWuIvRgzEWfSJtL
        l2R9y+hcQWZ301nSVYH4wkE=
X-Google-Smtp-Source: APXvYqxfmJ4nOJ0DINLqpQX6ysIMCkxDx/Mwkk0IG1DIGaQ3+7bCkrPfWGbYOJfFAkKO80hIl/iIvQ==
X-Received: by 2002:a5d:410a:: with SMTP id l10mr30422000wrp.182.1553807102720;
        Thu, 28 Mar 2019 14:05:02 -0700 (PDT)
Received: from localhost ([31.127.45.89])
        by smtp.gmail.com with ESMTPSA id e9sm342468wrp.35.2019.03.28.14.05.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 14:05:01 -0700 (PDT)
Date:   Thu, 28 Mar 2019 21:05:00 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Philip Oakley <philipoakley@iee.org>,
        Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v3] glossary: add definition for overlay
Message-ID: <20190328210500.GH32487@hank.intra.tgummerer.com>
References: <xmqqa7i8ss4l.fsf@gitster-ct.c.googlers.com>
 <CACsJy8C7F_Ju2F7COUVd9-1FcyQL=mZph7qmkDh9sS-ENb4PEQ@mail.gmail.com>
 <f6052ac6-60c4-1e70-b3f4-571885ba9e8d@iee.org>
 <CACsJy8D48YiWYkuLW8BbeYvRz=yMmb=XWoMJroPXFAcSV2VjHw@mail.gmail.com>
 <20190309172733.GC31533@hank.intra.tgummerer.com>
 <20190312233040.GE16414@hank.intra.tgummerer.com>
 <20190317201956.GB1216@hank.intra.tgummerer.com>
 <3d2ad13b-b5de-7e8f-9647-983e964c6303@iee.org>
 <xmqqbm23qzj8.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqbm23qzj8.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/22, Junio C Hamano wrote:
> Philip Oakley <philipoakley@iee.org> writes:
> 
> >> of 'cp -R'.  I thought of making the same clarification for 'rsync
> >> --delete' as well, however I think with it being explicitly specified
> >> for 'cp -R', readers should be able to deduce that we are talking
> >> about the destination directory there as well.
> > As a historically Windows user, we should ensure that the meaning is
> > clear to all without the otherwise helpful *nix command examples.

Sure, it would definitely be good to be clear to users of all
platforms.  Is the text by itself not understandable enough?  If not
do you have any suggestions to improve it?

I think giving the example of 'cp -R' is still good, even if not all
Windows users are familiar with it, as it's supposed to provide some
additional context.  But it's only an additional example, the sentence
is supposed to be understandable either way.  Would there be a similar
command for Windows that could be used as an example?

> I do not know about "cp -R", but surely "rsync" is used by Windows
> users as well as users of Unix based systems, isn't it?
> 
> >> +	Only update and add files to the working directory, but don't
> >> +	delete them, similar to how 'cp -R' would update the contents
> 
> > perhaps  s/them/any files/
> 
> Probably.  The paths that are not deleted are certainly different
> set of paths from those that are updated and/or added, so it sounds
> like a reasonable thing to do.

Thanks, will update this.

> >> +	in the destination directory.  This is the default mode in a
> >> +	<<def_checkout,checkout>> when checking out files from the
> >> +	<<def_index,index>> or a <<def_tree-ish,tree-ish>>.  In
> >> +	contrast, no-overlay mode also deletes tracked files not
> >
> > understanding the past/future distinction is tricky here. Maybe
> > 'deletes previously tracked files that are no longer present in the
> > new source'.
> >
> > It's tricky talking about deleting things that are not there.
> 
> I am afraid that "previously" may be taken too literally by readers
> and misunderstood as paths that had been tracked even once in the
> past.  
> 
> If you think that is worried too much because we can only delete
> what is _currently_ in the index, and any past before what is in the
> current index cannot ever affect the outcome, the same reasoning
> tells me that the original is clear enough without "previously",
> i.e. "tracked ones not present in..." are the ones that are in the
> index currently, but the tree that we are taking new contents from
> does not have them.

Agreed, I think I prefer the current version over the suggested change
here too.

> I dunno.
> 
> >> +	present in the source, similar to 'rsync --delete'.

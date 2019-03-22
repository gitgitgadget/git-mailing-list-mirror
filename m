Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D4D220248
	for <e@80x24.org>; Fri, 22 Mar 2019 04:54:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbfCVEy4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Mar 2019 00:54:56 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38187 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbfCVEy4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Mar 2019 00:54:56 -0400
Received: by mail-wm1-f66.google.com with SMTP id a188so821318wmf.3
        for <git@vger.kernel.org>; Thu, 21 Mar 2019 21:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=OhAnWKLU7H5uyM3aCLKVR2Yz/OqHwWsH81THLBrZfSA=;
        b=tI/7qY5xCVhsioFACxB/jiTatv3QPYbeEFnUDN7yTWRxL7PNmywXuXOe6RIDA/WbUv
         7BftmZ8tKCHkJosn0PKkdLlr6p0I6PTTuvjVSk5tT4PY26/MgcZZS45jLP4aCYlRURbe
         ukApQy6yvRegTHPKyz4tKyZT88+M3yBT84V+s38YCMXVUDtLnfm06HfrqvyVZSa7kA6A
         n2rrmkj0P0EmVrqwh0ear4tZPe/bhf19kg6Nmgtcso7/H0xWn28nvm3BxjEemKVCM/nF
         ZLy5ITSvtiX0ofFltQsXuLI6mYNzqZaoAdLimy4VplDUYu+MfmP4ghI92efVOQbVXkUm
         peIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=OhAnWKLU7H5uyM3aCLKVR2Yz/OqHwWsH81THLBrZfSA=;
        b=A2rcUNT5hb1RxZN2foJ4e9YHquVSleEXkF0k+8ZVIe2jQ6DK8bVCO1QdCcavBM3WDP
         y53lMr7x49OnpvY1A38dv+7CV4veC/0w//KZq+9IN5e9pVjWsb0df8A68nK14RrTWMkL
         SK8x/PoIk9M/tAGu8IoUnrv3W9Vsxc/LRRJR05VP3tP94iM2EUE6xVR/QkeU6zBvHLVM
         PV54aGuBunP1usJIsWHi5O6Ji4sGsf5Ml0BQP41c+QS9W7zwkNovoy2aCR+ueyEU5b6h
         1iNwBOsxpLywiRLAncxZ2l1vJBYewzjHh/FkgcMVZBQQJxhZEXj5YgpIM9eWkPXVHsL9
         s7yw==
X-Gm-Message-State: APjAAAUeluo3TRqyivRLKoPPxMLFnkJSlwIUSS03PTWQtV5gmqk1LfTC
        etSJisY5q2+OFf92tsmwEYg=
X-Google-Smtp-Source: APXvYqwQlB0/l1e7lmpsDPACD+8tgxfADoI1c23OsrXBzn2PbYEH8kI+b5b7wRUu1z6xPUw4jdwSbw==
X-Received: by 2002:a1c:44:: with SMTP id 65mr1422146wma.127.1553230493814;
        Thu, 21 Mar 2019 21:54:53 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id d9sm5108434wmb.8.2019.03.21.21.54.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Mar 2019 21:54:52 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philip Oakley <philipoakley@iee.org>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v3] glossary: add definition for overlay
References: <xmqqa7i8ss4l.fsf@gitster-ct.c.googlers.com>
        <CACsJy8C7F_Ju2F7COUVd9-1FcyQL=mZph7qmkDh9sS-ENb4PEQ@mail.gmail.com>
        <f6052ac6-60c4-1e70-b3f4-571885ba9e8d@iee.org>
        <CACsJy8D48YiWYkuLW8BbeYvRz=yMmb=XWoMJroPXFAcSV2VjHw@mail.gmail.com>
        <20190309172733.GC31533@hank.intra.tgummerer.com>
        <20190312233040.GE16414@hank.intra.tgummerer.com>
        <20190317201956.GB1216@hank.intra.tgummerer.com>
        <3d2ad13b-b5de-7e8f-9647-983e964c6303@iee.org>
Date:   Fri, 22 Mar 2019 13:54:51 +0900
In-Reply-To: <3d2ad13b-b5de-7e8f-9647-983e964c6303@iee.org> (Philip Oakley's
        message of "Thu, 21 Mar 2019 14:48:28 +0000")
Message-ID: <xmqqbm23qzj8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@iee.org> writes:

>> of 'cp -R'.  I thought of making the same clarification for 'rsync
>> --delete' as well, however I think with it being explicitly specified
>> for 'cp -R', readers should be able to deduce that we are talking
>> about the destination directory there as well.
> As a historically Windows user, we should ensure that the meaning is
> clear to all without the otherwise helpful *nix command examples.

I do not know about "cp -R", but surely "rsync" is used by Windows
users as well as users of Unix based systems, isn't it?

>> +	Only update and add files to the working directory, but don't
>> +	delete them, similar to how 'cp -R' would update the contents

> perhaps  s/them/any files/

Probably.  The paths that are not deleted are certainly different
set of paths from those that are updated and/or added, so it sounds
like a reasonable thing to do.

>> +	in the destination directory.  This is the default mode in a
>> +	<<def_checkout,checkout>> when checking out files from the
>> +	<<def_index,index>> or a <<def_tree-ish,tree-ish>>.  In
>> +	contrast, no-overlay mode also deletes tracked files not
>
> understanding the past/future distinction is tricky here. Maybe
> 'deletes previously tracked files that are no longer present in the
> new source'.
>
> It's tricky talking about deleting things that are not there.

I am afraid that "previously" may be taken too literally by readers
and misunderstood as paths that had been tracked even once in the
past.  

If you think that is worried too much because we can only delete
what is _currently_ in the index, and any past before what is in the
current index cannot ever affect the outcome, the same reasoning
tells me that the original is clear enough without "previously",
i.e. "tracked ones not present in..." are the ones that are in the
index currently, but the tree that we are taking new contents from
does not have them.

I dunno.

>> +	present in the source, similar to 'rsync --delete'.

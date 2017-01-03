Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC9DD1FEB3
	for <e@80x24.org>; Tue,  3 Jan 2017 17:58:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759512AbdACR6v (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jan 2017 12:58:51 -0500
Received: from mail-pf0-f176.google.com ([209.85.192.176]:35937 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753143AbdACR6t (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jan 2017 12:58:49 -0500
Received: by mail-pf0-f176.google.com with SMTP id 189so77957845pfz.3
        for <git@vger.kernel.org>; Tue, 03 Jan 2017 09:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CTp8Gml3vQPR2CvAlGZ7NVrFwH05jcUJBwPVMDr1LYE=;
        b=qcpdAEBZrcxoUQDHxPial4MwRaYL9tHGnoM9B/hJWMGsW0dgRk2FM+Ewc6VwM87hZC
         yJZ6uL1pJN1t2dJOvvV6JPvL/MHD/UOdH2xDKwpbYwlO/cXmueIwHcHcmnM5DeVtYylY
         Aw37O0Hw7XI2tTlorKPiuVCUq+ldsbvmx+8jOFxMdRXAt0/NBty6HH7Dv4cBJZ3AJybd
         zpP7tCysyha/H7SFefrUtpQlJSiLHfnCEvCz9gg6adbex6tmy33ZKdsSiHdus1EDgIQO
         1kCCu9dwQdPczGsVrU8tGFxREFMLEEicg1aoNVGQYnhUE18eaUiC2kTv8NB8PGReGWS4
         19xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CTp8Gml3vQPR2CvAlGZ7NVrFwH05jcUJBwPVMDr1LYE=;
        b=N1vudqOPnsDqqSwFJw/a69BSfbqwOrs3biHe0Sl4GW79NALTXNMhcDbZLiwfm41RVV
         D7CPj+qzrtnq3Pov7JTtSTFBRdUbyfvR0XnwymO8FGZ2fQvVbU5SXgP8Z/B+HpBuLEBq
         qcSZ/AgiEuxwD4UGwuFCo31G8qQFBQ3eP+9FA2Xk7Hd327dWbY+REfN1IrEw5dO+samy
         tYQyAfcEGGRTgH4jOmcRciQjkCy05tw60sdW68rYQ12oe6eiebQ0o9EhBT9ZDy6qgked
         fCtcG625gToLcm+75ejeZp5F3TaY+t3uiPWg1oeTOwkf59BBwvkGIBdn2Be8wxj8eJS9
         rS3w==
X-Gm-Message-State: AIkVDXL6EYL2OiO8XdWYrWayH4EaT9Kfthbzn5khE+ck7QMo+UENcXh+locC74ueOizycFhf
X-Received: by 10.99.226.83 with SMTP id y19mr117463911pgj.147.1483466328727;
        Tue, 03 Jan 2017 09:58:48 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:c019:d4:4575:9b1b])
        by smtp.gmail.com with ESMTPSA id k67sm141394634pfk.69.2017.01.03.09.58.47
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 03 Jan 2017 09:58:47 -0800 (PST)
Date:   Tue, 3 Jan 2017 09:58:46 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Dec 2016, #08; Tue, 27)
Message-ID: <20170103175846.GA42671@google.com>
References: <xmqqy3z155o1.fsf@gitster.mtv.corp.google.com>
 <20161228181808.GC33595@google.com>
 <CACsJy8CmKBpWa=yi44vGUe56CmeT-Swh_M_XxMeA+xkLLUhQ3Q@mail.gmail.com>
 <CACsJy8BxsEtU0q4VBpRpELTnubmL624n35Hw3HPhBVx4=6b5DQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACsJy8BxsEtU0q4VBpRpELTnubmL624n35Hw3HPhBVx4=6b5DQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/03, Duy Nguyen wrote:
> On Thu, Dec 29, 2016 at 5:06 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> > On Thu, Dec 29, 2016 at 1:18 AM, Brandon Williams <bmwill@google.com> wrote:
> >> On 12/27, Junio C Hamano wrote:
> >>> * bw/pathspec-cleanup (2016-12-14) 16 commits
> >>>  - pathspec: rename prefix_pathspec to init_pathspec_item
> >>>  - pathspec: small readability changes
> >>>  - pathspec: create strip submodule slash helpers
> >>>  - pathspec: create parse_element_magic helper
> >>>  - pathspec: create parse_long_magic function
> >>>  - pathspec: create parse_short_magic function
> >>>  - pathspec: factor global magic into its own function
> >>>  - pathspec: simpler logic to prefix original pathspec elements
> >>>  - pathspec: always show mnemonic and name in unsupported_magic
> >>>  - pathspec: remove unused variable from unsupported_magic
> >>>  - pathspec: copy and free owned memory
> >>>  - pathspec: remove the deprecated get_pathspec function
> >>>  - ls-tree: convert show_recursive to use the pathspec struct interface
> >>>  - dir: convert fill_directory to use the pathspec struct interface
> >>>  - dir: remove struct path_simplify
> >>>  - mv: remove use of deprecated 'get_pathspec()'
> >>>
> >>>  Code clean-up in the pathspec API.
> >>>
> >>>  Waiting for the (hopefully) final round of review before 'next'.
> >>
> >> What more needs to be reviewed for this series?
> >
> > I wanted to have a look at it but I successfully managed to put if off
> > so far. Will do soonish.
> 
> I have just sent a couple of minor comments. The rest looks good!

Thanks!  I'll go take a look.

-- 
Brandon Williams

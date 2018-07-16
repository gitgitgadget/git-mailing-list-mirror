Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EAD241F597
	for <e@80x24.org>; Mon, 16 Jul 2018 20:40:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728558AbeGPVJ0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 17:09:26 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]:39770 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728290AbeGPVJZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 17:09:25 -0400
Received: by mail-wr1-f43.google.com with SMTP id h10-v6so33208368wre.6
        for <git@vger.kernel.org>; Mon, 16 Jul 2018 13:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CiP6s6Hofq28Y2jfU6yBre5pb0qrQvV0j6gSWG43wMc=;
        b=TsnK6JRI0N9lthYpwqyYM5XYGAYR10XFVsN5DYvKgo3shAZev6i96PdndAzxJOy7gD
         I3jy7SIwDdVEr5Kt3HYscKUjkVUloeLPxWaXg6H1bheAFSmZAZeilQfI4ptQavq2jakS
         2c/bflSKrNlsVypPhTQEmQYG+r62KVMe3V0AUsbNa1Ilw6zQWXdQtiqy9wrrJRwHxqIc
         eo39NJLF4sJjFS0UOBrOb88FN0hk5I3aRGQZ4NOXw+vxLU+RH5zj7eTWYH59np4rYpqk
         C5fILDN5TjqahJqpi/GNYUy7VxeXjlDcMgFShmsJTrkbZb2FcKtJU8ezSijDhDnJbEhl
         2j4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CiP6s6Hofq28Y2jfU6yBre5pb0qrQvV0j6gSWG43wMc=;
        b=Jd1md3JOeFVFBt8izeNGR7qvSKcK1DDHY0iuKrOnKysw03tS80MdmwyiEfZheluva0
         BX41T4MTTl8KJMbCO5uJ2FfJNlvfxnDkNs4jlMHxM8vo0+jr8Y4MI/XIbn31r/wyPI9Q
         135pICb9AyZNgv1oe+DGVVRwnfJXOpp+jW8gb8jJ+wP1qEDoenVzJ6P75XBgjg1WcL4o
         uZyfi/DVSHsDRvL/aXZlY+ZXfRt0tqE9d1LPj1p6cEBO/1r5rK4vyydR/SYVDwHIlhb0
         QhTzKXmasK4q4DjES2LejPFWroJpg6K/mhSc5+CqKpLpwohOyo0ECVzqSiiHn7eTypFf
         QtzQ==
X-Gm-Message-State: AOUpUlGoEkuznvnw1D8a32EXXW1phRFj8vAurh5YycYI5juP+4IfzArs
        cpaETDUONuH89FcJcjpDUCcLmMz6
X-Google-Smtp-Source: AAOMgpetq34QWEjidiPnA/ogPGvZBNMp6OZNGSl5moGr7l+t9a/J2/UslxbqAmm52yhcd90QYNvSug==
X-Received: by 2002:adf:84e5:: with SMTP id 92-v6mr13459653wrg.56.1531773619395;
        Mon, 16 Jul 2018 13:40:19 -0700 (PDT)
Received: from localhost ([2.30.88.37])
        by smtp.gmail.com with ESMTPSA id m136-v6sm17079515wma.32.2018.07.16.13.40.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 13:40:18 -0700 (PDT)
Date:   Mon, 16 Jul 2018 21:40:17 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Simon Ruderich <simon@ruderich.org>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 04/11] rerere: mark strings for translation
Message-ID: <20180716204017.GB2186@hank.intra.tgummerer.com>
References: <20180605215219.28783-1-t.gummerer@gmail.com>
 <20180714214443.7184-1-t.gummerer@gmail.com>
 <20180714214443.7184-5-t.gummerer@gmail.com>
 <20180715132421.GA5015@ruderich.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180715132421.GA5015@ruderich.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/15, Simon Ruderich wrote:
> On Sat, Jul 14, 2018 at 10:44:36PM +0100, Thomas Gummerer wrote:
> > 'git rerere' is considered a plumbing command and as such its output
> 
> s/plumbing/porcelain/?

Ah yes indeed.  Thanks for catching!

> Regards
> Simon
> -- 
> + privacy is necessary
> + using gnupg http://gnupg.org
> + public key id: 0x92FEFDB7E44C32F9

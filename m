Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A52AD1F859
	for <e@80x24.org>; Wed, 17 Aug 2016 01:32:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753252AbcHQBcr (ORCPT <rfc822;e@80x24.org>);
	Tue, 16 Aug 2016 21:32:47 -0400
Received: from mail-ua0-f171.google.com ([209.85.217.171]:34942 "EHLO
	mail-ua0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752325AbcHQBcq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2016 21:32:46 -0400
Received: by mail-ua0-f171.google.com with SMTP id n59so150601427uan.2
        for <git@vger.kernel.org>; Tue, 16 Aug 2016 18:32:45 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HxmH43mPHjb5HdjdASbZdtj1c9uyxZ1LsCaJHK0j7rg=;
        b=qXOmBya/fqfTb+6X4sk9d8A+BpozxWPWjoB9XiGEuj436WSR5jG00DApx9ShW9pqRH
         3B5fUllGHTunq+Fl75lwWiiSqTCOxTbw9RiVBTYr9/lJtz79nSp1oGPzx2jeQqzf2XJX
         /KRRV8QByt94mXc/sYnY6fSEMRvPXzcelzYXkMijnGZ+iEmc6nQxMbDbVRDl+QzxuiPb
         YKOXK2nSrJEneXS45sHqJUOVbjxEUhpkO5pMTHKGRKh/tbDckX/r1C+T/IIzWRqGj+k+
         8sPBOio2GbMf/CV2Bj/ZlYr3xZWE27NrrcO2gZWyCtsoYGKI4RjHsAO3yMptRav4Ig1a
         pZQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HxmH43mPHjb5HdjdASbZdtj1c9uyxZ1LsCaJHK0j7rg=;
        b=PkQ2bD2yMrJLxMj74L+Q8Lg3j//0h5IkxgROqVMFzRvzTv4eTPeuMWuvF80xdA7RW5
         Q+1k99KVBHjaCyNnRvHCeTCVMtWvEPqALQzbwHxWt6NnbooXzrfQm6/i2CUNVElo4Y9G
         5Ah6483G0Pc0pBYyaiRCQhyPgYrsGf++f6B3aA+d0/s87J2RFcwqcIaYziUHRivq4tJ7
         s/upWVoySoGk9MLqulj0EcRB3PearSqUJ1Frwpc6hnfgnWfRD4Nc6ikZZh45I0fhapNG
         KCm3K7wZc/3SALyR2t7SCvFUwu8qMSwB1MduPew7Nq4YGJ49VffameZsMJIhwhEiaJhF
         C8ZQ==
X-Gm-Message-State: AEkoousxqldWpcvON95ZwMXIcOKZ0sGScFI7WF4m5nxGEZjJ7vk5bRFGO6HcA3bZ8LNUMg==
X-Received: by 10.31.7.6 with SMTP id 6mr8117158vkh.17.1471397162200;
        Tue, 16 Aug 2016 18:26:02 -0700 (PDT)
Received: from gmail.com ([2800:370:4c:3a70::3])
        by smtp.gmail.com with ESMTPSA id 74sm1790772uag.16.2016.08.16.18.25.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Aug 2016 18:26:01 -0700 (PDT)
Date:	Tue, 16 Aug 2016 18:25:54 -0700
From:	David Aguilar <davvid@gmail.com>
To:	Luis Gutierrez <luisgutz@gmail.com>
Cc:	John Keeping <john@keeping.me.uk>, git@vger.kernel.org
Subject: Re: git-mergetool reverse file ordering
Message-ID: <20160817012554.GA12991@gmail.com>
References: <CAD8hE_yzNZDPkxRy8s4Fy2_dZN5ppWzLM_2xc01C-VAdR1Pj_g@mail.gmail.com>
 <20160814034221.GB21057@gmail.com>
 <20160814103801.tpixnskdsf5ycj66@john.keeping.me.uk>
 <CAD8hE_xR2mB3=_oot9cWxmFy7z4oBhjABNOo3aJKN=bOw5ybzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAD8hE_xR2mB3=_oot9cWxmFy7z4oBhjABNOo3aJKN=bOw5ybzQ@mail.gmail.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Aug 15, 2016 at 09:19:35PM +0100, Luis Gutierrez wrote:
> > Thoughts?  Would you be interested in helping work up a patch
> > for this idea?  At a minimum we should also write a test case in
> > t/t7610-mergetool.sh to verify that it works as advertised.
> ....
> > Why not reuse the existing diff.orderFile config variable?  (Also
> > supported by the -O option to git-diff).
> 
> 
> I'll be happy to write a testcase, and to re-use the -O
> (diff.orderFile config var) option to git-diff as sugguested by John
> Keeping.
> 
> Is this the final spec?
> 
> 
> 
> I'll be happy to do that.
> 
> Luis

Hmm, I do like the idea of reusing the diff orderFile, but a
mechanism for sorting arbitrary inputs based on the orderFile
isn't currently exposed in a way that mergetool could use it.


Looking at the code in mergetool, we basically need something
that has the same spec as "sort" itself, namely that it can take
arbitrary arbitrary input on stdin and sort it.


Implementing the orderFile support would probably be best done
in C.  Would we want to expose it as an internal helper?

e.g.
	git diff--order-helper <order-file>

could be used to perform the sorting.

But, that sort is honestly kinda crude.  It can't implement the
interesting case where we want bar.h to sort before bar.c but
not foo.h.

If we did the sort option, we could have both.

Thoughts?

-- 
David

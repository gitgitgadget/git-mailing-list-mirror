Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HK_NAME_MR_MRS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8976C433E0
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 10:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64B84224F9
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 10:05:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbhAEKFm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jan 2021 05:05:42 -0500
Received: from kane-il.us ([198.74.55.137]:46500 "EHLO kane-il.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727871AbhAEKFm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jan 2021 05:05:42 -0500
X-Greylist: delayed 468 seconds by postgrey-1.27 at vger.kernel.org; Tue, 05 Jan 2021 05:05:42 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kane-il.us; s=mail;
        t=1609840629; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=6NzN1DcmrrCDcdu7v3PWCU6VAjgyXjY1OXJ81dbPrRQ=;
        b=M7qwnWCq1hRAdi4H8zDdv0gv/Jt6ScqMTbbKTSNJvBWzVmPbWNj7rK7gucsMF7RAFatQs8
        Q/ccFYLkbr9cLFXN3nHL4SeQLbFWvgs6ZsQnwGAcA0eE62Aa0beQ+HlQEg2xSUBnkMBiJ9
        ha9j34R7oC129+IkvnlVRDQVKqDtooo=
MIME-Version: 1.0
Date:   Tue, 05 Jan 2021 09:57:08 +0000
From:   "Mr. Sandor Kunyik" <sandor@kane-il.us>
To:     git@vger.kernel.org
Subject: Using Git for OpenSCAD and 3D Printing
Message-ID: <cee9debaf32b69d793d0b8a3e8d4b2c6@kane-il.us>
X-Sender: sandor@kane-il.us
Organization: Factory 4.0 Open Initiative, LLC.
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Greetings,

If you were to design a new workflow, what key observations would you 
make in regards to OpenSCAD scripts?

As a quick illustration: I have a model with cavities to hold hex bolts 
and nuts. I fine-tuned the model to print on PrinterA, using FilamentA, 
SettingsA. Once in "production" I need to "freeze" all relevant scripts, 
especially when using multi-file structure. If the modules receive 
parameters I need to "remember" those parameters (such as the radius for 
the hex, and the dept of the cavity), and if they use hard-coded values 
I must remember not to change them. Otherwise I cannot repeatedly print 
the same model.

Now imagine this for the entire standard set of hex bolts - each of 
these were fine-tuned, test-printed and verified.
The rationale behind this to guarantee that the models trying to conform 
to a standard (such as ASME B18.3) stay put, while models receiving 
non-standardized sizes such as Nylon 6/6/ (which have bigger hex heads) 
stay separated, and tweaked to work with each supplier.

My question is, should I just "hardcode" everything, set up forks or 
branches for all past scenarios? So far I only have a few dozen models 
and I'm already having a hard time finding models I printed and used in 
the past, to print again. How do I structure all this?

I am a mechanical engineer not a coder, new to all these. Maybe git or 
revision control is not the correct tool for this job?

-- 
Thanks for your time reading,
Sandor

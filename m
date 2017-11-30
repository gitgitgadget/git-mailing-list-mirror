Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC24E20954
	for <e@80x24.org>; Thu, 30 Nov 2017 10:35:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751465AbdK3Kfx (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Nov 2017 05:35:53 -0500
Received: from smtp1.de.adit-jv.com ([62.225.105.245]:38444 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750760AbdK3Kfw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Nov 2017 05:35:52 -0500
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
        by smtp1.de.adit-jv.com (Postfix) with ESMTP id D984C3C0062;
        Thu, 30 Nov 2017 11:35:49 +0100 (CET)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
        by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id AaPIdzHMUnQ2; Thu, 30 Nov 2017 11:35:43 +0100 (CET)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id 9062A3C0034;
        Thu, 30 Nov 2017 11:35:43 +0100 (CET)
Received: from vmlxhi-102.adit-jv.com (10.72.93.184) by HI2EXCH01.adit-jv.com
 (10.72.92.24) with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 30 Nov
 2017 11:35:43 +0100
Date:   Thu, 30 Nov 2017 11:35:39 +0100
From:   Eugeniu Rosca <erosca@de.adit-jv.com>
To:     Junio C Hamano <gitster@pobox.com>
CC:     <git@vger.kernel.org>
Subject: Re: Make patch-id more flexible?
Message-ID: <20171130103539.GA19237@vmlxhi-102.adit-jv.com>
References: <20171124073327.GA15188@vmlxhi-102.adit-jv.com>
 <xmqqlgiwm7x1.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <xmqqlgiwm7x1.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.72.93.184]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Junio,

> > file-names. Here comes my actual question. Would it be conceptually fine
> > to implement some `git patch-id` parameter, which would allow ignoring
> > the file-names (or reducing those to their `basename`) before computing
> > the patch id? Or would it break the concept of patch id (which shouldn't
> > accept variations)?
> 
> My gut feeling is that a tool like that would be fine as long as it
> is local to your organization and is not called "git patch-id"; it
> may be useful in the situation you described, but as you mention
> above, it feels that it is differnt from what a patch-id is.
> 

Thank you very much for your feedback. That's exactly I was looking for.
A clear statement from the maintainer. We will live then with a custom
tool that acts like `git patch-id`, just strips the patches from
file-names before computing the hash.

Best regards,
Eugeniu.

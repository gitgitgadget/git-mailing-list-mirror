Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 884BFC4361B
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 02:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C7B42389E
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 02:36:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732266AbgLRCgV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Dec 2020 21:36:21 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:37830 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726951AbgLRCgV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Dec 2020 21:36:21 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <seth@eseth.com>)
        id 1kq5cI-0043MY-9H; Thu, 17 Dec 2020 19:35:38 -0700
Received: from mta4.zcs.xmission.com ([166.70.13.68])
        by in01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <seth@eseth.com>)
        id 1kq5cH-0006PW-On; Thu, 17 Dec 2020 19:35:38 -0700
Received: from localhost (localhost [127.0.0.1])
        by mta4.zcs.xmission.com (Postfix) with ESMTP id 5F366500F3B;
        Thu, 17 Dec 2020 19:35:37 -0700 (MST)
X-Amavis-Modified: Mail body modified (using disclaimer) -
        mta4.zcs.xmission.com
Received: from mta4.zcs.xmission.com ([127.0.0.1])
        by localhost (mta4.zcs.xmission.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id o6ppYK6Dguvm; Thu, 17 Dec 2020 19:35:37 -0700 (MST)
Received: from ellen (unknown [139.60.10.209])
        by mta4.zcs.xmission.com (Postfix) with ESMTPSA id 5CA7C500F53;
        Thu, 17 Dec 2020 19:35:36 -0700 (MST)
Date:   Thu, 17 Dec 2020 19:35:34 -0700
From:   Seth House <seth@eseth.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Johannes Sixt <j6t@kdbg.org>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org, David Aguilar <davvid@gmail.com>
Message-ID: <20201218023534.GA117762@ellen>
References: <20201216174345.28146-1-felipe.contreras@gmail.com>
 <xmqqa6ud2xuw.fsf@gitster.c.googlers.com>
 <105041520.23756286.1608159189934.JavaMail.zimbra@eseth.com>
 <5fdaef83a40ba_d0e26208f6@natae.notmuch>
 <e5c73fed-b87e-2091-794e-19aced4dd25b@kdbg.org>
 <20201217094424.GA75257@ellen>
 <5fdb3471c6bb7_d6d032087@natae.notmuch>
 <20201217175037.GA80608@ellen>
 <5fdc0e6dd79a7_f2faf208a1@natae.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5fdc0e6dd79a7_f2faf208a1@natae.notmuch>
X-XM-SPF: eid=1kq5cH-0006PW-On;;;mid=<20201218023534.GA117762@ellen>;;;hst=in01.mta.xmission.com;;;ip=166.70.13.68;;;frm=seth@eseth.com;;;spf=none
X-SA-Exim-Connect-IP: 166.70.13.68
X-SA-Exim-Mail-From: seth@eseth.com
Subject: Re: [RFC/PATCH] mergetool: use resolved conflicts in all the views
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 17, 2020 at 08:05:33PM -0600, Felipe Contreras wrote:
> > Would you mind switching the autoMerge option to be per-tool rather than
> > under the main mergetool config section?
> 
> As I said; I don't see the point.

I know you've said that. But I would prefer that, and Junio requested
that, and other people may prefer that as well. Since it's not too much
trouble to make the option per-tool with a global fallback, and since
Junio already provided example code to do that, do you mind adding it
anyway even though you don't see the point?


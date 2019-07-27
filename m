Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D395E1F462
	for <e@80x24.org>; Sat, 27 Jul 2019 08:22:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbfG0IW5 (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Jul 2019 04:22:57 -0400
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21487 "EHLO
        sender-of-o52.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727466AbfG0IW5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Jul 2019 04:22:57 -0400
X-Greylist: delayed 903 seconds by postgrey-1.27 at vger.kernel.org; Sat, 27 Jul 2019 04:22:56 EDT
ARC-Seal: i=1; a=rsa-sha256; t=1564214872; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=dDe8ygcmAB8aZD0JNy4vfaj62Ue3ceswftLXJErUR+NDbedp/wlT2biQ7DqALwXPTWYdmdSGmISvSCmsQeuUu+UJ03RR1mTT9vP8FRGqYJyyM9hzZSg+4gEkaToB51JR2VmSfkNT6dH+mn0rfR1BqZCXSJ8n/p6iKK6kuVcRaiw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1564214872; h=Content-Type:Content-Transfer-Encoding:Date:From:MIME-Version:Message-ID:Subject:To:ARC-Authentication-Results; 
        bh=zPv4Ym8OYusp63YkgQG0fT3zTcxAx0P+AjoYXuD7tf4=; 
        b=NVeFUrwWmZM6IQ2GNnRTw3/AChmmbEAN+qDaxuWJ6ZOrT4h7bAWaDMpDD1xlX4esO/Y+HLqG1v70pcPiBEmli46azuiUYyOak0Sqg9EvcsGtlHpTuqlaj6vSjzqgAlP73L2ynpwMQ32itu/XQqMdunJX74C7awNgMHXk+U1d970=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=topbug.net;
        spf=pass  smtp.mailfrom=hong@topbug.net;
        dmarc=pass header.from=<hong@topbug.net> header.from=<hong@topbug.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1564214872;
        s=zoho; d=topbug.net; i=hong@topbug.net;
        h=To:From:Subject:Message-ID:Date:MIME-Version:Content-Type:Content-Transfer-Encoding;
        l=305; bh=zPv4Ym8OYusp63YkgQG0fT3zTcxAx0P+AjoYXuD7tf4=;
        b=es9w+jG3upkZZEl+Ll5N4A6gb3QM2a2x7ELWK0lcbyGsQyxQ3U3AV+nmRtoEhOYT
        eIoff+xytRnUlj0yivSn99S2hvia6Jpii+tLbKGFobwze2hnnVIt07V6hGZO3A1McJ8
        XAJCVIGqsliOXYEeOMhQl8Om20++BvsaI9etKuuQ=
Received: from [192.168.1.88] (69-215-149-151.lightspeed.sntcca.sbcglobal.net [69.215.149.151]) by mx.zohomail.com
        with SMTPS id 1564214871490973.4084040252891; Sat, 27 Jul 2019 01:07:51 -0700 (PDT)
To:     git@vger.kernel.org
From:   Hong Xu <hong@topbug.net>
Subject: git gui blame: Possible to pass more options in?
Openpgp: preference=signencrypt
Message-ID: <2ebb18ea-26a9-68fe-7d5e-e75a18f70a1b@topbug.net>
Date:   Sat, 27 Jul 2019 01:07:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

I tried to run

    git gui blame -C somefile

but I got the following error message:

    error: Unknown switch `C'
    usage: git cat-file (-t .... [What exactly "git cat-file -C" prints
out for me]

Is there a way to pass in additional options to git gui blame for now?

Thanks!

Hong


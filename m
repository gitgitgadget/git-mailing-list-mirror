Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3465E202F2
	for <e@80x24.org>; Thu, 23 Nov 2017 21:24:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753371AbdKWVYZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Nov 2017 16:24:25 -0500
Received: from wp156.webpack.hosteurope.de ([80.237.132.163]:52534 "EHLO
        wp156.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752928AbdKWVYY (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 23 Nov 2017 16:24:24 -0500
Received: from p5099125b.dip0.t-ipconnect.de ([80.153.18.91] helo=[192.168.100.43]); authenticated
        by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1eHyyq-0006Le-Jb; Thu, 23 Nov 2017 22:24:20 +0100
Subject: Re: Unify annotated and non-annotated tags
To:     "Randall S. Becker" <rsbecker@nexbridge.com>, techtonik@gmail.com
Cc:     gitster@pobox.com, git@vger.kernel.org, igor.d.djordjevic@gmail.com
References: <201711231458.vANEwUMK048049@elephants.elehost.com>
 <003c01d3646c$df78fc50$9e6af4f0$@nexbridge.com>
From:   Thomas Braun <thomas.braun@virtuell-zuhause.de>
Message-ID: <f189258d-5709-d236-ff58-5653edc57eb6@virtuell-zuhause.de>
Date:   Thu, 23 Nov 2017 22:24:13 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <003c01d3646c$df78fc50$9e6af4f0$@nexbridge.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1511472264;cd5b8f95;
X-HE-SMSGID: 1eHyyq-0006Le-Jb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 23.11.2017 um 16:08 schrieb Randall S. Becker:

[...]

>> So my proposal is to get rid of non-annotated tags, so to get all
>> tags with commits that they point to, one would use:
>> git for-each-ref --format='%(*objectname) %(refname)' refs/tags>
>> For so-called non-annotated tags just leave the message empty.
>> I don't see why anyone would need non-annotated tags though.

I'm using exclusively non-annotated tags. Why? Because that is the
default of "git tag" and I also, until now, never needed more than
giving a commit a "name".

Many annotated tag messages just repeat the tag name itself, so the
message seems quite redundant to me.

Just my 2 cents,
Thomas

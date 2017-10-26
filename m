Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0239E202A0
	for <e@80x24.org>; Thu, 26 Oct 2017 21:01:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751929AbdJZVBS (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Oct 2017 17:01:18 -0400
Received: from smtp-o-1.desy.de ([131.169.56.154]:53323 "EHLO smtp-o-1.desy.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751305AbdJZVBS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Oct 2017 17:01:18 -0400
X-Clacks-Overhead: GNU Terry Pratchett
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-1.desy.de 9502A280720
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
        t=1509051676; bh=MqMDtoLfOKAeNXSbaL4WSo6RgxvsOblp6b5gY5dGNqM=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=qhFrSACFQjEq6cDSo8wbzu2YI2rA2XWGPEMg3cf71oIKz2SpX3g3VarRdp4kuMTpx
         uGTFREnl4Keo8MqvNFog7tVgrA02D5/cDnRtXNSumvl8KL1p+516p3W/f3KoURRU9K
         pj2S57Udp4oDOu1WCw+UDfeiOzg9EWmKpR+f8HCg=
Received: from smtp-map-1.desy.de (smtp-map-1.desy.de [131.169.56.66])
        by smtp-o-1.desy.de (DESY-O-1) with ESMTP id 9502A280720
        for <git@vger.kernel.org>; Thu, 26 Oct 2017 23:01:16 +0200 (CEST)
X-Virus-Scanned: amavisd-new at desy.de
Received: from z-mbx-2.desy.de (z-mbx-2.desy.de [131.169.55.140])
        by smtp-intra-1.desy.de (DESY-INTRA-1) with ESMTP id 5F4923E901;
        Thu, 26 Oct 2017 23:01:16 +0200 (MEST)
Date:   Thu, 26 Oct 2017 23:01:16 +0200 (CEST)
From:   "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org
Message-ID: <1113033991.3307260.1509051676201.JavaMail.zimbra@desy.de>
In-Reply-To: <20171026205509.2ydjd3bai2l6pqxi@aiede.mtv.corp.google.com>
References: <20171026195516.3354-1-tigran.mkrtchyan@desy.de> <20171026205509.2ydjd3bai2l6pqxi@aiede.mtv.corp.google.com>
Subject: Re: [PATCH] tag: add tag.gpgSign config option to force all tags be
 GPG-signed
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.7.11_GA_1854 (ZimbraWebClient - FF56 (Linux)/8.7.11_GA_1854)
Thread-Topic: add tag.gpgSign config option to force all tags be GPG-signed
Thread-Index: CIDcxIrtQmojnwVPs/luet5+Jc75Dw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Well, this is a build/release process where we can't pass additional
command line options to git. TO be hones, is case of annotated tags
there is already option tag.forceSignAnnotated. However, non annotated
tags are not forced to be signed.

Additionally, the proposed option is symmetric with commit.gpgSign.

Tigran.

----- Original Message -----
> From: "Jonathan Nieder" <jrnieder@gmail.com>
> To: "Tigran Mkrtchyan" <tigran.mkrtchyan@desy.de>
> Cc: git@vger.kernel.org
> Sent: Thursday, October 26, 2017 10:55:09 PM
> Subject: Re: [PATCH] tag: add tag.gpgSign config option to force all tags be GPG-signed

> Hi,
> 
> Tigran Mkrtchyan wrote:
> 
>> In some workflows we have no control on how git command is executed,
>> however a signed tags are required.
> 
> Don't leave me hanging: this leaves me super curious.  Can you tell me
> more about these workflows?
> 
> Thanks and hope that helps,
> Jonathan

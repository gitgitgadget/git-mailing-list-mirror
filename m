Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14D0D1F404
	for <e@80x24.org>; Sat, 23 Dec 2017 17:56:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752835AbdLWR4w convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sat, 23 Dec 2017 12:56:52 -0500
Received: from elephants.elehost.com ([216.66.27.132]:54014 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752688AbdLWR4v (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Dec 2017 12:56:51 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from pangea (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id vBNHun1J027493
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 23 Dec 2017 12:56:49 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "=?UTF-8?Q?'=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason'?=" 
        <avarab@gmail.com>, <git@vger.kernel.org>
Cc:     "'Junio C Hamano'" <gitster@pobox.com>,
        "'Jeff King'" <peff@peff.net>,
        "'Eric Sunshine'" <sunshine@sunshineco.us>,
        "'Eric Wong'" <e@80x24.org>, "'Jakub Narebski'" <jnareb@gmail.com>,
        "'Petr Baudis'" <pasky@suse.cz>,
        "'Giuseppe Bilotta'" <giuseppe.bilotta@gmail.com>
References: <20171223174400.26668-1-avarab@gmail.com>
In-Reply-To: <20171223174400.26668-1-avarab@gmail.com>
Subject: RE: [RFC/PATCH] perl: bump the required Perl version to 5.10.0 from 5.8.0
Date:   Sat, 23 Dec 2017 12:56:44 -0500
Message-ID: <000601d37c17$68423da0$38c6b8e0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQEUWQ8ICrXsuuNxESGgpA55PZpyf6TPe86g
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On December 23, 2017 12:44 PM,  Ævar Arnfjörð Bjarmason wrote:
> 
> In late 2010 I bumped our perl version dependency from 5.6.* to 5.8.0[1]. Git
> had been failing for a while on <5.8, and it was suspected that nobody cared
> enough to keep using it, which turned out to be true.
> 
> Follow that up with bumping the dependency to 5.10.0. The 5.8.0 release
> was released in 2002, and the 5.10.0 release just turned 10 years old[2].

The git HPE NonStop NSE/NSX ports that I maintain has Perl 5.22 generally available, so no objections here. Ours is just a CPAN dependency concern as previously discussed. 😊

Cheers,
Randall

-- Brief whoami: NonStop&UNIX developer since approximately UNIX(421664400)/NonStop(211288444200000000)
-- In my real life, I talk too much.




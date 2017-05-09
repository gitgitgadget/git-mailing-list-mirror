Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A79F2018D
	for <e@80x24.org>; Tue,  9 May 2017 21:42:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750767AbdEIVmg convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 9 May 2017 17:42:36 -0400
Received: from elephants.elehost.com ([216.66.27.132]:14871 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750734AbdEIVmg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2017 17:42:36 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.238.41.215])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id v49LgXD0047938
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 9 May 2017 17:42:33 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Pierre J. Ludwick'" <pierrelud@gmail.com>, <git@vger.kernel.org>
References: <0629aefd-d6f9-ee6c-27f6-1244552e3550@yahoo.com> <75e9acf2-006e-9844-2e91-ac48cde625c0@gmail.com>
In-Reply-To: <75e9acf2-006e-9844-2e91-ac48cde625c0@gmail.com>
Subject: RE: git client debug with customer ssh client
Date:   Tue, 9 May 2017 17:42:19 -0400
Message-ID: <000001d2c90d$25f09f90$71d1deb0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKiyrAu/1soDB152OFAld0aadWwrwISFYGBoDvzGgA=
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On May 5, 2017 7:50 AM  Pierre J. Ludwick wrote:
<big snip>
> How can we get more info from git client? Any helps suggestions welcomed?

It might be helpful to put a full trace in OpenSSH. Running ssh with -vvv should give you a lot of noise. I have used 
https://en.wikibooks.org/wiki/OpenSSH/Logging_and_Troubleshooting
to pull information when the platform's OpenSSH port was done. If you need access to the ported code, the sources are available in the usual spot at ITUGLIB.

Cheers,
Randall


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A88421F731
	for <e@80x24.org>; Fri,  9 Aug 2019 14:06:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406863AbfHIOGW convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 9 Aug 2019 10:06:22 -0400
Received: from elephants.elehost.com ([216.66.27.132]:26176 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbfHIOGW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Aug 2019 10:06:22 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x79E6DQO064935
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 9 Aug 2019 10:06:13 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>,
        "'Christian Couder'" <christian.couder@gmail.com>
Cc:     <git@vger.kernel.org>
References: <xmqq36itprzo.fsf@gitster-ct.c.googlers.com> <20190809001315.GA87896@syl.lan> <3C7105E5-5DE1-42DC-A9A4-65C061FD6139@dereferenced.org>
In-Reply-To: <3C7105E5-5DE1-42DC-A9A4-65C061FD6139@dereferenced.org>
Subject: RE: What's cooking in git.git (Jul 2019, #06; Thu, 25)
Date:   Fri, 9 Aug 2019 10:06:06 -0400
Message-ID: <001e01d54ebb$9a1ab4b0$ce501e10$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQI4e27fuor1V6G+VVNTu5eJdxwFnwIJ14M8AThYM+emEmxdIA==
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01 Aug 2019 13:05:12, Junio wrote:
> >> *snip*

I think this got missed in the shuffle, but I am getting questions about the topic from my own team that I cannot answer.

I noticed that the switch and restore commands are now available in 2.23.0 but are not discussed in recent What's Cooking or Git Rev (or I blithely missed them). The question from my team is what are the plans for deprecating checkout. They have loads of scripts and want to plan for moving over.

Regards and Thanks,
Randall


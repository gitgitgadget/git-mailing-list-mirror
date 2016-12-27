Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D305200E0
	for <e@80x24.org>; Tue, 27 Dec 2016 19:30:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933062AbcL0TaO (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Dec 2016 14:30:14 -0500
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:45594 "EHLO
        alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932355AbcL0TaH (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 27 Dec 2016 14:30:07 -0500
X-AuditID: 12074411-fa3ff700000009b7-f0-5862c13e9aa0
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 01.35.02487.E31C2685; Tue, 27 Dec 2016 14:30:06 -0500 (EST)
Received: from [192.168.69.190] (p5B10401B.dip0.t-ipconnect.de [91.16.64.27])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id uBRJU4FZ021313
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Tue, 27 Dec 2016 14:30:05 -0500
Subject: Re: Intermittent failure of t0021
To:     git discussion list <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>
References: <ec454def-88a7-5562-1bfe-9d52de42dc55@alum.mit.edu>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <2c2c574c-a840-4eb9-848f-8c56f1ad7d66@alum.mit.edu>
Date:   Tue, 27 Dec 2016 20:30:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.5.1
MIME-Version: 1.0
In-Reply-To: <ec454def-88a7-5562-1bfe-9d52de42dc55@alum.mit.edu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCIsWRmVeSWpSXmKPExsUixO6iqGt3MCnC4MA+KYuuK91MFo8fLmF1
        YPLYOesuu8fnTXIBTFFcNimpOZllqUX6dglcGTO+z2QvOMlUsePUepYGxklMXYwcHBICJhLL
        eqS7GDk5hAQuM0psWZTXxcgFZJ9lkvj8ZTMTSEJYQEviUMcmFhBbRCBR4s/7rcwQDfYSXX9n
        soPYbAK6Eot6msHqeYHiex8tBLNZBFQlPjZPYASxRQVCJC7POcoGUSMocXLmE7CZnAIOEm8f
        rwOrYRZQl/gz7xIzhC0vsf3tHOYJjHyzkLTMQlI2C0nZAkbmVYxyiTmlubq5iZk5xanJusXJ
        iXl5qUW6pnq5mSV6qSmlmxghQSe4g3HGSblDjAIcjEo8vAGrEiOEWBPLiitzDzFKcjApifK2
        TEqKEOJLyk+pzEgszogvKs1JLT7EKMHBrCTC+3gvUI43JbGyKrUoHyYlzcGiJM7Lt0TdT0gg
        PbEkNTs1tSC1CCYrw8GhJMF7az9Qo2BRanpqRVpmTglCmomDE2Q4D9BwpwMgw4sLEnOLM9Mh
        8qcYjTkOvF/xlIlj2rSVT5mEWPLy81KlxHl5QEoFQEozSvPgpsESxytGcaDnhHmDQap4gEkH
        bt4roFVMQKv06+NBVpUkIqSkGhg13r0L2GYT1VH/+tm2/Z+an8zubzoR7zLjj2LQ8aNLZ5Wc
        MMkt2le9k2llne8CpWiX4HfOhfrnks+/NDrAanOjo9trQ6jyPLW+5SUPDWxDuc9Ilt7R1p7+
        NO3uxZenOeQXimmLzVvkFcoUzjV3zo1Lzf0PdBslD1zZWnLj64SDC/sEbJ8+aatSYinOSDTU
        Yi4qTgQAmpiw0PcCAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/27/2016 08:21 PM, Michael Haggerty wrote:
> I'm seeing intermittent failures of t0021. [...]

Just after submitting this, I saw that the problem has already been
reported and a fix proposed:

http://public-inbox.org/git/dd8decbc-f856-4f68-6d77-7ea9d5f9d126@ramsayjones.plus.com/

Sorry for the noise.

Michael


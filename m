Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2F9A1F453
	for <e@80x24.org>; Tue, 12 Feb 2019 02:47:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbfBLCra (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Feb 2019 21:47:30 -0500
Received: from sonic309.consmr.mail.bf2.yahoo.com ([74.6.129.253]:40249 "EHLO
        sonic309-18.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726655AbfBLCra (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 11 Feb 2019 21:47:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rogers.com; s=s2048; t=1549939649; bh=Lq2E6MRUQRoA3fCc+tCP6NhJfeLlAizlbwqtNxiwI0A=; h=From:To:Cc:References:In-Reply-To:Subject:Date:From:Subject; b=ar5otU+R/9EnymQ61GW/CMjfq0X4gWUtOe0nWt0S1cRN5hjyxxVTnXUSX/7Wn9grCFDj9Nnwo1ieNuwwjMPbr4gTyf6YKDudSC5zXAsYrLPAY4AHY5raCF8aaLKJ6VxSExXGf663MB7ErTX4dt3zEXLk1PwVzNLNbhEorGba2aVyzpbqE2roOTCza35JRtyQWjKdpY3B+32q7wVxTHwdAmAJxFvi41C1Khl7BCcZLA9t9YDZjPlBpFLnLBFxaQ0s6muQtXvZ5BKzp+ObmUcL6RQLZRrWjuU87Xd+kV3Lp6WeCIhtAdXpXVGgt6fwsjc73Al5ed6sb/OmVbF2C8leEw==
X-YMail-OSG: UWB10VkVM1mfwWEKBrEyf7_ZxsHsIimc7WWvKba.0dxI7raa56t_oXR0WnUHUW0
 zOvBd.75vTknUWA4ipitsKA3nXZWPwGjc9xCASk_yEr.1me.vQ4kVrOD.0UU2J6kLqUT5mcQEWus
 Lv.3I7geI.4Pi5YHCASFk9HG6rRShZwAU6z6c0J.SMiXLeyR5r5W5b0RU6qD7cpiHH6wpQ9fJQSe
 srM7uoyQvzrnSUvxCy_gk4qVxNhOqTo5sEhb1t_8NJdbgCkm_ZJqjFJAhcWVh0DSBzvD38mADF9_
 jizj35Rf.m7F1q1wIr4rSYcfsiCW6IST9bYab4uP5ehPwOcTQgz8XjEyDOsqt8wVdOrDgBOAmcN6
 bT8Im_AUOFmGSivwlDcnt6k3ZSKWNvaXSXL3lO7xn83xst5OwTTuQ3_xIKbkUFAQ.xZqPjvm9pDr
 jefB_316eI8laYpwGlb_ehaK_7zGoy4Cg0ufMmtMHKkIn22kEEaiRRZDxzkw4VZIFJMmLSdQ7YG2
 aWuvFlFJhalxqr2CcCkTxlMyB3XGhckP9Qwl3TSQMEqzJOhgMpLHkHLZROuUN.CnamZdepSx7rZM
 sBhTet9Kykq4CWK_PuJhqgqy6WybglSiFW5lSBUUxSwlfUWB7e5YFGUCUR1x9ysC4uINC_wsD0wW
 3fbl1KW3kJzriQDMjgrJFnTr6.qnZpQ32RcBZfHn3.SAXu8U4SK3Cnuubk6PMrW5uCA4zec0jXah
 81wZwgVcv2de16045sUSmzbU_59Yn1yKxRZbAfAwzJbMu9AWXivpwOPxK.xOn39LAtW_EIXb3eUm
 Is8_kPlXcNzL9LUptRiFZPlBJguZ5vG2aiFZoWYZuKpiyUDUTJwS7wTmuq4jUekKMDLdhHhFdd1j
 BMeu7s3A.3jSWfVHMU4yKA4wGQbfMJpCqCj_7nChuNXrVtJ.TIcjgnQiBo4qQ2_lCvWye_ug73LF
 70FO0hCR2zcntFsTQnazm1VhMHOYaq_XdoZLtpRzAqroOsrrQUO.juqr9K0vi8ZZIp87DwnCAVUB
 KQDmQ_pmrxGYADNqg1BNJ.5RMOm4VVqWdo6IacvSYMAOcgOWJZieuRE0T9OTZGHGv87NmpUhrbKH
 KgwsN69ofkBgjQX56SCrw81Fr57hXK5RUMw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.bf2.yahoo.com with HTTP; Tue, 12 Feb 2019 02:47:29 +0000
Received: from CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com (EHLO gnash) ([99.229.179.249])
          by smtp426.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 8f11bff4774df19e6a115700fcb02e53;
          Tue, 12 Feb 2019 02:47:27 +0000 (UTC)
From:   <randall.s.becker@rogers.com>
To:     "'Eric Sunshine'" <sunshine@sunshineco.com>,
        "'Jeff King'" <peff@peff.net>
Cc:     "'Git List'" <git@vger.kernel.org>,
        "'Randall S. Becker'" <rsbecker@nexbridge.com>
References: <20190209185930.5256-1-randall.s.becker@rogers.com> <20190209185930.5256-2-randall.s.becker@rogers.com> <CAPig+cRARdkKN-wR4EzVSzxuK51VOPf-kFFG57kkEsnFBfe4TA@mail.gmail.com> <20190212003735.GH13301@sigill.intra.peff.net> <CAPig+cQwh8RxVLgbBXR2WtE+k-aFAWnr12nBcTPzccQp_gdEZw@mail.gmail.com>
In-Reply-To: <CAPig+cQwh8RxVLgbBXR2WtE+k-aFAWnr12nBcTPzccQp_gdEZw@mail.gmail.com>
Subject: RE: [Patch v1 1/3] test-lib-functions.sh: add generate_zero_bytes function
Date:   Mon, 11 Feb 2019 21:47:25 -0500
Message-ID: <001201d4c27d$4980b7e0$dc8227a0$@rogers.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGM7GjkJQPJw2ZzFceglcz2DqNUWwDZJf6DAflb4NwBpydqTQG7ktwQpjl3tnA=
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On February 11, 2019 20:18, Eric Sunshine wrote:
> On Mon, Feb 11, 2019 at 7:37 PM Jeff King <peff@peff.net> wrote:
> > On Sat, Feb 09, 2019 at 09:05:04PM -0500, Eric Sunshine wrote:
> > > On Sat, Feb 9, 2019 at 1:59 PM <randall.s.becker@rogers.com> wrote:
> > > > +generate_zero_bytes () {
> > > > +       perl -e 'if ($ARGV[0] == "infinity") {
> > >
> > > s/perl/"$PERL_PATH"/
> >
> > This shouldn't be necessary. perl() is a function that uses $PERL_PATH
> > (so you only need $PERL_PATH when you're writing out another script
> > that doesn't run in the same process space as the rest of the test code).
> 
> Thanks for clarifying. I either didn't know or forgot about that.

As did I, thank you.


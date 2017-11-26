Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB39E20A40
	for <e@80x24.org>; Sun, 26 Nov 2017 19:39:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751574AbdKZTjQ (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Nov 2017 14:39:16 -0500
Received: from p3plsmtpa08-10.prod.phx3.secureserver.net ([173.201.193.111]:54260
        "EHLO p3plsmtpa08-10.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751342AbdKZTjQ (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 26 Nov 2017 14:39:16 -0500
Received: from jessie.local ([212.149.203.197])
        by :SMTPAUTH: with SMTP
        id J2ljexAog0TufJ2lleE9l2; Sun, 26 Nov 2017 12:39:16 -0700
Date:   Sun, 26 Nov 2017 21:39:11 +0200
From:   Max Kirillov <max@max630.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Max Kirillov <max@max630.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        Florian Manschwetus <manschwetus@cs-software-gmbh.de>,
        Chris Packham <judge.packham@gmail.com>,
        Konstantin Khomoutov <kostix+git@007spb.ru>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH v5 1/2] http-backend: respect CONTENT_LENGTH as specified
 by rfc3875
Message-ID: <20171126193911.GE26158@jessie.local>
References: <20171126015448.24111-1-max@max630.net>
 <20171126015448.24111-2-max@max630.net>
 <xmqqo9npitx7.fsf@gitster.mtv.corp.google.com>
 <20171126081329.GD26158@jessie.local>
 <xmqq3751idmp.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq3751idmp.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CMAE-Envelope: MS4wfN5CP/K+rC3HcxGlx5kjdrxbtbOwy7fFOECKz4SKr24+593aK1iyQhR7B/T/AN4u3xW5/p2piuhjZtVXsgn2kIQyR4hM1GHUJGeCYYQs02vj00ygoiYJ
 LWO93Ei8tu6+VyN4xWFFnOlMgqlD4ecZiQ98gHLMbvrVhej9/aIIBeiGxcWV6QCGbaUxi/jKdKFAC+x+sf0yLo4gISnw3GSjdo/Y0akjk+MFuE9+WQ+2lJ+r
 0ZJ0PsZS8j0vrixsxsaFvIvj+sAxbrOPSPY3TeiIWhkNVPvH24TaM5/bqzThv88vU5LWI5byRsRDq/UxuoYThsSzixyd8dFqZigeIFbAaPBQGcH4cZ51TdGj
 wuDXCgCg2N4gitVAi5IohamyJWybFJ608bJw1Bd/la/XSgnevkw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 26, 2017 at 06:38:06PM +0900, Junio C Hamano wrote:
> Max Kirillov <max@max630.net> writes:
>> +static ssize_t env_content_length()
> 
> We need s/length()/length(void)/; though.

thanks, fixed it

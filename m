Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E4D2120954
	for <e@80x24.org>; Wed, 29 Nov 2017 05:07:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750868AbdK2FHg (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Nov 2017 00:07:36 -0500
Received: from p3plsmtpa11-10.prod.phx3.secureserver.net ([68.178.252.111]:52991
        "EHLO p3plsmtpa11-10.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750770AbdK2FHg (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 Nov 2017 00:07:36 -0500
Received: from jessie.local ([212.149.203.197])
        by :SMTPAUTH: with SMTP
        id JuaoeU5PPFPuuJuaqe6tse; Tue, 28 Nov 2017 22:07:35 -0700
Date:   Wed, 29 Nov 2017 07:07:30 +0200
From:   Max Kirillov <max@max630.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Max Kirillov <max@max630.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        Florian Manschwetus <manschwetus@cs-software-gmbh.de>,
        Chris Packham <judge.packham@gmail.com>,
        Konstantin Khomoutov <kostix+git@007spb.ru>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH v6 0/2] http-backend: respect CONTENT_LENGTH as specified
 by rfc3875
Message-ID: <20171129050730.GG26158@jessie.local>
References: <20171126193813.12531-1-max@max630.net>
 <xmqqzi78e5dp.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqzi78e5dp.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CMAE-Envelope: MS4wfOyF6spBq4CwsaAZ57hoV6nZ03V2q8NMIRp8Dz/vEkHTaxBbfsewE7j3EKk3a9RXn7YyeK3N4CwGaDag8+rRaXRav5FOBGvTkkX9RxtcQcnuQLGla5LE
 fxGQ9wxRH5pT4GY8Efx54JTuiny9w2J/aPH9oZglW7DNDyb6ezuiv74vTAHaVRiwpzA+4kBzvgjPfDy32XMQLwG9OmaUUjRqx0NtBDUwYUcTxhjLAAlfK7XM
 x/TCdmR0Vd3gn5VmgOXX51gq3Zf2tolVi73gK8ozU57YcZd9tPmAFvEffdJXypl9bMBfZr0RIQiX4DShXCyHpaPyEIcTJg2rI9cU8MvRAJHRtVSNbxX2wKs0
 gF+EwwPy5uUMPUZmHpQnE+p6nmTtNLhTvch4xJycossIpDMzuBc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 27, 2017 at 01:02:10PM +0900, Junio C Hamano wrote:
> To recap (other than the typofix in the proposed log message), here
> is what I would have as SQUASH??? on top of (or interspersed with)
> v6.

Thank you. I'll update it a bit later. May/should I add
"Signed-off-by:" from you?

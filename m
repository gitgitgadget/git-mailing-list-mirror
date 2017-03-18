Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E4F2E2095B
	for <e@80x24.org>; Sat, 18 Mar 2017 22:41:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751262AbdCRWlw (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Mar 2017 18:41:52 -0400
Received: from lang.hm ([66.167.227.134]:53484 "EHLO bifrost.lang.hm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751207AbdCRWlv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Mar 2017 18:41:51 -0400
Received: from dlang-laptop ([10.2.0.162])
        by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id v2IMe8BF010332;
        Sat, 18 Mar 2017 14:40:08 -0800
Date:   Sat, 18 Mar 2017 15:40:08 -0700 (PDT)
From:   David Lang <david@lang.hm>
X-X-Sender: dlang@dlang-laptop
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?ISO-8859-15?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Is there a way to have a local version of a header file?
In-Reply-To: <xmqqzigi31fl.fsf@gitster.mtv.corp.google.com>
Message-ID: <nycvar.QRO.7.75.62.1703181539310.3797@qynat-yncgbc>
References: <nycvar.QRO.7.75.62.1703180724490.3797@qynat-yncgbc> <CACBZZX5FMdjuxxNru+XfTQdSXEQ_b0OP2rngGZLf1sSHR_D8Ng@mail.gmail.com> <nycvar.QRO.7.75.62.1703180750460.3797@qynat-yncgbc> <CACBZZX7G=C84kz4n26VTnWWUTKRv1rVvms=8AvELtMSCviu1kQ@mail.gmail.com>
 <xmqqzigi31fl.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20.17 (DEB 179 2016-10-28)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1537639233-1489876808=:3797"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1537639233-1489876808=:3797
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Sat, 18 Mar 2017, Junio C Hamano wrote:

> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
>
>> There might be some way I haven't thought of, in particular maybe you
>> can use gitattributes to define a custom diff/merge driver that always
>> reports no changes, or some ways to (ab)use the index to make git
>> ignore any changes to the file.
>
> Why does this have to be so difficult?
>
> Ship a config.h.sample file, have a Makefile rule that is forced to
> run before any compilation happens that checks if config.h exists
> and then created it if missing by copying config.h.sample over, and
> then all other source files can include config.h without having to
> know anything about config.h.sample's existence.
>
> Did I miss something?

There is no makefile with the arduino IDE/build system :-(

David Lang
--8323328-1537639233-1489876808=:3797--

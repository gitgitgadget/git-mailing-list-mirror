Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5587320209
	for <e@80x24.org>; Fri, 30 Jun 2017 07:12:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751651AbdF3HMW (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Jun 2017 03:12:22 -0400
Received: from mailhub.007spb.ru ([84.204.203.130]:41572 "EHLO
        mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751565AbdF3HMV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2017 03:12:21 -0400
Received: from tigra (unknown [192.168.2.102])
        by hermes.domain007.com (Postfix) with ESMTP id B3362D400C6;
        Fri, 30 Jun 2017 10:12:19 +0300 (MSK)
Date:   Fri, 30 Jun 2017 10:12:19 +0300
From:   Konstantin Khomoutov <kostix+git@007spb.ru>
To:     =?utf-8?B?0KHQtdGA0LPQtdC5INCo0LXRgdGC0LDQutC+0LI=?= 
        <s_shestakov@playrix.com>
Cc:     git@vger.kernel.org
Subject: Re: Bug with automated processing of git status results
Message-ID: <20170630071219.m757vvyccrp3afli@tigra>
References: <CAM1TZMGXiDpzt3uhpDaE41KR8GWyjMq=+Mcvz5Zrj0EffNrGrw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM1TZMGXiDpzt3uhpDaE41KR8GWyjMq=+Mcvz5Zrj0EffNrGrw@mail.gmail.com>
User-Agent: NeoMutt/20170306 (1.8.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 30, 2017 at 09:00:14AM +0300, Сергей Шестаков wrote:

> I am trying to make an automated processing of "git status" results.
> I execute the command
> 
> git status -z -uno
> 
> I expect that it has stable output format. However, it still can print
> warnings like
> 
> warning: CRLF will be replaced by LF in somefile.xml
> 
> I understand that we can turn off core.safecrlf, but it's
> inconvinient. It would be better if "git status" command had an
> optional parameter that disables any other output besides changed
> files.

The `git status` command supposedly writes their "regular" data to its
standard output while warnings go to its standard error stream.
Is this not the case?


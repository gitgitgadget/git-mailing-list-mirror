Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F13D020D09
	for <e@80x24.org>; Sun, 16 Apr 2017 13:31:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755385AbdDPNbr (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Apr 2017 09:31:47 -0400
Received: from [195.159.176.226] ([195.159.176.226]:54989 "EHLO
        blaine.gmane.org" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1754961AbdDPNbq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Apr 2017 09:31:46 -0400
Received: from list by blaine.gmane.org with local (Exim 4.84_2)
        (envelope-from <gcvg-git-2@m.gmane.org>)
        id 1czkHC-0000lJ-3c
        for git@vger.kernel.org; Sun, 16 Apr 2017 15:31:38 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     git@vger.kernel.org
From:   Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH v1] travis-ci: add static analysis build job to run
 coccicheck
Date:   Sun, 16 Apr 2017 15:31:36 +0200
Message-ID: <55524921-3295-90e6-6473-ae1289eeeb75@gmail.com>
References: <20170411072637.57369-1-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@blaine.gmane.org
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12)
 Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Cc:     gitster@pobox.com, l.s.r@web.de
In-Reply-To: <20170411072637.57369-1-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2017-04-11 09:26, Lars Schneider wrote:

> Add a dedicated build job for static analysis. As a starter we only run
> coccicheck but in the future we could run Clang Static Analyzer or
> similar tools, too.

Just FYI, some time ago someone (I don't recall who) signed up Git with 
Coverity's free scan service for OSS projects:

https://scan.coverity.com/projects/git?tab=overview

Maybe it makes sense to at least link to this page, too?

-- 
Sebastian Schuberth


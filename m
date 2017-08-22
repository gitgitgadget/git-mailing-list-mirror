Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 978551F667
	for <e@80x24.org>; Tue, 22 Aug 2017 18:00:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751853AbdHVSA2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Aug 2017 14:00:28 -0400
Received: from [195.159.176.226] ([195.159.176.226]:39221 "EHLO
        blaine.gmane.org" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1751781AbdHVSA1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Aug 2017 14:00:27 -0400
Received: from list by blaine.gmane.org with local (Exim 4.84_2)
        (envelope-from <gcvg-git-2@m.gmane.org>)
        id 1dkDTD-0000be-7r
        for git@vger.kernel.org; Tue, 22 Aug 2017 20:00:07 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     git@vger.kernel.org
From:   Sebastian Schuberth <sschuberth@gmail.com>
Subject: Best way to check whether working tree matches a commit's tree
Date:   Tue, 22 Aug 2017 20:00:01 +0200
Message-ID: <onhres$g9$1@blaine.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@blaine.gmane.org
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12)
 Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
X-Mozilla-News-Host: news://news.gmane.org:119
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I'd like to check whether my working tree exactly matches the tree of a given commit. That is, there should not be any untracked, staged or modified files (including ignored files).

Currently, I'm doing this in two steps:

- check for success and empty output of "git status --ignored --porcelain"
- check that the output of "git rev-parse HEAD" matches the given commit

While this works, it feels sub-optimal. Is there a better / smarter way?

-- 
Sebastian Schuberth


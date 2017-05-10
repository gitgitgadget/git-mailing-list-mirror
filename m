Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE75320188
	for <e@80x24.org>; Wed, 10 May 2017 19:00:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752954AbdEJTAT (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 May 2017 15:00:19 -0400
Received: from [195.159.176.226] ([195.159.176.226]:40363 "EHLO
        blaine.gmane.org" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1750897AbdEJTAR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2017 15:00:17 -0400
Received: from list by blaine.gmane.org with local (Exim 4.84_2)
        (envelope-from <gcvg-git-2@m.gmane.org>)
        id 1d8WqE-0003P3-2b
        for git@vger.kernel.org; Wed, 10 May 2017 21:00:06 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     git@vger.kernel.org
From:   Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: Possible bug in includeIf / conditional includes
Date:   Wed, 10 May 2017 20:58:18 +0200
Message-ID: <b80c68fa-fe1e-3cf8-3c7e-527a4d941108@gmail.com>
References: <C1ACB28C-F1B4-42A1-8135-797DEFD9F03C@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@blaine.gmane.org
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12)
 Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
In-Reply-To: <C1ACB28C-F1B4-42A1-8135-797DEFD9F03C@gmail.com>
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2017-05-10 19:00, raphael.stolt@gmail.com wrote:

> Current configuration which finds the conditional configuration.
> 
> ~/.gitconfig
> [includeIf "gitdir:~/Work/git-repos/oss/"]
>    path = ~/Work/git-repos/oss/.oss-gitconfig
> 
> Expected configuration which doesn't find the conditional configuration:
> 
> ~/.gitconfig
> [includeIf "gitdir:~/Work/git-repos/oss/"]
>    path = .oss-gitconfig

My guess is, because includeIf might contain other conditionals than 
"gitdir", the generic convention is to always use an absolute path for 
"path".

-- 
Sebastian Schuberth


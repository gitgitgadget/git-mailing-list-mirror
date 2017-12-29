Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF1C71F406
	for <e@80x24.org>; Fri, 29 Dec 2017 04:28:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754903AbdL2E16 (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Dec 2017 23:27:58 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:52171 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754733AbdL2E15 (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 28 Dec 2017 23:27:57 -0500
X-Greylist: delayed 506 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 Dec 2017 23:27:57 EST
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id DF68B20AF7;
        Thu, 28 Dec 2017 23:19:28 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute2.internal (MEProxy); Thu, 28 Dec 2017 23:19:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=keith.so; h=cc
        :content-type:date:from:in-reply-to:message-id:mime-version
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        mesmtp; bh=B+4UbIlrpJEkRUN6EhOht9UfFmOLubWS4oS4lmOGELM=; b=f5XG/
        QlEuosjIAJ/M1wlK6jJ/a8qi4OTHdWeCRnh7kSAZJoDNFE4Ck/kduyrSO/4P5K7f
        fe1JfaizMzGLw9yt4U4gfMstv8CTv2cv0aDWZUaP3PkZ/acv2NunZCjUin/+lJZv
        BMfSW0CKdj5eGY+4Bp/c4yisMflqAw1uV531Bw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; bh=B+4UbIlrpJEkRUN6EhOht9UfFmOLu
        bWS4oS4lmOGELM=; b=R3fZHg6WOyFR6J1sHT9r5jlvNkIa2nb4nmTRriWZGMAz3
        Reuv/Iy0C2Wt1ZBOG4HonAzVJ4xWTgjpCS4lqoFWMjXlz/aK2rQFJO8sEwlybtK5
        zSA3iTcj0Gu8zbPWG7grCBhkGI3oP7OEo2nxAahyXz1l0tw0RVojOm5SIRwhetGY
        ElITcVG9iTRKXaehj67Mvhc8Ab4NaNONRnDNkPdCuaJY7GSB3X3el20uZz0ed6OR
        r33NSoRXHX5MTcBmZEwcmVmUdoqWF08D3CqfE4jB6T3P7PSRtMBBWuCQWPwlCOVa
        gMDwNd4+e8tdiTVZvl5l50WN+SoMdoUFKudrTR4MA==
X-ME-Sender: <xms:UMJFWlXJCX1jb1uMCiwh7FcNtGDruxKQk8dlVaTXmLdXAa-i5bx5qQ>
Received: from localhost (unknown [136.24.23.40])
        by mail.messagingengine.com (Postfix) with ESMTPA id 82E04240DB;
        Thu, 28 Dec 2017 23:19:28 -0500 (EST)
Date:   Thu, 28 Dec 2017 20:19:27 -0800
From:   Keith Smiley <k@keith.so>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH] Add shell completion for git remote rm
Message-ID: <20171229041927.GA83931@bryant.local>
References: <01020160a0004473-277c3d7c-4e3b-4c50-9d44-4a106f37f1d9-000000@eu-west-1.amazonses.com>
 <20171229032927.GN3693@zaya.teonanacatl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20171229032927.GN3693@zaya.teonanacatl.net>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It looks like that was just about preferring remove in documentation and 
the like, I think it would still make sense to have both for completion 
since rm is still supported.

--
Keith Smiley

On 12/28, Todd Zullinger wrote:
>Hi Keith,
>
>Keith Smiley wrote:
>> Previously git remote rm did not complete your list of removes as remove
>> does.
>
>Looking through the history, the rm subcomand completion was
>explicitly removed in e17dba8fe1 ("remote: prefer subcommand
>name 'remove' to 'rm'", 2012-09-06).
>
>-- 
>Todd
>~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>Genius is 1% inspiration and 99% perspiration, which is why engineers
>sometimes smell really bad.
>    -- Demotivators (www.despair.com)
>

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B1CC11F64
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 01:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19FBE61CD6
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 01:57:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbhF2CAG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Jun 2021 22:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbhF2CAG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jun 2021 22:00:06 -0400
Received: from act-MTAout6.csiro.au (act-mtaout6.csiro.au [IPv6:2405:b000:e00:257::7:43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0346C061574
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 18:57:38 -0700 (PDT)
IronPort-SDR: PRjmaGso03woyrBPtYZW63bmwQY2QwTlegRcICmYCamF2dBM+cQENFc5bL+0gUKWx5yq7QXcRC
 hy10f4nL7bqA==
X-SBRS: 4.0
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AUMAZi64rhQPBuROBnAPXwPXXdLJyesId70?=
 =?us-ascii?q?hD6qkRc202TiX8ravFoB1173PJYUkqKRYdcLy7VpVoOEmskaKdgrNhXotKPj?=
 =?us-ascii?q?OKhILAFugL0WKF+Vzd8kbFmdK1u50BT4FOTPHVJXheyebWiTPIdurIyeP3lp?=
 =?us-ascii?q?yVuQ=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2FVAgB2fdpgjA9OdpJagQmBV4MNbIU?=
 =?us-ascii?q?ziQSIPjCdSgsBAQEPQQQBAYRSAoJyJjcGDgIEAQEBEgEBBgEBAQEBBgQCAhA?=
 =?us-ascii?q?BAQEBKUOFdYZPAQIDIxUbNgsYAgImAgJXEwgBAYJtgwcBqlyBMoEBhGaDa4F?=
 =?us-ascii?q?jgRAqjWo3gVVEgTwPgm0+hRGCSoJkBIMcgQoFoXFanEIsB4MjgS4LkBOMMwY?=
 =?us-ascii?q?OBRYQlRqQbrpsgWqBfzMaH4M+TxkOjjiOQjRqAgYKAQEDCYtxAQE?=
X-IPAS-Result: =?us-ascii?q?A2FVAgB2fdpgjA9OdpJagQmBV4MNbIUziQSIPjCdSgsBA?=
 =?us-ascii?q?QEPQQQBAYRSAoJyJjcGDgIEAQEBEgEBBgEBAQEBBgQCAhABAQEBKUOFdYZPA?=
 =?us-ascii?q?QIDIxUbNgsYAgImAgJXEwgBAYJtgwcBqlyBMoEBhGaDa4FjgRAqjWo3gVVEg?=
 =?us-ascii?q?TwPgm0+hRGCSoJkBIMcgQoFoXFanEIsB4MjgS4LkBOMMwYOBRYQlRqQbrpsg?=
 =?us-ascii?q?WqBfzMaH4M+TxkOjjiOQjRqAgYKAQEDCYtxAQE?=
Received: from mail-server.pawsey.org.au (HELO prod-mail.pawsey.org.au) ([146.118.78.15])
  by act-ironport-int.csiro.au with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jun 2021 11:57:32 +1000
Received: from [192.168.42.112] (unknown [1.126.250.96])
        by prod-mail.pawsey.org.au (Postfix) with ESMTPSA id E1F66315813F
        for <git@vger.kernel.org>; Tue, 29 Jun 2021 09:57:31 +0800 (AWST)
Subject: Re: Definition of "the Git repository"
To:     git@vger.kernel.org
References: <7dd55e85-38eb-7346-ff10-7124102cd22b@pawsey.org.au>
 <435b0150-cd9f-32ce-7a07-3057ef20662a@iee.email>
 <12dd4f05-456f-c763-441e-5bb16634306a@pawsey.org.au>
 <60d9410bb07a1_aac5d20888@natae.notmuch>
 <ec31434f-0c99-ffb7-6eb0-6ecb1f6e761c@pawsey.org.au>
 <60d95c6024f3d_aaf7e208a4@natae.notmuch>
From:   Kevin Buckley <Kevin.Buckley@pawsey.org.au>
Message-ID: <a5579940-237b-2e4d-bf18-bc0a8f2f1ee3@pawsey.org.au>
Date:   Tue, 29 Jun 2021 09:57:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <60d95c6024f3d_aaf7e208a4@natae.notmuch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021/06/28 13:21, Felipe Contreras wrote:
> 
> To try to make it more orthogonal, let's suppose the index file was
> outside the .git directory. Would you consider then the staging area
> separate from the repository?
> 
> In fact, we don't have to suppose:
> 
>    GIT_INDEX_FILE=/tmp/index git checkout @~ -- .
> 
> Does that command change the repository in any way?
  
I have to admit that I don't know, and that I can't immediately
see where the "repository" would be, in that example. This is
obviously a gap in my understanding: happy to defer to yours.

I do however feel that the fact that we have moved to using examples
that override the Git Index file on the command line, in order to
define what a "repository" is, just so that we might be able to give
a "more correct" definition of the term, to someone completely new to
Git, suggests that, as others have already noted in the discussion,
it's not easy to be "correct"?

Kevin

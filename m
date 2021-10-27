Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C8AC433EF
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 19:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CF4060F5A
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 19:43:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243739AbhJ0Tpu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 15:45:50 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:43521 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbhJ0Tpt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 15:45:49 -0400
Received: (Authenticated sender: me@yadavpratyush.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 2310C40002;
        Wed, 27 Oct 2021 19:43:21 +0000 (UTC)
Date:   Thu, 28 Oct 2021 01:13:19 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, angavrilov@gmail.com
Subject: Re: [RFC PATCH 1/4] blame: prefer null_sha1 over nullid and retire
 later
Message-ID: <20211027194319.iwa6gx3xuth5rclu@yadavpratyush.com>
References: <20211011121757.627-1-carenas@gmail.com>
 <20211011121757.627-2-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211011121757.627-2-carenas@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/10/21 05:17AM, Carlo Marcelo Arenas Belón wrote:
> a9786bb (git-gui: Fix Blame Parent & Context for working copy lines.,
> 2008-09-08) adds nullid (and a never used nullid2) for matching locally
> modified lines in blame.
> 
> Use instead the already available null_sha1 for the same and in
> preparation to making that hash independent on a future patch.

LGTM.

-- 
Regards,
Pratyush Yadav

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F372220136
	for <e@80x24.org>; Fri, 17 Feb 2017 13:16:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933930AbdBQNPx (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 08:15:53 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:55704 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933915AbdBQNPw (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 17 Feb 2017 08:15:52 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id C6B3E209D6;
        Fri, 17 Feb 2017 08:15:50 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute1.internal (MEProxy); Fri, 17 Feb 2017 08:15:50 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=
        content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=mesmtp; bh=+OY7O/t7dbz7174
        vVkppxDLeMpc=; b=o4/DXU4TIJGPgBXrkzRv/ZGTcba2cekxE7dSgGJr9bedYje
        zemqDXxRX1QGHZ1nSeC0bgparMvxTCcvoKXk0teehrMgTrPYdW9efxOD+tjzVd0n
        PR0o9m/qzN7pju9ZGYKMfama7+4qGKSXFaJiHCDXy4eSLPTBYwEPTy2W1btQ=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=
        smtpout; bh=+OY7O/t7dbz7174vVkppxDLeMpc=; b=P2oAy/fKpPf7OdSwE8kp
        VbAYVIz0w3dkw3vs/q6eLfpsIckkOB03UpKfmmC+xfRdnovlWGOwbkmD4ZLDJOOP
        3S0t2VElX6gUY2XE0YpMMP4CWq6j1AaurffBNXRhcFOuHvKHqFDNcXrjbjhlhitg
        cYXmRn7Erdl99G+HLGMfKjE=
X-ME-Sender: <xms:hvemWNerdNa-mkncc7p0zL_XZUKC1ya8mAcztIHR9uERH_M_ufsBKA>
X-Sasl-enc: XwhLre5/Gj4idbBaafylbgZr0o/FVUNIcZVpHrURvqXO 1487337350
Received: from skimbleshanks.math.uni-hannover.de (skimbleshanks.math.uni-hannover.de [130.75.46.4])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5E14A245AD;
        Fri, 17 Feb 2017 08:15:50 -0500 (EST)
Subject: Re: git alias for options
To:     hIpPy <hippy2981@gmail.com>, git@vger.kernel.org
References: <CAM_JFCz+9mxp37BTT7XPJ0fMd41DdbAxnvQF7id9msH+SDe6_Q@mail.gmail.com>
From:   Michael J Gruber <git@drmicha.warpmail.net>
Message-ID: <e6b3b3fa-2993-2850-a682-c58312a8385c@drmicha.warpmail.net>
Date:   Fri, 17 Feb 2017 14:15:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <CAM_JFCz+9mxp37BTT7XPJ0fMd41DdbAxnvQF7id9msH+SDe6_Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

hIpPy venit, vidit, dixit 17.02.2017 09:23:
> Git has aliases for git commands. Is there a (an inbuilt) way to alias
> options? If not, what is the reason?
> 
> Thanks,
> hippy
> 

You can setup an alias for "command with options", for example:

git help s
`git s' is aliased to `status -s -b -uno .'

As you see here, this can include non-option arguments such as the
pathsepc '.'.

You cannot alias options independent of the command, though.

Michael

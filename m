Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 178CEC4332F
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 22:45:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbiKHWpf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 17:45:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbiKHWpd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 17:45:33 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF1AD60685
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 14:45:31 -0800 (PST)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rjp.ie; s=key1;
        t=1667947530;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bYwp/wQvMeqtsdymSlzYg7qFE25qnO6dqAbmD7bphGA=;
        b=vkTh3Y3HAa3y6JSBWwkpSVgwneiJzv/PI4E8lelyhQsy7e6AXdJmLoDSIAKoGGa0Vg02S4
        I5M1g40236Di/Mp3ae7FAN5H5LnaYzqPPpN0dkQAmCQFeDePs7SoK/TP+kTbnSxtMqLceA
        Lsdn0vrmZ7L09thHIcpyKPc9CPuUtXo=
Date:   Tue, 08 Nov 2022 22:45:29 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   ronan@rjp.ie
Message-ID: <3f2efad81c08dce739ece667331738bb@rjp.ie>
Subject: Re: [PATCH v2 2/2] maintenance: add option to register in a
 specific config
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org
In-Reply-To: <7730f942-7332-4408-a2c0-f6ccde3cdb3a@dunelm.org.uk>
References: <7730f942-7332-4408-a2c0-f6ccde3cdb3a@dunelm.org.uk>
 <20221108194930.25805-1-ronan@rjp.ie>
 <20221108194930.25805-3-ronan@rjp.ie>
 <448cc6ed-c441-85a3-2780-0c07e56f53f8@dunelm.org.uk>
 <Y2rCsq5y9TuCfrKC@nand.local>
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Yes, I saw that the xdg_config was ignored but did not try to change it.=
=0A=0AIf we add a helper function for this in the future it might be wort=
h considering=0Asome of the lesser supported parts of the xdg spec, speci=
fically XDG_CONFIG_DIRS=0Awhich I use with neovim, for example, to achiev=
e some more host-specific configurations.=0A=0AThe xdg spec isn't totally=
 clear on how these additional configuration directories should=0Abe used=
 imo, so it would also be acceptable to just ignore them as is currently =
done.

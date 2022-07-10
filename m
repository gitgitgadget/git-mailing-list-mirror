Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4260FC433EF
	for <git@archiver.kernel.org>; Sun, 10 Jul 2022 14:55:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbiGJOzG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Jul 2022 10:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGJOzG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Jul 2022 10:55:06 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 062F2101DB
        for <git@vger.kernel.org>; Sun, 10 Jul 2022 07:55:04 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 9A86F22363;
        Sun, 10 Jul 2022 14:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1657464903; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f+7aayADF/0SSvTzlPen6R4Hag2EctIwWiMjL8Wm8Qs=;
        b=yQQLw/PK2jdx2NdpZOaDjpG9LwOnQme6sUNIYht9/EA98NDl54DSwYt+xejyOoGqHKkabl
        ppbuZskjjozHemxfxagivK1xsS87onPsJPiRPubGYhiY3B2w2l+A+tz28dKomq+75ap1xq
        PMm70Pw0T88XGjAxIKux2Wg6gHtBMnE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1657464903;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f+7aayADF/0SSvTzlPen6R4Hag2EctIwWiMjL8Wm8Qs=;
        b=D1YBd8cdzY+YWzzm9DW++GEg1VBr+GtJ5MX86ohwqaRy1eqWRwXcOoQt3kIP8pGNtWm/oe
        Q1hzPd6e+8AvEcAw==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 840802C141;
        Sun, 10 Jul 2022 14:55:03 +0000 (UTC)
Date:   Sun, 10 Jul 2022 16:55:02 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Jonas Aschenbrenner <jonas.aschenbrenner@gmail.com>,
        git@vger.kernel.org
Subject: Re: Suggestion to rename "blame" of the "git blame" command to
 something more neutral
Message-ID: <20220710145502.GT17705@kitsune.suse.cz>
References: <CADS2hGpnkiPzivVDyN-PnGsQCTafqx68PxigXvBK1bv4O=p4kg@mail.gmail.com>
 <220710.86r12t82ea.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <220710.86r12t82ea.gmgdl@evledraar.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

On Sun, Jul 10, 2022 at 04:31:18PM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> On Thu, Jul 07 2022, Jonas Aschenbrenner wrote:
> 
> > Similar to the change of the default branch name from "master" to
> > "main" to use a word which has less negative associations,
> > I suggest to replace the word "blame" with something more neutral.
> > Maybe "annotate". That word seems to already be used at some places
> > for this Git feature.
> 
> What do you think about this old patch of mine to add a 'git praise'?:
> https://lore.kernel.org/git/20190401101246.21418-1-avarab@gmail.com/

Since you are asking .. I think it completely misses the point.

I would consider it effective if users of git-praise(1) needed no
knowledge of existence of git-blame(1).

Thanks

Michal

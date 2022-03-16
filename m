Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 403A0C433F5
	for <git@archiver.kernel.org>; Wed, 16 Mar 2022 20:11:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347761AbiCPUMU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Mar 2022 16:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238194AbiCPUMT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Mar 2022 16:12:19 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AFB56C938
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 13:11:01 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D4710210ED;
        Wed, 16 Mar 2022 20:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1647461459; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U16Y43FGMXGVikMdsSgDRFiMu+OVR9rVMuCR4tywur8=;
        b=Ps3yS704MHNn2B4mVQvLmr9YCoLN8SWwokTLJzUxsTrHkrmP+HmKTVaM1ep9GNf97nnB+y
        KF/8EJu26vRlgd4q3ZuZY8W/40cyJGKk/JTofS5hVDduS8B4VtiEULi9upr8avJo0JdmFi
        mS8eUl7ou/DIFukI86KYlA2/QvBZzq0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1647461459;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U16Y43FGMXGVikMdsSgDRFiMu+OVR9rVMuCR4tywur8=;
        b=HELw1lEs87lB2tJZ7bIOC80Yj7j2dx7BpiOVdqt1kiuQ5N74xOZBmLYS1IQztVi2r4Br6W
        /I8v910flyUpk9DA==
Received: from kunlun.suse.cz (unknown [10.100.128.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id BD60EA3B83;
        Wed, 16 Mar 2022 20:10:59 +0000 (UTC)
Date:   Wed, 16 Mar 2022 21:10:58 +0100
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Alice Merrick <amerrick@google.com>
Cc:     git@vger.kernel.org
Subject: Re: Let's have a user experience workshop
Message-ID: <20220316201058.GI163591@kunlun.suse.cz>
References: <CA+Yb-VSaeKy-g_ywkZzQuEX=k3EXM+Ky-rHOb2az0SHGVbdaVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+Yb-VSaeKy-g_ywkZzQuEX=k3EXM+Ky-rHOb2az0SHGVbdaVw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

On Tue, Mar 15, 2022 at 02:04:09PM -0700, Alice Merrick wrote:
> Hello Git,
> 
> I’m doing a 20% project with the Git Core team at Google. I've been
> encouraged by Emily Shaffer and Jonathan Nieder to reach out to the
> Git community to help incorporate UX practices into the Git
> development cycle. My goal is to 1) gauge interest in improving Git's
> user experience and 2) recruit interested folks in organizing or
> attending a workshop where you can learn more about what UX is and
> discuss ways to bake UX into the process of making changes to Git to
> improve the experience for all users.
> 
> Some additional context about me: I am a UX (user experience)
> professional at Google. I have experience applying UX and
> accessibility practices[1] to developer tools for searching,
> reviewing, debugging code, etc. For the past couple years I’ve worked
> with the Golang project on their websites and helped set project
> priorities by collecting community feedback through their annual
> developer survey[2].
> 
> Interested?
> * Join the git UX Google group (https://groups.google.com/g/git-ux) if you
> are interested in participating in an event.
> * Reply directly to this email if you are interested in organizing the
> event to discuss git UX (scheduling the event, sending invites,
> communicating with invitees)

Can you, please, use a sane mailing list for the discussion?

The user experience of Google Groups really bad.

Also it seems it is accessible only to people with a google account.

Could you use a more inclusive technology?

Thanks

Michal

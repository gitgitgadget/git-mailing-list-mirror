Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82D8DCCA481
	for <git@archiver.kernel.org>; Thu,  7 Jul 2022 17:00:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236440AbiGGRAp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jul 2022 13:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235568AbiGGRAg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jul 2022 13:00:36 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8125A2C9
        for <git@vger.kernel.org>; Thu,  7 Jul 2022 10:00:35 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 3B3CB1F9B4;
        Thu,  7 Jul 2022 17:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1657213234; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ykewhJzVSApWo2WPFSinxdkWQ48iG+8fzZo7dvo3kZo=;
        b=tZoXvUbGlgeRdnusaYepwlgO6MY1hXGYgMRFDdo/eHqb2AnEjZ9SIirrZP1b20ATsvujnf
        p7Fyz7CE9uFkiSlB6MgidX8mfm4OCv1RQrAhGm3J51yvwmiUmWd14joKFywz4lzaR4NZ48
        ZoNwyGGAe6L8Oes+InvWs0EQZsngnA4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1657213234;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ykewhJzVSApWo2WPFSinxdkWQ48iG+8fzZo7dvo3kZo=;
        b=15c/D22TVRbLF9MSh85A1YHdTKrSHivkEIEJDHnlenZuqwUuZ6+hYIfrTYNALpaakTmbLP
        FiRrKNUJ5g5NFICw==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 29A292C141;
        Thu,  7 Jul 2022 17:00:34 +0000 (UTC)
Date:   Thu, 7 Jul 2022 19:00:33 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Jonas Aschenbrenner <jonas.aschenbrenner@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Suggestion to rename "blame" of the "git blame" command to
 something more neutral
Message-ID: <20220707170032.GR17705@kitsune.suse.cz>
References: <CADS2hGpnkiPzivVDyN-PnGsQCTafqx68PxigXvBK1bv4O=p4kg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADS2hGpnkiPzivVDyN-PnGsQCTafqx68PxigXvBK1bv4O=p4kg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 07, 2022 at 05:35:41PM +0200, Jonas Aschenbrenner wrote:
> Similar to the change of the default branch name from "master" to
> "main" to use a word which has less negative associations,
> I suggest to replace the word "blame" with something more neutral.
> Maybe "annotate". That word seems to already be used at some places
> for this Git feature.

Have you seen git-annotate(1)

Best regards

Michal

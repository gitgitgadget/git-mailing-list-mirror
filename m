Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A6ACDB46E
	for <git@archiver.kernel.org>; Thu, 12 Oct 2023 18:53:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441975AbjJLSxN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Oct 2023 14:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441912AbjJLSxM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2023 14:53:12 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB09883
        for <git@vger.kernel.org>; Thu, 12 Oct 2023 11:53:10 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 8173B1F8B4
        for <git@vger.kernel.org>; Thu, 12 Oct 2023 18:53:09 +0000 (UTC)
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 148752CA3F
        for <git@vger.kernel.org>; Thu, 12 Oct 2023 18:53:09 +0000 (UTC)
Date:   Thu, 12 Oct 2023 20:53:08 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     git@vger.kernel.org
Subject: -q option for git to suppress informational messages?
Message-ID: <20231012185308.GB6241@kitsune.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spamd-Bar: +
Authentication-Results: smtp-out2.suse.de;
        dkim=none;
        dmarc=none;
        spf=softfail (smtp-out2.suse.de: 149.44.160.134 is neither permitted nor denied by domain of msuchanek@suse.de) smtp.mailfrom=msuchanek@suse.de
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [1.40 / 50.00];
         ARC_NA(0.00)[];
         FROM_HAS_DN(0.00)[];
         RWL_MAILSPIKE_GOOD(0.00)[149.44.160.134:from];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         MIME_GOOD(-0.10)[text/plain];
         PREVIOUSLY_DELIVERED(0.00)[git@vger.kernel.org];
         TO_DN_NONE(0.00)[];
         R_SPF_SOFTFAIL(0.60)[~all:c];
         RCPT_COUNT_ONE(0.00)[1];
         DMARC_NA(0.20)[suse.de];
         VIOLATED_DIRECT_SPF(3.50)[];
         MX_GOOD(-0.01)[];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         R_DKIM_NA(0.20)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         SUBJECT_ENDS_QUESTION(1.00)[];
         BAYES_HAM(-0.09)[64.83%]
X-Rspamd-Queue-Id: 8173B1F8B4
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

when using git in scripts I find that many git commands insist on
printing informational messages, and the only way to avoid this is to
sent the output to /dev/null.

While some select commands support the -q option to suppres
informational messages many don't.

Since there was recenly some discussion of problems that newcomers could
work on I suppose this could be added to the list if not there already.

Thanks

Michal

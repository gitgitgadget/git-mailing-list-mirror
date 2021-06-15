Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_20,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B8EC48BDF
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 10:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3974610A1
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 10:51:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbhFOKxt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 06:53:49 -0400
Received: from server.abelardolg.com ([198.57.192.92]:41338 "EHLO
        server.abelardolg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbhFOKxs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 06:53:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=abelardolg.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        Message-ID:Subject:To:From:Date:MIME-Version:Sender:Reply-To:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=eJZ5ugi94IJlhubsmVVC7rtYAiTQOB15CIgcoq/iW1g=; b=kD7R5GeO1PCxsKFx6KcDxdRKWG
        cgBDOn9er2NhO7XJ9Kh+lEEhKezEK2QbbgbQpxHmOvwQKPzh9R3pI5lXDCi3tSULdM5Rp+eArnn8j
        k6jhE1BaY1IVyok48u3w9qFwXag4dA/NHU8EIdtHIYtHqsoSKWgIYx0zVrE7aHhD+gr2dgtSU28pg
        AmfNv1ipYMkNuU7aOi/BYM5UP/UNNzv2iBLgIdgOESeJSIqrAtgvNG3rnruRy+Y13gDcAMLdk8xlT
        dIuXynnyMtdFhqETR61ek9o+khQaszsIOESxORW0p+wvRIP2YDhet2aOmqTsGh/IBKetBRRQ8K3Qy
        FwDir+Fw==;
Received: from localhost ([127.0.0.1]:38706 helo=server.abelardolg.com)
        by server.abelardolg.com with esmtpa (Exim 4.94.2)
        (envelope-from <it-developer@abelardolg.com>)
        id 1lt6fW-0007q6-TX
        for git@vger.kernel.org; Tue, 15 Jun 2021 04:51:42 -0600
MIME-Version: 1.0
Date:   Tue, 15 Jun 2021 12:51:36 +0200
From:   it-developer@abelardolg.com
To:     git@vger.kernel.org
Subject: A suggestion: more readable human commands
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <fa2e886dd03a26c945d9deffe6f96d48@abelardolg.com>
X-Sender: it-developer@abelardolg.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server.abelardolg.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - abelardolg.com
X-Get-Message-Sender-Via: server.abelardolg.com: authenticated_id: it-developer@abelardolg.com
X-Authenticated-Sender: server.abelardolg.com: it-developer@abelardolg.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi there,

I would like to suggest you a new improvement.

Why not adding a new layer of abstraction for commands or to make more 
explicitly the commands?

For instance:

To merge a single file from one branch to another:

git checkout <branch_name> <path_to_file> --patch

would be like more readable human like this:

git merge <path_file> to <dst_branch>

It uses a more natural language.

Best regards.

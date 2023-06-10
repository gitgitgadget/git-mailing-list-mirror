Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 746A6C7EE2E
	for <git@archiver.kernel.org>; Sat, 10 Jun 2023 23:11:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232676AbjFJXLl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Jun 2023 19:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231463AbjFJXLl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jun 2023 19:11:41 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E1E35B8
        for <git@vger.kernel.org>; Sat, 10 Jun 2023 16:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=iee.email;
        s=2023022100; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:To:Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID; bh=isqN3QdoFzjK8EgTcgZjvzNv+SoQdC2DozZLo31e5gk=; b=zJu6UW
        ix2MfxItEWyP9StczKvcBVBefoTY3jsy7mlvSsHEMQIs2+A2N3QNDi4kJzbSegbRQJoz07ncWgmM0
        AxeQZopHdzmDBsUX+XJAaP2WhtRdJ2g1lrMdUL8rYYNwBBnrMrHpdYfbtpADXd3eeqI3MHwGwsAJD
        IMutY+Itu1s=;
Received: from host-89-242-64-91.as13285.net ([89.242.64.91] helo=[192.168.1.57])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1q87k8-0006bx-8w;
        Sun, 11 Jun 2023 00:11:37 +0100
Message-ID: <836c9d7d-43bc-6166-a818-d8e1c146ebd2@iee.email>
Date:   Sun, 11 Jun 2023 00:11:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: Questions regarding French Translation of Git
To:     Simon Priet <simon.priet@gmail.com>, git@vger.kernel.org
References: <CAF3Uz7_tMJ=02T91haQEoFOB5B+C4npAYxhk6WzCj6BJGU4p5A@mail.gmail.com>
 <CAF3Uz7-wAiUCizrW5s1zR6GSt6VxPbtt1DkOGOgKvda9nTDLuA@mail.gmail.com>
Content-Language: en-GB
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <CAF3Uz7-wAiUCizrW5s1zR6GSt6VxPbtt1DkOGOgKvda9nTDLuA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Simon
On 10/06/2023 14:51, Simon Priet wrote:
> Hello to the Git community,
> 
> I am contributing in translating software such as Gitea and Gitlab in
> French, and I have a few questions regarding the french wording and
> translations that were decided in Git itself. Is there someone I can
> speak to?

The translations are handled via a separate team (though many are also
contributors)
see
[1] po/README.md,
[2] Documentation/SubmittingPatches#L462-464 for extra links.
 e.g. https://github.com/git-l10n/git-po/

Also see
https://lore.kernel.org/git/20230516100949.24007-1-worldhello.net@gmail.com/
for the most recent formal release cycle (L10N = Localisation)

> 
> Best.
> 
> PS: Resent mail as the first version was not PLAIN-TEXT and was
> rejected by the postmaster.

Philip

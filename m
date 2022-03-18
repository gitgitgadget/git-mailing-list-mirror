Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 833C7C433F5
	for <git@archiver.kernel.org>; Fri, 18 Mar 2022 21:29:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241146AbiCRVaw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Mar 2022 17:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241141AbiCRVat (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Mar 2022 17:30:49 -0400
X-Greylist: delayed 400 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 18 Mar 2022 14:29:29 PDT
Received: from hekla.abc.se (hekla.abc.se [158.174.61.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 23935173340
        for <git@vger.kernel.org>; Fri, 18 Mar 2022 14:29:27 -0700 (PDT)
Received: from orm.abc.se (orm.abc.se [158.174.61.226])
        by hekla.abc.se (OpenSMTPD) with ESMTPS id 050a951a (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 18 Mar 2022 22:22:46 +0100 (CET)
Date:   Fri, 18 Mar 2022 22:22:45 +0100 (CET)
From:   Peter Krefting <peter@softwolves.pp.se>
To:     Sean Allred <allred.sean@gmail.com>
cc:     git@vger.kernel.org, sallred@epic.com, grmason@epic.com,
        sconrad@epic.com
Subject: Re: Dealing with corporate email recycling
In-Reply-To: <878rtebxk0.fsf@gmail.com>
Message-ID: <e0b85f26-ab5e-b3ae-a2fb-e7d927c46763@softwolves.pp.se>
References: <878rtebxk0.fsf@gmail.com>
User-Agent: Alpine 2.25 (BSO 592 2021-09-18)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
Organization: /universe/earth/europe/norway/oslo
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 12 Mar 2022, Sean Allred wrote:

> We are currently replaying a 15-year SVN history into Git -- with
> contributions from thousands of developers -- and are faced with the
> challenge of corporate email recycling, departures, re-hires, and name
> changes causing identity issues.

I have performed a couple of imports of old version history into Git, from
various version control systems, some of them with history dating to before
the corporation even had e-mail addresses for employees. In those cases I
found that the easiest option was just to use whatever user identification
was available in the old version control system -- Git does not explicitely
require a valid e-mail address in the author and committer header.

For Subversion import, for instance, I used "Name <login>" where "login" was
the Subversion committer ID, and "Name" was from a mapping file I created
for the repository. Where records were sketchy and Name information was not
available, I would just use "<login>".

When it comes to name changes, I have had scripts map login + date to name.
For instance, I changed my last name when I married, so I would have my old
(I don't know what the masculine equivalent of "maiden name" is in English)
mapped up until a specific date, and my current name afterwards.

-- 
\\// Peter

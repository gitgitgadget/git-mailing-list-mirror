Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F824C433F5
	for <git@archiver.kernel.org>; Sun, 13 Mar 2022 12:20:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233544AbiCMMVp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Mar 2022 08:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbiCMMVp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Mar 2022 08:21:45 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8E28300E
        for <git@vger.kernel.org>; Sun, 13 Mar 2022 05:20:36 -0700 (PDT)
Received: from host-84-13-159-41.opaltelecom.net ([84.13.159.41] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1nTND8-0001IA-Ao;
        Sun, 13 Mar 2022 12:20:34 +0000
Message-ID: <27b5bf20-2eb5-7873-4fdd-875aa699862c@iee.email>
Date:   Sun, 13 Mar 2022 12:20:34 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: Dealing with corporate email recycling
Content-Language: en-GB
To:     Sean Allred <allred.sean@gmail.com>, git@vger.kernel.org
Cc:     sallred@epic.com, grmason@epic.com, sconrad@epic.com
References: <878rtebxk0.fsf@gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <878rtebxk0.fsf@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/03/2022 22:38, Sean Allred wrote:
> Hi all,
>
> We are currently replaying a 15-year SVN history into Git -- with
> contributions from thousands of developers -- and are faced with the
> challenge of corporate email recycling, departures, re-hires, and name
> changes causing identity issues.
Naming is a big issue [1,2].

Do you already have a map of those personal name and email name changes
that are causing conflicts, or are you hoping for a way of detecting
such changes? If you already know which names produce conflicts you are
more than half way there.

If you do know of the name conflicts, (e.g. when `John Doe` changed to
`Jane Doe2`, then acquired `Jane Doe`, before being put back to `Jane
Doe2`), do you have dates for the change over to map into the commit
dates (assuming no slop or author/committer date slip). At least with
the change-over dates you can apply mapping during the history transfer.

An alternate option is to simply stick with the fact that history is
messy, and use internal corporate knowledge for the few case that cause
the major issues. It some point it always gets to be a Gödel Grammar
(needing another rule).

Philip

[1]
https://www.kalzumeus.com/2010/06/17/falsehoods-programmers-believe-about-names/
[2] https://acrl.ala.org/techconnect/post/names-are-hard/

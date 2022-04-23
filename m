Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1440C433EF
	for <git@archiver.kernel.org>; Sat, 23 Apr 2022 11:27:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234872AbiDWLan (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Apr 2022 07:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232564AbiDWLak (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Apr 2022 07:30:40 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8940A1D0B44
        for <git@vger.kernel.org>; Sat, 23 Apr 2022 04:27:43 -0700 (PDT)
Received: from host-84-13-159-41.opaltelecom.net ([84.13.159.41] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1niDvQ-000BKA-5o;
        Sat, 23 Apr 2022 12:27:41 +0100
Message-ID: <3d762060-b817-0246-c4a2-8eb35096cb7f@iee.email>
Date:   Sat, 23 Apr 2022 12:27:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: a problem with git describe
Content-Language: en-GB
To:     Guy Maurel <guy.j@maurel.de>, git@vger.kernel.org
References: <4ef9287b-6260-9538-7c89-cffb611520ee@maurel.de>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <4ef9287b-6260-9538-7c89-cffb611520ee@maurel.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Guy,

On 23/04/2022 10:12, Guy Maurel wrote:
> Hello!
>
> I am using git version 2.25.1
>
> 6-8 weeks ago I don't get any problem.
> Now I get :
> guy@renard ~/Software/uncrustify $ sudo git describe --always --dirty
> [sudo] password for guy:
> fatal: unsafe repository ('/home/guy/Software/uncrustify' is owned by
> someone else)
>
> What is to do?
>
There was a security warning noted in recent maintenance releases, see
https://lore.kernel.org/git/20220414003839.1616296-2-gitster@pobox.com/
where users could be fooled to access unsafe repositories that they
didn't own.

You may have received a maintenance update that makes this check now the
default.

Could you check what `git version` reports? 

There has also been added an escape hatch of allowing "*" for the
permitted safe directories. but do check the updated manuals, and the
git mailing list archive (update the search in the above link).
--
Philip

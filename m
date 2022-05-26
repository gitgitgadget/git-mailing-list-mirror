Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A14ECC433EF
	for <git@archiver.kernel.org>; Thu, 26 May 2022 12:57:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345008AbiEZM5n (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 May 2022 08:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbiEZM5m (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 May 2022 08:57:42 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC49C522C6
        for <git@vger.kernel.org>; Thu, 26 May 2022 05:57:41 -0700 (PDT)
Received: from host-84-13-159-41.opaltelecom.net ([84.13.159.41] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1nuD3c-000AVt-6t;
        Thu, 26 May 2022 13:57:40 +0100
Message-ID: <b794f028-97be-beb8-b815-4d9b8aa8b643@iee.email>
Date:   Thu, 26 May 2022 13:57:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 0/3] Die preserve ggg
Content-Language: en-GB
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Philip Oakley via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
References: <pull.1242.git.1653556865.gitgitgadget@gmail.com>
 <220526.86y1yo62jl.gmgdl@evledraar.gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <220526.86y1yo62jl.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 26/05/2022 10:54, Ævar Arnfjörð Bjarmason wrote:
> On Thu, May 26 2022, Philip Oakley via GitGitGadget wrote:
>
>> This short series is a follow up to GitGitGadget "Update the die()
>> preserve-merges messages to help some users (PR #1155)" [1].
>>
>> The first patch is a tidy up of the --preserve option to highlight that it
>> is now Deleted, rather than Deprecated.
>>
>> In response to Avar's comments that the former error message merely
>> 'tantilised without telling' the user what to do, it became obvious that the
>> underling problem was that the user was unable to git rebase --abort which
>> was also fatal, when a preserve-rebase was in progress.
> Thanks a lot for following up on this, this all looks OK to me. I had
> some minor comments about maybe tweaking this & that, but as far as I'm
> concerned this could go in as-is, depending on whether you think it
> needs a re-roll in response to my comments + others.
Thanks, I am a bit busy with family issues, so I'd rather use as-is,
unless other feel that the tweaks will be worth it.
I'm effectively off-line for the next 5-6 days anyway.
--
Philip

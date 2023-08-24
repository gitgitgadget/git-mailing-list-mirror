Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF110C3DA6F
	for <git@archiver.kernel.org>; Thu, 24 Aug 2023 15:55:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239380AbjHXPyo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Aug 2023 11:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235946AbjHXPyU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Aug 2023 11:54:20 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56800198D
        for <git@vger.kernel.org>; Thu, 24 Aug 2023 08:54:17 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id CE51BFF802;
        Thu, 24 Aug 2023 15:54:13 +0000 (UTC)
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Mark Levedahl <mlevedahl@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, mdl123@verizon.net,
        git@vger.kernel.org, adam@dinwoodie.org, me@yadavpratyush.com,
        johannes.schindelin@gmx.de, sunshine@sunshineco.com
Subject: Re: [PATCH v1 0/4] Remove obsolete Cygwin support from git-gui
In-Reply-To: <07677f17-be9b-dc46-d204-6fe46d46ebc0@gmail.com> (Mark Levedahl's
        message of "Sat, 5 Aug 2023 10:47:57 -0400")
References: <20230624212347.179656-1-mlevedahl@gmail.com>
        <20230626165305.37488-1-mlevedahl@gmail.com> <xmqq4jmsiyhw.fsf@gitster.g>
        <07677f17-be9b-dc46-d204-6fe46d46ebc0@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date:   Thu, 24 Aug 2023 17:54:13 +0200
Message-ID: <mafs01qfse8re.fsf@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: me@yadavpratyush.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 05 2023, Mark Levedahl wrote:

> On 6/27/23 13:52, Junio C Hamano wrote:
>> Mark Levedahl <mlevedahl@gmail.com> writes:
>>
>>> === This is an update, incorporating responses to Junio's and Eric's
>>> comments:
>>>    -- clarified what the "upstream" git-gui branch is
>>>    -- Removed some changes from patch 2 as requested by Junio, reducing
>>>       changes in patch 3 and patch 4
>>>         All code is fixed only after applying patch 4
>>>         Differences in patch 3 and 4 are minimimized
>>>     -- updated comments to clarify G4w dedicated code.
>>>     -- updated all comments to (hopefully) clarify points of confusion
>>> ===
>>> ...
>>> Mark Levedahl (4):
>>>    git gui Makefile - remove Cygwin modifications
>>>    git-gui - remove obsolete Cygwin specific code
>>>    git-gui - use cygstart to browse on Cygwin
>>>    git-gui - use mkshortcut on Cygwin
>>>
>>>   Makefile                  |  21 +------
>>>   git-gui.sh                | 118 +++-----------------------------------
>>>   lib/choose_repository.tcl |  27 +--------
>>>   lib/shortcut.tcl          |  31 +++++-----
>>>   4 files changed, 27 insertions(+), 170 deletions(-)
>> OK, Dscho says v1 looks good, and I have no further comments.
>>
>> Pratyush, can I expect that you take further comments and usher
>> these patches to your tree, and eventually tell me to pull from your
>> repository?
>>
>> Thanks, all.
>
> Junio,
>
> Thank you and Dscho for the detailed reviews. But, there is no response from
> Pratyush in over a month, is there a different maintainer then who should take
> this?

Almost 2 months now... I'm sorry. I just do not find enough time or
energy for git-gui these days. More on that later.

For now, I took a brief look at the patches. They look good to me. I
appreciate the detailed commit messages. I did not test them since I do
not have a Windows setup currently, but I believe Johannes did so it's
all good for me.

Applied to git-gui/master. Will send a pull request soon.

-- 
Regards,
Pratyush Yadav

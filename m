Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FA3EC433EF
	for <git@archiver.kernel.org>; Tue, 15 Mar 2022 11:23:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347609AbiCOLZI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Mar 2022 07:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233729AbiCOLZH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Mar 2022 07:25:07 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AEFD7679
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 04:23:55 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 30FCE182A6D;
        Tue, 15 Mar 2022 07:23:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=IXbEnlbxjSfXnqciFsgwKuBVZGurecnPvVhgx5f0buY=; b=vsIN
        JOvkrgLsPOF6gDd/8CZK7vwlCLPxvGYPRZkfgt994DS2vgf+VYjqwVcnREYk8B8b
        efJ3AhhuxoNbSgcjHmaJ7telFpB9awKDpbGTfCVTJ/z7Sx5ut9HzUJBX/G9WaVuz
        F+NjX0qeme05/JAW0zBH09Qfpnetkahp3SjZ95s=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 28DFD182A6C;
        Tue, 15 Mar 2022 07:23:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9F7E7182A6A;
        Tue, 15 Mar 2022 07:23:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "David Cantrell via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, David Cantrell <david@cantrell.org.uk>
Subject: Re: [PATCH v2 0/2] Improved bash tab completion for 'git restore' -
 adds support for auto-completing filenames
References: <pull.1227.git.git.1647032857097.gitgitgadget@gmail.com>
        <pull.1227.v2.git.git.1647305547.gitgitgadget@gmail.com>
Date:   Tue, 15 Mar 2022 04:23:51 -0700
Message-ID: <xmqq8rtbh320.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 64C6DCC2-A452-11EC-8E35-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"David Cantrell via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This adds tab-completion of filenames to the bash completions for git
> restore.
>
> David Cantrell (2):
>   tab completion of filenames for 'git restore'
>   if a file has been staged we don't want to list it

Why two patches?  The second separate patch makes the topic look as
if "oops, the first step designed a wrong behaviour and here is a
brown paper bag fix-up".


Return-Path: <SRS0=Ny9l=7D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE73EC433DF
	for <git@archiver.kernel.org>; Thu, 21 May 2020 18:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D16620823
	for <git@archiver.kernel.org>; Thu, 21 May 2020 18:09:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="gqmtR3+2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729444AbgEUSJE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 May 2020 14:09:04 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53544 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728067AbgEUSJC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 May 2020 14:09:02 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7AB51BC7F0;
        Thu, 21 May 2020 14:09:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=HB0LVRgP0oFE
        C9P0dCSOJRvM9UI=; b=gqmtR3+2Rgizk9QQhYjUhDuC8F7O8W1mpDVqokV2yZ98
        bdyo+Ps0tQD0Eu7RsFaOJmrLH8Na3DwZM5hRE48/9OzxUA4fUBjkTRqYYz7sMU74
        w6lTGbWJJFm2MImSDzWZNMyGloITSPgzzBM/TYyUgqMYeCzwNZvFpHats3mmADM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=nA3mxz
        OV7Rd00mal/X0o27uWrEqlYYTHCIVo4coShW1D2Q5yvcFO0m3laXEbSh8PBnUVx4
        jxXta1GsTeiRGLDLYWVorwKNQdHhDw5gWs/fkeCMPRQ4EeKZ8ZVkAnOyasfTeCkD
        d2AE/V4W3sUdBXIYxE8YS4xBPyQlmsVdvE0c8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 72DD0BC7EE;
        Thu, 21 May 2020 14:09:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9CE4CBC7E6;
        Thu, 21 May 2020 14:08:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     git@vger.kernel.org
Subject: Re: [GIT PULL] git-gui pull request
References: <20200521131220.t5lhw4e4qp4bpk3s@yadavpratyush.com>
Date:   Thu, 21 May 2020 11:08:56 -0700
In-Reply-To: <20200521131220.t5lhw4e4qp4bpk3s@yadavpratyush.com> (Pratyush
        Yadav's message of "Thu, 21 May 2020 18:42:20 +0530")
Message-ID: <xmqqsgftrwhz.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 24669C86-9B8E-11EA-916F-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pratyush Yadav <me@yadavpratyush.com> writes:

> Hi Junio,
>
> Please pull the changes in git-gui for Git v2.27.0. Since there was som=
e=20
> fallout on MacOS last time around, please merge it in -rc2 so the=20
> changes can get a bit more exposure, even though the changes this time=20
> around are fairly minimal.
>
> Regards,
> Pratyush Yadav

Thanks, will do.


> ---
> The following changes since commit=20
> a5728022e07c53e5ac91db0960870518e243b7c1:
>
>   Merge branch 'py/remove-tcloo' (2020-03-19 21:29:19 +0530)
>
> are available in the Git repository at:
>
>   https://github.com/prati0100/git-gui.git=20
>
> for you to fetch changes up to c195247812f8cd38ba7e1c603112e6c1d8d8e71e=
:
>
>   Merge branch 'il/ctrl-bs-del' (2020-05-21 18:25:32 +0530)
>
> ----------------------------------------------------------------
> Ansgar R=C3=B6ber (1):
>       Subject: git-gui: fix syntax error because of missing semicolon
>
> Ismael Luceno (1):
>       git-gui: Handle Ctrl + BS/Del in the commit msg
>
> Pratyush Yadav (2):
>       Merge branch 'ar/ui-ready-semicolon'
>       Merge branch 'il/ctrl-bs-del'
>
>  git-gui.sh        | 6 ++++--
>  lib/index.tcl     | 6 +++---
>  lib/mergetool.tcl | 2 +-
>  3 files changed, 8 insertions(+), 6 deletions(-)

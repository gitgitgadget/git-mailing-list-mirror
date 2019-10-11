Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A88C1F4C0
	for <e@80x24.org>; Fri, 11 Oct 2019 05:57:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbfJKF5w (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Oct 2019 01:57:52 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59169 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbfJKF5w (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Oct 2019 01:57:52 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 766609A436;
        Fri, 11 Oct 2019 01:57:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/hBOFxygEFJiEX9g1CDL5Q1w1c0=; b=RRoczg
        JN3V7i8sJN68WJ2vwL+0Odi5+79IqKWUp6C/+DBmAhBsRtxjuiktre/nb+5AgBCp
        dL8SHfTR6hxDPlTEKqqxosf7uN0emHMcU2+xEkf2CE2Fgfimd45x2DhB6kkkEy6l
        kMWnF1LGO8egPTBEIhrGrRQDKyQ0tmzNRI8A0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WcoZXZr14y54TvuSxx1EpVIrFbrSpJV1
        f+Csxb3sI0XA4bhe4sxfDqlDY97casd1nCa0Yc7PxMO4o7MueTpVyKqVYYUBD9SO
        Cnx5zqmBQntQMiPaHPiTY2z7p8oK01pmtoksUC/0W+w5/kwQM8etckV7auZz75U4
        o3Fdp43ML+0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6E4769A435;
        Fri, 11 Oct 2019 01:57:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9AA4E9A432;
        Fri, 11 Oct 2019 01:57:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Maxim Belsky via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Max Belsky <public.belsky@gmail.com>
Subject: Re: [PATCH 1/1] doc: Change zsh git completion file name
References: <pull.367.git.gitgitgadget@gmail.com>
        <ae00e1e3932b3364da68fa66e2ec5fbcce124bdc.1570726611.git.gitgitgadget@gmail.com>
        <nycvar.QRO.7.76.6.1910102310260.46@tvgsbejvaqbjf.bet>
Date:   Fri, 11 Oct 2019 14:57:42 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1910102310260.46@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Thu, 10 Oct 2019 23:12:41 +0200 (CEST)")
Message-ID: <xmqqmue7hlih.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0B55B800-EBEC-11E9-AEF4-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Thu, 10 Oct 2019, Maxim Belsky via GitGitGadget wrote:
>
>> From: Maxim Belsky <public.belsky@gmail.com>
>>
>> Signed-off-by: Maxim Belsky <public.belsky@gmail.com>
>
> I totally agree with the patch, but only because I read a couple of
> reports that users were struggling with this. Maybe add a couple of
> reference points to the commit message, to describe how easy it is to
> miss the fact that it needs to be a _file_, not a directory, and also
> describe how `zsh` tells you that there is a problem (even if it does
> not report a problem, that's a valuable piece of information for the
> commit message).

After reading the updated text, and then hearing many people cannot
get if the existing reference to ~/.zsh/_git is about a directory
(to which this should be added as one of the files in it) or a file,
I doubt that the updated text is clear enough for these people.

>> -# The recommended way to install this script is to copy to '~/.zsh/_git', and
>> -# then add the following to your ~/.zshrc file:
>> +# The recommended way to install this script is to copy to
>> +# '~/.zsh/.git-completion.zsh', and then add the following to your ~/.zshrc
>> +# file:

Perhaps making it absolutely clear by risking to be overly verbose,
like so?

    The recommended way to install this script is to make a copy of it
    in ~/.zsh/ directory as ~/.zsh/git-completion.zsh and then ...

If my attempt to be overly verbose and absolutely clear above is
giving a wrong piece of advice, then that would be an indication
that the original nor the updated text is clear enough, as they are
the primary sources of information on this matter I used to come up
with the suggestion ;-)

>>  #
>>  #  fpath=(~/.zsh $fpath)
>>
>> --
>> gitgitgadget
>>

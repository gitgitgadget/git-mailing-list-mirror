Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BCF9C433EF
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 17:15:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381559AbiBURQB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 12:16:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381516AbiBURPj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 12:15:39 -0500
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E21522611C
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 09:15:15 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 99CF6175A7C;
        Mon, 21 Feb 2022 12:15:15 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=rx6t3vP6sFCX
        bDSul9C9fkLzpFELrM6krOH9Jjj6vB8=; b=yPDq2fjkDQadPPVZToh9lBjQZlgX
        lMOHw/STFNZoGJYlDr1TiizAHq6LHlsD5/XOPCV+du3sNdGlzfgWzrjlelGhNpfL
        LY8DM+q30X404KI7ff9rFx50ar6DAQOVHX0Yh5/KiLtSxb86kj+AdymY1sqxXSme
        txXqmJCdlgQpsGY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 921F6175A7B;
        Mon, 21 Feb 2022 12:15:15 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id EA257175A7A;
        Mon, 21 Feb 2022 12:15:12 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Abhradeep Chakraborty via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Abhra303 <chakrabortyabhradeep79@gmail.com>
Subject: Re: [PATCH] add usage-strings ci check and amend remaining usage
 strings
References: <pull.1147.git.1645030949730.gitgitgadget@gmail.com>
        <220221.86tucsb4oy.gmgdl@evledraar.gmail.com>
Date:   Mon, 21 Feb 2022 09:15:10 -0800
In-Reply-To: <220221.86tucsb4oy.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Mon, 21 Feb 2022 16:39:54 +0100")
Message-ID: <xmqqsfscta3l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D488527C-9339-11EC-9443-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> diff --git a/ci/test-documentation.sh b/ci/test-documentation.sh
>> index de41888430a..f66848dfc66 100755
>> --- a/ci/test-documentation.sh
>> +++ b/ci/test-documentation.sh
>> @@ -15,6 +15,7 @@ filter_log () {
>>  }
>
> As much as I like the idea, I really don't want us to have this method
> of doing it though, i.e. to start parsing our C code with a
> hard-to-maintain shellscript.
>
> But the good news is that there's much easier way to add this!

;-)  Good suggestions.  I have nothing to add.


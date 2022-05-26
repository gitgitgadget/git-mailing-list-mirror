Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B5FC433EF
	for <git@archiver.kernel.org>; Thu, 26 May 2022 17:33:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346102AbiEZRcv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 May 2022 13:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237053AbiEZRct (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 May 2022 13:32:49 -0400
Received: from pb-sasl-trial21.pobox.com (pb-sasl-trial21.pobox.com [173.228.157.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C431013F7D
        for <git@vger.kernel.org>; Thu, 26 May 2022 10:32:46 -0700 (PDT)
Received: from pb-sasl-trial21.pobox.com (localhost.local [127.0.0.1])
        by pb-sasl-trial21.pobox.com (Postfix) with ESMTP id CC0FA36A66;
        Thu, 26 May 2022 13:32:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0Q6rETe7ggy0pE8FApDpS14h1CI=; b=aIPtiD
        8zKBI60STqdSgfENMpqLbz1FV/lIDd+1iU9q1yNcb9TNVdpMvrSLdQOJNILmD1Qz
        ccSRY8Z/LM66FzKG2bzmAbBO+wnXbwYwCnNYdsnAuxUHDy26hmqKhrAM65l25PP8
        ybEvRJ7N1r3Awf+rcjWCI3jzZyVWFPLYMFn68=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jL6oUXwrWA42QmfdpwCzdmgCa5hH/jxd
        czA10za6nZWS3al+QP+LTDjv0+VxIxwZcLjBnL8ZIt8HOjdrjxn1xqKS5qW7rXWr
        DXn8/6NpQOobv/o2Jhxm/VHiJggYq2aBABKABdS+YZkpllEMebqA24cwsz/aE1sl
        U9+MWjOnUCM=
Received: from pb-smtp20.sea.icgroup.com (pb-smtp20.pobox.com [10.110.30.20])
        by pb-sasl-trial21.pobox.com (Postfix) with ESMTP id BDE7F36A65;
        Thu, 26 May 2022 13:32:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 559061924B7;
        Thu, 26 May 2022 13:32:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git List <git@vger.kernel.org>,
        Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        Matthias =?utf-8?Q?R=C3=BCster?= <matthias.ruester@gmail.com>,
        Jimmy Angelakos <vyruss@hellug.gr>,
        Christopher =?utf-8?Q?D=C3=ADaz?= 
        <christopher.diaz.riv@gmail.com>,
        =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Gwan-gyeong Mun <elongbug@gmail.com>, Arusekk <arek_koz@o2.pl>,
        Daniel Santos <dacs.git@brilhante.top>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        Emir SARI <bitigchi@me.com>,
        =?utf-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
        Fangyi Zhou <me@fangyi.io>, Yi-Jyun Pan <pan93412@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH v5 06/10] po/git.pot: this is now a generated file
References: <20220523152128.26380-1-worldhello.net@gmail.com>
        <20220526145035.18958-7-worldhello.net@gmail.com>
Date:   Thu, 26 May 2022 10:32:41 -0700
In-Reply-To: <20220526145035.18958-7-worldhello.net@gmail.com> (Jiang Xin's
        message of "Thu, 26 May 2022 22:50:31 +0800")
Message-ID: <xmqqv8tsyzba.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D8D9E17C-DD19-11EC-A607-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

> We no longer keep track of the contents of this file.
>
> Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> ---
>  Please remove the "po/git.pot" file manually.
>
>  po/git.pot | 25151 ---------------------------------------------------
>  1 file changed, 25151 deletions(-)
>  delete mode 100644 po/git.pot

FWIW, these large patches from previous rounds seem to have finally
appeared in the list archive, e.g.

https://lore.kernel.org/git/20220523152128.26380-1-worldhello.net@gmail.com/T/#m505ac9e82e1bbd280c4993027e6bcf0740473fda

Will commit a removal for now.

Thanks.

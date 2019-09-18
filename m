Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 643EF1F463
	for <e@80x24.org>; Wed, 18 Sep 2019 17:31:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728260AbfIRRbk (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Sep 2019 13:31:40 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54578 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727056AbfIRRbk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Sep 2019 13:31:40 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E540D18817;
        Wed, 18 Sep 2019 13:31:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=B9ReHoQuoF7h695CEGdK0ERg/2g=; b=wqnM41
        juptgn/p5DGS0cCMyFu7sfwUG2ViRSbh/MyAjNB12egeitu/mMnWQeey4y1oT8f4
        wWMtB20r0sPMfQ+jxahrQnKFDqUJQNWZ/1qPOGzUl5A+VzgrdLOfADuFItiM6bmB
        r0BFDL6LDDEmDasBxUt4LHdPH8SSgrOtQASe8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=U81EpKSt44v8xhSzFhugcbFIbrSC5Oty
        RrA/oFd5Re9umAs4aciHAWx2yLuj0RymTM6DoXwIaCC6BZArwaCszwOV2XA07J5w
        i+K0mrljUO5SpezxRrN/kikUCP/Qu14fjiG7XeYldWlQJrUiS3qbvtl2NhL7S0GR
        OmHEronkCNw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DD3D218816;
        Wed, 18 Sep 2019 13:31:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 47C7E18815;
        Wed, 18 Sep 2019 13:31:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Birger Skogeng Pedersen <birger.sp@gmail.com>
Cc:     Pratyush Yadav <me@yadavpratyush.com>,
        Git List <git@vger.kernel.org>
Subject: Re: git-gui: missing some patches from git?
References: <CAGr--=KXqFbivuXHPNecb3dBR_hx8QqWoR4pBGXy7uOiT+ESbg@mail.gmail.com>
Date:   Wed, 18 Sep 2019 10:31:36 -0700
In-Reply-To: <CAGr--=KXqFbivuXHPNecb3dBR_hx8QqWoR4pBGXy7uOiT+ESbg@mail.gmail.com>
        (Birger Skogeng Pedersen's message of "Wed, 18 Sep 2019 09:02:37
        +0200")
Message-ID: <xmqqftkt5x53.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2AD558C0-DA3A-11E9-8EF6-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Birger Skogeng Pedersen <birger.sp@gmail.com> writes:

> For example, I created a patch back in March 2018[3]. Junio pulled it
> so the changes are really there in git/git-gui/git-gui.sh (see this[4]
> line). This was while there was no git-gui maintainer. I guess the
> change never got merged to git-gui, but directly to git.

Thanks for noticing.  

I do recall forking Pat's tree, applying a few patches and pulling
the result to git itself while asking Pat to pull from me to get
these patches.  Perhaps these were not merged back before Pratyush
inherited the tree.


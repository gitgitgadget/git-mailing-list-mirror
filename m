Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD3B9EB64DC
	for <git@archiver.kernel.org>; Tue, 18 Jul 2023 23:03:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjGRXDM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Jul 2023 19:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjGRXDL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jul 2023 19:03:11 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CED2E0
        for <git@vger.kernel.org>; Tue, 18 Jul 2023 16:03:07 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D91E419BBF8;
        Tue, 18 Jul 2023 19:03:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=8umCaYZV6wxe
        b9Hy58UzxSMownmj8V2n4eH+4SdHBEo=; b=gdG3fEHM1YCmvOxxtXV108WtBaAr
        98xc3/z80BI7eLXfHN08yL93s946cT6J0kNvSbJWFsGVTwhfhc+y4pCebreELiuG
        Bhd2xEVNWfs42RuH98RDSJGzOWPiYhB20/LeO6P7aHTjJtsfr0SdAhJfvWESwuCA
        IhsyW+xkyoI5QwY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B36BF19BBF7;
        Tue, 18 Jul 2023 19:03:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B774219BBF5;
        Tue, 18 Jul 2023 19:03:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Adam_=5C=22Sinus=5C=22_Skawi=C5=84ski?= 
        <adam.skawinski@sinpi.net>
Cc:     git@vger.kernel.org
Subject: Re: receive.denyCurrentBranch=updateInstead won't update the repo
References: <CAGE71k3Ccm3hBrfNgXFqO9Zk0V9FkoskgD1ViJ6eSakxdBuqQQ@mail.gmail.com>
        <xmqqfs5mgs8v.fsf@gitster.g>
        <CAGE71k2bdy2aYy7speu=OOStopgjzVNOPQ_-V-63aCURLibFWw@mail.gmail.com>
        <CAGE71k3c+CGT=42cfkh+2Z-BcvefojNwpzWfc_XHPkBK8psJfA@mail.gmail.com>
        <CAGE71k3tMOtyFVrmGW33RuQ3GufJg8X6ORKCwHQgg6RmXbRCQA@mail.gmail.com>
        <xmqqa5vsg8gp.fsf@gitster.g>
        <CAGE71k28Gao4xuR565qsLmPH02tVAdoCZPeuCjo7r9YZXWs82Q@mail.gmail.com>
Date:   Tue, 18 Jul 2023 16:03:02 -0700
In-Reply-To: <CAGE71k28Gao4xuR565qsLmPH02tVAdoCZPeuCjo7r9YZXWs82Q@mail.gmail.com>
        ("Adam \"Sinus\" =?utf-8?Q?Skawi=C5=84ski=22's?= message of "Wed, 19 Jul
 2023 00:49:45
        +0200")
Message-ID: <xmqqh6q0esbd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 40972286-25BF-11EE-BFB6-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Adam \"Sinus\" Skawi=C5=84ski"  <adam.skawinski@sinpi.net> writes:

> Oh. Then it's different from the other hooks, which merely enhance or
> abort the default behaviour by returning non-zero! I hadn't thought of
> that.

I do not know if it is all that different from others, but in any
case it is a clear sign that the documentation needs a bit more love
to make sure that it will not lead new readers and users into the
same confusion.

Thanks.

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1342EC433EF
	for <git@archiver.kernel.org>; Thu,  7 Apr 2022 18:20:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240758AbiDGSWp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Apr 2022 14:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346836AbiDGSWg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Apr 2022 14:22:36 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEFB1F460F
        for <git@vger.kernel.org>; Thu,  7 Apr 2022 11:20:35 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 346C8135ACD;
        Thu,  7 Apr 2022 14:20:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=SOhA8C0SUug1kI1Jipg8WqU1m
        Sl7JoEUQ5iYqmItuHk=; b=GYX5hQGLhSR4PfLHjlSdI014RuultrSEAggx4Vxfi
        QEpkKhv2k3DuHN8CzdQgou/RGFIz8grfXFcjzMkdcUDZhh+u+KlD1e/oiVmF9dek
        s106ji6n0tFPAV6ZMnW8rUZYcTfesF1r0R/DQmlPqpVudxH+pWMM97MME3+YY9YL
        PE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2B3D6135ACC;
        Thu,  7 Apr 2022 14:20:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.214.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 936B5135ACB;
        Thu,  7 Apr 2022 14:20:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Teng Long <dyroneteng@gmail.com>, bturner@atlassian.com,
        avarab@gmail.com, git@vger.kernel.org
Subject: Re: Git 2.36, ls-tree submodule regression?
References: <CAGyf7-FjqrGYTUwdS=a6nsUnbn0qD9=Pf2Nx=gy6g8KGVRJivw@mail.gmail.com>
        <20220407022207.12542-1-dyroneteng@gmail.com>
        <nycvar.QRO.7.76.6.2204071436150.347@tvgsbejvaqbjf.bet>
Date:   Thu, 07 Apr 2022 11:20:33 -0700
Message-ID: <xmqqk0c0sqku.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6A9B09C0-B69F-11EC-BDA9-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Correction, it was fixed by Josh Steadmon, and =C3=86var proposed an
> alternative, but Josh's version made it into the `main` branch:

Correct, although the actual fixes were identical one-liner and it
didn't really matter in the end result where the fix was taken from.

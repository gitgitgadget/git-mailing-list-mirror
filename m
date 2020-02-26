Return-Path: <SRS0=QAHC=4O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF9DAC4BA24
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 21:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83C5E2072D
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 21:06:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="G5b3a2Ng"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbgBZVGp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Feb 2020 16:06:45 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55697 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727444AbgBZVGp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Feb 2020 16:06:45 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 20CF23AF97;
        Wed, 26 Feb 2020 16:06:44 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=e9iZ63YCghkqOapXyXQKEtFpgFE=; b=G5b3a2
        Ng4P9VxRhN+0OEMtTS2y+8QxNNHL8Cd8ELn1VCMIRfuOnMnUPBRBFkucyu41w69j
        ed0x0JXd8zd0GMGvPRRdvMnYH8Mvy9c+Dxs3OySKGir5NrVsy5EFE+erE+kIJi5c
        k32dbIPq8Zwl10Jcc8QoPe5Gc2JvsqTIKdiR4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Rj+8xUbCe8m9BzavmJjZzSQIlVsQEDTG
        z/rHMJUdR3JZBr6CD07yxT7DkwWACe/puta48Npiisd9oO1EUi7QKOKDvU/38Lwd
        8X50RAmo/CjgDoHQYdcnvmzMfRwny8PQvL/ZtAtRrnFQnhlPXckyn/egR7UXnyGA
        M/55zFQaJzs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 18FB93AF96;
        Wed, 26 Feb 2020 16:06:44 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 619DE3AF93;
        Wed, 26 Feb 2020 16:06:43 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Feb 2020, #05; Tue, 25)
References: <xmqqo8tml1lv.fsf@gitster-ct.c.googlers.com>
        <CAN0heSqfEsEZVBnFP0cSNoB-gK=EG1nuDL0EQHHc8MSH=TcPRw@mail.gmail.com>
Date:   Wed, 26 Feb 2020 13:06:42 -0800
In-Reply-To: <CAN0heSqfEsEZVBnFP0cSNoB-gK=EG1nuDL0EQHHc8MSH=TcPRw@mail.gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Wed, 26 Feb 2020 21:54:04
 +0100")
Message-ID: <xmqq1rqhhxct.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E3FA8DF0-58DB-11EA-9616-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(many typofixes)

Thanks.

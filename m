Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1E641F4C0
	for <e@80x24.org>; Wed, 16 Oct 2019 01:28:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730729AbfJPB2K (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Oct 2019 21:28:10 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55367 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbfJPB2K (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Oct 2019 21:28:10 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6264733DC2;
        Tue, 15 Oct 2019 21:28:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LwYxVeV9l7kZIEBGcElhYGUtdvY=; b=Eb7VR5
        rI//7aiFUSy6cEoKJTCilMzRcE54RjV9F1BtRPGCNdb5RqJpLs3fk0IbPcJ07QJe
        Y6yz4aNze9jCy8XCz7z4PUSt/EKlI7dyZSnQBlgXzjI9Do8yUEOuTp/Ti5ld55vY
        Fg+M2VHK1rdMlYg0BWS5+x2azI5wuUf1YLHcE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=N5FOXN/4nm7JRbi2/0WlLt5/OBsMO26B
        u5UuPWM+XcYVWNfDkU6KJAtz0AQ1BFaXOB9H86+zxWrKDAXUkubynlKyjypQlLdS
        cKqM2gevwgwurxCaQPrgmRg9Is2Yh3SCGwgHGqis+6BOSsAFe0bAsVDGgnmC2lI/
        jpY4bfqAwdU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5972933DC1;
        Tue, 15 Oct 2019 21:28:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9F96533DC0;
        Tue, 15 Oct 2019 21:28:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmo=?= =?utf-8?B?w7Zyw7A=?= Bjarmason 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH v6 0/3] format-patch: learn --infer-cover-subject option (also t4014 cleanup)
References: <cover.1558492582.git.liu.denton@gmail.com>
        <cover.1571130298.git.liu.denton@gmail.com>
Date:   Wed, 16 Oct 2019 10:28:06 +0900
In-Reply-To: <cover.1571130298.git.liu.denton@gmail.com> (Denton Liu's message
        of "Tue, 15 Oct 2019 02:06:31 -0700")
Message-ID: <xmqq4l09bhsp.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 352C15EA-EFB4-11E9-B926-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks.  I think we are ready for 'next'.

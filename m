Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C48920229
	for <e@80x24.org>; Thu, 10 Nov 2016 21:44:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965345AbcKJVnx (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Nov 2016 16:43:53 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62813 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934649AbcKJVnv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2016 16:43:51 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7C3104C16A;
        Thu, 10 Nov 2016 16:43:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tAwEcQPUxHWR5K8VV1psdDDO+0U=; b=PEHHS0
        D/4AIPp+fkZlllDPasfEkTS9Y1cV7X9nJOsaVfczWnk+I0EVDeSfjfmDD6L55A0x
        Z4omI0duBcgpBfwaOOAOreSo80ubxBOVXI2SPMLonDlY35h/71P99AffrWV6miU0
        Gh/zSN/Io8ZqhLEjmMESN18pyPivwX/BtV1jk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=em3T4z465LLEBagMzZP4L9MSEGXBVe0Q
        RwVdXVdNb2weWGSyL3iR3jUS2CGCZZ6bM+nLeuBoHMOXc5KWaQtxxwdqIU01TYfO
        h1IURWBoqLwaIv7x7F1CIuRblFtm2y1jWOoMLktX0hatEncMcXMGs9HSetyBe5WK
        BjkoJ1lAMVE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 73DFC4C169;
        Thu, 10 Nov 2016 16:43:49 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DF6484C168;
        Thu, 10 Nov 2016 16:43:48 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: Re: 2.11.0-rc1 will not be tagged for a few days
References: <xmqqk2cgc95m.fsf@gitster.mtv.corp.google.com>
Date:   Thu, 10 Nov 2016 13:43:47 -0800
In-Reply-To: <xmqqk2cgc95m.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Sun, 06 Nov 2016 18:32:05 -0800")
Message-ID: <xmqqoa1n57u4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C38BCA22-A78E-11E6-84EA-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I'll report back an updated schedule when able.

I pushed some updates out on 'master' today.  Between 'master' and
'pu' on the first-parent history there is a merge 52975d2b1f ("Merge
branch 'ls/macos-update' into jch", 2016-11-10) and that matches
what I expect to be in -rc1 tomorrow (modulo RelNotes and the actual
version tag), unless there is a showstopper regresion reported, in
which case we may want to first look into reverting the whole series
that introduced the regression before considering to pile on fix-up
patches.

http://tinyurl.com/gitCal has been redrawn, with -rc1 scheduled for
tomorrow on 11th, -rc2 on the 17th, and final on the 23rd.

Thanks.

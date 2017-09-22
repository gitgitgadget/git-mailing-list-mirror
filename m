Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFC81202A5
	for <e@80x24.org>; Fri, 22 Sep 2017 04:38:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751845AbdIVEiO (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Sep 2017 00:38:14 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55081 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751809AbdIVEiN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2017 00:38:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7A1E6A807A;
        Fri, 22 Sep 2017 00:38:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=AOxyMpFFjt5iBY4PnaQDmQAC4HA=; b=Ynbiuj
        gay+AnBmc/8xViAMs8GJqP7jITUVQkXfxd9AokqRdjqUaCsY5sx3BPQZvVkfWajp
        djudgpnVzjg1TGnKjRZZB6XRqrGzMb2fb8jtttFIoVjp8eKco2r9E+0f1I2ZsqPX
        S45RAWxrOT7ezEx0+aD4/8WP5vzgXawFc4xN0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rxzujmO49rJmKQ2BNrDxAVIyAT/gkGTE
        bdtw1FLgjV4ZobNeFx3oiQ0vRUkg5ra7y7JRJFnwaKO6/a0OH19Sqin3DTNj9GeI
        lhmB/Jtt8mmAX570hHIHApf3T+CAeBrOBDaOWKmlafJSRD/YvfEdTS17GJuxAUms
        vXm6Xcn712A=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7285CA8079;
        Fri, 22 Sep 2017 00:38:12 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B4409A8078;
        Fri, 22 Sep 2017 00:38:11 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Daniel Santos <daniel.santos@pobox.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: KDevelop developers obviously don't use git :(
References: <1469bc42-0a21-8cc4-f9bb-000c3737fe19@pobox.com>
Date:   Fri, 22 Sep 2017 13:38:10 +0900
In-Reply-To: <1469bc42-0a21-8cc4-f9bb-000c3737fe19@pobox.com> (Daniel Santos's
        message of "Thu, 21 Sep 2017 23:03:53 -0500")
Message-ID: <xmqq4lrvl559.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D7109C3A-9F4F-11E7-A1F2-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Daniel Santos <daniel.santos@pobox.com> writes:

> So first I need to inquire if there is a current mechanism to say "git
> status, but please fail if you're busy with a non-atomic operation".

Reading this list sometimes makes me wonder if there is some higher
intelligence telling independent souls to come up with the same wish
at the same time.

https://public-inbox.org/git/20170921050835.mrbgx2zryy3jusdk@sigill.intra.peff.net/



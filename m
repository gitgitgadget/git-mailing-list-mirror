Return-Path: <SRS0=Vx3J=3N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00333C2D0CE
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 23:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2C48206D4
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 23:44:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="W8+eNAv9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729590AbgAXXos (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jan 2020 18:44:48 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58121 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729557AbgAXXos (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jan 2020 18:44:48 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 693669FEB0;
        Fri, 24 Jan 2020 18:44:46 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=aqJ4AaJ/clXz
        mMhXlF7zloPJk8c=; b=W8+eNAv9VcLKimczwvE4KmsJCHuVl4rBbAQWGk5ftutK
        Q5YfY0M4UXr5FQPLo3rRynTnFTvoD/41qZgWrM9w0Teu/njd2fKf678E5CFg+rh/
        cbIQxFHrar+DIyDubPwFWXg6rHUZAPfAHYHzGpj8eZ7yslD3nNtl0vZoBQohmeE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=OkoRM5
        8PEYhM+8HrxPfOxmazODSbEvZCaW+jbS9EWxniHJ/BUs8+BAJzQmtHHEXGPhW8aY
        kYurIe8H9ZzZkNN19ub8e3Y3qKuk18fDQIdXrZNYSaDYlnfqZWL6V3SmVIi90fpY
        LchNtm/ubhb+Wk3db88GscnrrqJdbxeqnimwc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 62EEF9FEAF;
        Fri, 24 Jan 2020 18:44:46 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 882FA9FEAD;
        Fri, 24 Jan 2020 18:44:43 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v7] MyFirstContribution: add avenues for getting help
References: <20200124210148.220007-1-emilyshaffer@google.com>
        <20200124212602.74194-1-emilyshaffer@google.com>
        <20200124215628.GI6837@szeder.dev>
Date:   Fri, 24 Jan 2020 15:44:40 -0800
In-Reply-To: <20200124215628.GI6837@szeder.dev> ("SZEDER =?utf-8?Q?G=C3=A1?=
 =?utf-8?Q?bor=22's?= message of
        "Fri, 24 Jan 2020 22:56:28 +0100")
Message-ID: <xmqqh80kctcn.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 7EF6AB38-3F03-11EA-B993-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> On Fri, Jan 24, 2020 at 01:26:02PM -0800, Emily Shaffer wrote:
>> With https://lore.kernel.org/git/20191114194708.GD60198@google.com/ we
>> now have a mentoring mailing list, to which we should direct new
>> contributors who have questions.
>
> Why should a supposedly "open" open source project direct new
> contributors to a mailing list that is not openly accessible, and even
> reading and searching its archives requires registration?

Haven't we had that discussion when the mentoring list was launched?

I would not prefer joining a closed list of unknown people over
coming up with a fake name and asking for help in an open list if I
had choice when interacting with an established community as a new
member, but I would understand it if preference of some people are
opposite from mine.  The more important part, from my point of view,
is that we offer choices (the proposed doc update illustrates
three).


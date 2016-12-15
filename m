Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 866471FF6D
	for <e@80x24.org>; Thu, 15 Dec 2016 17:50:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754320AbcLORun (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Dec 2016 12:50:43 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52199 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754303AbcLORum (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2016 12:50:42 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 932E457931;
        Thu, 15 Dec 2016 12:50:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=KY7YFhpQcR6m
        drbIpV+HzBvygnc=; b=SxOPsZYD+Ds3QvGt0hJmOUdhgHipdS1FxpcPCl9ZkGDJ
        4wNEPGabNOM6axw8jIy07gq9sX/qCwri/yiZ+Qi3n0W/ga1xWLUmiAw47i+hhXxd
        XR0pcykZUenjLNWN1Sudq0gYfiAqcTnuvg3/Qg8TDDHjtJBYn+nzgb9td1qRaKA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=r+Bj6a
        74o/QNfIBt5BQwaabFyojB6osQnvUmp42qufmA2BG6ZTrBNF70tw2j+Xdsuotyj6
        69tQGPV4t0YqC5ZZxcH/j4catDpQZNKDxxdjPMgIzhByUpKBGztRbPYrghokgOrL
        uTTRRy4H5M2iSv5NbifuN29E30gctYoNhYWSI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8C1C357930;
        Thu, 15 Dec 2016 12:50:41 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F399A5792F;
        Thu, 15 Dec 2016 12:50:40 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Dennis Kaarsemaker <dennis@kaarsemaker.net>
Cc:     Beat Bolli <dev+git@drbeat.li>, git@vger.kernel.org
Subject: Re: [PATCH v2 3/6] update_unicode.sh: pin the uniset repo to a known good commit
References: <1481671904-1143-1-git-send-email-dev+git@drbeat.li>
        <1481671904-1143-4-git-send-email-dev+git@drbeat.li>
        <1481795248.4090.15.camel@kaarsemaker.net>
Date:   Thu, 15 Dec 2016 09:50:39 -0800
In-Reply-To: <1481795248.4090.15.camel@kaarsemaker.net> (Dennis Kaarsemaker's
        message of "Thu, 15 Dec 2016 10:47:28 +0100")
Message-ID: <xmqq4m25w07k.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: FE8E25EA-C2EE-11E6-A643-E98412518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dennis Kaarsemaker <dennis@kaarsemaker.net> writes:

> On Wed, 2016-12-14 at 00:31 +0100, Beat Bolli wrote:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0( cd uniset && git checkout=
 4b186196dd )
>
> Micronit, but this is perhaps better written as
>
> git -C uniset checkout 4b186196dd
>
> to avoid the subshell and cd.
>
> D.

In the context of this script, I would say that is not even a
micronit.  It is "you could do this if you wanted to".
